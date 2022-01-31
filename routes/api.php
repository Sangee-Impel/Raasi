<?php

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register the API routes for your application as
| the routes are automatically authenticated using the API guard and
| loaded automatically by this application's RouteServiceProvider.
|
*/

Route::group([
    'middleware' => 'auth:api'
], function () {
    Route::post('/get-dropdown-data','API\UnitController@getDropDownData');
    Route::post('/transaction/get-drop-down-data', 'API\TransactionController@getDropDownData');
    Route::post('/user/get-drop-down-data', 'API\UserController@getDropDownData');

    Route::apiResource('roles', 'API\RoleController');
    Route::apiResource('user', 'API\UserController');
    Route::get('/users/getAllStaff', 'API\UserController@getAllStaff');
    Route::get('/user/restore/{id}','API\UserController@restore');
    Route::post('/roles/gerUserPermission/','API\RoleController@gerUserPermission');

    Route::apiResource('unit', 'API\UnitController');
    Route::get('/unit/restore/{id}','API\UnitController@restore');
    Route::post('/get-units','API\UnitController@getUnits');


    Route::apiResource('department', 'API\DepartmentController');
    Route::get('/department/restore/{id}','API\DepartmentController@restore');

    Route::apiResource('process', 'API\ProcessController');
    Route::get('/process/restore/{id}','API\ProcessController@restore');

    Route::apiResource('employee', 'API\EmployeeController');
    Route::get('/employee/restore/{id}','API\EmployeeController@restore');
    Route::delete('/employee/delete-employee-process/{employeeProcess}', 'API\EmployeeController@deleteEmployeeProcess');

    Route::apiResource('product-category', 'API\ProductCategoryController');
    Route::get('/product-category/restore/{id}','API\ProductCategoryController@restore');
    Route::post('/product-category/view', 'API\ProductCategoryController@viewProductCategory');

    Route::apiResource('product', 'API\ProductController');
    Route::get('/product/restore/{id}','API\ProductController@restore');

    Route::delete('/product/delete-product-style/{style}', 'API\ProductController@deleteProductStyle');
    Route::delete('/product/delete-product-style-image/{style}', 'API\ProductController@deleteProductStyleImage');
    Route::delete('/product/delete-product-style-department-loss/{styleDepartmentLossApproval}', 'API\ProductController@deleteProductStyleDepartmentLoss');

    Route::apiResource('uom', 'API\UomController');
    Route::get('/uom/restore/{id}','API\UomController@restore');

    Route::apiResource('bag', 'API\BagController');
    Route::get('/bag/restore/{id}','API\BagController@restore');
    Route::get('/bag/generate-otp/{id}','API\BagController@generateOtp');
    Route::post('/bag/cancel','API\BagController@cancel');
    Route::delete('/bag/delete-bag-style/{style}', 'API\BagController@deleteBagStyle');

    Route::post('/style/search', 'API\ProductController@search');
    Route::post('/bag/search', 'API\BagController@search');
    Route::post('/transaction/bagSearch', 'API\TransactionController@searchBag');
    Route::apiResource('transaction', 'API\TransactionController');


    Route::apiResource('casting', 'API\CastingController');


    Route::post('/transaction/change-transaction-item', 'API\TransactionController@changeTransactionItemStatus');

    Route::apiResource('other-accessories', 'API\OtherAccessoriesController');
    Route::get('/other-accessories/restore/{id}','API\OtherAccessoriesController@restore');

    Route::post('/transaction-history', 'API\TransactionHistoryController@getTransactionHistory');
    Route::post('/transaction-bag-history', 'API\TransactionHistoryController@getTransactionBagHistory');
    Route::post('/transaction-history/get-drop-down-data', 'API\TransactionHistoryController@getDropDownData');

    Route::post('/tally-report', 'API\TransactionHistoryController@getTallyReport');

    Route::post('/configuration/get-configuration-data', 'API\ConfigurationController@getConfigurationData');
    Route::post('/configuration/save', 'API\ConfigurationController@store');
    Route::post('/bag/dropDown/','API\BagController@dropDown');

    Route::apiResource('loss-approval', 'API\LossApprovalController');
    Route::post('/loss-approval/status-update','API\LossApprovalController@statusUpdate');
    Route::post('/loss-approval/drop-down','API\LossApprovalController@dropDown');

    Route::apiResource('opening-report', 'API\OpeningReportController');
    Route::apiResource('fctransaction-report', 'API\FcTransactionReportController');
    Route::apiResource('merge-report', 'API\MergeReportController');
    Route::apiResource('split-report', 'API\SplitReportController');
    Route::apiResource('scrap-report', 'API\ScrapReportController');
    Route::apiResource('channam-report', 'API\ChannamReportController');
    Route::apiResource('loss-report', 'API\LossReportController');
    Route::apiResource('pending-report', 'API\PendingReportController');
    Route::apiResource('emploss-report', 'API\EmplossReportController');
    Route::apiResource('castinginword-report', 'API\CastinginwordReportController');
    Route::apiResource('accessoriesinword-report', 'API\AccessoriesinwordReportController');
});



