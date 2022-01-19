<?php

namespace App\Models;

use App\GenXCommon\XModel;
use Illuminate\Database\Eloquent\Model;
use jeremykenedy\LaravelRoles\Traits\HasRoleAndPermission;
use Illuminate\Database\Eloquent\SoftDeletes;
class PermissionRole extends XModel
{
    use SoftDeletes;
    use HasRoleAndPermission;
    protected $table = 'permission_role';
    protected $fillable = [
        'permission_id','role_id',
    ];
}
