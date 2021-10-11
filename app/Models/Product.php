<?php

namespace App\Models;

use App\GenXCommon\XModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class Product extends XModel
{
    protected $table = 'product';
    protected $fillable = ['product_category_id','name','description'];
    public function productCategory()
    {
        return $this->hasOne(ProductCategory::class,'id','product_category_id');
    }
    public function styles(){
        return $this->hasMany(Style::class,'product_id','id')->with(['upload','uom','styleDepartmentLossApproval','styleImages']);
    }
    public function uploads() {
        return $this->belongsTo(Uploads::class);
    }
}
