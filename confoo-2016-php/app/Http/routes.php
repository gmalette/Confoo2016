<?php

/*
|--------------------------------------------------------------------------
| Routes File
|--------------------------------------------------------------------------
|
| Here is where you will register all of the routes in an application.
| It's a breeze. Simply tell Laravel the URIs it should respond to
| and give it the controller to call when that URI is requested.
|
*/
Route::macro('after', function ($callback) {
    $this->events->listen('router.filter:after:newrelic-patch', $callback);
});

Route::group(['middleware' => ['web']], function () {
    Route::get('/', 'PostsController@getIndex');
});

