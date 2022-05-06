<?php

namespace App\Http\Controllers\API;

use App\GenXCommon\XModel;
use App\Models\Bag;
use App\Models\BagStyle;
use App\Models\Configuration;
use App\Models\Department;
use App\Models\Employee;
use App\Models\Casting;
use App\Models\CastingWeight;
use App\Models\Transaction;
use App\Models\TransactionItem;
use App\Models\TransactionItemLossDetails;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Config;

class BagController extends Controller
{
    /**
     * Getting grid data
     *
     */

    public function getIndex()
    {
        self::hasPermission('index.bag');
        return view("bag.index");
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        self::hasPermission('index.bag');
        $query = Bag::query()->select(
            'bag.*',
            DB::raw("CASE WHEN bag.department_id = 9 THEN 1 ELSE bag.status END as status"),
            'parent_bag.bag_number as parent_bag_number',
            'department.name as department_name',
            DB::raw("CONCAT(employee.code,'-',employee.name) as employee_name")
        )
            ->leftJoin('bag as parent_bag', 'parent_bag.id', '=', 'bag.parent_bag_id');
        if ($request->has('advanceFilter')) {
            $params = json_decode($request->get('advanceFilter'), true);
            if (!is_null($params)) {
                foreach ($params  as $column => $value) {
                    if (!is_null($value)) {
                        switch ($column) {
                            case 'department_id':
                                $query->where("bag.department_id", $value);
                                break;
                            case 'employee_id':
                                $query->where("bag.employee_id", $value);
                                break;
                        }
                    }
                }
            }
        }

        if ($request->get('trash') == Config::get('constants.trash_on')) {
            $query->onlyTrashed();
        }
        $query->leftJoin('department', 'department.id', '=', 'bag.department_id');
        $query->leftJoin('employee', 'employee.id', '=', 'bag.employee_id');
        $query->groupBy('bag.bag_number')
            ->whereNotIn('bag.status', [XModel::getConfigType("splitted", "bag_status", "value")['id'], XModel::getConfigType("merge", "bag_status", "value")['id']]);
        return XModel::preparePagination($query, $request, ['bag.bag_number', 'department.name', 'parent_bag.bag_number']);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        self::hasPermission('store.bag');
        $validatedData = $request->validate([
            // 'bag_number'                    => 'required|regex:/^[a-zA-Z0-9_]*$/|unique:bag,bag_number,null',
            'order_number'                  => "required",
            'bag_styles'                        => "required|array|min:1",
        ]);


        $post_data  =   $request->all();
        $bag_starting_department  = Configuration::getConfigurationRowByConfigKey("bag_starting_department");

        $casting = Casting::where('name', '=', 'Gold')->first();
        if ($casting) {
            $casting_weight = $casting->weight;
            $total_weight = 0;
            foreach ($post_data['bag_styles'] as $styleBagKey => $styleBagValue) {
                $weight =  $styleBagValue['weight'];
                $total_weight += $weight;
            }

            if ($casting_weight < $total_weight) {
                return response()->json(["errors" => "Please enter a vaild weight", "message" => "Please enter a vaild weight."], 422);
            }

            if (!is_null($bag_starting_department)) {
                $post_data['department_id'] =  $bag_starting_department['bag_starting_department_id'];
                $bagOrder = Bag::orderBy('inc_val', 'DESC')->first();
                $bagOrderNum = 1;
                if (!is_null($bagOrder)) {
                    $bagOrderNum = intval($bagOrder->inc_val) + 1;
                }
                $post_data["inc_val"] = $bagOrderNum;
                $post_data["bag_number"] = "BAG" . sprintf("%04d", $bagOrderNum);

                $bag    =   Bag::create($post_data);

                if ($bag) {
                    $request->validate((new BagStyle())->rules($post_data['bag_styles']));
                    foreach ($post_data['bag_styles'] as $styleBagKey => $styleBagValue) {
                        $styleBagValue['bag_id']   =   $bag['id'];
                        $bagStyle =  BagStyle::create($styleBagValue);
                    }
                    $post_data_create['weight'] = $casting_weight - $total_weight;
                    $weightValue['casting_id']   =   $casting['id'];
                    $weightValue['weight']   =    (float) $total_weight;
                    $weightValue['adjustment']   =   'Lot_Deduct';
                    $weightValue['bag_id'] = $bag['id'];
                    $casting->update($post_data_create);
                    CastingWeight::create($weightValue);
                }
            } else {
                //throw error...!

            }
        } else {
            return response()->json(["errors" => "Please enter a vaild weight", "message" => "No casting data available"], 422);
        }


        return response()->json([], 201);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show(Bag $bag)
    {
        self::hasPermission('update.bag');
        $bag->bagStyles;
        $bag->parentBag;
        return $bag;
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Bag $bag)
    {
        self::hasPermission('update.bag');
        $validatedData = $request->validate([
            //'bag_number'                    => "required|unique:bag,bag_number,$bag->id",
            'order_number'                  => "required",
            'bag_styles'                        => "required|array|min:1",
        ]);
        DB::transaction(function () use ($request, $bag) {
            $post_data  =   $request->all();
            $bag->update($post_data);
            if ($bag) {
                $request->validate((new BagStyle())->rules($post_data['bag_styles']));
                foreach ($post_data['bag_styles'] as $styleKey => $styleValue) {
                    $styleValue['bag_id']   =   $bag['id'];
                    if (isset($styleValue['id']) && $styleValue['id'] > 0) {
                        $style = BagStyle::findOrFail($styleValue['id']);
                        $style->fill($styleValue);
                        $style->update();
                    } else {
                        BagStyle::create($styleValue);
                    }
                }
            }
        });
        return response()->json($bag, 201);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(Request $request, $bag)
    {
        self::hasPermission('destroy.bag');
        if ($request->filled('trash') && $request->get('trash') == 0) {
            $model = Bag::findOrFail($bag);
            $model->delete();
        } else {
            $model = Bag::withTrashed()->find($bag);
            $model->forceDelete();
        }
        return response()->json(null);
    }
    public function restore(Request $request, $id)
    {
        self::hasPermission('restore.bag');
        $model            = Bag::withTrashed()->find($id);
        $model->restore();
        return response()->json(null);
    }
    /**
     * Update bag status.
     *
     * @param  \Illuminate\Http\Request
     * @return \Illuminate\Http\Response
     */
    public function cancel(Request $request)
    {
        self::hasPermission('cancel.bag');
        $validatedData = $request->validate([
            'id'                    => "required",
            'otp'                   => "required",
        ]);
        $post_data = $request->all();
        $bag          = Bag::findOrFail($post_data['id']);
        if ($bag['cancel_otp'] == $post_data['otp']) {
            DB::transaction(function () use ($request, $bag, $post_data) {
                $bag->status  = XModel::getConfigType("cancel", "bag_status", "value")['id'];
                if ($bag->save()) {
                    $total_transfer_weight = 0;
                    $total_transfer_quantity = 0;
                    //#need to change all the bag item into scrab...!
                    $transactionData = [
                        "transaction_date" => date('y-m-d'),
                        "from_department_id" => $bag['department_id'],
                        "from_employee_id" => $bag['employee_id'],
                        "to_department_id" => $bag['department_id'],
                        "to_employee_id" => $bag['employee_id'],
                        "bag_id" => $bag['id'],
                        "total_transfer_weight" => 0,
                        "total_transfer_quantity" => 0,
                        "total_receive_weight" => 0,
                        "status" => XModel::getConfigType("completed", "transaction", "value")['id'],
                        "description" => "DUMMY TRANSACTION",
                        /*"is_eod_reporting" => "",
                        "transaction_mode" => "",
                        "to_bag_id" => "",*/
                    ];
                    $transaction = Transaction::create($transactionData);
                    if ($transaction) {
                        //#transaction item...!
                        $bagStyles = $bag->bagStyles;
                        if (count($bagStyles) > 0) {
                            foreach ($bagStyles as $bagStyleKey => $bagStyleValue) {
                                $uom_id = null;
                                $type = XModel::getConfigType("bag", "transaction_item_type", "value")['id'];
                                if (!is_null($bagStyleValue['other_accessories_id'])) {
                                    $uom_id = $bagStyleValue['otherAccessories']['uom_id'];
                                    $type = XModel::getConfigType("other_accessories", "transaction_item_type", "value")['id'];
                                } else {
                                    $uom_id = $bagStyleValue['style']['uom_id'];
                                }
                                $total_transfer_quantity += $bagStyleValue['quantity'];
                                $total_transfer_weight += $bagStyleValue['weight'];
                                $transactionItemData = [
                                    "transaction_id" => $transaction['id'],
                                    "bag_style_id" => $bagStyleValue['id'],
                                    "status" => XModel::getConfigType("completed", "transaction_type", "value")['id'],
                                    "other_accessories_id" => $bagStyleValue['other_accessories_id'],
                                    "uom_id" => $uom_id,
                                    "quantity" => $bagStyleValue['quantity'],
                                    "weight" => $bagStyleValue['weight'],
                                    "receive_weight" => 0,
                                    "type" => $type,

                                ];
                                $transactionItem = TransactionItem::create($transactionItemData);
                                if ($transactionItem) {
                                    $transactionItemLossDetails = [
                                        "date"  => $transaction['transaction_date'],
                                        "transaction_item_id"  => $transactionItem['id'],
                                        "transaction_id"  => $transactionItem['transaction_id'],
                                        "weight"  => $transactionItem['weight'],
                                        "user_id"  => Auth::id(),
                                        "type"  => XModel::getConfigType("scrap", "transaction_item_loss_type", "value")['id'],
                                        "bag_style_id"  => $transactionItem['bag_style_id'],
                                        /*"admin_approval_loss_weight"  => 0,
                                        "status"  => 0,
                                        "approval_date"  => null,
                                        "admin_id"  => null,
                                        "reason_type_id"  => null,
                                        "loss_description"  => null,*/
                                    ];
                                    TransactionItemLossDetails::create($transactionItemLossDetails);
                                }
                            }
                        }
                        $transaction->total_transfer_quantity = $total_transfer_weight;
                        $transaction->total_transfer_weight = $total_transfer_weight;
                        $transaction->save();
                    }
                }
            });
            return response()->json([]);
        }
        return response()->json(["errors" => "Please enter a valid otp", "message" => "The given data was invalid."], 422);
        /**/
    }
    /**
     * Update bag status.
     *
     * @param  \Illuminate\Http\Request
     * @return \Illuminate\Http\Response
     */
    public function generateOtp(Request $request, $id)
    {
        self::hasPermission('cancel.bag');
        $post_data = $request->all();

        $bag_otp_number  = Configuration::getConfigurationRowByConfigKey("bag_cancel_number");
        if (!is_null($bag_otp_number)) {
            $mobile_number = $bag_otp_number['config_value'];
            $cancelOtp = str_pad(mt_rand(0, 999999), 6, '0', STR_PAD_LEFT); //str_random(6);
            $bag          = Bag::findOrFail($id);
            if (!is_null($bag->cancel_otp))
                $cancelOtp = $bag->cancel_otp;
            else {
                $bag->cancel_otp  = $cancelOtp;
                $bag->save();
            }
            $client = new \GuzzleHttp\Client();
            $response = $client->request('GET', "https://2factor.in/API/V1/09524649-4166-11e8-a895-0200cd936042/SMS/+91$mobile_number/$cancelOtp");
            $statusCode = $response->getStatusCode();
            $content = $response->getBody();
           // return response()->json([]);
        }

        $bag_otp_number  = Configuration::getConfigurationRowByConfigKey("otp_number_1");
        if (!is_null($bag_otp_number)) {
            $mobile_number = $bag_otp_number['config_value'];
            $cancelOtp = str_pad(mt_rand(0, 999999), 6, '0', STR_PAD_LEFT); //str_random(6);
            $bag          = Bag::findOrFail($id);
            if (!is_null($bag->cancel_otp))
                $cancelOtp = $bag->cancel_otp;
            else {
                $bag->cancel_otp  = $cancelOtp;
                $bag->save();
            }
            $client = new \GuzzleHttp\Client();
            $response = $client->request('GET', "https://2factor.in/API/V1/09524649-4166-11e8-a895-0200cd936042/SMS/+91$mobile_number/$cancelOtp");
            $statusCode = $response->getStatusCode();
            $content = $response->getBody();
            // return response()->json([]);
        }

        $bag_otp_number  = Configuration::getConfigurationRowByConfigKey("otp_number_2");
        if (!is_null($bag_otp_number)) {
            $mobile_number = $bag_otp_number['config_value'];
            $cancelOtp = str_pad(mt_rand(0, 999999), 6, '0', STR_PAD_LEFT); //str_random(6);
            $bag          = Bag::findOrFail($id);
            if (!is_null($bag->cancel_otp))
                $cancelOtp = $bag->cancel_otp;
            else {
                $bag->cancel_otp  = $cancelOtp;
                $bag->save();
            }
            $client = new \GuzzleHttp\Client();
            $response = $client->request('GET', "https://2factor.in/API/V1/09524649-4166-11e8-a895-0200cd936042/SMS/+91$mobile_number/$cancelOtp");
            $statusCode = $response->getStatusCode();
            $content = $response->getBody();
            // return response()->json([]);
        }

        $bag_otp_number  = Configuration::getConfigurationRowByConfigKey("otp_number_3");
        if (!is_null($bag_otp_number)) {
            $mobile_number = $bag_otp_number['config_value'];
            $cancelOtp = str_pad(mt_rand(0, 999999), 6, '0', STR_PAD_LEFT); //str_random(6);
            $bag          = Bag::findOrFail($id);
            if (!is_null($bag->cancel_otp))
                $cancelOtp = $bag->cancel_otp;
            else {
                $bag->cancel_otp  = $cancelOtp;
                $bag->save();
            }
            $client = new \GuzzleHttp\Client();
            $response = $client->request('GET', "https://2factor.in/API/V1/09524649-4166-11e8-a895-0200cd936042/SMS/+91$mobile_number/$cancelOtp");
            $statusCode = $response->getStatusCode();
            $content = $response->getBody();
        }

        return response()->json([]);
        /*

        */
        //$bag->status  = XModel::getConfigType("cancel","bag_status","value")['id'];

    }
    public function deleteBagStyle(Request $request,  $bagStyles)
    {
        $bagStyles = BagStyle::findOrFail($bagStyles);
        $bagStyles->delete();
        return response()->json("ok", 203);
    }
    /**
     * function for search the style.
     */
    public function search(Request $request)
    {
        $post_data      =   $request->all();
        $query          =   Bag::query()->select(['bag.*']);
        if (isset($post_data['q'])) {
            $query->where("bag.bag_number", 'like', "%" . $post_data['q'] . "%");
        }

        if (isset($post_data['id']) && !is_null($post_data['id'])) {
            $query->whereNotIn('bag.id', [$post_data['id']]);
        }
        $query->with(['bagStyles']);
        $bagData      =     $query->get();
        return $bagData;
    }
    public function dropDown(Request $request)
    {
        $post_data      =   $request->all();
        $departmentQuery = Department::query();
        $departmentQuery->with(['employees']);
        $result         =   [
            "department"    =>  $departmentQuery->get(),
            "employee"      =>  Employee::get()
        ];
        return $result;
    }
}
