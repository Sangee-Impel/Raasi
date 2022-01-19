<?php

namespace App\Models;

use App\GenXCommon\XModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class Style extends XModel
{
    protected $table = 'style';
    protected $fillable = ['product_id','upload_id','sku','weight','uom_id','image_name'];
    public function product()
    {
        return $this->belongsTo(Product::class,'product_id','id')->with(['productCategory']);
    }
    public function upload() {
        return $this->belongsTo(Uploads::class,'upload_id','id');
    }
    public function uom(){
        return $this->belongsTo(Uom::class,'uom_id','id');
    }
    public function styleDepartmentLossApproval(){
        return $this->hasMany(StyleDepartmentLossApproval::class,'style_id','id')->with(['department']);
    }
    public  function rules($styleData)
    {
        $rules = [
            'styles.*.weight'   => 'required|numeric|gt:0',
            'styles.*.uom_id'   => 'required|numeric',
            'styles.*.style_department_loss_approval.*.department_id' => 'required|numeric',
            'styles.*.style_department_loss_approval.*.percentage' => 'required|numeric|gt:0|lt:100'
        ];
        foreach($styleData as $key => $val){
            $skuRule    =   'required|unique:style,sku';
            if( isset($val['id']) && $val['id'] > 0 ){
                $skuRule = $skuRule.",".$val['id'];
            }
            $rules['styles.'.$key.'.sku'] = $skuRule;
        }
        return $rules;
    }
    public function styleImages(){
        return $this->hasMany(StyleImages::class)->with(['upload']);
    }
}
