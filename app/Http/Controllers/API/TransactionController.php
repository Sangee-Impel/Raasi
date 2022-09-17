<?php

namespace App\Http\Controllers\API;

use App\GenXCommon\XModel;
use App\Models\Bag;
use App\Models\BagStyle;
use App\Models\Department;
use App\Models\Employee;
use App\Models\OtherAccessories;
use App\Models\Style;
use App\Models\StyleDepartmentLossApproval;
use App\Models\Transaction;
use App\Models\Casting;
use App\Models\CastingWeight;
use App\Models\TransactionItem;
use App\Models\TransactionItemLossDetails;
use App\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Config;
use Illuminate\Support\Facades\DB;

use Illuminate\Support\Facades\Validator;

class TransactionController extends Controller
{
    /**
     * Getting grid data
     *
     */

    public function getIndex()
    {
        return view("transaction.index");
    }

    public function getTransaction()
    {
        return view("transaction.form");
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        self::hasPermission('index.transaction');
        $query = Transaction::query()->select(
            'transaction.*',
            'bag.bag_number',
            'bag.order_number',
            'from_department.name as from_department_name',
            'to_department.name as to_department_name',
            /*'to_employee.name as to_employee_name',
            'to_employee.code as to_employee_code',*/
            DB::raw("CONCAT(from_employee.code,'-',from_employee.name) as from_employee_name"),
            DB::raw("CONCAT(to_employee.code,'-',to_employee.name) as to_employee_name")
        );
        if ($request->get('trash') == Config::get('constants.trash_on')) {
            $query->onlyTrashed();
        }
        if (!(auth()->user()->isAdmin())) {
            $userDetails = User::getUserDetails();
            if ($userDetails['employee'] != null) {
                $employee_id = $userDetails['employee']['id'];
                $query
                    ->where('transaction.from_employee_id', $employee_id)
                    ->orWhere('transaction.to_employee_id', $employee_id);
            }
        }

        $query->leftJoin('bag', 'bag.id', '=', 'transaction.bag_id');
        $query->leftJoin('department as from_department', 'from_department.id', '=', 'transaction.from_department_id');
        $query->leftJoin('employee as from_employee', 'from_employee.id', '=', 'transaction.from_employee_id');
        $query->leftJoin('department as to_department', 'to_department.id', '=', 'transaction.to_department_id');
        $query->leftJoin('employee as to_employee', 'to_employee.id', '=', 'transaction.to_employee_id');

        return XModel::preparePagination($query, $request, [
            'bag.bag_number',
            'bag.order_number',
            'from_department.name',
            'to_department.name',
            'from_employee.code', 'from_employee.name',
            'to_employee.code', 'to_employee.name',
        ]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        self::hasPermission('store.transaction');
        $request->validate([
            'transaction_date' => 'required',
            'bag_id' => 'required',
            'from_department_id' => 'required_without:from_employee_id',
            'from_employee_id' => 'required_without:from_department_id',
            'to_department_id' => 'required_without:to_employee_id',
            'to_employee_id' => 'required_without:to_department_id',
            'total_transfer_quantity' => 'required|numeric|gt:0',
            'total_transfer_weight' => 'required|numeric|gt:0',
            'total_receive_weight' => 'required|numeric|gt:0',
            'transaction_items.*.weight' => 'required|numeric|gt:0',
            'transaction_items.*.receive_weight' => 'required|numeric|gt:0|lte:transaction_items.*.weight',
            'transaction_items.*.other_accessories_id' => 'required_without:transaction_items.*.bag_style_id',
            'transaction_items.*.bag_style_id' => 'required_without:transaction_items.*.other_accessories_id',
            'transaction_items.*.quantity' => 'required|integer|gt:0',
            'transaction_items.*.uom_id' => 'required|numeric'
        ]);
        // DB::transaction(function() use ($request) {

        // });

        $post_data  =   $request->all();

        //#block for receive quantity validation...!
        $bag = Bag::findOrFail($post_data['bag_id']);
        $receiveWeightRule = ['transaction_items.*.receive_weight' => 'required|numeric|same:transaction_items.*.weight'];
        $bagEmployee = null;
        if (!is_null($bag['employee_id'])) {
            $bagEmployee = Employee::findOrFail($bag['employee_id']);
            $receiveWeightRule = [
                'transaction_items.*.receive_weight' => 'required|numeric|gt:0|lte:transaction_items.*.weight',
                //'transaction_items.*.user_loss_scrap_weight'=>'required|numeric|same:transaction_items.*.max_loss_weight',

                'transaction_items.*.transaction_item_loss_details' => 'required_if:transaction_items.*.receive_weight,!=,transaction_items.*.weight',
                'transaction_items.*.transaction_item_loss_details.*.weight' => 'required_if:transaction_items.*.receive_weight,!=,transaction_items.*.weight|gte:0',
                'transaction_items.*.transaction_item_loss_details.*.type' => 'required_if:transaction_items.*.receive_weight,!=,transaction_items.*.weight',
            ];
            /*'transaction_items.*.transaction_item_loss_details.*.user_id'=>'required_if:transaction_items.*.transaction_item_loss_details.*.type,'.XModel::getConfigType("scrap","transaction_item_loss_type","value")['id'],*/
        }
        $name = [];
        $transaction_items = $post_data['transaction_items'];
        foreach ($transaction_items as $transaction_item_key => $transaction_item_value) {
            if ($transaction_item_value['id'] == 0) {
                if (isset($transaction_item_value['bag_style_id']) && $transaction_item_value['bag_style_id'] > 0) {
                    if (!isset($name['Gold'])) {
                        $name['Gold']['weight'] = 0;
                    }
                    $name['Gold']['weight'] += $transaction_item_value['receive_weight'];
                    $name['Gold']['quantity'] = $transaction_item_value['quantity'];
                } else {
                    if (!isset($name[$transaction_item_value['other_accessories']['name']])) {
                        $name[$transaction_item_value['other_accessories']['name']]['weight'] = 0;
                    }
                    $name[$transaction_item_value['other_accessories']['name']]['weight'] +=  $transaction_item_value['receive_weight'];
                    $name[$transaction_item_value['other_accessories']['name']]['quantity'] =  $transaction_item_value['quantity'];
                }
            }
        }
        if (!empty($name)) {
            foreach ($name as $n => $weight) {
                $casting = Casting::where('name', '=', $n)->first();
                if (!$casting) {
                    return response()->json(["errors" => "Please enter a vaild weight", "message" => "No casting data available for " . $n], 422);
                }
                if ($casting->weight < $weight['weight']) {
                    return response()->json(["errors" => "Please enter a vaild weight", "message" => "Please enter a vaild weight for casting: " . $n], 422);
                }
            }
        }

        $request->validate($receiveWeightRule);
        $isSplitMode = false;
        $isMergeMode = false;
        //#block for check transaction mode...!
        if (isset($post_data['transaction_mode'])) {
            switch ($post_data['transaction_mode']) {
                case XModel::getConfigType("split_mode", "transaction_mode", "value")['id']:
                    //#block for split bag validation...!
                    $isSplitMode = true;
                    $rules = [];
                    foreach ($request->get('transaction_items') as $validatorKey => $validatorValue) {
                        if ($validatorValue['split']['transfer']['weight'] > 0)
                            $rules['transaction_items.' . $validatorKey . '.split.transfer.quantity'] = 'required|numeric|gt:0';
                        if ($validatorValue['split']['transfer']['quantity'] > 0)
                            $rules['transaction_items.' . $validatorKey . '.split.transfer.weight'] = 'required|gt:0';

                        if ($validatorValue['split']['receive']['weight'] > 0)
                            $rules['transaction_items.' . $validatorKey . '.split.receive.quantity'] = 'required|numeric|gt:0';
                        if ($validatorValue['split']['receive']['quantity'] > 0)
                            $rules['transaction_items.' . $validatorKey . '.split.receive.weight'] = 'required|gt:0';
                    }

                    $transaction_items = $post_data['transaction_items'];
                    $splitArray = array_column($transaction_items, 'split');

                    $transferArray = array_filter(array_column($splitArray, "transfer"), function ($value) {
                        return $value['quantity'] > 0 && $value['weight'] > 0;
                    });
                    $receiveArray = array_filter(array_column($splitArray, "receive"), function ($value) {
                        return $value['quantity'] > 0 && $value['weight'] > 0;
                    });
                    $weight =  $qty = 0;

                    foreach ($receiveArray as $k => $tk) {
                        $weight += $tk['weight'];
                        $qty += $tk['quantity'];
                    }

                    $post_data['total_transfer_weight'] = $post_data['total_transfer_weight'] - $weight;
                    $post_data['total_receive_weight'] = $post_data['total_receive_weight'] - $weight;
                    $post_data['total_transfer_quantity'] = $post_data['total_transfer_quantity'] - $qty;

                    /*$request->validate([
                            'transaction_items.*.split.receive.quantity' => 'required_if:transaction_items.*.split.receive.weight,gt,0',
                        ]);*/
                    $request->validate($rules);
                    break;
                case XModel::getConfigType("merge_mode", "transaction_mode", "value")['id']:
                    $isMergeMode = true;
                    //#todo need to validate...!
                    $request->validate([
                        'merge.receive' => 'required',
                        'merge.transfer' => 'required',
                    ]);
                    break;
            }
        }
        //#block for check
        //$post_data['status'] = XModel::getConfigType("completed","transaction","value")['id'];
        $transaction = Transaction::create($post_data);

        if ($transaction) {
            //#block for change bag department...!
            if ($transaction->status == XModel::getConfigType("completed", "transaction", "value")['id']) {
                if (!$isSplitMode && !$isMergeMode) {
                    $bag->department_id = $transaction['to_department_id'];
                    $bag->employee_id = $transaction['to_employee_id'];
                    if (!is_null($transaction['to_department_id'])) {
                        //#block to check the bag status...!
                        $department = Department::findOrFail($transaction['to_department_id']);
                        if (Config::get('constants.department.final_process_status.is_final') == $department->is_last)
                            $bag->status    =   XModel::getConfigType("completed", "bag_status", "value")['id'];
                    }
                }
            } else {
                //                    $bag->status = XModel::getConfigType("admin_loss_approval","bag_status","value")['id'];
                $bag->status = XModel::getConfigType("in_progress", "bag_status", "value")['id'];
            }
            if ($bag->save()) {
                $transaction_items = $post_data['transaction_items'];
                $post_data_create = [];
                if (!empty($name)) {
                    foreach ($name as $n => $weight) {
                        $casting = Casting::where('name', '=', $n)->first();
                        $post_data_create['weight'] = (float)  $casting->weight - (float) $weight['weight'];;
                        $weightValue['casting_id']   =   $casting['id'];
                        $weightValue['quantity']   =   $weight['quantity'];
                        $weightValue['weight']   =    (float) $weight['weight'];
                        $weightValue['adjustment']   =   'Transaction_Deduct';
                        $weightValue['transaction_id']   =   $transaction['id'];
                        $casting->update($post_data_create);
                        CastingWeight::create($weightValue);
                    }
                }

                $transaction_item_loss_details = isset($post_data['transaction_item_loss_details']) ? $post_data['transaction_item_loss_details'] : array();
                if (count($transaction_items) > 0) {
                    $transferBagID = null;
                    $receiveBagID = null;
                    //#block for save split bag...!
                    if ($isSplitMode) {
                        $bag->status    =   XModel::getConfigType("splitted", "bag_status", "value")['id'];

                        //#block to check the bag status...!
                        if ($bag->save()) {
                            $t = Transaction::where('bag_id', '=', $bag['id'])->get();
                            $transferBag = [
                                "parent_bag_id" => $bag['id'],
                                "bag_number" => $bag['bag_number'],
                                "order_number" => $bag['order_number'],
                                "instructions" => $bag['instructions'],
                                "department_id" => $bag['department_id'],
                                "employee_id" => $bag['employee_id'],
                                "created_at" => $bag['created_at'],
                                "updated_at" => $bag['updated_at']
                            ];
                            $receiveBag = [
                                "parent_bag_id" => $bag['id'],
                                "bag_number" => $bag['bag_number'] . Config::get('constants.bag_split_string') . Bag::getBagIteration($bag['id']),
                                "order_number" => $bag['order_number'],
                                "instructions" => $bag['instructions'],
                                "department_id" => $transaction['to_department_id'],
                                "employee_id" =>  $transaction['to_employee_id'],
                                "created_at" => $bag['created_at'],
                                "updated_at" => $bag['updated_at']
                            ];
                            $department = Department::findOrFail($transaction['to_department_id']);
                            if (Config::get('constants.department.final_process_status.is_final') == $department->is_last)
                                $receiveBag["status"]    =   XModel::getConfigType("completed", "bag_status", "value")['id'];

                            //#check split bag is valid or not....!
                            $splitArray = array_column($transaction_items, 'split');

                            $transferArray = array_filter(array_column($splitArray, "transfer"), function ($value) {
                                return $value['quantity'] > 0 && $value['weight'] > 0;
                            });
                            $receiveArray = array_filter(array_column($splitArray, "receive"), function ($value) {
                                return $value['quantity'] > 0 && $value['weight'] > 0;
                            });

                            if (count($transferArray) > 0) {
                                //print_r($transferBag);exit;
                                $transfer = Bag::create($transferBag);
                                $transferBagID = $transfer['id'];

                                if (!empty($t)) {
                                    foreach ($t as $k => $tk) {
                                        $tk->bag_id = $transferBagID;
                                        $tk->save();
                                    }
                                }
                            }
                            if (count($receiveArray) > 0) {
                                $receive_t = Transaction::where('id', '=', $transaction['id'])->first();
                                $receive = Bag::create($receiveBag);
                                $receiveBagID = $receive['id'];
                                $receive_t->to_bag_id = $receiveBagID;
                                $receive_t->save();

                                $weight =  $qty = 0;
                                $oa = array_column($transaction_items, 'other_accessories');
                                $i = [];

                                foreach ($oa as $k => $a) {
                                    if (!empty($a)) {
                                        $i[] = @$a['id'];
                                    }
                                }

                                foreach ($receiveArray as $k => $tk) {
                                    if (!in_array($tk['class'], $i)) {
                                        $weight += $tk['weight'];
                                        $qty += $tk['quantity'];
                                    }
                                }

                                $n_transaction = Transaction::create($post_data);
                                $n_transaction->bag_id = $receiveBagID;
                                $n_transaction->total_transfer_quantity = $qty;
                                $n_transaction->total_transfer_weight = $weight;
                                $n_transaction->total_receive_weight = $weight;
                                $n_transaction->total_loss_weight = 0;
                                $n_transaction->total_loss_quantity = 0;
                                $n_transaction->transaction_mode = 0;
                                $n_transaction->save();
                            }
                        }
                    }
                    //#block for save merge bag...!
                    if ($isMergeMode) {
                        $mergeData = $post_data['merge'];
                        $bag->status    =   XModel::getConfigType("merge", "bag_status", "value")['id'];
                        if ($bag->save()) {
                            $totalTransferQuantity  = 0;
                            $totalTransferWeight    = 0;
                            $toBagID                =   null;
                            $fromBagID              =   $transaction['bag_id'];
                            $transferBag = [
                                //"parent_bag_id" => $bag['id'],
                                "bag_number" => $bag['bag_number'],
                                "order_number" => $bag['order_number'],
                                "instructions" => $bag['instructions'],
                                "department_id" => $transaction['to_department_id'],
                                "employee_id" =>  $transaction['to_employee_id'],
                                "created_at" => $bag['created_at'],
                                "updated_at" => $bag['updated_at']
                            ];
                            $t = Transaction::where('bag_id', '=', $bag['id'])->get();
                            if (isset($mergeData['transfer'])) {
                                $transfer = Bag::create($transferBag);
                                if ($transfer) {
                                    $fromBagID = $transfer['id'];
                                    if (!empty($t)) {
                                        foreach ($t as $k => $tk) {
                                            $tk->bag_id = $fromBagID;
                                            $tk->save();
                                        }
                                    }
                                    $transferBagStyles = $mergeData['transfer'];
                                    if (count($transferBagStyles) > 0) {
                                        foreach ($transferBagStyles as $transferBagStyleKey => $transferBagStyleValue) {
                                            if ($transferBagStyleValue['quantity'] > 0 && $transferBagStyleValue['weight'] > 0) {
                                                $bagStyleData = $transferBagStyleValue;
                                                if ($bagStyleData['bag_style'] != null) {
                                                    $bagStyleData =  $bagStyleData['bag_style'];
                                                    $totalTransferQuantity += $transferBagStyleValue['quantity'];
                                                    $totalTransferWeight += $transferBagStyleValue['weight'];
                                                    $bagStyleData['quantity'] = $transferBagStyleValue['quantity'];
                                                    $bagStyleData['weight'] = $transferBagStyleValue['weight'];
                                                    $bagStyleData['weight'] = $transferBagStyleValue['weight'];
                                                    $bagStyleData['created_at'] = $bagStyleData['created_at'];
                                                    $bagStyleData['updated_at'] = $bagStyleData['updated_at'];
                                                }
                                                $bagStyleData['bag_id'] = $transfer['id'];
                                                $bagStyle = BagStyle::create($bagStyleData);
                                                if ($bagStyle) {
                                                    $uomId = null;
                                                    $styleId = $bagStyle['style_id'];
                                                    $otherAccessoriesId = $bagStyle['other_accessories_id'];
                                                    if (!is_null($styleId)) {
                                                        $style = Style::findOrFail($styleId);
                                                        $uomId = $style['uom_id'];
                                                    }
                                                    if (!is_null($otherAccessoriesId)) {
                                                        $otherAccessories = OtherAccessories::findOrFail($otherAccessoriesId);
                                                        $uomId = $otherAccessories['uom_id'];
                                                    }
                                                    //#todo assign to a constant value
                                                    $type = is_null($bagStyle['other_accessories_id']) ? 0 : 1;
                                                    $transactionItem = [
                                                        "transaction_id"        => $transaction['id'],
                                                        "bag_style_id"          => $bagStyle['id'],
                                                        "other_accessories_id"  => $bagStyle['other_accessories_id'],
                                                        "uom_id"                => $uomId,
                                                        "quantity"              => $bagStyle['quantity'],
                                                        "weight"                => $bagStyle['weight'],
                                                        "receive_weight"        => $bagStyle['weight'],
                                                        "type"                  => $type,
                                                    ];
                                                    //#need to create transaction items...!
                                                    TransactionItem::create($transactionItem);
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            //#block for receive bag...!
                            if (isset($mergeData['receive'])) {
                                $receiveBagID =  $mergeData['receive']['id'];
                                $oldReceiveBag = Bag::findOrFail($receiveBagID);
                                $oldReceiveBag->status    =   XModel::getConfigType("merge", "bag_status", "value")['id'];
                                if ($oldReceiveBag->save()) {
                                    $receiveBag = [
                                        // "parent_bag_id" => $oldReceiveBag['id'],
                                        "bag_number" => $oldReceiveBag['bag_number'],
                                        "order_number" => $oldReceiveBag['order_number'],
                                        "instructions" => $oldReceiveBag['instructions'],
                                        "department_id" => $oldReceiveBag['department_id'],
                                        "employee_id" =>  $oldReceiveBag['employee_id'],
                                        "created_at" => $oldReceiveBag['created_at'],
                                        "updated_at" => $oldReceiveBag['updated_at']
                                    ];
                                    $receive = Bag::create($receiveBag);
                                    $t = Transaction::where('bag_id', '=', $oldReceiveBag['id'])->get();
                                    if (!empty($t)) {
                                        foreach ($t as $k => $tk) {
                                            $tk->bag_id = $fromBagID;
                                            $tk->save();
                                        }
                                    }

                                    $to = Transaction::where('to_bag_id', '=', $oldReceiveBag['id'])->get();
                                    if (!empty($to)) {
                                        foreach ($to as $k => $tok) {
                                            $tok->to_bag_id = $receive['id'];
                                            $tok->save();
                                        }
                                    }

                                    if ($receive) {
                                        $toBagID = $receive['id'];
                                        if (!empty($t)) {
                                            foreach ($t as $k => $tk) {
                                                $tk->bag_id = $toBagID;
                                                $tk->save();
                                            }
                                        }

                                        $receiveBagStyles = $mergeData['receive']['bag_styles'];
                                        if (count($receiveBagStyles) > 0) {
                                            foreach ($receiveBagStyles as $receiveBagStyleKey => $receiveBagStyleValue) {
                                                if ($receiveBagStyleValue['quantity'] > 0 && $receiveBagStyleValue['weight'] > 0) {
                                                    $receiveBagStyleValue['bag_id'] = $toBagID;
                                                    $cBag =   Bag::findOrFail($toBagID);
                                                    $receiveBagStyleValue['created_at'] = $cBag->created_at;
                                                    $receiveBagStyleValue['updated_at'] = $cBag->updated_at;
                                                    BagStyle::create($receiveBagStyleValue);
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            //#need to update transaction...!
                            $updateTransaction = Transaction::findOrFail($transaction['id']);

                            $updateTransaction->total_transfer_quantity = $totalTransferQuantity;
                            $updateTransaction->total_transfer_weight = $totalTransferWeight;
                            $updateTransaction->total_receive_weight = $totalTransferWeight;
                            $updateTransaction->total_receive_weight = $totalTransferWeight;
                            $updateTransaction->total_receive_weight = $totalTransferWeight;
                            $updateTransaction->to_bag_id = $toBagID;
                            $updateTransaction->bag_id = $fromBagID;
                            $updateTransaction->total_loss_weight = 0;
                            $updateTransaction->total_loss_quantity = 0;
                            $updateTransaction->save();
                        }
                    } else {
                        //#split or normal transaction...!
                        foreach ($transaction_items as $transaction_item_key => $transaction_item_value) {
                            $transaction_item_value['transaction_id'] = $transaction['id'];
                            if ($bag->status != XModel::getConfigType("admin_loss_approval", "bag_status", "value")['id']) {
                                if (isset($transaction_item_value['bag_style_id']) && $transaction_item_value['bag_style_id'] > 0) {
                                    //#block to update the receive quantity as quantity...!
                                    $bagStyle = BagStyle::findOrFail($transaction_item_value['bag_style_id']);
                                    $bagStyle->weight = $transaction_item_value['receive_weight'];
                                    $bagStyle->save();
                                } else {
                                    //#addiing bag additional accessories to the bag...!
                                    $bagStyleData = $transaction_item_value;
                                    $bagStyleData['weight'] = $transaction_item_value['receive_weight'];
                                    $bagStyleData['bag_id'] = $transaction['bag_id'];
                                    // $cBag =   Bag::findOrFail($transaction['bag_id']);
                                    // $bagStyleData['created_at'] = $cBag->created_at;
                                    // $bagStyleData['updated_at'] = $cBag->updated_at;
                                    $bagStyle = BagStyle::create($bagStyleData);
                                    $transaction_item_value['bag_style_id']  = $bagStyle['id'];
                                }
                                //#block to split the bag...!
                                if (!is_null($transferBagID) && isset($transaction_item_value['split']['transfer'])) {
                                    if ($transaction_item_value['split']['transfer']['weight'] > 0 &&  $transaction_item_value['split']['transfer']['quantity'] > 0) {
                                        $cBag =   Bag::findOrFail($transferBagID);
                                        $transferBagStyleData = [
                                            "bag_id"                =>  $transferBagID,
                                            "style_id"              =>  $bagStyle['style_id'],
                                            "other_accessories_id"  =>  $bagStyle['other_accessories_id'],
                                            "upload_id"             =>  $bagStyle['upload_id'],
                                            "quantity"              =>  $transaction_item_value['split']['transfer']['quantity'],
                                            "weight"                =>  $transaction_item_value['split']['transfer']['weight'],
                                            "instructions"          =>  $bagStyle['instructions'],
                                            "parent_bag_style_id"   =>  $bagStyle['id'],
                                            "created_at" => $bagStyle['created_at'],
                                            "updated_at" => $bagStyle['updated_at']
                                        ];
                                        BagStyle::create($transferBagStyleData);
                                    }
                                }
                                if (!is_null($receiveBagID) && isset($transaction_item_value['split']['receive'])) {
                                    if ($transaction_item_value['split']['receive']['weight'] > 0 &&  $transaction_item_value['split']['receive']['quantity'] > 0) {
                                        $cBag =   Bag::findOrFail($receiveBagID);
                                        $transferBagStyleData = [
                                            "bag_id"                =>  $receiveBagID,
                                            "style_id"              =>  $bagStyle['style_id'],
                                            "other_accessories_id"  =>  $bagStyle['other_accessories_id'],
                                            "upload_id"             =>  $bagStyle['upload_id'],
                                            "quantity"              =>  $transaction_item_value['split']['receive']['quantity'],
                                            "weight"                =>  $transaction_item_value['split']['receive']['weight'],
                                            "instructions"          =>  $bagStyle['instructions'],
                                            "parent_bag_style_id"          =>  $bagStyle['id'],
                                            "created_at" => $bagStyle['created_at'],
                                            "updated_at" => $bagStyle['updated_at']
                                        ];
                                        BagStyle::create($transferBagStyleData);
                                    }
                                }
                            }



                            $transaction_item = TransactionItem::create($transaction_item_value);
                            if ($transaction_item) {
                                if (!is_null($bagEmployee)) {
                                    if ($transaction_item_value['weight'] > $transaction_item_value['receive_weight']) {
                                    }
                                }
                            }
                        }
                    }
                }
                if (count($transaction_item_loss_details) > 0) {
                    $admin_loss                 = StyleDepartmentLossApproval::where('department_id', $bag->department_id)->get();
                    $admin_approval_loss_weight = $admin_loss[0]->percentage;
                    $status = XModel::getConfigType("in_progress", "bag_status", "value")['id'];
                    foreach ($transaction_item_loss_details as $transaction_item_loss_detail_key => $transaction_item_loss_detail_value) {
                        if ($transaction_item_loss_detail_value['weight'] > 0) {
                            //$transaction_item_loss_detail_value['transaction_item_id'] = $transaction_item['id'];
                            $transaction_item_loss_detail_value['transaction_id'] = $transaction['id'];
                            //$transaction_item_loss_detail_value['bag_style_id'] = $transaction_item_value['bag_style_id'];
                            $transaction_item_loss_detail_value['date'] = $transaction['transaction_date'];
                            //$transaction_item_loss_detail_value['user_id'] = $bagEmployee['user_id'];
                            $transaction_item_loss_detail_value['admin_approval_loss_weight'] = (float) $admin_approval_loss_weight;
                            $transaction_item_loss_detail_value['status'] = XModel::getConfigType("approved", "transaction_item_loss_status", "value")['id'];
                            if ($transaction_item_loss_detail_value['type'] == XModel::getConfigType("loss", "transaction_item_loss_type", "value")['id']) {
                                if ($admin_approval_loss_weight < $transaction_item_loss_detail_value['weight']) {
                                    $transaction_item_loss_detail_value['status'] = XModel::getConfigType("waiting_admin_approval", "transaction_item_loss_status", "value")['id'];
                                    $status = XModel::getConfigType("admin_loss_approval", "bag_status", "value")['id'];
                                }
                            }
                            //#status for loss approval...!
                            TransactionItemLossDetails::create($transaction_item_loss_detail_value);
                        }
                    }
                    $bag->status    = $status;
                    $bag->save();
                }
            }
        }
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

    public function getDepartmentBag($departmentId = null, $employeeId = null)
    {
        $bag = [];
        if (!is_null($departmentId)) {
            $alreadyTransferBag = [];
            $employeeArray      = [null];
            if (is_null($employeeId)) {
                $employeeArray = [null, $employeeId];
            }


            $transaction = Transaction::where("from_department_id", $departmentId)
                ->where("status", XModel::getConfigType("in_progress", "transaction_type", "value")['id'])
                ->get();
            if (count($transaction) > 0) {
                foreach ($transaction as $transactionKey => $transactionValue) {
                    $alreadyTransferBag[] = $transactionValue['bag_id'];
                }
            }
            $query = Bag::query()->where("bag.department_id", $departmentId)
                ->whereNotIn("bag.id", $alreadyTransferBag)
                ->whereNull('bag.employee_id');
            if (!is_null($employeeId)) {
                $query->orWhere('bag.employee_id', '=', $employeeId);
            }
            $query->with(['bagStyles']);
            $bag = $query->get();
            //$department = Department::findOrFail($departmentId);
            //$bag = $department->bags;
        }
        return $bag;
    }
    public function getDropDownData(Request $request)
    {
        $postData    =   $request->all();
        $loginUser = User::getUserDetails();
        if (isset($postData['tab_status'])) {
            if ($postData['tab_status'] == "issue") {
                if (!isset($postData['from_employee_id'])) {
                    if (isset($loginUser['employee']) && isset($loginUser['employee']['id'])) {
                        $postData['from_employee_id'] = $loginUser['employee']['id'];
                    }
                }
                if (!isset($postData['from_department_id'])) {
                    if (isset($loginUser['department']) && isset($loginUser['department'])) {
                        $postData['from_department_id'] = $loginUser['department']['id'];
                    }
                }
            } else {
                if (!isset($postData['to_employee_id'])) {
                    if (isset($loginUser['employee']) && isset($loginUser['employee']['id'])) {
                        $postData['to_employee_id'] = $loginUser['employee']['id'];
                    }
                }
                if (!isset($postData['to_department_id'])) {
                    if (isset($loginUser['department']) && isset($loginUser['department'])) {
                        $postData['to_department_id'] = $loginUser['department']['id'];
                    }
                }
            }
        }

        return [
            "department"    =>  Department::get(),
            "form_department"    =>  Transaction::getDepartmentBasedOnSelectedDepartment($postData['to_department_id']),
            "to_department"    =>  Transaction::getDepartmentBasedOnSelectedDepartment(), //$postData['from_department_id']
            "form_employee" =>  Transaction::getEmployeeBasegOnDepartment($postData['from_department_id'], $postData['to_department_id']),
            //"bags"      =>  $this->getDepartmentBag($postData['from_department_id'],$postData['from_employee_id']),
            "to_employee"   =>  Transaction::getEmployeeBasegOnDepartment($postData['to_department_id'], null), //, $postData['from_employee_id'],$postData['from_department_id']
            "other_accessories" => OtherAccessories::query()->with(['uom'])->get(),
            "login_user_details" => $loginUser,
            "users" =>  User::all(),
        ];
    }
    public function changeTransactionItemStatus(Request $request)
    {
        DB::transaction(function () use ($request) {
            $postData    =   $request->all();
            if (isset($postData['id']) &&  isset($postData['type'])) {
                $transactionItem = TransactionItem::findOrFail($postData['id']);
                $transactionItem->status = $postData['type'];
                if ($transactionItem->save()) {
                    //#todo check status ..!
                    $transactionItems = TransactionItem::where("transaction_id", $transactionItem['transaction_id'])
                        ->where("status", XModel::getConfigType("in_progress", "transaction_type", "value")['id'])
                        ->get();
                    if (count($transactionItems) == 0) {
                        $transaction = Transaction::findOrFail($transactionItem['transaction_id']);
                        //#block for change bag department...!
                        $transaction->status = XModel::getConfigType("completed", "transaction", "value")['id'];
                        if ($transaction->save()) {
                            $bag = Bag::findOrFail($transaction['bag_id']);
                            $bag->department_id = $transaction['to_department_id'];
                            $bag->employee_id = $transaction['to_employee_id'];
                            $bag->save();
                        }
                    }
                }
            }
        });
    }
    /**
     * function for search the style.
     */
    public function searchBag(Request $request)
    {
        $post_data      =   $request->all();
        $query          =   Bag::query()->select(['bag.*'])
            ->whereIn("bag.status", [XModel::getConfigType("in_progress", "bag_status", "value")['id']]);
        if (isset($post_data['q'])) {
            $query->where("bag.bag_number", 'like', "%" . $post_data['q'] . "%");
        }
        if (!is_null($post_data['from_department_id']))
            $query->where('bag.department_id', $post_data['from_department_id']);
        if (!is_null($post_data['from_employee_id']))
            $query->where('bag.employee_id', $post_data['from_employee_id']);

        if (!is_null($post_data['to_department_id']))
            $query->whereNotIn('bag.department_id', [$post_data['to_department_id']]);
        if (isset($post_data['bag_id'])) {
            $query->whereNotIn('bag.id', [$post_data['bag_id']]);
        }
        /*if(  !is_null($post_data['to_employee_id']))
            $query->whereNotIn('bag.employee_id', [$post_data['to_employee_id']]);*/
        $query->groupBy('bag.bag_number');
        /*$isJobCardSearch  = false;
        if( isset($post_data['is_job_card_search']) && $post_data['is_job_card_search'] == Config::get('constants.success') )
            $isJobCardSearch = true;
        if( !$isJobCardSearch ){
            $isDepartmentSearch = true;
            if( is_null($post_data['department_id'])  ){
                if( !is_null($post_data['employee_id']) )
                    $isDepartmentSearch = false;
            }
            if( $isDepartmentSearch )
                $query->where('bag.department_id', $post_data['department_id']);

        }*/
        $query->with(['bagStyles', 'department', 'employee']);
        $bagData      =     $query->get();
        if (count($bagData) > 0) {
            foreach ($bagData as $bagKey => $bagValue) {
                //#block to get last transaction to department and employee if it is eod reporting block...!
                $transaction = Transaction::where('bag_id', $bagValue['id'])
                    ->orderBy('transaction_date', 'DESC')
                    ->orderBy('id', 'DESC')
                    ->with(['fromDepartment', 'fromEmployee', 'toDepartment', 'toEmployee'])
                    ->first();
                if (!is_null($transaction)) {
                    $bagValue['last_transaction'] = $transaction;
                }
                $bagValue['iteration'] = Bag::getBagIteration($bagValue['id']); //Bag::where("bag.parent_bag_id",$bagValue['id'])->count();
                /*if( $isJobCardSearch ){

                }*/
            }
        }

        return $bagData;
    }
}
