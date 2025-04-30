<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\HomeController;
use App\Http\Controllers\AuthController;


Route::get('/', [HomeController::class, 'login'])->name('login');
Route::get('/akademik', [HomeController::class, 'akademik'])->name('akademik');
Route::get('/tahunakademik', [HomeController::class, 'indexThnAk'])->name('tahunakademik');
Route::get('/kelas', [HomeController::class, 'kelas'])->name('kelas');
Route::get('/mahasiswa', [HomeController::class, 'mahasiswa'])->name('mahasiswa');


// !Logic untuk login
Route::post('/authlogin', [AuthController::class, 'login'])->name('authlogin');
// Route Logout
Route::post('/logout', [AuthController::class, 'logout'])->name('logout');
