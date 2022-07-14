<?php

namespace App\Http\Controllers\API;

use App\GenXCommon\XModel;
use App\Models\Bag;
use App\Models\Department;
use App\Models\Employee;
use App\Models\OtherAccessories;
use App\Models\Transaction;
use App\Models\TransactionItem;
use App\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Config;
use Illuminate\Support\Facades\DB;

class TransactionHistoryController extends Controller
{
    /**
     * Getting grid data
     *
     */

    public function getIndex()
    {
        self::hasPermission('index.transactionreport');
        return view("transaction_history.index");
    }
    public function getTransactionHistory(Request $request)
    {
        $request->validate([
            /*'date_range.start' => 'required',
            'date_range.end' => 'required',*/
            'tab_status' => 'required',
        ]);
        $post_data = $request->all();

        //#block for issue...!
        $transactionQuery = Transaction::query();
       
        $this->buildCriteria($transactionQuery, $post_data);
        $transaction = $transactionQuery->get();
        if (count($transaction) > 0) {
            foreach ($transaction as $item => $value) {
                $value->transactionItems;
            }
        }
        return $transaction;
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show(Transaction $transaction)
    {
        self::hasPermission('update.transaction');
        $transaction->bag;
        $transaction->fromDepartment;
        $transaction->fromEmployee;
        $transaction->toDepartment;
        $transaction->toEmployee;
        $transaction->toEmployee;
        $transaction->transactionItems;

        return $transaction;
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
    public function getDropDownData(Request $request)
    {
        $postData       =   $request->all();
        $departmentQuery = Department::query();
        /*if( isset($postData['department_id']) > 0 )
            $departmentQuery->where("");*/
        $departments = $departmentQuery->get();
        $loginUser = User::getUserDetails();
        if (isset($loginUser['employee']['id'])) {
            $postData['employee_id'] = $loginUser['employee']['id'];
        }
        if (isset($loginUser['department']['id'])) {
            $postData['department_id'] = $loginUser['department']['id'];
        }

        return [
            "department"    =>  $departments,
            "employee"      =>  Transaction::getEmployeeBasegOnDepartment($postData['department_id']),
            "login_user_details" =>  User::getUserDetails()
        ];
    }
    public function viewTallyReport()
    {
        self::hasPermission('index.tallyreport');
        return view("transaction_history.tally_report");
    }
    public function getTallyReport(Request $request)
    {
        $request->validate([
            'date' => 'required',
        ]);
        //#these bag array is used for calculating the receive and transfer weight for an day...!
        $bags = [];
        $transactionSum = [
            "total_transfer_weight" => 0,
            "total_transfer_quantity" => 0,
            "total_receive_weight" => 0,
            "total_scrab" => 0,
            "total_loss" => 0,
        ];
        $post_data = $request->all();
        $transactionQuery = Transaction::query()
            ->where("transaction.transaction_date", $post_data['date'])
            ->leftJoin('bag', 'bag.id', '=', 'transaction.bag_id')
            ->select([
                "transaction.*",
                "bag.bag_number",
                "bag.order_number",
            ]);
        $transactionQuery->addSelect(DB::raw("IFNULL((SELECT SUM(transaction_item_loss_details.weight) FROM transaction_item_loss_details WHERE transaction_item_loss_details.transaction_id = transaction.id AND transaction_item_loss_details.type = " . XModel::getConfigType("scrap", "transaction_item_loss_type", "value")['id'] . "),0) as total_scrab"));
        $transactionQuery->addSelect(DB::raw("IFNULL((SELECT SUM(transaction_item_loss_details.weight) FROM transaction_item_loss_details WHERE transaction_item_loss_details.transaction_id = transaction.id AND transaction_item_loss_details.type = " . XModel::getConfigType("loss", "transaction_item_loss_type", "value")['id'] . "),0) as total_loss"));
        $transactionData  = $transactionQuery->get();
        //#note i didn't use sum, need to write lot of sub query to skip i used for loop...!
        if (count($transactionData) > 0) {
            foreach ($transactionData as $key => $value) {
                $bag_id = $value['bag_id'];
                $bags[$bag_id] = [
                    "total_transfer_weight" => $value['total_transfer_weight'],
                    "total_transfer_quantity" => $value['total_transfer_quantity'],
                    "total_receive_weight" => $value['total_receive_weight'],

                ];
                $transactionSum['total_scrab'] += $value['total_scrab'];
                $transactionSum['total_loss'] += $value['total_loss'];
            }
        }
        if (count($bags) > 0) {
            foreach ($bags as $bagKey => $bagValue) {
                $transactionSum['total_transfer_weight'] += $bagValue['total_transfer_weight'];
                $transactionSum['total_transfer_quantity'] += $bagValue['total_transfer_quantity'];
                $transactionSum['total_receive_weight'] += $bagValue['total_receive_weight'];
            }
        }
        return [
            "transaction_data" => $transactionData,
            "transaction_sum" => $transactionSum
        ];
    }
    public function getTransactionBagHistory(Request $request)
    {
        $request->validate([
            'tab_status' => 'required',
            'bag_id' => 'required',
        ]);
        $post_data       =   $request->all();
        $bag = Bag::findOrFail($post_data['bag_id']);
        $transactionQuery = Transaction::query();
        $this->buildCriteria($transactionQuery, $post_data);
        $transactionQuery->addSelect(DB::raw("IFNULL((SELECT SUM(transaction_item_loss_details.weight) FROM transaction_item_loss_details WHERE transaction_item_loss_details.transaction_id = transaction.id AND transaction_item_loss_details.type = " . XModel::getConfigType("scrap", "transaction_item_loss_type", "value")['id'] . "),0) as total_scrab"));
        $transactionQuery->addSelect(DB::raw("IFNULL((SELECT SUM(transaction_item_loss_details.weight) FROM transaction_item_loss_details WHERE transaction_item_loss_details.transaction_id = transaction.id AND transaction_item_loss_details.type = " . XModel::getConfigType("loss", "transaction_item_loss_type", "value")['id'] . "),0) as total_loss"));
        $transactionQuery->addSelect(DB::raw("IFNULL((SELECT SUM(transaction_item_loss_details.weight) FROM transaction_item_loss_details WHERE transaction_item_loss_details.transaction_id = transaction.id AND transaction_item_loss_details.type = " . XModel::getConfigType("channam", "transaction_item_loss_type", "value")['id'] . "),0) as total_channam"));
        $transaction = $transactionQuery->get();
        return ["transaction" => $transaction, "bag" => $bag];
    }
    public function buildCriteria(&$criteria, $post_data)
    {
        $criteria->leftJoin('bag', 'bag.id', '=', 'transaction.bag_id');
        $dateRange = $post_data["date_range"];
        if (!is_null($dateRange)) {
            if (!is_null($dateRange['start']) && !is_null($dateRange['end']))
                $criteria->whereBetween("transaction.transaction_date", [$dateRange['start'], $dateRange['end']]);
        }
        if (isset($post_data['bag_id'])) {
            $criteria->where('transaction.bag_id', $post_data['bag_id']);
        }
        $employeeColumn = "transaction.to_employee_id";
        $departmentColumn = "transaction.to_department_id";
        if ($post_data['tab_status'] != "issue") {
            $criteria->leftJoin('department', 'department.id', '=', $departmentColumn);
            $criteria->leftJoin('employee', 'employee.id', '=',  $employeeColumn);
        } else {
            $employeeColumn = "transaction.from_employee_id";
            $departmentColumn = "transaction.from_department_id";
            $criteria->leftJoin('department', 'department.id', '=', $departmentColumn);
            $criteria->leftJoin('employee', 'employee.id', '=',  $employeeColumn);
        }
        // if( $post_data['tab_status'] != "issue" ){
        //     $criteria->leftJoin('department', 'department.id', '=', 'transaction.from_department_id');
        //     $criteria->leftJoin('employee', 'employee.id', '=', 'transaction.from_employee_id');
        // }else{
        //     $employeeColumn = "transaction.from_employee_id";
        //     $departmentColumn = "transaction.from_department_id";
        //     $criteria->leftJoin('department', 'department.id', '=', 'transaction.to_department_id');
        //     $criteria->leftJoin('employee', 'employee.id', '=', 'transaction.to_employee_id');
        // }
        if (isset($post_data['department_id']))
            $criteria->where($departmentColumn, $post_data['department_id']);
        if (isset($post_data['employee_id']))
            $criteria->where($employeeColumn, $post_data['employee_id']);
        if (isset($post_data['search']) && ($post_data['search'] != "")) {
            $criteria->where("bag.bag_number", 'like', "%" . $post_data['search'] . "%")
                ->orWhere("bag.order_number", 'like', "%" . $post_data['search'] . "%");
        }

        $criteria->select([
            "transaction.*",
            "bag.bag_number",
            "bag.order_number",
            "department.name as department_name", 'employee.code as employee_code', 'employee.name as employee_name'
        ]);
    }
}
