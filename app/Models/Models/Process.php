<?php

namespace App\Models;

use App\GenXCommon\XModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class Process extends XModel
{
    protected $table = 'process';
    protected $fillable = ['code','name','description'];
    
}
