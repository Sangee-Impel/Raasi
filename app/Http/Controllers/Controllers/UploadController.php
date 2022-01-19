<?php

namespace App\Http\Controllers;

use App\Models\BugCatcher;
use App\Models\Uploads;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Config;

class UploadController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('auth');
    }

    /**
     * Handles upload POST multipart request from client!
     * @param Request $request
     * @return \Illuminate\Http\Response
     */
    public function upload(Request $request){
        $uploadedPath = $request->attachment->store(Config::get('constants.upload_path'));
        $upload_file = $this->storeFile($uploadedPath,$request->all());
        return response()->make($upload_file);
//        return response()->json($upload_file);
    }

    /**
     * Customer file upload
     *
     * @param Request $request
     * @return \Illuminate\Http\Response
     */

    public function storeCustomerUpload(Request $request) {
        $current_year  = date('Y');
        $current_month = date('m');
        $current_date  = date('d');
        $year_path = 'customer_attachments/'.$current_year;
        if (!file_exists($year_path)) {
            mkdir($year_path, 0777, true);
        }
        $month_path = $year_path.'/'.$current_month;
        if (!file_exists($month_path)) {
            mkdir($month_path, 0777, true);
        }
        $day_path = $month_path.'/'.$current_date;
        if (!file_exists($day_path)) {
            mkdir($day_path, 0777, true);
        }
        $upload_path = Config::get('constants.customer_file_path').$current_year.'/'.$current_month.'/'.$current_date;
        $uploadedPath = $request->attachment->store($upload_path);
        $upload_file = $this->storeFile($uploadedPath,$request->all());
        $upload = Uploads::with('user')->findOrFail($upload_file->id);
        return response()->make($upload);
    }


    /**
     * Handles file delete request form FilePond!
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function delete(Request $request){

        $random_key = (array)\GuzzleHttp\json_decode($request->getContent());
        if(isset($random_key['random_key'])){
            $random_key= $random_key['random_key'];
        }
        $upload = Uploads::where('random_key', $random_key)->firstOrFail();
        Storage::delete($upload->uploaded_path);
        $upload->delete();
        return response()->json(['id'=>$upload['id']]);
    }

    public function download(Uploads $upload){
        $filename = (basename($upload->uploaded_path));
        return response()->download(storage_path("app/public/attachments/{$filename}"));
    }
    public function downloadBugCatcher(BugCatcher $bugCatcher){
        $filename = (basename($bugCatcher->uploaded_path));
        return response()->download(storage_path("app/public/bc-files/{$filename}"));
    }

    public function storeFile($path = null,$data) {
        $upload = new Uploads();
        if($path!=null) {
            $upload->uploaded_path  = $path;
            $upload->random_key     = str_random(20);
            $upload->file_name      = $data["attachment"]->getClientOriginalName();
            $upload->file_size      = $data["attachment"]->getSize();
            $upload->user_id        = Auth()->user()->id;
            $upload->save();
        }
        return $upload;
    }
}
