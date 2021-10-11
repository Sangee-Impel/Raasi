<?php

namespace App\Models;

use App\GenXCommon\XModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class Configuration extends XModel
{
    protected $table = 'configuration';
    protected $fillable = ['config_key','config_value','bag_starting_department_id'];

    public static function getConfigurationRowByConfigKey($config_key=''){
        return Configuration::where("configuration.config_key",$config_key)->first();
    }
    public static function getConfigurationArray(){
        $returnArray = [];
        $configuration = Configuration::all();
        if( count( $configuration ) > 0 ){
            foreach ( $configuration as $item => $value )
                $returnArray[$value['config_key']] = $value['config_value'];
        }
        return $returnArray;
    }
    public function bagStartingDepartment(){
        return $this->hasOne(Department::class,'id','bag_starting_department_id');
    }
}
