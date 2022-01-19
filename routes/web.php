<?php

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It's a breeze. Simply tell Laravel the URIs it should respond to
| and give it the controller to call when that URI is requested.
|
*/
Route::post('/custom-login', 'Auth\LoginController@customLogin');
Route::group([
    'middleware' => 'auth:web'
], function () {
    Route::post('/upload', 'UploadController@upload');
    Route::delete('/upload', 'UploadController@delete');
    Route::get('/', 'HomeController@show');
    Route::get('/welcome', 'WelcomeController@show');

    Route::get('/home', 'HomeController@show');
    Route::get('/dashboard', 'DashboardController@index')->name('dashboard');
    

    Route::get('/roles', 'RoleController@index')->name('roles');
    Route::get('/user', 'UserController@index')->name('user');

    Route::get('/unit', 'API\UnitController@getIndex');
    Route::get('/department', 'API\DepartmentController@getIndex');
    Route::get('/process', 'API\ProcessController@getIndex');
    Route::get('/employee', 'API\EmployeeController@getIndex');
    Route::get('/product-category', 'API\ProductCategoryController@getIndex');
    Route::get('/product', 'API\ProductController@getIndex');
    Route::post('/product/styleUpload', 'API\ProductController@styleUpload');
    Route::get('/transaction', 'API\TransactionController@getIndex');
    Route::get('/transactions', 'API\TransactionController@getTransaction');
    Route::get('/transactions-history', 'API\TransactionHistoryController@getIndex');
    Route::get('/uom', 'API\UomController@getIndex');
    Route::get('/bag', 'API\BagController@getIndex');    
    Route::get('/profile', 'UserController@getProfile');
    Route::get('/other-accessories', 'API\OtherAccessoriesController@getIndex');
    Route::get('/resetPassword','API\UserController@getResetView');
    Route::post('/reset/passwords','API\UserController@customizedResetPassword');

    Route::get('/configuration', 'API\ConfigurationController@getIndex');
    Route::get('/loss-approval', 'API\LossApprovalController@getIndex');
    Route::get('/tally-report', 'API\TransactionHistoryController@viewTallyReport');

    Route::get('/casting', 'API\CastingController@getIndex');
});


