<?php

namespace App\Http\Controllers\API;

use App\GenXCommon\XModel;
use App\Models\ProductCategory;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Config;

class ProductCategoryController extends Controller
{
    /**
     * Getting grid data
     *
     */

    public function getIndex() {
        self::hasPermission('index.productcategory');
        return view("product_category.index");
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        self::hasPermission('index.productcategory');
        $query = ProductCategory::query()->select('product_category.*','parent_product_category.name as parent_product_category_name');
        if($request->get('trash')==Config::get('constants.trash_on')) {
            $query->onlyTrashed();
        }
        $query->leftJoin('product_category as parent_product_category', 'parent_product_category.id', '=', 'product_category.parent_product_category_id');
        return XModel::preparePagination($query, $request, ['product_category.name','parent_product_category.name']);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        self::hasPermission('store.productcategory');
        $parent_product_category_id  = $request['parent_product_category_id'];
        if( is_null($parent_product_category_id) )
            $parent_product_category_id = "NULL";
        $validatedData = $request->validate([
            'name'                  => "required|unique:product_category,name,NULL,id,parent_product_category_id,".$parent_product_category_id,
        ]);
        DB::transaction(function() use ($request) {
            ProductCategory::create($request->all());
        });
        return response()->json([], 201);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show(ProductCategory $productCategory)
    {
        self::hasPermission('update.productcategory');
        $productCategory->parentProductCategory;
        return $productCategory;
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, ProductCategory $productCategory)
    {
        self::hasPermission('update.productcategory');
        $parent_product_category_id  = $request['parent_product_category_id'];
        if( is_null($parent_product_category_id) )
            $parent_product_category_id = "NULL";
        $validatedData = $request->validate([
            'name'                          => "required|unique:product_category,name,".$productCategory->id.",id,parent_product_category_id,".$parent_product_category_id,
            'parent_product_category_id'    => "not_in:$productCategory->id",
        ]);
        DB::transaction(function() use ($request,$productCategory) {
            $productCategory->update($request->all());
        });
        return response()->json($productCategory, 201);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(Request $request,$productCategory)
    {
        self::hasPermission('destroy.productcategory');
        if ($request->filled('trash') && $request->get('trash') == 0)
        {
            $model= ProductCategory::findOrFail($productCategory);
            $model->delete();
        } else {
            $model= ProductCategory::withTrashed()->find($productCategory);
            $model->forceDelete();
        }
        return response()->json(null);
    }
    public function restore($id){
        self::hasPermission('restore.productcategory');
        $model            = ProductCategory::withTrashed()->find($id);
        $model->restore();
        return response()->json(null);
    }
    /**
     *
     *
     * @return \Illuminate\Http\Response
     */
    public function viewProductCategory(Request $request){
        $post_data = $request->all();
        $treeViewArray = [];
        if( isset($post_data['id']) ){
            $treeViewArray = $this->getTreeViewData( $this->getParentProductCategory($post_data['id']));
        }
        echo json_encode(array($treeViewArray));
    }
    public function getTreeViewData($id){
        $ProductCategory    = ProductCategory::findOrFail($id);

        $treeViewArray = [
            "id" => $ProductCategory['id'],
            "name" => $ProductCategory['name'],
            "children" => []
        ];
        $childProductCategory = ProductCategory::where('parent_product_category_id',$id)->get();
        if( count($childProductCategory) > 0 ){
            foreach ( $childProductCategory as $childProductCategoryKey => $childProductCategoryValue ){
                $treeViewArray['children'][] = $this->getTreeViewData($childProductCategoryValue['id']);
            }
        }
        return $treeViewArray;
    }

    public function getParentProductCategory($id){
        $productCategory = ProductCategory::findOrFail($id);
        if( !is_null($productCategory->parent_product_category_id)){
            $id = $this->getParentProductCategory($productCategory->parent_product_category_id);
        }
        return $id;
    }
}
