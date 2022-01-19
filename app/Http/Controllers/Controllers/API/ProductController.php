<?php

namespace App\Http\Controllers\API;

use App\GenXCommon\XModel;
use App\Models\Product;
use App\Models\ProductCategory;
use App\Models\Style;
use App\Models\StyleDepartmentLossApproval;
use App\Models\StyleImages;
use App\Models\Uom;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Config;
use App\Helpers\Alerts;

use Illuminate\Support\Facades\Validator;

class ProductController extends Controller
{
    /**
     * Getting grid data
     *
     */

    public function getIndex() {
        self::hasPermission('index.product');

        return view("product.index",["uploadResponce" => json_encode([])]);
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        self::hasPermission('index.product');
        $query = Product::query()->select('product.*','product_category.name as product_category_name');
        if($request->get('trash')==Config::get('constants.trash_on')) {
            $query->onlyTrashed();
        }
        $query->leftJoin('product_category', 'product_category.id', '=', 'product.product_category_id');
        return XModel::preparePagination($query, $request, ['product.name','product_category.name']);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        self::hasPermission('store.product');
        $validatedData = $request->validate([
            'product_category_id'               => 'required',
            'name'                  => "required|unique:product,name,NULL,id,product_category_id,".$request['product_category_id'],
        ]);
        DB::transaction(function() use ($request) {
            $post_data  =   $request->all();
            $product = Product::create($post_data);
            if( $product ){
                if( isset($post_data['styles']) && count($post_data['styles']) > 0 ){
                    $request->validate([
                        'styles.*.sku'      => 'required|unique:style,sku',
                        'styles.*.weight'   => 'required|numeric|gt:0',
                        'styles.*.uom_id'   => 'required|numeric',
                        'styles.*.style_department_loss_approval.*.department_id' => 'required|numeric',
                        'styles.*.style_department_loss_approval.*.percentage' => 'required|numeric|gt:0|lt:100'
                    ]);
                    foreach ($post_data['styles'] as $styleKey => $styleValue){
                        $styleValue['product_id']   =   $product['id'];
                        $style = Style::create($styleValue);
                        if($style){
                            $styleImages = $styleValue['style_images'];
                            if( count($styleImages ) > 0 ){
                                foreach ( $styleImages as $styleImageKey => $styleImageValue){
                                    $styleImageValue['style_id'] = $style['id'];
                                    StyleImages::create($styleImageValue);
                                }
                            }
                            $DepartmentLossApproval = $styleValue['style_department_loss_approval'];
                            if( count($DepartmentLossApproval) > 0 ){
                                foreach ( $DepartmentLossApproval as $DepartmentLossApprovalKey => $DepartmentLossApprovalValue ){
                                    $DepartmentLossApprovalValue['style_id'] = $style['id'];
                                    StyleDepartmentLossApproval::create($DepartmentLossApprovalValue);
                                }
                            }
                        }
                    }
                }
            }
        });
        return response()->json([], 201);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show(Product $product)
    {
        self::hasPermission('update.product');
        $product->productCategory;
        $product->styles;
        return $product;
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Product $product)
    {
        self::hasPermission('update.product');
        $validatedData = $request->validate([
            'product_category_id'               => 'required',
            'name'                  => "required|unique:product,name,".$product->id.",id,product_category_id,".$request['product_category_id'],
            //'name'                  => "required|unique:product,name,$product->id",
        ]);
        DB::transaction(function() use ($request,$product) {
            $post_data  =   $request->all();
            $product->update($post_data);
            if( $product ){
                if( isset($post_data['styles']) && count($post_data['styles']) > 0 ){

                    $request->validate((new Style())->rules($post_data['styles']));
                    foreach ($post_data['styles'] as $styleKey => $styleValue){
                        $styleValue['product_id']   =   $product['id'];
                        if( isset($styleValue['id']) && $styleValue['id'] > 0 ){
                            $style = Style::findOrFail($styleValue['id']);
                            $style->fill($styleValue);
                            $style->update();
                        }else{
                            $style = Style::create($styleValue);
                        }
                        $styleImages = $styleValue['style_images'];
                        if( count($styleImages ) > 0 ){
                            foreach ( $styleImages as $styleImageKey => $styleImageValue){
                                $styleImageValue['style_id'] = $style['id'];
                                if( isset($styleImageValue['id']) && $styleImageValue['id'] > 0){

                                }else{
                                    StyleImages::create($styleImageValue);
                                }
                            }
                        }
                        $DepartmentLossApproval = $styleValue['style_department_loss_approval'];
                        if( count($DepartmentLossApproval) > 0 ){
                            foreach ( $DepartmentLossApproval as $DepartmentLossApprovalKey => $DepartmentLossApprovalValue ){
                                $DepartmentLossApprovalValue['style_id'] = $style['id'];
                                if( isset($DepartmentLossApprovalValue['id']) && $DepartmentLossApprovalValue['id'] > 0 ){
                                    $DepartmentLossApprovalModel = StyleDepartmentLossApproval::findOrFail($DepartmentLossApprovalValue['id']);
                                    $DepartmentLossApprovalModel->fill($DepartmentLossApprovalValue);
                                    $DepartmentLossApprovalModel->update();

                                }else
                                    StyleDepartmentLossApproval::create($DepartmentLossApprovalValue);
                            }
                        }
                    }
                }
            }
        });
        return response()->json($product, 201);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(Request $request,$product)
    {
        self::hasPermission('destroy.product');
        if ($request->filled('trash') && $request->get('trash') == 0)
        {
            $model= Product::findOrFail($product);
            $model->delete();
        } else {
            $model= Product::withTrashed()->find($product);
            $model->forceDelete();
        }
        return response()->json(null);
    }
    public function restore($id){
        self::hasPermission('restore.product');
        $model            = Product::withTrashed()->find($id);
        $model->restore();
        return response()->json(null);
    }
    public function deleteProductStyle(Request $request, Style $style){
        $style->delete();
        return response()->json("ok", 203);
    }
    public function deleteProductStyleImage(Request $request, $id){
        $styleImage =  StyleImages::findOrFail($id);
        $styleImage->delete();
        return response()->json("ok", 203);
    }
    public function deleteProductStyleDepartmentLoss(Request $request, StyleDepartmentLossApproval $styleDepartmentLossApproval){
        $styleDepartmentLossApproval->delete();
        return response()->json("ok", 203);
    }
    /**
     * function for search the style.
    */
    public function search(Request $request){
        $post_data      =   $request->all();
        $query          =   Style::query()->select(['style.*']);
        if( isset($post_data['q']) ){
            $query->where("style.sku",'like',"%".$post_data['q']."%");
        }
        /*$query->leftJoin('product', 'product.id', '=', 'style.product_id');
        $query->leftJoin('product_category', 'product_category.id', '=', 'product.product_category_id');*/
        $query->with(['uom','upload','product','styleImages']);
        $styleData      =     $query->get();
        return $styleData;
    }
    public function styleUpload(Request $request){
        $post_data      =   $request->all();
        $uploadResponceData = [];
        if( isset($_FILES['styleUploadFile']['tmp_name']) && ($_FILES['styleUploadFile']['tmp_name'] != "") ){
            //Alerts::addPostGritter("Fail","Something went wrong failed to save!",'http://127.0.0.1:8000/images/impel.png');

            //#transation begin...!
            DB::beginTransaction();
            $uploadResponceData['status']   = Config::get('constants.success');
            $uploadResponceData['message']  = "File Upload Successfully";
            $reader = new \PhpOffice\PhpSpreadsheet\Reader\Xlsx();
            $spreadsheet = $reader->load($_FILES['styleUploadFile']['tmp_name']);
            $sheetData = $spreadsheet->getActiveSheet()->toArray();
            if (count($sheetData) > 0) {
                foreach ($sheetData as $index => $value) {
                    if( $index != 0 ){
                        $product_category_value   =   $value[0];
                        $product_name       =   $value[1];
                        $sku                =   $value[2];
                        $weight             =   $value[3];
                        $uom                =   $value[4];
                        $imageName              =   $value[5];

                        if( $product_category_value != "" && $product_name != "" ){
                            $product_category = ProductCategory::where("product_category.name",'like',"%".$product_category_value."%")->first();
                            if( !is_null($product_category) ){
                                $product = Product::where("product.name",'like',"%".$product_name."%")->where("product.product_category_id",$product_category['id'])->first();
                                if( is_null($product) ){
                                    $productData = [
                                        "product_category_id"   =>  $product_category['id'],
                                        "name"                  =>  $product_name
                                    ];
                                    $product = Product::create($productData);
                                }
                                $uomModel = Uom:: where("uom.name",'like',"%".$uom."%")->first();
                                if( !is_null($uomModel) ){
                                    $styleValue = [
                                        'product_id'    =>  $product['id'],
                                        'sku'               =>  $sku,
                                        'weight'            =>  $weight,
                                        'imageName'            =>  $imageName,
                                        'uom_id'            =>  $uomModel['id'],
                                    ];
                                    $validator = Validator::make($styleValue, [
                                        'sku'      => 'required|unique:style,sku',
                                        'weight'   => 'required|numeric',
                                        'uom_id'   => 'required|numeric',
                                    ]);
                                    if ($validator->fails()) {
                                        $uploadResponceData['message'] = $validator->messages()." at row:".$index;
                                        $uploadResponceData['status']   = Config::get('constants.failure');
                                        goto uploadResponce;
                                    }else{
                                        Style::create($styleValue);
                                    }
                                }
                            }
                            else{
                                $uploadResponceData['message'] = "Product Category Does not Exits :".$product_category_value." at row:".$index;
                                $uploadResponceData['status']   = Config::get('constants.failure');
                                goto uploadResponce;
                            }
                        }else{
                            $uploadResponceData['status']   = Config::get('constants.failure');
                            if( $product_category_value == "" )
                                $uploadResponceData['message'] = "Product Category Does not Empty at row:".$index;
                            else
                                $uploadResponceData['message'] = "Product Name Does not Empty at row:".$index;
                            goto uploadResponce;
                        }
                    }
                }
            }
            uploadResponce:
            if( $uploadResponceData['status'] == Config::get('constants.success') )
                DB::commit();
            else
                DB::rollBack();
        }
        else{
            $uploadResponceData = [
                "status" => Config::get('constants.failure'),
                "message" => "Please Upload Valid File"
            ];

        }
        return view("product.index",["uploadResponce" => json_encode($uploadResponceData)]);
        //["message"=>"","status"=>"success"]

    }
}
