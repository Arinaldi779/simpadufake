<?php

use App\Http\Controllers\AdminAkademikController;
use App\Http\Controllers\AdminProdiController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\HomeController;
use App\Http\Controllers\AuthController;



Route::get('/login', [HomeController::class, 'login'])->name('login');
// Redirect user ke halaman login jika belum login
Route::middleware(['auth'])->group(function () {
    Route::get('/', [HomeController::class, 'akademik'])->name('akademik');
    Route::get('/tahunakademik', [HomeController::class, 'indexThnAk'])->name('tahunakademik');
    Route::get('/kelas', [HomeController::class, 'kelas'])->name('kelas');
    Route::get('/mahasiswa', [HomeController::class, 'mahasiswa'])->name('mahasiswa');
    Route::get('/prodi', [HomeController::class, 'prodi'])->name('prodi');
    Route::get('/kurikulum', [HomeController::class, 'kurikulum'])->name('kurikulum');
    Route::get('/matakuliah', [HomeController::class, 'matakuliah'])->name('matakuliah');
    Route::get('/dosenajar', [HomeController::class, 'dosenajar'])->name('dosenajar');
    Route::get('/presensi', [HomeController::class, 'presensi'])->name('presensi');
    Route::get('/nilai', [HomeController::class, 'nilai'])->name('nilai');
    Route::get('/khskrs', [HomeController::class, 'khskrs'])->name('khskrs');
    Route::get('/editta/{tahunAkademik}/edit', [HomeController::class, 'editta'])->name('editta');
    Route::get('/editkls', [HomeController::class, 'editkls'])->name('editkls');
    Route::get('/editmhs', [HomeController::class, 'editmhs'])->name('editmhs');
    Route::get('/editkur', [HomeController::class, 'editkur'])->name('editkur');
    Route::get('/editmk', [HomeController::class, 'editmk'])->name('editmk');
    Route::get('/editdosen', [HomeController::class, 'editdosen'])->name('editdosen');
    Route::get('/editpresensi', [HomeController::class, 'editpresensi'])->name('editpresensi');
    Route::get('/editpresensidosen', [HomeController::class, 'editpresensidosen'])->name('editpresensidosen');
    Route::get('/editpresensimahasiswa', [HomeController::class, 'editpresensimahasiswa'])->name('editpresensimahasiswa');
    Route::get('/editnilai', [HomeController::class, 'editnilai'])->name('editnilai');
    Route::get('/editkrs', [HomeController::class, 'editkrs'])->name('editkrs');
    Route::get('/editkhs', [HomeController::class, 'editkhs'])->name('editkhs');
    
    Route::post('/kurikulum', [AdminProdiController::class, 'kurikulumCreate'])->name('kurikulum.create');
});






// todoLogic untuk login
Route::post('/login', [AuthController::class, 'login']);
// Route Logout
Route::post('/logout', [AuthController::class, 'logout'])->name('logout');
// Route untuk update tahun akademik
Route::put('/editta/{id}', [AdminAkademikController::class, 'thnAkUpdate'])->name('thnAk.update');
// ROute Untuk tambah tahun akademik
Route::post('/tahunakademik', [AdminAkademikController::class, 'tahuAkCreate'])->name('thnAk.create');
// Route untuk tambah kurikulum
Route::post('/kurikulum', [AdminProdiController::class, 'kurikulumCreate'])->name('kurikulum.create');
