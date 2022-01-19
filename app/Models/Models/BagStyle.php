<?php

namespace App\Models;

use App\GenXCommon\XModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class BagStyle extends XModel
{
    protected $table = 'bag_styles';
    protected $fillable = ['bag_id','style_id','other_accessories_id','upload_id','quantity','weight','instructions','parent_bag_style_id'];
    public function bag()
    {
        return $this->belongsTo(Bag::class);
    }
    public function style(){
        return $this->hasOne(Style::class,'id','style_id')->with(['product','upload','uom','styleDepartmentLossApproval','styleImages']);
    }
    public function otherAccessories(){
        return $this->hasOne(OtherAccessories::class,'id','other_accessories_id')->with(['uom']);
    }
    public function upload() {
        return $this->belongsTo(Uploads::class,'upload_id','id');
    }
    public function transactionItem(){
        return $this->hasMany(TransactionItem::class);
    }
    public function bagStyleImages(){
        return $this->hasMany(BagStyleImages::class)->with(['upload']);
    }
    public function transactionItemLossDetails(){
        return $this->hasMany(TransactionItemLossDetails::class)->orderBy('date','ASC')->orderBy('id', 'ASC')->with(['user']);
    }
    public  function rules($styleData)
    {
        $rules = [
            'bag_styles.*.quantity'   => 'required|numeric|gte:1',
            'bag_styles.*.weight'   => 'required|numeric|gte:1',
            'bag_styles.*.style_id'   => 'required|numeric',
        ];
        return $rules;
    }
}
