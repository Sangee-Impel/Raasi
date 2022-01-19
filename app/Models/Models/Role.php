<?php

namespace App\Models;

use App\GenXCommon\XModel;
use App\User;
use Illuminate\Database\Eloquent\Model;
use jeremykenedy\LaravelRoles\Traits\HasRoleAndPermission;
use Illuminate\Database\Eloquent\SoftDeletes;

class Role extends XModel
{
    protected $table='roles';
    public static $role_admin_slug = "admin",$role_staff_slug = "staff",$role_employee_slug = "employee";
    use SoftDeletes;
    use HasRoleAndPermission;
    protected $fillable = [
        'name','slug'
    ];
    public static function getRoleID($role){
        $role = Role::where('slug',$role)->first();
        if( !is_null($role) ){
            return $role['id'];
        }
        return null;
    }
    
    public function permission_role()
    {
        return $this->hasMany(PermissionRole::class);
    }
    public static function getRole($skipRole=[]){
        $query = Role::query();
        if( count($skipRole) > 0 ){
            $query->whereNotIn('slug',$skipRole);
        }
        return  $query->get();
    }
    
    public function role(){
        return $this->belongsToMany(RoleUser::class);
    }
    /**
     * The users that belong to the role.
     */
    public function users()
    {
        $query  =   $this->belongsToMany(User::class, 'role_user');
        return $query;
    }
}
