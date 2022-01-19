<?php

namespace App\Http\Controllers\API;

use App\GenXCommon\XModel;
use App\Models\Uom;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Config;

class UomController extends Controller
{
    /**
     * Getting grid data
     *
     */

    public function getIndex() {
        self::hasPermission('index.uom');
        return view("uom.index");
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        self::hasPermission('index.uom');
        $query = Uom::query()->select('uom.*');
        if($request->get('trash')==Config::get('constants.trash_on')) {
            $query->onlyTrashed();
        }
        return XModel::preparePagination($query, $request, ['uom.name']);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        self::hasPermission('store.uom');
        $validatedData = $request->validate([
            'name'                  => "required|unique:uom,name",
        ]);
        DB::transaction(function() use ($request) {
            Uom::create($request->all());
        });
        return response()->json([], 201);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show(Uom $uom)
    {
        self::hasPermission('update.uom');
        return $uom;
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Uom $uom)
    {
        self::hasPermission('update.uom');
        $validatedData = $request->validate([
            'name'                          => "required|unique:uom,name,$uom->id",
        ]);
        DB::transaction(function() use ($request,$uom) {
            $uom->update($request->all());
        });
        return response()->json($uom, 201);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(Request $request,$uom)
    {
        self::hasPermission('destroy.uom');
        if ($request->filled('trash') && $request->get('trash') == 0)
        {
            $model= Uom::findOrFail($uom);
            $model->delete();
        } else {
            $model= Uom::withTrashed()->find($uom);
            $model->forceDelete();
        }
        return response()->json(null);
    }
    public function restore($id){
        self::hasPermission('restore.uom');
        $model            = Uom::withTrashed()->find($id);
        $model->restore();
        return response()->json(null);
    }
}
