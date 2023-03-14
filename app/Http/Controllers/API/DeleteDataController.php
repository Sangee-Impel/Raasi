<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Configuration;
use Exception;
use Illuminate\Support\Facades\DB;

class DeleteDataController extends Controller
{
    public function getIndex()
    {
        self::hasPermission('index.deletedata');
        return view("delete_data.index");
    }

    public function store(Request $request)
    {
        $current_otp  = Configuration::getConfigurationRowByConfigKey("current_otp");
        if ($request->get('otp') === $current_otp['config_value']) {
            try {
                DB::statement('SET FOREIGN_KEY_CHECKS=0;');
                DB::table('bag')->truncate();
                DB::table('bag_styles')->truncate();
                DB::table('casting_weights')->truncate();
                DB::table('transaction')->truncate();
                DB::table('transaction_item')->truncate();
                DB::table('transaction_item_loss_details')->truncate();
                DB::statement('SET FOREIGN_KEY_CHECKS=1;');
            } catch (Exception $ex) {
               
            }
            return response()->json([], 200);
        } else {
            return response()->json([], 400);
        }
    }

    public function generateOtp(Request $request)
    {
        $cancelOtp = str_pad(mt_rand(0, 999999), 6, '0', STR_PAD_LEFT); //str_random(6);
        $bag_otp_number  = Configuration::getConfigurationRowByConfigKey("bag_cancel_number");
        $configSetModel = Configuration::findOrFail(6);
        $configurationValue = [
            "config_key"    =>  'current_otp',
            "config_value"  =>  $cancelOtp
        ];
        $configSetModel->fill($configurationValue);
        $configSetModel->save();
        if (!is_null($bag_otp_number) && isset($bag_otp_number['config_value']) && trim($bag_otp_number['config_value']) != '') {
            $mobile_number = $bag_otp_number['config_value'];
            $client = new \GuzzleHttp\Client();

            $response = $client->request('GET', "https://2factor.in/API/V1/09524649-4166-11e8-a895-0200cd936042/SMS/+91$mobile_number/$cancelOtp");
            $statusCode = $response->getStatusCode();
            $content = $response->getBody();
            // return response()->json([]);
        }

        $bag_otp_number  = Configuration::getConfigurationRowByConfigKey("otp_number_1");
        if (!is_null($bag_otp_number) && isset($bag_otp_number['config_value']) && trim($bag_otp_number['config_value']) != '') {
            $mobile_number = $bag_otp_number['config_value'];

            $client = new \GuzzleHttp\Client();
            $response = $client->request('GET', "https://2factor.in/API/V1/09524649-4166-11e8-a895-0200cd936042/SMS/+91$mobile_number/$cancelOtp");
            $statusCode = $response->getStatusCode();
            $content = $response->getBody();
            // return response()->json([]);
        }

        $bag_otp_number  = Configuration::getConfigurationRowByConfigKey("otp_number_2");
        if (!is_null($bag_otp_number) && isset($bag_otp_number['config_value']) && trim($bag_otp_number['config_value']) != '') {
            $mobile_number = $bag_otp_number['config_value'];

            $client = new \GuzzleHttp\Client();
            $response = $client->request('GET', "https://2factor.in/API/V1/09524649-4166-11e8-a895-0200cd936042/SMS/+91$mobile_number/$cancelOtp");
            $statusCode = $response->getStatusCode();
            $content = $response->getBody();
            // return response()->json([]);
        }

        $bag_otp_number  = Configuration::getConfigurationRowByConfigKey("otp_number_3");
        if (!is_null($bag_otp_number) && isset($bag_otp_number['config_value']) && trim($bag_otp_number['config_value']) != '') {
            $mobile_number = $bag_otp_number['config_value'];

            $client = new \GuzzleHttp\Client();
            $response = $client->request('GET', "https://2factor.in/API/V1/09524649-4166-11e8-a895-0200cd936042/SMS/+91$mobile_number/$cancelOtp");
            $statusCode = $response->getStatusCode();
            $content = $response->getBody();
        }

        return response()->json([], 200);
    }
}
