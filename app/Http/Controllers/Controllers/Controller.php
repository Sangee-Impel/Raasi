<?php

namespace App\Http\Controllers;
use App\Models\Role;
use Illuminate\Http\Request;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Support\Facades\Auth;

global $postGritters;
global $gritterBusCallBack;
$gritterBusCallBack = null;
$postGritters = array();

class Controller extends BaseController
{
    use AuthorizesRequests, DispatchesJobs, ValidatesRequests;

    public static function hasPermission($key){
        $user = Auth::user();
        if(  count($user->getRoles()) == 0   ){
            return  abort(403,'Permission denied!');
        }
        if( ! Auth::user()->hasPermission($key) ){
            return  abort(403,'Permission denied!');
        }
    }
    public static function checkIsAdmin($getTheme = true){
        $user   = Auth::user();
        $roles = $user->getRoles();
        if(  count($roles) != 0   ){
            if( $roles[0]['slug'] == Role::$role_admin_slug ){
                if( $getTheme )
                    return 'theme-deep-orange';
                else
                    return true;
            }
        }
        if( $getTheme )
            return 'theme-blue';
        else
            return true;
    }
}
