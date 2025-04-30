<?php

namespace App\Http\Controllers;

use App\Models\TahunAkademik;

use Illuminate\Http\Request;

class HomeController extends Controller
{
    // Halaman Login
    public function login()
    {
        return view('login');
    }

    // Menampilkan Data di Halaman Tahun Akademik
    public function indexThnAk()
    {
        $data = TahunAkademik::all();

        return view('tahunakademik', [
            'data' => $data
        ]);
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

    public function akademik()
{
    return view('akademik'); // Sesuaikan dengan nama view kamu
}

}
