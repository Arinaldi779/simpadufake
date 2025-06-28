<?php

use App\Http\Controllers\AdminAkademikController;
use App\Http\Controllers\AdminProdiController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\HomeController;
use App\Http\Controllers\AuthController;
use Illuminate\Support\Facades\Auth;




// todo Route Post Login
Route::middleware('throttle:60,1')->group(function () {
    Route::get('/login', [HomeController::class, 'login'])->name('login');
    Route::post('/login', [AuthController::class, 'login'])->name('login.post'); // Route untuk login
});

// Redirect user ke halaman login jika belum login
Route::middleware(['web', 'auth.jwt', 'roleAccess:Admin Prodi,Super Admin', 'throttle:60,1'])->prefix('prodi')->group(function () {
    Route::get('/', [HomeController::class, 'prodi'])->name('prodi');
    Route::get('/kurikulum', [HomeController::class, 'kurikulum'])->name('kurikulum');
    Route::get('/matakuliah', [HomeController::class, 'matakuliah'])->name('matakuliah');
    Route::get('/dosenajar', [HomeController::class, 'dosenajar'])->name('dosenajar'); //Memampilkan dosen ngajar matkul apa saja
    Route::get('/presensi', [HomeController::class, 'presensi'])->name('presensi');
    Route::get('/khskrs', [HomeController::class, 'khskrs'])->name('khskrs');
    Route::get('/editmk', [HomeController::class, 'editmk'])->name('editmk');
    Route::get('/editdosen', [HomeController::class, 'editdosen'])->name('editdosen');
    Route::get('/editpresensi', [HomeController::class, 'editpresensi'])->name('editpresensi');
    Route::get('/editpresensidosen', [HomeController::class, 'editpresensidosen'])->name('editpresensidosen');
    Route::get('/editpresensimahasiswa', [HomeController::class, 'editpresensimahasiswa'])->name('editpresensimahasiswa');
    Route::get('/editnilai', [HomeController::class, 'editnilai'])->name('editnilai');
    Route::get('/editkrs', [HomeController::class, 'editkrs'])->name('editkrs');
    Route::get('/editkhs', [HomeController::class, 'editkhs'])->name('editkhs');
    Route::post('/kurikulum', [AdminProdiController::class, 'kurikulumCreate'])->name('kurikulum.create'); // Route untuk tambah kurikulum
    Route::post('/matakuliah', [AdminProdiController::class, 'mkCreate'])->name('matakuliah.create'); // Route untuk tambah mata kuliah
    Route::post('/kurikulum', [AdminProdiController::class, 'kurikulumCreate'])->name('kurikulum.create');
    Route::get('nilai', [HomeController::class, 'nilai'])->name('nilai');
    Route::post('/dosenajar', [AdminProdiController::class, 'dosenAjarCreate'])->name('dosenajar.create'); // Route untuk tambah dosen ajar
});



Route::middleware(['web', 'auth.jwt', 'roleAccess:Admin Akademik,Super Admin', 'throttle:60,1'])->prefix('akademik')->group(function () {
    Route::get('/', [HomeController::class, 'akademik'])->name('akademik'); // Route untuk halaman akademik
    Route::get('/tahunakademik', [HomeController::class, 'indexThnAk'])->name('tahunakademik'); // Route untuk halaman tahun akademik
    Route::get('/mahasiswa', [HomeController::class, 'mahasiswa'])->name('mahasiswa'); // Route untuk halaman mahasiswa
    Route::get('/kelas', [HomeController::class, 'kelas'])->name('kelas'); // Route untuk halaman kelas
    Route::get('/editta/{tahunAkademik}/edit', [HomeController::class, 'editta'])->name('editta'); //Route untuk halaman edit tahun akademik
    Route::get('/editkls', [HomeController::class, 'editkls'])->name('editkls'); // Route untuk halaman edit kelas
    Route::post('/tambahkelas', [AdminAkademikController::class, 'tambahKelas'])->name('tambahKelas'); // Route untuk tambah kelas
    Route::get('/editkur', [HomeController::class, 'editkur'])->name('editkur'); // Route untuk halaman edit kurikulum
    Route::get('/editmhs', [HomeController::class, 'editmhs'])->name('editmhs'); // Route untuk halaman edit mahasiswa
    Route::put('/editta/{id}', [AdminAkademikController::class, 'thnAkUpdate'])->name('thnAk.update'); // Route untuk edit Tahun Akademik
    Route::post('/tahunakademik', [AdminAkademikController::class, 'tahuAkCreate'])->name('thnAk.create'); // Route untuk tambah Tahun Akademik
    Route::post('/kelas', [AdminAkademikController::class, 'mhsMasterCreate'])->name('mhsMaster.create'); // Route untuk tambah mahasiswa ke siap_kelas_master
    Route::patch('/tahun-akademik/{id}/toggle-status', [HomeController::class, 'toggleStatus'])->name('tahun-akademik.toggleStatus');
    Route::patch('/akademik/kelas-master/mhs-status/{id}', [HomeController::class, 'mhsStatus'])->name('kelas-master.mhsStatus');
});

Route::middleware(['web', 'auth.jwt', 'throttle:60,1'])->group(function () {
    Route::post('/logout', [AuthController::class, 'logout'])->name('logout'); // Route untuk logout
});





Route::fallback(function () {
    if (auth::check()) {
        return redirect()->back()->with('warning', 'Halaman tidak ditemukan.');
    }

    return redirect()->route('login')->with('warning', 'Silakan login terlebih dahulu.');
});

Route::prefix('superadmin')->group(function () {
    Route::get('/', [HomeController::class, 'usersView'])->name('users.view'); //Route Daftar View
    Route::post('/userss', [AuthController::class, 'createUser'])->name('user.store'); //Route Daftar Logic

});
