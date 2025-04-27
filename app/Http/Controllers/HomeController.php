<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class HomeController extends Controller
{
    // Halaman Login
    public function login()
    {
        return view('login');
    }

    // Halaman Akademik
    public function akademik()
    {
        return view('akademik');
    }

    // Halaman Tahun Akademik
    public function tahunakademik()
    {
        return view('tahunakademik');
    }

    // Halaman Kelas
    public function kelas()
    {
        return view('kelas');
    }

    // Halaman Mahasiswa
    public function mahasiswa()
    {
        return view('mahasiswa');
    }
}
