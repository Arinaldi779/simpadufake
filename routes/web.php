<?php

use App\Http\Controllers\AdminAkademikController;
use App\Http\Controllers\AdminProdiComtroller;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\HomeController;
use App\Http\Controllers\AuthController;



Route::get('/login', [HomeController::class, 'login'])->name('login');
// Redirect user ke halaman login jika belum login
Route::middleware(['auth'])->group(function () {
    Route::get('/', [HomeController::class, 'akademik'])->name('akademik');
    Route::get('/tahunakademik', [HomeController::class, 'indexThnAk'])->name('tahunakademik');
    // Route::get('/tahun-akademik', [HomeController::class, 'filterIndexThnAk'])->name('filterThnAk');
    Route::get('/kelas', [HomeController::class, 'kelas'])->name('kelas');
    Route::get('/mahasiswa', [HomeController::class, 'mahasiswa'])->name('mahasiswa');
    Route::get('/prodi', [HomeController::class, 'prodi'])->name('prodi');
    Route::get('/kurikulum', [HomeController::class, 'kurikulum'])->name('kurikulum');
    Route::get('/matakuliah', [HomeController::class, 'matakuliah'])->name('matakuliah');
    Route::get('/dosenajar', [HomeController::class, 'dosenajar'])->name('dosenajar');
    Route::get('/presensi', [HomeController::class, 'presensi'])->name('presensi');
    Route::get('/nilai', [HomeController::class, 'nilai'])->name('nilai');
    Route::get('/khskrs', [HomeController::class, 'khskrs'])->name('khskrs');
});






// todoLogic untuk login
Route::post('/login', [AuthController::class, 'login']);
// Route Logout
Route::post('/logout', [AuthController::class, 'logout'])->name('logout');
// Route untuk update tahun akademik
Route::put('/users/{id}', [AdminAkademikController::class, 'thnAkUpdate'])->name('thnAk.update');
