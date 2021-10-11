<?php

namespace App\Models;

use App\GenXCommon\XModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class OtherAccessories extends XModel
{
    protected $table = 'other_accessories';
    protected $fillable = ['name','uom_id','description'];
    public function uom(){
        return $this->belongsTo(Uom::class,'uom_id','id');
    }

}
