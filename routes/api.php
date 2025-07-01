<?php

use App\Http\Controllers\API\ApiAdminAkademikController;
use App\Http\Controllers\API\ApiAdminProdiController;
use App\Http\Controllers\API\ApiAuthController;
use App\Http\Controllers\API\ApiNilaiController;
use App\Http\Controllers\API\PresensiController;
use App\Http\Controllers\API\PresensiMhsController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Semua route di sini otomatis mendapat prefix /api
|
*/


// Auth Routes
Route::middleware('throttle:60,1')->group(function () {
    Route::post('/login', [ApiAuthController::class, 'login']);
    Route::post('/create-user', [ApiAuthController::class, 'createUser']);
    Route::put('/update-user', [ApiAuthController::class, 'updateUser']);
});

// Admin Akademik Routes
Route::middleware(['throttle:api', 'auth:api'])->group(function () {
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
    Route::get('/dosen-ajar/{id}', [ApiAdminProdiController::class, 'showDosenAjar']);
    Route::get('/kls-mk', [ApiAdminProdiController::class, 'getKurikulumKelas']);

    // Kelas Master
    Route::get('/kls-master', [ApiAdminAkademikController::class, 'indexKlsMaster']);
    Route::get('/kls-master/{id}', [ApiAdminAkademikController::class, 'showKlsMaster']);
    Route::post('/kls-master', [ApiAdminAkademikController::class, 'apiMhsMasterCreate']);
});

// Presensi Routes (Dosen)
Route::middleware('throttle:60,1')->prefix('presensi')->group(function () {
    Route::get('/matkul-dosen/{id_pegawai}', [PresensiController::class, 'matkulByDosen']);
    Route::post('/buka', [PresensiController::class, 'bukaPresensi']);
    Route::get('/cek-presensi/{id}', [PresensiController::class, 'indexPresensiDosen']);
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

// Dosen Ajar
Route::get('/dosen-ajarr', [ApiAdminProdiController::class, 'indexDosenAjar']);
Route::post('/dosen-ajarr', [ApiAdminProdiController::class, 'createDosenAjar']);
Route::get('/dosen-ajarr/{id}', [ApiAdminProdiController::class, 'showDosenAjar']);
