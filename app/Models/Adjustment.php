<?php

namespace App\Models;

use App\GenXCommon\XModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class Adjustment extends XModel
{
    protected $table = 'adjustment';
    protected $fillable = ['name'];
}
