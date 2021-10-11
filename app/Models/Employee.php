<?php

namespace App\Models;

use App\GenXCommon\XModel;
use App\User;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class Employee extends XModel
{
    protected $table = 'employee';
    protected $fillable = ['user_id','department_id','code','name','description'];
    public function department()
    {
        return $this->hasOne(Department::class,'id','department_id');
    }
    /*public function user()
    {
        return $this->hasOne(User::class,'id','user_id');
    }*/
    public function employeeProcess()
    {
        return $this->hasMany(EmployeeProcess::class)->with('process');
    }

}
