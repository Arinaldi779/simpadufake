<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\API\ApiController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Ini adalah file routes untuk API.
| Semua route di sini otomatis mendapat prefix /api
|
*/

Route::post('/login', [ApiController::class, 'login']);
