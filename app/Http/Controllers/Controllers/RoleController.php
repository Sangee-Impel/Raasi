<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use jeremykenedy\LaravelRoles\Models\Permission;
use Illuminate\Support\Facades\DB;
class RoleController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth');
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return view('role.index', array('permissions' => $this->getPermissions() ));
    }
    /**
     * Display a listing of the permissions.
     *
     * @return json of permission array
     */
    public function getPermissions(){
        //$list = Permission::where('id', 19)->orWhere('parent_id', 19)->get();
        $list = Permission::orderBy('id','ASC')->get();
        
        $permissions=[];
        $id = '';
        foreach ($list as $key => $value){
            if(is_null($value->parent_id) ){
                $id = $value->id;
                $permissions[$id] = [ 'id' => $value->id, 'name'=>$value->name, 'children'=>[] ];
            }else{
                $child_arr= ['id'=>$value->id,'name'=>$value->name];
                array_push($permissions[$value->parent_id]['children'], $child_arr);
            }
        }
        $permission_list = array();
        foreach ($permissions as $key => $value){
            $permission_list[] = $value;
        }

        return json_encode($permission_list);

    }


}
