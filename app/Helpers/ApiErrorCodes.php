<?php
namespace App\Helpers;
/**
 * Created by IntelliJ IDEA.
 * User: baskar
 * Date: 7/8/14
 * Time: 5:49 PM
 */



class ApiErrorCodes
{
    const API_STATUS_ERROR                              =  0;
    const API_STATUS_SUCCESS                            =  1;
    const API_ERROR_CODE_UNAUTH                         =  401;
    const API_ERROR_MSG_UNAUTH                          =  'Unauthorized Access';
    const API_ERROR_CODE_INPUT                          =  402;
    const API_ERROR_MSG_INPUT                           =  'Error in input';
    const API_ERROR_CODE_DB                             =  503;
    const API_ERROR_MSG_DB                              =  'Internal DB error!';
    const API_ERROR_CODE_RENDER_CALLED                  =  504;
    const API_ERROR_MSG_RENDER_CALLED                   =  'Controller::render Called in API Mode!';
    const API_ERROR_CODE_NOTFOUND                       =  404;
    const API_ERROR_MSG_NOTFOUND                        =  'Unable to find requested WebService/Method ([CONTROLLER]/[ACTION]) in current API version!';
    const API_ERROR_CODE_PARAM_MISSING                  =  403;
    const API_ERROR_MSG_PARAM_MISSING                   =  'One or more Required params are missing!';
    const API_ERROR_CODE_MKEY_NOTVALID                  =  403;
    const API_ERROR_MSG_MKEY_NOTVALID                   =  'Login is expired!, Please re-login!';
    const API_ERROR_UNKNOWN_DEVICE                      =  601;
    const API_ERROR_MSG_UNKNOWN_DEVICE                  =  'Unknown Device! Please contact your admin';
    const API_ERROR_CODE_CONFLICT_DEVICE                =  602;
    const API_ERROR_MSG_CONFLICT_DEVICE                 =  'Device <> User Conflicts';
    const API_ERROR_DEVICE_UNASSIGNED                   =  603;
    const API_ERROR_MSG_DEVICE_UNASSIGNED               =  "No device's assigned for current login! Please contact admin to resolve this issue";
    const API_ERROR_CODE_BLOCKED_USER                   =  604;
    const API_ERROR_MSG_BLOCKED_USER                    =  'User are not allowed to book new Order(s).Since User is blocked.Please contact admin to resolve this issue ';
    const ERROR_CODE_UNIQUE_EMAIL                       =  606;
    const ERROR_CODE_UNIQUE_MOBILE_NO                   =  607;
    const ERROR_CODE_DEALER_HAS_ORDERS                  =  608;
    const ERROR_CODE_CLOUD_SERVER_SYNC_DELETE_ERROR     =  609;
    const ERROR_CODE_EXCEPTION                          =  610;
    const API_ERROR_CODE_INVALID_PRICE                  =  701;
    const API_ERROR_MSG_INVALID_PRICE                   =  ' Invalid Price ';
    const API_ERROR_CODE_INSUFFICIENT_STOCK             =  700;
    const API_ERROR_MSG_INSUFFICIENT_STOCK              =  'Insufficient stock';

    public static $ERROR_MESSAGE;

    public function __construct()
    {
        self::$ERROR_MESSAGE = array(
            ERROR_CODE_EXCEPTION => 'Could not delete Dealer',
            ERROR_CODE_DEALER_HAS_ORDERS => 'Dealer has Orders',
            ERROR_CODE_CLOUD_SERVER_SYNC_DELETE_ERROR => 'Sync Deletion failed',
            ERROR_CODE_UNIQUE_EMAIL => 'Someone has that Email!',
            ERROR_CODE_UNIQUE_MOBILE_NO => 'Someone has that Phone Number!'
        );
    }

    public static function getErrorMessage($err)
    {
        $message = self::$ERROR_MESSAGE;
        return array_key_exists($err, $message) ? $message[$err] : '--UNKNOWN ERROR--';
    }
}