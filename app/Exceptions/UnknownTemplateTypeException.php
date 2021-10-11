<?php
/**
 * Created by IntelliJ IDEA.
 * User: baskar
 * Date: 2/3/19
 * Time: 11:12 PM
 */

namespace App\Http\Controllers\API;


class UnknownTemplateTypeException extends \Exception
{

    /**
     * UnknownTemplateTypeException constructor.
     * @param $template_string
     */
    public function __construct($template_string)
    {
        $this->code = 500;
        $this->message = "Unknown test case template -> $template_string";
    }
}
