<?php

namespace App\Http\Controllers\API;

use App\GenXCommon\XModel;
use App\Models\Configuration;
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

class ConfigurationController extends Controller
{
    /**
     * Getting grid data
     *
     */

    public function getIndex()
    {
        self::hasPermission('index.configuration');
        return view("configuration.index");
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        self::hasPermission('index.configuration');
        $validatedData = $request->validate([
            'precision.config_value' => 'required|integer|between:1,6',
            'bag_cancel_number.config_value' => 'required|integer|digits:10',
            
            'bag_starting_department.bag_starting_department_id' => 'required|integer',
        ]);
        DB::transaction(function () use ($request) {
            $postDate = $request->all();
            if (count($postDate) > 0) {
                foreach ($postDate as $item => $value) {
                    if (($item != "errors") && ($item != "busy") && ($item != "successful")) {
                        $value['config_key'] = $item;
                        /*$configurationValue = [
                            "config_key"    =>  $item,
                            "config_value"  =>  $value
                        ];*/
                        $defaultConfiguration = Configuration::getConfigurationRowByConfigKey($item);
                        $configSetModel = new Configuration();
                        if (!is_null($defaultConfiguration)) {
                            $configSetModel = Configuration::findOrFail($defaultConfiguration['id']);
                        }
                        $configSetModel->fill($value);
                        $configSetModel->save();
                    }
                }
            }
        });
        return response()->json([], 201);
    }
    public function getConfigurationData(Request $request)
    {
        return [
            "configration" => Configuration::with('bagStartingDepartment')->get(),
            "departments" => Department::get()
        ];
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
        DB::transaction(function () use ($request, $unit) {
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
    public function destroy(Request $request, $unit)
    {
        self::hasPermission('destroy.unit');
        if ($request->filled('trash') && $request->get('trash') == 0) {
            $model = Unit::findOrFail($unit);
            $model->delete();
        } else {
            $model = Unit::withTrashed()->find($unit);
            $model->forceDelete();
        }
        return response()->json(null);
    }
    public function restore($id)
    {
        self::hasPermission('restore.unit');
        $model            = Unit::withTrashed()->find($id);
        $model->restore();
        return response()->json(null);
    }
}
