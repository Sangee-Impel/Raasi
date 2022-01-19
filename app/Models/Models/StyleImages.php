<?php
/**
 * Created by IntelliJ IDEA.
 * User: baskar
 * Date: 25/8/20
 * Time: 7:39 PM
 */


namespace App\Models;

use App\GenXCommon\XModel;

class StyleImages extends XModel
{
    protected $table = 'style_images';
    protected $fillable = ['style_id','upload_id'];
    public function upload() {
        return $this->belongsTo(Uploads::class,'upload_id','id');
//        return $this->hasOne(Uploads::class,'id','upload_id');
    }
}
