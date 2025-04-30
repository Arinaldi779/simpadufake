<?php

use App\Http\Controllers\API\ApiAdminAkademikController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\API\ApiAuthController;
use App\Http\Controllers\API\ApiTahunAkademikController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Ini adalah file routes untuk API.
| Semua route di sini otomatis mendapat prefix /api
|
*/


Route::middleware('api')->group(function () {
    Route::post('/login', [ApiAuthController::class, 'login']);
    Route::post('/createthnak', [ApiAdminAkademikController::class, 'login']);

    Route::get('/tahun-akademik', [ApiAdminAkademikController::class, 'indexThnAk']);

    // Menampilkan data berdasarkan ID
    Route::get('/tahun-akademik/{id}', [ApiAdminAkademikController::class, 'showThnAk']);
});
