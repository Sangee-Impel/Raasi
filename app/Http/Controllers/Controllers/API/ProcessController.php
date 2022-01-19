<?php

namespace App\Http\Controllers\API;

use App\GenXCommon\XModel;
use App\Models\Process;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Config;

class ProcessController extends Controller
{
    /**
     * Getting grid data
     *
     */

    public function getIndex() {
        self::hasPermission('index.process');
        return view("process.index");
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        self::hasPermission('index.process');
        $query = Process::query()->select('process.*');
        if($request->get('trash')==Config::get('constants.trash_on')) {
            $query->onlyTrashed();
        }
        return XModel::preparePagination($query, $request, ['process.name','process.code']);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        self::hasPermission('store.process');
        $validatedData = $request->validate([
            'name'                  => "required",
            'code'                  => "required|unique:process,code",
        ]);
        DB::transaction(function() use ($request) {
            Process::create($request->all());
        });
        return response()->json([], 201);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show(Process $process)
    {
        self::hasPermission('update.process');
        return $process;
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Process $process)
    {
        self::hasPermission('update.process');
        $validatedData = $request->validate([
            'name'                  => "required",
            'code'                  => "required|unique:process,code,$process->id",
        ]);
        DB::transaction(function() use ($request,$process) {
            $process->update($request->all());
        });
        return response()->json($process, 201);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(Request $request,$process)
    {
        self::hasPermission('destroy.process');
        if ($request->filled('trash') && $request->get('trash') == 0)
        {
            $model= Process::findOrFail($process);
            $model->delete();
        } else {
            $model= Process::withTrashed()->find($process);
            $model->forceDelete();
        }
        return response()->json(null);
    }
    public function restore($id){
        self::hasPermission('restore.process');
        $model            = Process::withTrashed()->find($id);
        $model->restore();
        return response()->json(null);
    }
}
