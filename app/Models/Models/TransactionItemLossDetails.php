<?php

namespace App\Models;

use App\GenXCommon\XModel;
use App\User;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class TransactionItemLossDetails extends XModel
{
    protected $table = 'transaction_item_loss_details';
    protected $fillable = ['transaction_id','transaction_item_id','bag_style_id','date','weight','user_id','type','admin_approval_loss_weight','status','admin_id','reason_type_id','loss_description'];

    public function user(){
        return $this->belongsTo(User::class);
    }
}
