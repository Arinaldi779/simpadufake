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
use App\Http\Controllers\API\ApiNilaiController;


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
    Route::get('/tahun-akademik/{id}', [ApiAdminAkademikController::class, 'showThnAk']); // Menampilkan data tahun akademik berdasarkan ID
    Route::post('/tahun-akademik', [ApiAdminAkademikController::class, 'createThnAk']); // Menambahkan data tahun akademik
    Route::put('/tahun-akademik/{id}', [ApiAdminAkademikController::class, 'thnAkUpdate']); // Update data tahun akademik
    Route::get('/siap-kurikulum', [ApiAdminProdiController::class, 'indexSiapKurikulum']); // Menampilkan Semua data siap kurikulum
    Route::get('/siap-kurikulum/{id}', [ApiAdminProdiController::class, 'showSiapKurikulum']); // Menampilkan data siap Mata Kuliah
    Route::get('/siapmk', [ApiAdminProdiController::class, 'indexMataKuliah']); // Menampilkan Semua data siap Mata Kuliah
    Route::get('/siapmk/{id}', [ApiAdminProdiController::class, 'showMataKuliah']); // Menampilkan data siap Mata Kuliah berdasarkan ID
    Route::get('/siapkelas', [ApiAdminAkademikController::class, 'indexSiapKelas']); // Menampilkan data siap kelas
    Route::post('/siapkelas', [ApiAdminAkademikController::class, 'tambahKelas']); // Menambahkan data siap kelas
    Route::get('/siapkelas/{id}', [ApiAdminAkademikController::class, 'showSiapKelas']);
    Route::get('/prodi', [ApiAdminProdiController::class, 'indexProdi']); // Menampilkan semua data Prodi
});

// Untuk dosen (Kelompok 2)
Route::prefix('presensi')->group(function () {
    Route::get('/matkul-dosen/{id_pegawai}', [PresensiController::class, 'matkulByDosen']);
    Route::post('/buka', [PresensiController::class, 'bukaPresensi']);
});


// Untuk mahasiswa (Kelompok 3)
Route::get('/mahasiswa/{nim}/presensi-aktif', [PresensiMhsController::class, 'presensiAktif']);
Route::post('/presensi-mahasiswa/hadir', [PresensiMhsController::class, 'isiPresensi']);

Route::get('/nilai-mahasiswa/{nim}', [ApiNilaiController::class, 'nilaiByNim']);
Route::get('/jadwal-mahasiswa/{id_kelas_master}', [ApiNilaiController::class, 'jadwalMahasiswa']);
Route::get('/hitung-nilai-akhir/{id_kelas_master}', [ApiNilaiController::class, 'hitungNilaiAkhir']);

Route::get('/thnak-prodi', [ApiAdminProdiController::class, 'prodiThn']);
