<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\HomeController;
use App\Http\Controllers\AuthController;


Route::get('/login', [HomeController::class, 'login'])->name('login');
// Redirect user ke halaman login jika belum login
Route::middleware(['auth'])->group(function () {
    Route::get('/akademik', [HomeController::class, 'akademik'])->name('akademik');
    Route::get('/tahunakademik', [HomeController::class, 'indexThnAk'])->name('tahunakademik');
    // Route::get('/tahun-akademik', [HomeController::class, 'filterIndexThnAk'])->name('filterThnAk');
    Route::get('/kelas', [HomeController::class, 'kelas'])->name('kelas');
    Route::get('/mahasiswa', [HomeController::class, 'mahasiswa'])->name('mahasiswa');
    Route::get('/prodi', [HomeController::class, 'prodi'])->name('prodi');
});





// todoLogic untuk login
Route::post('/login', [AuthController::class, 'login']);
// Route Logout
Route::post('/logout', [AuthController::class, 'logout'])->name('logout');
