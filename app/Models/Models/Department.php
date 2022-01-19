<?php

namespace App\Models;

use App\GenXCommon\XModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class Department extends XModel
{
    protected $table = 'department';
    protected $fillable = ['unit_id','name','description','is_last'];
    public function unit()
    {
        return $this->hasOne(Unit::class,'id','unit_id');
    }
    public function employees(){
        return $this->hasMany(Employee::class,'department_id','id');
    }
    public function bags(){
        return $this->hasMany(Bag::class,'department_id','id')->with(['bagStyles']);
    }

}
