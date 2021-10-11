<?php

namespace App\Models;

use App\GenXCommon\XModel;
use App\User;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class Unit extends XModel
{
    protected $table = 'unit';
    protected $fillable = ['name','description'];
}
