<?php

namespace App\Models;

use App\GenXCommon\XModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class EmployeeProcess extends XModel
{
    protected $table = 'employee_process';
    protected $fillable = ['employee_id','process_id'];
    public function employee()
    {
        return $this->hasOne(Employee::class,'id','employee_id');
    }
    public function process()
    {
        return $this->hasOne(Process::class,'id','process_id');
    }
}
