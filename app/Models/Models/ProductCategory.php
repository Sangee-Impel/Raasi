<?php

namespace App\Models;

use App\GenXCommon\XModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class ProductCategory extends XModel
{
    protected $table = 'product_category';
    protected $fillable = ['name','description','parent_product_category_id'];
    public function parentProductCategory()
    {
        return $this->hasOne(ProductCategory::class,'id','parent_product_category_id');
    }
}
