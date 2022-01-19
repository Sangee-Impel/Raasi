<?php

namespace App\Models;

use App\GenXCommon\XModel;

class CastingWeight extends XModel
{
    protected $table = 'casting_weights';
    protected $fillable = ['weight', 'adjustment', 'instruction', 'deleted_at', 'created_at', 'updated_at', 'casting_id'];

    public function casting()
    {
        return $this->belongsTo(Casting::class);
    }

    public  function rules($styleData)
    {
        $rules = [
            'casting_weights.*.weight'   => 'required|numeric|gte:1',
            'casting_weights.*.adjustment'   => 'required',
            'casting_weights.*.instruction'   => 'required',
        ];
        return $rules;
    }
}
