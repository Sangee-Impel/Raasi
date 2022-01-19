<?php

namespace App\Http\Controllers\API;

use App\GenXCommon\XModel;
use App\Http\Controllers\Controller;
use App\Models\CastingWeight;
use App\Models\Adjustment;
use Illuminate\Http\Request;
use App\Models\Casting;
use Illuminate\Support\Facades\Config;
use Illuminate\Support\Facades\DB;

class CastingController extends Controller
{
    /**
     * Getting grid data
     *
     */

    public function getIndex()
    {
        self::hasPermission('index.casting');
        return view("casting.index");
    }

    public function index(Request $request)
    {
        self::hasPermission('index.casting');
        $query = Casting::query()->select('casting.*');
        if ($request->get('trash') == Config::get('constants.trash_on')) {
            $query->onlyTrashed();
        }
        return XModel::preparePagination($query, $request, ['casting.name']);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show(Casting $casting)
    {
        self::hasPermission('update.casting');
        $casting->castingWeights;
        return $casting;
    }

    public function store(Request $request)
    {
        self::hasPermission('store.casting');
        $validatedData = $request->validate([
            'name' => "unique:casting,name|required",
            'casting_weights' => "required|array|min:1",
        ]);

        $post_data  = $post_data_create =   $request->all();
        $request->validate((new CastingWeight())->rules($post_data['casting_weights']));
        $post_data['weight'] = $post_data_create['weight'] = 0;

        foreach ($post_data['casting_weights'] as $weightKey => $weightValue) {
            if ($weightValue['adjustment'] == 'Add') {
                $post_data['weight'] += (float) $weightValue['weight'];
            } else {
                $post_data['weight'] -= (float) $weightValue['weight'];
            }
        }

        if ($post_data['weight'] > 0) {
            $casting    =   Casting::create($post_data);
            foreach ($post_data['casting_weights'] as $weightKey => $weightCal) {
                $weightCal['casting_id']   =   $casting['id'];
                if ($weightCal['adjustment'] == 'Add') {
                    $post_data_create['weight'] += (float) $weightCal['weight'];
                } else {
                    $post_data_create['weight'] -= (float) $weightCal['weight'];
                }
                CastingWeight::create($weightCal);
            }

            $casting->update($post_data_create);
        }


        if ($post_data['weight'] < 0) {
            return response()->json(["errors" => "Please enter a vaild add/deduct weight", "message" => "The given data was invalid."], 422);
        } else {
            return response()->json([], 201);
        }
    }

    public function update(Request $request, Casting $casting)
    {
        self::hasPermission('update.casting');
        $validatedData = $request->validate([
            'name' => "required",
            'casting_weights' => "required|array|min:1",
        ]);

        $post_data  = $post_data_create =    $request->all();
        $post_data['weight'] = $post_data_create['weight'] =  0;



        foreach ($post_data['casting_weights'] as $weightKey => $weightValue) {
            if (isset($weightValue['id']) && $weightValue['id'] > 0) {
                if ($weightValue['adjustment'] == 'Add') {
                    $post_data['weight'] += (float) $weightValue['weight'];
                } else {
                    $post_data['weight'] -= (float) $weightValue['weight'];
                }
            } else {
                if ($weightValue['adjustment'] == 'Add') {
                    $post_data['weight'] += (float) $weightValue['weight'];
                } else {
                    $post_data['weight'] -= (float) $weightValue['weight'];
                }
            }
        }

        $casting_weight  = CastingWeight::where('casting_id', $casting['id'])->whereIn('adjustment', ['Lot_Deduct', 'Transaction_Deduct'])->get();
       
        if ($post_data['weight'] > 0) {
            foreach ($post_data_create['casting_weights'] as $weightKey => $weightValue) {
                $weightValue['casting_id']   =   $casting['id'];
                if (isset($weightValue['id']) && $weightValue['id'] > 0) {
                    if ($weightValue['adjustment'] == 'Add') {
                        $post_data_create['weight'] += (float) $weightValue['weight'];
                    } else {
                        $post_data_create['weight'] -= (float) $weightValue['weight'];
                    }
                } else {
                    if ($weightValue['adjustment'] == 'Add') {
                        $post_data_create['weight'] += (float) $weightValue['weight'];
                    } else {
                        $post_data_create['weight'] -= (float) $weightValue['weight'];
                    }
                    CastingWeight::create($weightValue);
                }
            }
            foreach ($casting_weight as $key => $w) {
                $post_data_create['weight'] -= (float) $w['weight'];
            }
            $casting->update($post_data_create);
        }

        if ($post_data['weight'] < 0) {
            return response()->json(["errors" => "Please enter a vaild add/deduct weight", "message" => "The given data was invalid."], 422);
        } else {
            return response()->json([], 201);
        }
    }
}
