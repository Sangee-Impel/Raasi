<?php

namespace App\Models;

use App\GenXCommon\XModel;

class Casting extends XModel
{
    protected $table = 'casting';
    protected $fillable = ['name', 'weight', 'deleted_at', 'created_at', 'updated_at'];

    public function castingWeights()
    {
        return $this->hasMany(CastingWeight::class, 'casting_id', 'id')->whereIn('adjustment', ['Add', 'Deduct'])->orderBy("id", "DESC");
    }

    public  function rules($styleData)
    {
        $rules = [
            'casting.*.weight'   => 'required|numeric|gte:1'
        ];
        return $rules;
    }
}
