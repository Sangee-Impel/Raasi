<?php

namespace App\Models;

use App\GenXCommon\XModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class Uom extends XModel
{
    protected $table = 'uom';
    protected $fillable = ['name','description'];
}
