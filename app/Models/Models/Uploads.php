<?php

namespace App\Models;

use App\GenXCommon\XModel;
use App\User;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class Uploads extends XModel
{
    protected $table = 'uploads';

    protected  $dates = ['created_at'];
    public function getUploadedPathAttribute($value)
    {
        $value = str_replace('public', 'storage', $value);
        return asset($value);
    }


    public function user() {
        return $this->hasOne(User::class,'id','user_id');
    }
    public function scopeUploadsData($query) {
        return $query->select('uploads.*',DB::raw('DATE_FORMAT(uploads.created_at, "%d-%m-%Y") AS created'))->with('user');
    }

}
