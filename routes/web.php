<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('login');
});

Route::post('/akademik', function () {
    // proses login bisa kamu tambahkan di sini
    return view('akademik');
})->name('akademik');

Route::get('/tahunakademik', function () {
    return view('tahunakademik');
});


Route::get('/akademik', function () {
    return view('akademik');
});

Route::get('/kelas', function () {
    return view('kelas');
});

Route::get('/mahasiswa', function () {
    return view('mahasiswa');
});

