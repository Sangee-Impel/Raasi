<?php

namespace App\Http\Controllers\API;

use App\GenXCommon\XModel;

use App\Models\PermissionRole;
use App\Models\Role;

use App\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
class RoleController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
       self::hasPermission('index.role');
        return XModel::preparePagination( $request->has('trash') && $request->get('trash')==1?
            Role::onlyTrashed():Role::query(), $request, ['name']);

    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        self::hasPermission('store.role');
        $validatedData = $request->validate([
           /* 'slug'          => 'required|max:200|min:2',*/
            'name'          => 'required|max:200|min:2|unique:roles',
            'permission_id' => 'required'
        ], array(
            /*'slug.required'          => 'The System Role field is required.',*/
            'permission_id.required' => 'The permission field is required.'
        ));
        DB::transaction(function() use ($request) {
            $data = $request->all();
            $data['slug'] = strtolower(str_replace(" ","_",$data['name']));
            $model = Role::create($data);
            $model->syncPermissions($request['permission_id']);
        });
        return response()->json([], 201);

    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show(Role $role)
    {
        self::hasPermission('update.role');
        $role['permission_role'] = $role->permission_role;
        return $role;

    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Role $role)
    {
        self::hasPermission('update.role');
        $validatedData = $request->validate([
           /* 'slug'       => 'required|max:200|min:2',*/
            'name'       => 'required|max:200|min:2|unique:roles,name,'.$role->id,
            'permission_id' => 'required'
        ], array(
            'permission_id.required' => 'The permission field is required.'
        ));
        $role->update($request->all());
        $role->syncPermissions($request['permission_id']);
        return response()->json($role, 200);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(Request $request,$role)
    {
        self::hasPermission('destroy.role');
        if($request->filled('trash') && $request->get('trash') == 0){
            $model=Role::findOrFail($role);
            $model->permission_role()->delete();
            $model->delete();
        }else{
           $model= Role::withTrashed()->find($role);
           $model->detachAllPermissions();
           $model->forceDelete();

        }
        return response()->json(null);
    }
    public function restore($id){
        self::hasPermission('restore.role');
        $model            = Role::withTrashed()->find($id);
        $model->permission_role()->restore();
        $model->restore();
        return response()->json(null);
    }
    /**
     * Remove the specified resource from storage.
     *
     * @return \Illuminate\Http\Response
     */
    public function gerUserPermission(Request $request){
        $user = Auth::user();
        $permissions = $user->getPermissions();
        return response()->json($permissions);
    }
}
