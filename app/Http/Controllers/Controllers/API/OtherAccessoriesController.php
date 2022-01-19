<?php

namespace App\Http\Controllers\API;

use App\GenXCommon\XModel;
use App\Models\Bag;
use App\Models\OtherAccessories;
use App\Models\Uom;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Config;

class OtherAccessoriesController extends Controller
{
    /**
     * Getting grid data
     *
     */

    public function getIndex() {
        self::hasPermission('index.otheraccessories');
        return view("other_accessories.index");
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        self::hasPermission('index.otheraccessories');
        $query = OtherAccessories::query()->select('other_accessories.*','uom.name as uom_name');
        $query->leftJoin('uom', 'uom.id', '=', 'other_accessories.uom_id');
        if($request->get('trash')==Config::get('constants.trash_on')) {
            $query->onlyTrashed();
        }
        return XModel::preparePagination($query, $request, ['other_accessories.name']);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        self::hasPermission('store.otheraccessories');
        $validatedData = $request->validate([
            'name'                  => "required|unique:other_accessories,name",
        ]);
        DB::transaction(function() use ($request) {
            OtherAccessories::create($request->all());
        });
        return response()->json([], 201);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        self::hasPermission('update.otheraccessories');
        $otherAccessories = OtherAccessories::findOrFail($id);
        $otherAccessories->uom;
        return $otherAccessories;
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $otherAccessories
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        self::hasPermission('update.otheraccessories');
        $validatedData = $request->validate([
            'name'                          => "required|unique:other_accessories,name,$id",
        ]);
        $otherAccessories = OtherAccessories::findOrFail($id);
        DB::transaction(function() use ($request,$otherAccessories) {
            $otherAccessories->update($request->all());
        });
        return response()->json($otherAccessories, 201);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(Request $request,$otherAccessories)
    {
        self::hasPermission('destroy.otheraccessories');
        if ($request->filled('trash') && $request->get('trash') == 0)
        {
            $model= OtherAccessories::findOrFail($otherAccessories);
            $model->delete();
        } else {
            $model= OtherAccessories::withTrashed()->find($otherAccessories);
            $model->forceDelete();
        }
        return response()->json(null);
    }
    public function restore($id){
        self::hasPermission('restore.otheraccessories');
        $model            = OtherAccessories::withTrashed()->find($id);
        $model->restore();
        return response()->json(null);
    }
}
