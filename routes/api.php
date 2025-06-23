<?php

use App\Http\Controllers\API\ApiAdminAkademikController;
use App\Http\Controllers\API\ApiAdminProdiController;
use App\Http\Controllers\API\ApiAuthController;
use App\Http\Controllers\API\ApiNilaiController;
use App\Http\Controllers\API\PresensiController;
use App\Http\Controllers\API\PresensiMhsController;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\RateLimiter;
use Illuminate\Cache\RateLimiting\Limit;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Semua route di sini otomatis mendapat prefix /api
|
*/

// Rate Limiting
RateLimiter::for('api', function ($request) {
    return Limit::perMinute(60)->by($request->user()?->id ?: $request->ip());
});

// Auth Routes
Route::middleware('throttle:60,1')->group(function () {
    Route::post('/login', [ApiAuthController::class, 'login']);
});

// Admin Akademik Routes
Route::middleware(['api', 'auth:sanctum', 'throttle:60,1'])->group(function () {
    // Tahun Akademik
    Route::get('/tahun-akademik', [ApiAdminAkademikController::class, 'indexThnAk']);
    Route::get('/tahun-akademik/{id}', [ApiAdminAkademikController::class, 'showThnAk']);
    Route::post('/tahun-akademik', [ApiAdminAkademikController::class, 'createThnAk']);
    Route::put('/tahun-akademik/{id}', [ApiAdminAkademikController::class, 'thnAkUpdate']);

    // Siap Kurikulum
    Route::get('/siap-kurikulum', [ApiAdminProdiController::class, 'indexSiapKurikulum']);
    Route::get('/siap-kurikulum/{id}', [ApiAdminProdiController::class, 'showSiapKurikulum']);
    Route::post('/siap-kurikulum', [ApiAdminProdiController::class, 'createKurikulum']);

    // Siap Mata Kuliah
    Route::get('/siapmk', [ApiAdminProdiController::class, 'indexMataKuliah']);
    Route::get('/siapmk/{id}', [ApiAdminProdiController::class, 'showMataKuliah']);
    Route::post('/siapmk', [ApiAdminProdiController::class, 'mkCreate']);

    // Siap Kelas
    Route::get('/siapkelas', [ApiAdminAkademikController::class, 'indexSiapKelas']);
    Route::post('/siapkelas', [ApiAdminAkademikController::class, 'apiTambahKelas']);
    Route::get('/siapkelas/{id}', [ApiAdminAkademikController::class, 'showSiapKelas']);

    // Prodi
    Route::get('/prodi', [ApiAdminProdiController::class, 'indexProdi']);

    // Dosen Ajar
    Route::get('/dosen-ajar', [ApiAdminProdiController::class, 'indexDosenAjar']);
    Route::post('/dosen-ajar', [ApiAdminProdiController::class, 'createDosenAjar']);

    // Kelas Master
    Route::get('/kls-master', [ApiAdminAkademikController::class, 'indexKlsMaster']);
    Route::get('/kls-master/{id}', [ApiAdminAkademikController::class, 'showKlsMaster']);
    Route::post('/kls-master', [ApiAdminAkademikController::class, 'apiMhsMasterCreate']);
});

// Presensi Routes (Dosen)
Route::middleware('throttle:60,1')->group(function () {
    Route::get('/presensi/matkul-dosen/{id_pegawai}', [PresensiController::class, 'matkulByDosen']);
    Route::post('/presensi/buka', [PresensiController::class, 'bukaPresensi']);
});

// Mahasiswa Routes
Route::middleware('throttle:60,1')->group(function () {
    // Presensi Mahasiswa
    Route::get('/mahasiswa/{nim}/presensi-aktif', [PresensiMhsController::class, 'presensiAktif']);
    Route::get('/mahasiswa/{nim}/nilai-mahasiswa', [ApiNilaiController::class, 'nilaiByNim']);
    Route::post('/presensi-mahasiswa/hadir', [PresensiMhsController::class, 'isiPresensi']);

    // Jadwal Mahasiswa
    Route::get('/jadwal-mahasiswa/{id_kelas_master}', [ApiNilaiController::class, 'jadwalMahasiswa']);

    // Nilai Akhir
    Route::post('/hitung-nilai-akhir', [ApiNilaiController::class, 'inputNilaiDosen']);

    // Tahun Akademik Prodi
    Route::get('/thnak-prodi', [ApiAdminProdiController::class, 'prodiThn']);
});
