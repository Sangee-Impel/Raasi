<?php

namespace App\Models;

use App\GenXCommon\XModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class Transaction extends XModel
{
    protected $table = 'transaction';
    protected $fillable = ['transaction_date', 'from_department_id', 'from_employee_id', 'to_department_id', 'to_employee_id', 'bag_id', 'description', 'status', 'is_eod_reporting', 'total_transfer_weight', 'total_transfer_quantity', 'total_receive_weight', 'total_loss_weight', 'total_loss_quantity', 'transaction_mode', 'to_bag_id'];
    public function bag()
    {
        return $this->hasOne(Bag::class, 'id', 'bag_id')->with(['bagStyles']);
    }
    public function fromDepartment()
    {
        return $this->hasOne(Department::class, 'id', 'from_department_id');
    }
    public function fromEmployee()
    {
        return $this->hasOne(Employee::class, 'id', 'from_employee_id');
    }
    public function toDepartment()
    {
        return $this->hasOne(Department::class, 'id', 'to_department_id');
    }
    public function toEmployee()
    {
        return $this->hasOne(Employee::class, 'id', 'to_employee_id');
    }
    public function transactionItems()
    {
        return $this->hasMany(TransactionItem::class, 'transaction_id', 'id')->with(['bagStyle', 'otherAccessories', 'uom']);
    }

    public static function getEmployeeBasegOnDepartment($departmentId = null, $toDepartmentId = null, $fromEmpId = null)
    {
        $employeeQuery = Employee::query();
        if (!is_null($departmentId))
            $employeeQuery->where("employee.department_id", $departmentId);

        if (!is_null($toDepartmentId))
            $employeeQuery->whereNotIn("employee.department_id", [$toDepartmentId]);

        if (!is_null($fromEmpId))
            $employeeQuery->whereNotIn("employee.id", [$fromEmpId]);

        $employee       =   $employeeQuery->get();
        /*$employee = Employee::get();
        if( !is_null($departmentId) ){
            $department = Department::findOrFail($departmentId);
            $employee = $department->employees;
        }*/
        return $employee;
    }
    public static function getDepartmentBasedOnSelectedDepartment($toDepartmentId = null)
    {
        $departmentQuery = Department::query();
        if (!is_null($toDepartmentId))
            $departmentQuery->whereNotIn("department.id", [$toDepartmentId]);
        $departments       =   $departmentQuery->get();
        return $departments;
    }
}
