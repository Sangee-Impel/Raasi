<?php

namespace App\Http\Controllers\API;

use App\GenXCommon\XModel;
use App\Models\Department;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Config;

class DepartmentController extends Controller
{
    /**
     * Getting grid data
     *
     */

    public function getIndex() {
        self::hasPermission('index.department');
        return view("department.index");
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        self::hasPermission('index.department');
        $query = Department::query()->select('department.*','unit.name as unit_name');
        if($request->get('trash')==Config::get('constants.trash_on')) {
            $query->onlyTrashed();
        }
        $query->leftJoin('unit', 'unit.id', '=', 'department.unit_id');
        return XModel::preparePagination($query, $request, ['department.name','unit.name']);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        self::hasPermission('store.department');
        $validatedData = $request->validate([
            'unit_id'               => 'required',
            'name'                  => "required|unique:department,name",
        ]);
        DB::transaction(function() use ($request) {
            Department::create($request->all());
        });
        return response()->json([], 201);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show(Department $department)
    {
        self::hasPermission('update.department');
        $department->unit;
        return $department;
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Department $department)
    {
        self::hasPermission('update.department');
        $validatedData = $request->validate([
            'unit_id'               => 'required',
            'name'                  => "required|unique:department,name,$department->id",
        ]);
        DB::transaction(function() use ($request,$department) {
            $department->update($request->all());
        });
        return response()->json($department, 201);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(Request $request,$department)
    {
        self::hasPermission('destroy.department');
        if ($request->filled('trash') && $request->get('trash') == 0)
        {
            $model= Department::findOrFail($department);
            $model->delete();
        } else {
            $model= Department::withTrashed()->find($department);
            $model->forceDelete();
        }
        return response()->json(null);
    }
    public function restore($id){
        self::hasPermission('restore.department');
        $model            = Department::withTrashed()->find($id);
        $model->restore();
        return response()->json(null);
    }
}
