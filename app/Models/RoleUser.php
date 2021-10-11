<?php

namespace App\Models;

use App\GenXCommon\XModel;
use App\User;
use Illuminate\Database\Eloquent\Model;
use jeremykenedy\LaravelRoles\Traits\HasRoleAndPermission;
use Illuminate\Database\Eloquent\SoftDeletes;

class RoleUser extends XModel
{
    use SoftDeletes;
    use HasRoleAndPermission;
    protected $table='role_user';
    public function roleUser()
    {
        $this->belongsTo(User::class);
    }
    public function role(){
        return $this->belongsTo(Role::class,'role_id','id');
    }
}
