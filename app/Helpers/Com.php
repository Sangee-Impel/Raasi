<?php
namespace App\Helpers;

class Com
{
    public static $orderView = "orderView", $orderViewValue = "1", $orderViewUrl = "view";
    public static $whiteList = array('api', 'photo', 'mApi', 'login', 'login/index', 'login/reset', 'apiKey/generate', 'apiKey/validate', 'login/recover', 'snapshot/index', 'ceoDataProvider', 'mobile');

    public static function get($var)
    {
        return (isset($_GET[$var]));
    }

    public static function post($var)
    {
        return (isset($_POST[$var]));
    }


    public static function checkLogin()
    {
        //return true;
        $app = Yii::app();
        $requestPage = $app->getUrlManager()->parseUrl($app->getRequest());
        $parts = explode("/", $requestPage);
        $controller = $parts[0];
        if (isset($parts[1])) {
            $action = $parts[1];
        } else {
            $action = "index";
        }
        if (in_array($controller, Com::$whiteList) || in_array($requestPage, Com::$whiteList)) {
            return;
        }
        Com::unsetSession(Com::$orderView);
        /*Edit By Sridhar for order view access function*/
        //sridhar start
        if (Com::isSession('accessRules') && $controller === "order") {
            $access_order_view = Com::checkOrderViewAccess($controller, "View");
            if ($access_order_view) {
                Com::setSession(Com::$orderView, Com::$orderViewValue);

            }
        }

        $isValid = true;
        if ($parts[count($parts) - 1] == Com::$orderViewUrl && Com::isSession(Com::$orderView)) {
            $isValid = false;
        }
        //sridhar end

        if ($isValid) {
            if (!AccessRules::Check($controller, $action)) {
                global $ACCESS_DENIED;
                $ACCESS_DENIED = true;
            }
        }


    }

    public static function unsetSession($key)
    {
        unset(Yii::app()->session[$key]);
    }

    public static function isSession($key)
    {
        return Yii::app()->session->contains($key);
    }

    public static function checkOrderViewAccess($controller, $action)
    {
        if (Com::isSession('accessRules')) {
            $rules = Com::session('accessRules');
            foreach ($rules as $index => $module) {
                if ($module['id'] === strtolower($controller)) {
                    foreach ($module['values'] as $method_arr) {

                        if ($method_arr['id'] === strtolower($controller) . "/" . $action) {

                            if ($method_arr["state"] >= 1) {
                                return true;
                            } else {


                                return false;
                            }
                        }
                    }
                }
            }
        }


    }

    public static function session($key)
    {
        return Yii::app()->session[$key];
    }

    /* public static function custom_date_format($dt){
         if(is_numeric($dt)){
             $dt = $dt;
         }else if(is_string($dt)){
             $dt = strtotime($dt);
         }
         return date("d-m-Y", $dt);
     }*/

    public static function setSession($key, $value)
    {
        return Yii::app()->session[$key] = $value;
    }

    public static function isWhiteListed()
    {
        $app = Yii::app();
        $requestPage = $app->getUrlManager()->parseUrl($app->getRequest());
        $parts = explode("/", $requestPage);
        $controller = $parts[0];
        if (isset($parts[1])) {
            $action = $parts[1];
        } else {
            $action = "index";
        }


        //$whiteList = array('api', 'mApi', 'login', 'login/index', 'login/reset', 'login/recover', 'gvtrace/trackr');
        if (in_array($controller, Com::$whiteList) || in_array($requestPage, Com::$whiteList)) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * @param $resource String resource file path!
     * @param int|\Var $echo Var default 1
     * $echo variable will decide
     *
     * @return String
     */
    public static function res($resource, $echo = 1)
    {
        $resource = Com::url("resources/" . $resource, 1);
        if ($echo == "1") {
            echo $resource;
        } else {
            return $resource;
        }
    }

    /**
     * @param $path = input file path
     * $echo is boolean type variable
     * Echo decides, whether the printable statement is neccessary
     *
     * @param int $echo
     *
     * @return string
     */
    public static function url($path, $echo = 0)
    {

        $baseUrl = Yii::app()->getBaseUrl();
        if (strpos($path, "assets") !== false) {
            $baseUrl .= "/..";
        }

        $pathUrl = $baseUrl . "/" . $path;

        if ($echo == "1") {
            return $pathUrl;
        } else {
            echo $pathUrl;
        }
    }

    /**
     * This method will convert std date format to custom dateformat used in application wide.
     *
     * @param $dt int|string UnixTimestamp or std date time format
     *
     * @return string
     */
    public static function custom_date_format($dt)
    {
        return date("Y-m-d", strtotime($dt));
    }

    public static function custom_time_format($tm)
    {
        if (is_numeric($tm)) {
            $tm = $tm;
        } else if (is_string($tm)) {
            $tm = strtotime($tm);
        }
        return date("h:i A", $tm);
    }

    public static function user_time_format($tm)
    {
        if (is_numeric($tm)) {
            $tm = $tm;
        } else if (is_string($tm)) {
            $tm = strtotime($tm);
        }
        return date("h:i A", $tm);

    }

    /**
     * same as custom_date_format but this is used along with time
     */
    public static function custom_date_time_format($dt)
    {
        return date("h:i A Y-m-d", strtotime($dt));
    }

    /**
     * This method is used to convert Custom Dateformat to std date format. usefull when convert user input date to system date
     *
     * @param $ip_date string date in custom format
     *
     * @return DateTime datetime object
     */
    public static function std_date_format($ip_date)
    {
        $date = date_create_from_format('d-m-Y', $ip_date);
        return $date;
    }

    public static function mysql_date_format_from_unix($unix_time_int)
    {
        $dateTime = new DateTime();
        $dateTime->setTimeStamp($unix_time_int);
        return self::mysql_date_format($dateTime);
    }

    /**
     * This method will convert std date to mysql date format use full when used in insert or update
     */
    public static function mysql_date_format($std_date)
    {
        return $std_date->format('Y-m-d H:i:s');
    }

    public static function mysql_date_format_to_unix($mysql_date_time)
    {
        $date = date_create_from_format('Y-m-d H:i:s', $mysql_date_time);
        return $date->getTimestamp();
    }

    /**
     * This method will return number of days between two dates
     *
     */
    public static function get_number_of_days($from_date, $to_date)
    {

        $date1 = date('Y-m-d', strtotime($from_date));
        $date2 = date('Y-m-d', strtotime($to_date));

        $diff = strtotime($date2) - strtotime($date1);

        $day = floor($diff / (60 * 60 * 24));
        $day++;
        if ($day <= 1)
            return "1 Day";
        else
            return $day . " Days";
    }

    /**
     * This method will return number of hours between two dates
     * NOTE : Give The Input DateTime || Time
     *
     */
    public static function get_number_of_hours($from_time, $to_time)
    {

        //Getting Seconds For From Time
        $time_1 = explode(':', date('H:i:s', strtotime($from_time)));
        $total_secconds_1 = $time_1[0] * 3600;
        $total_secconds_1 += $time_1[1] * 60;
        $total_secconds_1 += $time_1[2];

        //Getting Seconds For To Time
        $time_2 = explode(':', date('H:i:s', strtotime($to_time)));
        $total_secconds_2 = $time_2[0] * 3600;
        $total_secconds_2 += $time_2[1] * 60;
        $total_secconds_2 += $time_2[2];

        $total_seconds = $total_secconds_2 - $total_secconds_1;

        if ($total_seconds < 3600)
            return floor($total_seconds / 60) . " Minutes";
        else if ($total_seconds >= 3600) {

            $hour = floor($total_seconds / 3600);
            if ($hour <= 1)
                return "1 Hour";
            else
                return $hour . " Hours";
        }
    }

    /**
     * @param $model = Table corresponding to the model ex: job_card_design
     * @param $field = Table field ex: image
     * @param $parent_directory = to save files ex:  design
     *
     * @param $image_name
     *
     * @return array
     * @return array
     */
    public static function imageUpload($model, $field, $parent_directory, $image_name)
    {
        $uploadedFile = CUploadedFile::getInstance($model, $field);

        #todo Change image filename
        $fileName = $uploadedFile;

        $path_to_db = "uploads/" . $parent_directory . "/" . $fileName;
        $thumb_path_to_db = "uploads/" . $parent_directory . "/thumbnails/" . $fileName;

        $path = Yii::app()->basePath . "/../" . $path_to_db;
        $thumb_path = Yii::app()->basePath . "/../" . $thumb_path_to_db;

        $uploadedFile->saveAs($path); //Save original image

        $thumb = Yii::app()->thumb; //Create thumb
        $thumb->image = $path;
        $thumb->defaultName = $fileName;
        $thumb->createThumb();

        $thumb->directory = Yii::app()->basePath . "/../" . "uploads/" . $parent_directory . "/thumbnails/"; //Directory to save thumb image
        $thumb->save();

        $retArray = array(
            "path" => $path_to_db,
            "thumb_path" => $thumb_path_to_db
        );

        return $retArray;
    }

    public static function get_today()
    {
        return date('Y-m-d', time());
    }

    /*
     * Function to return Today date in Y-m-d Formate
     */

    static function log($msg)
    {
        $i = 1;
        $flag = true;
        $txt = "\n[" . date("h:i A Y-m-d", time()) . "]\t" . $msg . "\n";
        $path = Yii::app()->getRuntimePath() . "/comLog.txt";
        if (file_exists($path)) {
            // 1 MB Size (1048576 Bytes / 1024 Bytes => 1024 KB => 1 MB )

            if ((filesize($path) / 1024) >= self::params('logFileSize')) {

                //if(filesize($path) >= 1024){
                while ($flag) {
                    $c_path = Yii::app()->getRuntimePath() . "/comLog.txt." . $i;
                    if (!file_exists($c_path)) {
                        $i--;
                        for ($j = $i; $j >= 1; $j--) {
                            self::apiLog($j);
                            $pathLB = Yii::app()->getRuntimePath() . "/comLog.txt." . $j;
                            $pathL = Yii::app()->getRuntimePath() . "/comLog.txt." . ($j + 1);
                            rename($pathLB, $pathL);
                        }
                        rename($path, $path . '.1');
                        $flag = false;
                    }
                    $i++;
                }
            }
        }
        file_put_contents(Yii::app()->getRuntimePath() . "/comLog.txt", $txt, FILE_APPEND);
    }

    /*
        static function log($msg){
            $txt  =  "\n[".date("h:i A Y-m-d", time())."]\t".$msg."\n";
            file_put_contents(Yii::app()->getRuntimePath()."/comLog.txt", $txt, FILE_APPEND);
        }
    */

    public static function params($key)
    {
        return Yii::app()->params[$key];
    }

    static function apiLog($msg)
    {
        $txt = "\n[" . date("h:i A Y-m-d", time()) . "]\t" . $msg . "\n";
        file_put_contents(Yii::app()->getRuntimePath() . "/mApi.txt", $txt, FILE_APPEND);
    }


    /*
     * function to return upload path based on year and month
     * */
    static function getUploadPath()
    {

        $path = 'uploads/' . date('Y') . "/" . date('m') . "/";
        $basePath = dirname(Yii::app()->basePath) . '/' . $path;

        if (!file_exists($basePath)) {
            if (!mkdir($path, 0777, true))
                return;
        }

        return $path;

        //$basePath   =   dirname(Yii::app()->basePath)."/uploads/";
        /*$directoryYear  =   $basePath."".date('Y');

        if(!file_exists($directoryYear)){
            if(!mkdir($directoryYear)){
                return;
            }
        }
        $directoryMonth  =   $directoryYear.'/'.date('m');

        if(!file_exists($directoryMonth)){
            if(!mkdir($directoryMonth))
                return;
        }*/


    }


    static function get_past_week_date()
    {
        $week = array();
        for ($i = 0; $i < 7; $i++) {
            $week[] = date('Y-m-d', strtotime('-' . $i . ' Day'));
        }
        return $week;

    }

    static function get_past_week_date_custom_format($arr = array())
    {
        $week = array();
        if (is_array($arr)) {
            foreach ($arr as $key => $value) {
                $week[] = date('M d', strtotime($value));
            }
            return $week;
        }
    }

    /**
     * Edited By kalai
     */
    static function get_client_ip()
    {
        $ipaddress = '';
        if (getenv('HTTP_CLIENT_IP'))
            $ipaddress = getenv('HTTP_CLIENT_IP');
        else if (getenv('HTTP_X_FORWARDED_FOR'))
            $ipaddress = getenv('HTTP_X_FORWARDED_FOR');
        else if (getenv('HTTP_X_FORWARDED'))
            $ipaddress = getenv('HTTP_X_FORWARDED');
        else if (getenv('HTTP_FORWARDED_FOR'))
            $ipaddress = getenv('HTTP_FORWARDED_FOR');
        else if (getenv('HTTP_FORWARDED'))
            $ipaddress = getenv('HTTP_FORWARDED');
        else if (getenv('REMOTE_ADDR'))
            $ipaddress = getenv('REMOTE_ADDR');
        else
            $ipaddress = 'UNKNOWN';

        return $ipaddress;
    }

    public static function getStandardTimeWithLeadingZeros($standard_time, $retType = 0)
    {
        $hours = floor($standard_time / 3600);
        $minutes = floor(($standard_time / 60) % 60);
        $seconds = $standard_time % 60;

        if ($hours < 10) {
            $hours = "0" . $hours;
        }
        if ($minutes < 10) {
            $minutes = "0" . $minutes;
        }
        if ($seconds < 10) {
            $seconds = "0" . $seconds;
        }
        $formatedTime = $hours . ":" . $minutes . ":" . $seconds;
        if ($retType == "1") {
            $formatedTime = $hours;
        } elseif ($retType == "2") {
            $formatedTime = $minutes;
        } elseif ($retType == "3") {
            $formatedTime = $seconds;
        } elseif ($retType == "4") {
            $formatedTime = $hours . ":" . $minutes;
        }

        return $formatedTime;
    }

    public static function getStandardTime($standard_time, $retType = 0)
    {
        $hours = floor($standard_time / 3600);
        $minutes = floor(($standard_time / 60) % 60);
        $seconds = $standard_time % 60;

        $formatedTime = $hours . ":" . $minutes . ":" . $seconds;
        if ($retType == "1") {
            $formatedTime = $hours;
        } elseif ($retType == "2") {
            $formatedTime = $minutes;
        } elseif ($retType == "3") {
            $formatedTime = $seconds;
        } elseif ($retType == "4") {
            $formatedTime = $hours . ":" . $minutes;
        }


        return $formatedTime;
    }


    /**
     * @param $hours
     * @param $minutes
     * @param $seconds
     * @return Seconds
     *
     */
    public static function setStandardTime($hours, $minutes, $seconds)
    {
        $hours = $hours * 3600;
        $minutes = $minutes * 60;
        $standard_time = $hours + $minutes + $seconds;
        return $standard_time;
    }

    public static function custom_display_time_format($tm)
    {

        return date("h:i:s A", strtotime($tm));
    }

    public static function getExperience($emp_code)
    {
        $arr = array(
            "C" => "Confirm",
            "P" => "Probationer"
        );
        $emp_code = substr($emp_code, 0, 1); //Get First Letter
        if (array_key_exists($emp_code, $arr)) {
            return $arr[$emp_code];
        }
        return false;
    }


    public static function setNumberFormat($num)
    {
        $num = str_replace(",", "", $num);
        $decimal_point = 2;
        /*if(get_settings('F_DECIMAL') == 1) {
            $decimal_point = 5;
        }*/
        if ((is_numeric($num)) && ($num >= 0 || $num < 0)) {
            return number_format($num, $decimal_point, ".", "");
        } else {
            return $num;
        }
    }


    public static function roundOffValue($round)
    {
        if (is_numeric($round)) {
            return number_format($round, 2);
        }
        return 0;
    }

    public static function downloadCSVFile($summary, $datas, $col_1_title = "Name", $key_value = "value", $report_info = array())
    {

        header('Content-Type: text/csv; charset=utf-8');
        header('Content-Disposition: attachment; filename=data.csv');

        $output = fopen('php://output', 'w');

        //Print Report Title with some information like dates
        if (isset($report_info["title"])) {
            fputcsv($output, array(ucfirst($report_info["title"])));
        }
        $remove_footer = isset($report_info["remove_footer"]) ? $report_info["remove_footer"] : 0;
        $percentage = ($key_value == "value_percentage") ? "%" : "";

        $keys = array();
        $keys[] = $col_1_title; //First Column Like Name
        $final_result = array();
        $final_result[] = ""; //In footer First Column is Blank

        //If Extra column like Emp code is avail means, that title can be add
        if (isset($report_info["extras"]) && count($report_info["extras"]) > 0) {
            foreach ($report_info["extras"] as $report_key => $report_val) {
                $keys[] = ucfirst($report_val);
                $final_result[] = "";
            }
        }


        //After that Other columns can be added
        foreach ($summary as $key => $val) {
            $keys[] = ucfirst($key);
            $final_result[] = $val . $percentage;
        }

        fputcsv($output, $keys);

        if ($datas != "0" && count($datas)) {
            foreach ($datas as $id => $data) {
                $ind_data = array();
                $ind_data[] = $data["name"]; //First Coulmn name

                //Specified Extra Coulmns
                if (isset($report_info["extras"]) && count($report_info["extras"]) > 0) {
                    foreach ($report_info["extras"] as $report_key => $report_val) {
                        $ind_val = isset($data["extras"][$report_val]) ? $data["extras"][$report_val] : "";
                        if ($ind_val != "") {
                            $ind_data[] = $ind_val;
                        }
                    }
                }

                //Other Columns
                foreach ($summary as $key => $val) {
                    $ind_val = isset($data[$key_value][$key]) ? $data[$key_value][$key] : 0;
                    $ind_data[] = $ind_val . $percentage;
                }

                fputcsv($output, $ind_data);
            }
        }
        //Footer
        if ($remove_footer == "0") {
            fputcsv($output, $final_result);
        }

        fclose($output);
    }

    public static function switchToDB($host = IP_ADDRESS_SLAVE, $DbName = DB_NAME)
    {

        Yii::app()->db->setActive(false);
        Yii::app()->db->connectionString = "mysql:host=$host;dbname=$DbName";

        if ($host != "192.168.1.39" && $host != "192.168.1.42" && $host != "192.168.1.56") {
            if ($host == IP_ADDRESS_SLAVE) {
                Yii::app()->db->password = "vignesh";
            } else {
                Yii::app()->db->password = "vignesh";
            }
        }

        Yii::app()->db->setActive(true);
    }


    /**
     * @param $diffArray
     * @return string
     */
    public static function minimiseTime(array $diffArray)
    {
        $mTime = '';
        $stopLoop = false;
        foreach ($diffArray as $type => $val) {
            $val = (int)$val;
            if ($val <= 0) {
                continue;
            }
            switch ($type) {
                case 'years'  :
                case 'months' :
                    $mTime = " $val $type ago";
                    if ($val === 1) {
                        $mTime = "a $type ago";
                    }
                    $stopLoop = true;
                    break;
                case 'days'   :
                    $mTime .= " $val $type ago";
                    if ($val >= 7 and $val < 14) {
                        $mTime = '';
                        $mTime .= 'a weeks ago';
                    } elseif ($val >= 14) {
                        $mTime = '';
                        $mTime .= ' ' . floor((int)$val / 7) . ' weeks ago ';
                    }
                    $stopLoop = true;
                    break;
                case 'hours':
                case 'mins':
                case 'sec':
                    $mTime .= " $val $type ago ";
                    $stopLoop = true;
                    break;
            }
            if ($stopLoop) {
                break;
            }
        }
        return $mTime;
    }


    public static function minimiseDate($array)
    {
        $diff = 0;
        foreach ($array as $type => $val) {
            $val = (int)$val;
            if ($val <= 0) {
                continue;
            }
            switch ($type) {
                case 'years'  :
                    $diff += $val * 365;
                    break;
                case 'months' :
                    $diff += $val * 31;
                    break;
                case 'days'   :
                    $diff += $val * 1;
                    break;
            }

        }
        /* var_dump($diff);
         exit;*/
        return $diff * -1;

    }

    /**
     * @param int $len
     * @param bool $readable
     * @param bool $hash
     * @return string
     */
    public static function random_key($len = 16, $readable = true, $hash = false)
    {
        $key = '';

        if ($hash)
            $key = substr(sha1(uniqid(rand(), true)), 0, $len);
        else if ($readable) {
            $chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

            for ($i = 0; $i < $len; ++$i)
                $key .= substr($chars, (mt_rand() % strlen($chars)), 1);
        } else
            for ($i = 0; $i < $len; ++$i)
                $key .= chr(mt_rand(33, 126));

        return $key;
    }

    /**
     * This will add "/" to 0th index of given string.
     * Can be useful in MQTT TOPIC
     * @param $string
     * @return string
     */
    public static function addRootSlash($string)
    {
        if (strpos($string, '/') === 0) {
            return $string;
        } else {
            return "/$string";
        }
    }

    /**
     * @param $date
     * @return bool|string
     * Converts d/m/Y to Y-m-d
     */
    public static function convertStringToDate($date)
    {
        $date = str_replace('/', '-', $date);
        return DateFormatter::format(DateFormatter::$MYSQL_DATE_FORMAT, $date);
    }

    function setParams($key, $value)
    {
        return Yii::app()->params[$key] = $value;
    }

    public static function moneyFormat($amount){

        $amount = (float) round($amount,2);
        setlocale(LC_MONETARY, 'en_IN');
        $amount = money_format('%!i', $amount);
        return $amount;
    }
    public static function getIndianCurrency($number)
    {
        $no = round($number);
        $decimal = round($number - ($no = floor($number)), 2) * 100;
        $digits_length = strlen($no);
        $i = 0;
        $str = array();
        $words = array(
            0 => '',
            1 => 'One',
            2 => 'Two',
            3 => 'Three',
            4 => 'Four',
            5 => 'Five',
            6 => 'Six',
            7 => 'Seven',
            8 => 'Eight',
            9 => 'Nine',
            10 => 'Ten',
            11 => 'Eleven',
            12 => 'Twelve',
            13 => 'Thirteen',
            14 => 'Fourteen',
            15 => 'Fifteen',
            16 => 'Sixteen',
            17 => 'Seventeen',
            18 => 'Eighteen',
            19 => 'Nineteen',
            20 => 'Twenty',
            30 => 'Thirty',
            40 => 'Forty',
            50 => 'Fifty',
            60 => 'Sixty',
            70 => 'Seventy',
            80 => 'Eighty',
            90 => 'Ninety');
        $digits = array('', 'Hundred', 'Thousand', 'Lakh', 'Crore');
        while ($i < $digits_length) {
            $divider = ($i == 2) ? 10 : 100;
            $number = floor($no % $divider);
            $no = floor($no / $divider);
            $i += $divider == 10 ? 1 : 2;
            if ($number) {
                $plural = (($counter = count($str)) && $number > 9) ? 's' : null;
                $str [] = ($number < 21) ? $words[$number] . ' ' . $digits[$counter] . $plural : $words[floor($number / 10) * 10] . ' ' . $words[$number % 10] . ' ' . $digits[$counter] . $plural;
            } else {
                $str [] = null;
            }
        }

        $Rupees = implode(' ', array_reverse($str));
        //$paise = ($decimal) ? "And Paise " . ($words[$decimal - $decimal%10]) ." " .($words[$decimal%10])  : '';
        $paise = ($decimal) ? "And " . ($words[$decimal - $decimal%10]) . " ". ($words[$decimal%10]) ." Paise ": '';
        return ($Rupees ? 'Rupees ' . $Rupees : '') . $paise . " Only";
    }


    /**
     * @param $path
     * @param $filename
     * @return string
     * created by:kartik
     */

    public static function generateNewFileName($path, $filename){
        if ($pos = strrpos($filename, '.')) {
            $name = substr($filename, 0, $pos);
            $ext = substr($filename, $pos);
        } else {
            $name = $filename;
        }
        $newpath = $path.'/'.$filename;
        $newname = $filename;
        $counter = 0;
        while (file_exists($newpath)) {
            $newname = $name .'_'. $counter . $ext;
            $newpath = $path.'/'.$newname;
            $counter++;
        }
        return $newname;
    }

    public static function getUnitLogo($user_id){

        if($user_id!=""){
            $user = User::model()->findByPk($user_id);
            if(!is_null($user)){
                $unit = Unit::model()->findByAttributes(array('trash'=>0,'id'=>$user->unit_id));
                if(!is_null($unit)){
                    return $unit->logo_image;
                }
            }
        }
    }


}