<?php

use \Illuminate\Http\Request;

use Illuminate\Support\Facades\Auth;


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
    'middleware' => 'auth:mobile-api'
], function () {
    Route::post('/user','InsuranceController@create');
});


