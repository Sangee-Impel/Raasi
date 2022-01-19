<?php

namespace App\Http\Controllers\API;

use App\GenXCommon\XModel;
use App\Models\Department;
use App\Models\Role;
use App\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Config;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Redirect;

class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        self::hasPermission('index.user');
        $query = User::with('role_user');
        if($request->get('trash')==Config::get('constants.trash_on')) {
            $query->onlyTrashed();
        }
        return XModel::preparePagination($query, $request, ['users.name']);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        self::hasPermission('store.user');
        $validatedData = $request->validate([
            'name'                  => 'required|max:50|min:2',
            'email'                 => 'required|email|unique:users,email',
            'password'              => 'required|min:6|confirmed',
            'password_confirmation' => 'required_with:password',
            'role_id'               => 'required'

        ], array(
            'role_id.required'          => 'The Role field is required.',
        ));
        DB::transaction(function() use ($request) {
        $request['password']              = Hash::make($request['password']);
        $model = User::create($request->all());
        $model->attachRole($request['role_id']);
        });
        return response()->json([], 201);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show(User $user)
    {
        self::hasPermission('update.user');
        $user['role_id'] = $user->role_user;
        $user->department;
        return $user;
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, User $user)
    {
        self::hasPermission('update.user');
        $validatedData = $request->validate([
            'name'                  => 'required|max:50|min:2',
            'email'                 => "required|email|unique:users,email,$user->id",
            'role_id'               => 'required',
            'password'          => 'confirmed',
        ], array(
            'role_id.required'          => 'The Role field is required.',

        ));
        DB::transaction(function() use ($request,$user) {
        if( !empty($request['password']) || !is_null($request['password']) ){

            $request['password']              = Hash::make($request['password']);
        }else{
            unset($request['password']);
        }
        $user->update($request->all());
        $user->syncRoles($request['role_id']);
        });
        return response()->json($user, 201);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(Request $request,$user)
    {
        self::hasPermission('destroy.user');
        if ($request->filled('trash') && $request->get('trash') == 0)
        {
            $model= User::findOrFail($user);
            $model->role_user()->delete();
            $model->delete();
        } else {
            $model= User::withTrashed()->find($user);
            $model->detachAllRoles();
            $model->forceDelete();
        }
        return response()->json(null);

    }
    public function restore($id){
        self::hasPermission('restore.user');
        $model            = User::withTrashed()->find($id);
        $model->role_user()->restore();
        $model->restore();
        return response()->json(null);
    }
    public function getUsers(){

        $userModel      =  User::all();
        /*$users          =   [];
        if( count($userModel) >  0 ){
            foreach ( $userModel as $key => $value ){
                $users[] = [
                    "key" => $value['id'],
                    "title"=>$value['name']
                ];
            }
        }*/
        return $userModel;

    }

    public function getCurrentUser() {
        $data["user"] = Auth::user();
        $data['today'] = date('M d y');

        return response()->json($data);
    }
    public function getDropDownData(Request $request){
        $postData    =   $request->all();
        return [
            "departments"   =>  Department::get(),
            "roles"         =>  Role::getRole([Role::$role_employee_slug])
            
        ];
    }
    public function getAllStaff() {
        $data = [];
        if(Auth::user()->hasRole('admin')) {
            $customers = User::with('role_user')->whereNotIn('id',[Auth::user()->id])->get();
            foreach ($customers as $key=>$value) {
                    $data[$key] = [
                        'id'        =>$value['id'],
                        'name'      =>$value['name'].' - '.$value['role_user']['role']['name']
                    ];
            }
        }
        return $data;
    }
    public function getResetView() {
        $data =[
            "email"=>Auth::user()->email,
            "token"=>""
        ];
        return view('spark::auth.passwords.reset')->with($data);
    }
    public function customizedResetPassword(Request $request)
    {
        $validatedData = $request->validate([
            'email' => "required",
            'password' => 'required',
            "password_confirmation" => 'required|same:password',
        ]);

        $user = User::findOrFail(Auth::user()->id);
        $user->password = Hash::make($request['password']);
        $user->save();
        $login_data = [
            "email" => $user->email,
            "password" => $request['password']
        ];
        if(Auth::guard()->attempt($login_data,true)) {
            return Redirect::to('/dashboard');
        }
    }
}
