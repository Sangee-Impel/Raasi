<?php

namespace App\Http\Controllers\API;

use App\GenXCommon\XModel;
use App\Models\Employee;
use App\Models\EmployeeProcess;
use App\Models\Role;
use App\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Config;
use Illuminate\Support\Facades\Hash;

class EmployeeController extends Controller
{
    /**
     * Getting grid data
     *
     */

    public function getIndex() {
        self::hasPermission('index.employee');
        return view("employee.index");
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        self::hasPermission('index.employee');
        $query = Employee::query()->select('employee.*','department.name as department_name');
        if($request->get('trash')==Config::get('constants.trash_on')) {
            $query->onlyTrashed();
        }
        $query->leftJoin('department', 'department.id', '=', 'employee.department_id');
        return XModel::preparePagination($query, $request, ['employee.name','department.name']);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        self::hasPermission('store.employee');
        $validatedData = $request->validate([
            'department_id'               => 'required',
            'code'                  => "required|unique:employee,code",
            'name'                  => "required",
            
        ]);
        DB::transaction(function() use ($request) {
            $post_data = $request->all();
            //#block for Create user...!
            $userData = [
                "name"      =>  $post_data['name'],
                "password"  =>  Hash::make($post_data['code']),
                "email"     =>  $post_data['code'].Config::get('constants.default_email'),
                "department_id"     =>  $post_data['department_id'],
            ];
            $userModel = User::create($userData);
            $roleId = Role::getRoleID(Role::$role_employee_slug);
            if(is_null($roleId)){
                $roleId = Role::getRoleID(Role::$role_admin_slug);
            }
            if(!is_null($roleId)){
                $userModel->attachRole($roleId);
            }
            $post_data['user_id'] = $userModel['id'];
            $employee = Employee::create($post_data);
            if( $employee ){
                $this->saveEmployeeProcess($post_data['employee_process'],$employee['id']);
            }
            
        });
        return response()->json([], 201);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show(Employee $employee)
    {
        self::hasPermission('update.employee');
        $employee->department;
        $employee->employeeProcess;
        return $employee;
    }
    public static function saveEmployeeProcess($processEmployee,$employeeId){
        if( count($processEmployee) > 0 ){
            foreach ($processEmployee as $processEmployeeKey => $processEmployeeValue ){
                if( $processEmployeeValue['id'] == 0 && isset($processEmployeeValue['process']['id'])){
                    $processEmployeeValue['employee_id'] = $employeeId;
                    $processEmployeeValue['process_id'] = $processEmployeeValue['process']['id'];
                    EmployeeProcess::create($processEmployeeValue);
                }
            }
        }
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Employee $employee)
    {
        self::hasPermission('update.employee');
        $post_data = $request->all();
        $validatedData = $request->validate([
            'department_id'               => 'required',
            'code'                  => "required|unique:employee,code,$employee->id",
            'name'                  => "required",
        ]);
        DB::transaction(function() use ($post_data,$employee) {
            $this->saveEmployeeProcess($post_data['employee_process'],$employee['id']);
            $employee->update($post_data);
        });
        return response()->json($employee, 201);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(Request $request,$employee)
    {
        self::hasPermission('destroy.employee');
        if ($request->filled('trash') && $request->get('trash') == 0)
        {
            $model= Employee::findOrFail($employee);
            $model->delete();
        } else {
            $model= Employee::withTrashed()->find($employee);
            $model->forceDelete();
        }
        return response()->json(null);
    }
    public function restore($id){
        self::hasPermission('restore.employee');
        $model            = Employee::withTrashed()->find($id);
        $model->restore();
        return response()->json(null);
    }
    public function deleteEmployeeProcess(Request $request, EmployeeProcess $employeeProcess){
        $employeeProcess->delete();
        return response()->json("ok", 203);
    }
}
