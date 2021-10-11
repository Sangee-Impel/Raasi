<?php
namespace App\Helpers;

 use Illuminate\Support\Facades\Session;

class Alerts
 {

 	/**
     * Display notification
    */
     //global $gritters, $postGritters;
     public static $gritters = array();
     public static $postGritters = array();
    public static function addGritter($title="", $text="",$image="",$sticky="false", $time=5000)
    {
        global $gritters;
        $gritters[] = <<<JS
$.gritter.add({
        title: "{$title}",
        text: "{$text}",
        image: "{$image}",
        sticky: $sticky,
        time: $time
});
JS;
    }

    public static  function addPostGritter($title="", $text="",$image="",$sticky="false", $time=5000){
        global $postGritters;
        global $gritterBusCallBack;

        $js = <<<JS
$.gritter.add({
        title: "{$title}",
        text: "{$text}",
        image: "{$image}",
        sticky: $sticky,
        time: $time
});
JS;

        if($gritterBusCallBack!=null){
            call_user_func_array($gritterBusCallBack, array($js));
            return;
        }
        array_push($postGritters, $js);
    }

    public static function yieldGritters()
    {
        global $gritters, $postGritters;
        echo <<<HTML
<script type="text/javascript">
    $(document).ready(function(){
HTML;

        if(!is_null($gritters)){
            foreach($gritters AS $key=>$gritter){
                echo $gritter;
            }
        }

        if(Session::has("postGritter")){
            foreach(Session::get("postGritter") AS $key => $gritter){
                echo $gritter;
            }
        }
        Session::put('postGritter',$postGritters);
        echo <<<HTML
});
</script>
HTML;
    }


     public static function setPostGritterBus($func)
     {
        global $gritterBusCallBack;
         $gritterBusCallBack = $func;
     }

    public static function controllerEndRequest(){
        global $postGritters;
        if(!isset(Yii::app()->session["postGritter"])) Yii::app()->session["postGritter"] = array();
        Yii::app()->session["postGritter"] = array_merge(Yii::app()->session["postGritter"], $postGritters );
    }
 }
?>
