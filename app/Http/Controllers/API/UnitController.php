<?php

namespace App\Http\Controllers\API;

use App\GenXCommon\XModel;
use App\Models\Department;
use App\Models\Process;
use App\Models\Product;
use App\Models\ProductCategory;
use App\Models\Unit;
use App\Models\Uom;
use App\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Config;

class UnitController extends Controller
{
    /**
     * Getting grid data
     *
     */

    public function getIndex() {
        self::hasPermission('index.unit');
        return view("unit.index");
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        self::hasPermission('index.unit');
        $query = Unit::query();
        if($request->get('trash')==Config::get('constants.trash_on')) {
            $query->onlyTrashed();
        }
        return XModel::preparePagination($query, $request, ['unit.name']);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        self::hasPermission('store.unit');
        $validatedData = $request->validate([
            'name' => 'required|unique:unit,name',
        ]);
        DB::transaction(function() use ($request) {
            Unit::create($request->all());
        });
        return response()->json([], 201);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show(Unit $unit)
    {
        self::hasPermission('update.unit');
        return $unit;
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Unit $unit)
    {
        self::hasPermission('update.unit');
        $validatedData = $request->validate([
            'name' => "required|unique:unit,name,$unit->id",
        ]);
        DB::transaction(function() use ($request,$unit) {
            $unit->update($request->all());
        });
        return response()->json($unit, 201);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(Request $request,$unit)
    {
        self::hasPermission('destroy.unit');
        if ($request->filled('trash') && $request->get('trash') == 0)
        {
            $model= Unit::findOrFail($unit);
            $model->delete();
        } else {
            $model= Unit::withTrashed()->find($unit);
            $model->forceDelete();
        }
        return response()->json(null);
    }
    public function restore($id){
        self::hasPermission('restore.unit');
        $model            = Unit::withTrashed()->find($id);
        $model->restore();
        return response()->json(null);
    }
    public function getUnits(Request $request){
        return Unit::get();
    }
    public function getDropDownData(Request $request){
        return [
            "unit" =>  Unit::get(),
            "department" =>  Department::get(),
            "product_category" =>  ProductCategory::get(),
            "process" =>  Process::get(),
            "uom" =>  Uom::get()
        ];
    }
    
}
