<?php

namespace App\Http\Controllers;

use App\Models\Role;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class UserController extends Controller
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
        return view('user.index',array(
            //'optionRole' => Role::getRole([Role::$role_employee_slug]),
            'user_id'  =>  null

        ));
    }
    public function getProfile(){
        return view('user.profile',array(
            //'optionRole' => Role::getRole([Role::$role_employee_slug]),
            'user_id'  =>  Auth::user()['id']
        ));
    }
}
