<?php

use App\Http\Controllers\API\ApiAdminAkademikController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\API\ApiAuthController;
use App\Http\Controllers\API\PresensiController;
use App\Http\Controllers\API\PresensiMhsController;
use App\Http\Controllers\API\ApiTahunAkademikController;
use Illuminate\Foundation\Configuration\RateLimiting;
use Illuminate\Cache\RateLimiting\Limit;
use Illuminate\Support\Facades\RateLimiter;
use App\Http\Controllers\API\ApiAdminProdiController;


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

Route::middleware('api', 'auth:sanctum')->group(function () {
    Route::post('/createthnak', [ApiAdminAkademikController::class, 'createThnAk']);

    Route::get('/tahun-akademik', [ApiAdminAkademikController::class, 'indexThnAk']);

    // Menampilkan data berdasarkan ID
    Route::get('/tahun-akademik/{id}', [ApiAdminAkademikController::class, 'showThnAk']);
    Route::post('/tahun-akademik', [ApiAdminAkademikController::class, 'createThnAk']);
    Route::put('/tahun-akademik/{id}', [ApiAdminAkademikController::class, 'thnAkUpdate']);
    // Route ambil data kurikulum
    Route::get('/siap-kurikulum', [ApiAdminProdiController::class, 'indexSiapKurikulum']);
    Route::get('/siap-kurikulum/{id}', [ApiAdminProdiController::class, 'showSiapKurikulum']); // Menampilkan data siap Mata Kuliah
    Route::get('/siapmk', [ApiAdminProdiController::class, 'indexMataKuliah']);
    Route::get('/siapmk/{id}', [ApiAdminProdiController::class, 'showMataKuliah']);
    Route::get('/siapkelas', [ApiAdminAkademikController::class, 'indexSiapKelas']);
    Route::get('/siapkelas/{id}', [ApiAdminAkademikController::class, 'showSiapKelas']);
});

// Untuk dosen (Kelompok 2)
Route::prefix('presensi')->group(function () {
    Route::get('/matkul-dosen/{id_pegawai}', [PresensiController::class, 'matkulByDosen']);
    Route::post('/buka', [PresensiController::class, 'bukaPresensi']);
});


// Untuk mahasiswa (Kelompok 3)
Route::get('/mahasiswa/{nim}/presensi-aktif', [PresensiMhsController::class, 'presensiAktif']);
Route::post('/presensi-mahasiswa/hadir', [PresensiMhsController::class, 'isiPresensi']);
