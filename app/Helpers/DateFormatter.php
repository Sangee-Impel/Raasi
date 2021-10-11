<?php
namespace App\Helpers;
use Faker\Provider\DateTime;

/**
 * @author : A Vijay
 * Date: 5/14/15
 * Time: 3:38 PM
 */
class DateFormatter
{

    public static $MYSQL_DATE_FORMAT = 'Y-m-d';
    public static $USER_DP_FORMAT = 'd-m-Y';
    public static $MYSQL_DATETIME_FORMAT = 'Y-m-d H:i:s';
    public static $USER_DATE_FORMAT = 'd M, Y';
    public static $USER_DATE_FORMAT_STYLE2 = 'M d, Y';
    public static $USER_TIME_FORMAT = 'h:i A';
    public static $USER_DATETIME_FORMAT = 'h:i:s A  d M, Y';
    public static $UNIX_TIMESTAMP = 'U';
    public static $JS_DATE_FORMAT = 'm-d-Y';

    public static $GLOBAL_DATE_FORMAT = 'd/m/Y';

    //date format to any date format which is mentioned

    public static function dateDiff($date1, $date2 = '', $minimise = true, $text = false)
    {
        $datetime1 = new \DateTime($date1);
        #$datetime2 = new DateTime('2011-01-03 17:13:00');
        if ($date2 == '') {
            $date2 = date(self::$MYSQL_DATETIME_FORMAT);
        }

        $datetime2 = new \DateTime($date2);
        $interval = $datetime1->diff($datetime2);
        $diff = array();
        $diff['years'] = $interval->format('%y');
        $diff['months'] = $interval->format('%m');
        $diff['days'] = $interval->format('%a');
        $diff['hours'] = $interval->format('%h');
        $diff['mins'] = $interval->format('%i');
        $diff['sec'] = $interval->format('%S');

        if ($text) {
            $diff = $interval->format('%y years %m months %a days %h hours %i minutes %S seconds');
        }
        if (!$text && $minimise) {
            return DateFormatter::minimiseTime($diff);
        }
        return $diff;
    }

    //unix timestamp to date converter

    public static function dateAdd($date, $number = '+1', $unit = 'day', $format = null)
    {
        if ($format === null) {
            $format = self::$MYSQL_DATE_FORMAT;
        }
        $date = date(strtotime($number . ' ' . $unit, strtotime($date)));
        /**
         * $date   =   date(DateFormatter::$MYSQL_DATE_FORMAT,date(strtotime($number.' '.$unit,strtotime($date))));
         */
        return self::formatUnix($format, $date);
    }

    public static function formatUnix($format, $dt)
    {
        $dateTime = new \DateTime();
        $dateTime->setTimeStamp($dt);
        return $dateTime->format($format);
    }

    public static function validate($date)
    {
        $hasSlashFun = explode('/', $date);
        $date = self::format(DateFormatter::$MYSQL_DATE_FORMAT, $date);
        $date = explode('-', $date);
        if (count($hasSlashFun) > 1) {
            $hasSlashFun = $date[1];
            $date[1] = $date[2];//1- is date
            $date[2] = $hasSlashFun;//now 1- is month
        }
        if ($date[0] == '1970') {
            return false;
        }
        return checkdate($date[1], $date[2], $date[0]);
    }

    public static function format($format, $dt)
    {
        if (is_string($dt)) {
            $dt = strtotime($dt);
        }
        return date($format, $dt);
    }
    public static function minimiseTime(array $diffArray){
        $mTime = '';
        $stopLoop = false;
        foreach($diffArray as $type => $val){
            $val = (int)$val;
            if($val <= 0){
                continue;
            }
            switch($type){
                case 'years'  :
                case 'months' :
                    $mTime =  " $val $type ago";
                    if($val === 1){
                        $mTime =  "a $type ago";
                    }
                    $stopLoop   =   true;
                    break;
                case 'days'   :
                    $mTime   .=  " $val $type ago";
                    if($val >= 7 and $val < 14){
                        $mTime = '';
                        $mTime   .=  'a weeks ago';
                    }elseif($val >= 14 ){
                        $mTime = '';
                        $mTime   .=  ' ' . floor((int)$val/7) . ' weeks ago ';
                    }
                    $stopLoop   =   true;
                    break;
                case 'hours':
                case 'mins':
                case 'sec':
                    $mTime   .=  " $val $type ago ";
                    $stopLoop   =   true;
                    break;
            }
            if($stopLoop){
                break;
            }
        }
        return $mTime;
    }
    public static function StartTime($date,$type){
        if($type ==1){
            return DateFormatter::format(Self::$MYSQL_DATETIME_FORMAT,$date);
        }else{
            return DateFormatter::format(Self::$MYSQL_DATE_FORMAT,$date).' 23:59:59';
        }
    }

    /*public static function strtotime( $dt ){
        if (is_string($dt)) {
            $dt = strtotime($dt);
        }
        return $dt;
    }*/
}