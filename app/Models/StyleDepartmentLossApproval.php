<?php

namespace App\Models;

use App\GenXCommon\XModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class StyleDepartmentLossApproval extends XModel
{
    protected $table = 'style_department_loss_approval';
    protected $fillable = ['style_id','department_id','percentage'];
    public function style()
    {
        return $this->belongsTo(Style::class,'style_id','id')->with(['product']);
    }
    public function department()
    {
        return $this->belongsTo(Department::class,'department_id','id');
    }

}
