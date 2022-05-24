<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Bag;
use App\Models\BagStyle;
use App\Models\Department;
use App\Models\Employee;
use App\Models\Transaction;
use App\Models\TransactionItem;
use App\Models\TransactionItemLossDetails;
use App\User;
use Illuminate\Http\Request;
use App\GenXCommon\XModel;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Config;
use Illuminate\Support\Facades\DB;

class LossApprovalController extends Controller
{
    /**
     * Getting grid data
     *
     */

    public function getIndex()
    {
        self::hasPermission('index.lossapproval');
        return view("loss_approval.index");
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        self::hasPermission('index.lossapproval');
        $query = TransactionItemLossDetails::query()->select(
            "bag.id as bag_id",
            "bag.bag_number",
            "bag.order_number",
            'transaction_item_loss_details.*',
            'bag.bag_number as bag_number',
            'bag.order_number as order_number',
            //'style.sku as style_sku',
            DB::raw("GROUP_CONCAT(style.sku) style_sku"),
            'users.name as user_name'
        )
            //->leftJoin('transaction_item', 'transaction_item.id', '=', 'transaction_item_loss_details.transaction_item_id')
            //->leftJoin('bag_styles', 'bag_styles.id', '=', 'transaction_item.bag_style_id')
            ->leftJoin('transaction', 'transaction.id', '=', 'transaction_item_loss_details.transaction_id')
            ->leftJoin('bag', 'bag.id', '=', 'transaction.bag_id')
            ->leftJoin('bag_styles', 'bag_styles.bag_id', '=', 'bag.id')
            ->leftJoin('style', 'style.id', '=', 'bag_styles.style_id')
            ->leftJoin('users', 'users.id', '=', 'transaction_item_loss_details.user_id')
            ->where('transaction_item_loss_details.admin_approval_loss_weight', '>', 0)
            ->where('transaction_item_loss_details.type', XModel::getConfigType("loss", "transaction_item_loss_type", "value")['id'])
            //->where('transaction_item_loss_details.status',XModel::getConfigType("waiting_admin_approval","transaction_item_loss_status","value")['id'])
        ;
        if ($request->has('advanceFilter')) {
            $params = json_decode($request->get('advanceFilter'), true);
            if (!is_null($params)) {
                foreach ($params  as $column => $value) {
                    if (!is_null($value)) {
                        switch ($column) {
                            case 'user_id':
                                $query->where("transaction_item_loss_details.user_id", $value);
                                break;
                            case 'status':
                                $query->where("transaction_item_loss_details.status", $value);
                                break;
                        }
                    }
                }
            }
        }
        $query->groupBy('bag.id', 'bag.bag_number', 'bag.order_number', 'transaction_item_loss_details.weight');
        return XModel::preparePagination($query, $request, ['bag.bag_number', 'bag.order_number', 'style.sku', 'users.name']);
    }
    public function statusUpdate(Request $request)
    {
        $data = $request->all();
        self::hasPermission('index.lossapproval');
        $request->validate([
            'id' => 'required|numeric',
            'reason_type_id' => 'required|numeric',
            'loss_description' => 'required_if:reason_type_id,==,' . XModel::getConfigType("others", "loss_reason_type", "value")['id'],
        ]);
        DB::transaction(function () use ($data) {
            $data['status'] = XModel::getConfigType("approved", "transaction_item_loss_status", "value")['id'];
            $data['admin_id'] = Auth::id();
            $data['approval_date'] = Date("Y-m-d");
            $transactionItemLossDetails = TransactionItemLossDetails::findOrFail($data['id']);
            $loss_status = (int)$transactionItemLossDetails['status'];
            $transactionItemLossDetails->fill($data);
            if ($transactionItemLossDetails->save()) {
                //#block to make transaction approval...!
                $transactionItem = TransactionItem::where('transaction_id', $transactionItemLossDetails['transaction_id'])->get();
                $transactionItem = $transactionItem[0];
                $transactionItem->status = XModel::getConfigType("completed", "transaction_type", "value")['id'];
                if ($transactionItem->save()) {
                    //#check the transaction has any loss approval...!
                    $lossApproval = TransactionItemLossDetails::where('status', XModel::getConfigType("admin_loss_approval", "transaction_type", "value")['id'])->count();
                    //if ($loss_status != 0) {
                        //#transcation approved...!
                        $transaction = Transaction::findOrFail($transactionItem->transaction_id);
                        $transaction->status = XModel::getConfigType("completed", "transaction", "value")['id'];
                        if ($transaction->save()) {
                            $bag = Bag::findOrFail($transaction->bag_id);
                            $bag->department_id = $transaction['to_department_id'];
                            $bag->employee_id = $transaction['to_employee_id'];
                            $bag->status = XModel::getConfigType("in_progress", "bag_status", "value")['id'];
                            if (!is_null($transaction['to_department_id'])) {
                                //#block to check the bag status...!
                                $department = Department::findOrFail($transaction['to_department_id']);
                                if (Config::get('constants.department.final_process_status.is_final') == $department->is_last)
                                    $bag->status    =   XModel::getConfigType("completed", "bag_status", "value")['id'];
                            }

                            if ($bag->save()) {
                                $transaction_items = TransactionItem::where('transaction_id', $transaction['id'])->get();
                                if (count($transaction_items) > 0) {
                                    foreach ($transaction_items as $transaction_item_key => $transaction_item_value) {
                                        if (isset($transaction_item_value['bag_style_id']) && $transaction_item_value['bag_style_id'] > 0) {
                                            print_r($transaction_item_value);
                                            //#block to update the receive quantity as quantity...!
                                            $bagStyle = BagStyle::findOrFail($transaction_item_value['bag_style_id']);
                                            $bagStyle->weight = $transaction_item_value['receive_weight'];
                                            $bagStyle->save();
                                        } else {
                                            //#addiing bag additional accessories to the bag...!
                                            $bagStyleData = [
                                                "bag_id" => $transaction['bag_id'],
                                                "style_id" => null,
                                                "other_accessories_id" => $transaction_item_value['other_accessories_id'],
                                                "upload_id" => $transaction_item_value['upload_id'],
                                                "quantity" => $transaction_item_value['quantity'],
                                                "weight" => $transaction_item_value['receive_weight'],
                                                "instructions" => '',
                                                "parent_bag_style_id" => null,
                                            ];
                                            $bagStyle = BagStyle::create($bagStyleData);
                                            $transactionItem  = TransactionItem::findOrFail($transaction_item_value['id']);
                                            $transactionItem->bag_style_id = $bagStyle['id'];
                                            $transactionItem->save();
                                        }
                                    }
                                }
                            }
                        }
                    //}
                }
                //$transactionItemLossDetails
            }
        });
    }
    public function dropDown(Request $request)
    {
        $post_all = $request->all();
        $user = User::query()->select('users.*')->join('employee', 'employee.user_id', '=', 'users.id')->get();
        $result         =   [
            "user"      =>  $user
        ];
        return $result;
    }
}
