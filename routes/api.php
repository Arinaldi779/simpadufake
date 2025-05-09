<?php

use App\Http\Controllers\API\ApiAdminAkademikController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\API\ApiAuthController;
use App\Http\Controllers\API\ApiTahunAkademikController;
use Illuminate\Foundation\Configuration\RateLimiting;
use Illuminate\Cache\RateLimiting\Limit;
use Illuminate\Support\Facades\RateLimiter;


/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Ini adalah file routes untuk API.
| Semua route di sini otomatis mendapat prefix /api
|
*/


RateLimiter::for('api', function ($request) {
    return Limit::perMinute(60)->by($request->user()?->id ?: $request->ip());
});

Route::post('/login', [ApiAuthController::class, 'login']);

Route::middleware('api')->group(function () {
    Route::post('/createthnak', [ApiAdminAkademikController::class, 'login']);

    Route::get('/tahun-akademik', [ApiAdminAkademikController::class, 'indexThnAk']);

    // Menampilkan data berdasarkan ID
    Route::get('/tahun-akademik/{id}', [ApiAdminAkademikController::class, 'showThnAk']);
});
