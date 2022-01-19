<?php

namespace App\Models;

use App\GenXCommon\XModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class TransactionItem extends XModel
{
    protected $table = 'transaction_item';
    protected $fillable = ['transaction_id','type','bag_style_id','other_accessories_id','status','uom_id','quantity','weight','receive_weight'];
    public function bagStyle(){
        return $this->belongsTo(BagStyle::class,'bag_style_id','id')->with(['style','otherAccessories','upload']);
    }
    public function uom(){
        return $this->belongsTo(Uom::class,'uom_id','id');
    }
    public function otherAccessories(){
        return $this->belongsTo(OtherAccessories::class,'other_accessories_id','id');
    }
}
