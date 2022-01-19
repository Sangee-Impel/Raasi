<?php

namespace App\Models;

use App\GenXCommon\XModel;
use App\User;
use Illuminate\Database\Eloquent\Model;
use jeremykenedy\LaravelRoles\Traits\HasRoleAndPermission;
//use Illuminate\Database\Eloquent\SoftDeletes;
class Permission extends XModel
{
    use HasRoleAndPermission;
    /*protected $fillable = [
        'name'
    ];*/
    /*public function permission_user()
    {
        return $this->hasMany(User::class);
    }*/
}
