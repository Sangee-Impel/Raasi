<?php

namespace App\Models;

use App\GenXCommon\XModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class Bag extends XModel
{
    protected $table = 'bag';
    protected $fillable = ['bag_number', 'parent_bag_id', 'order_number', 'instructions', 'status', 'department_id', 'employee_id', 'cancel_otp', 'inc_val', 'created_at', 'updated_at'];

    public function bagStyles()
    {
        return $this->hasMany(BagStyle::class, 'bag_id', 'id')->orderBy("id", "ASC")->with(['style', 'upload', 'otherAccessories', 'transactionItemLossDetails']);
    }
    public function parentBag()
    {
        return $this->hasOne(Bag::class, 'id', 'parent_bag_id');
    }
    public function employee()
    {
        return $this->hasOne(Employee::class, 'id', 'employee_id');
    }
    public function department()
    {
        return $this->hasOne(Department::class, 'id', 'department_id');
    }
    public static function getBagIteration($bagID = null)
    {
        $count = 0;
        if (!is_null($bagID)) {
            $bagModel = Bag::findOrFail($bagID);
            $count =  Bag::where("bag.bag_number", $bagModel['bag_number'])->where("bag.status", XModel::getConfigType("splitted", "bag_status", "value")['id'])->count();
        }
        return $count;
    }

    /* public static function create($data)
    {
        if( empty($data["bag_number"]) || is_null($data["bag_number"]) || !isset($data["bag_number"])  ) {
            $bagOrder = Bag::orderBy('inc_val', 'DESC')->first();
            $bagOrderNum = 1;
            if (!is_null($bagOrder)) {
                $bagOrderNum = intval($bagOrder->inc_val) + 1;
            }
            $data["inc_val"] = $bagOrderNum;
            $data["bag_number"] = "BAG" . sprintf("%04d", $bagOrderNum);
        }
        return parent::create($data);
    }*/
}
