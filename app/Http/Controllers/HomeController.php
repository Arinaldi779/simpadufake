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
    public function prodi()
    {
        return view('prodi'); // Sesuaikan dengan nama view kamu
    }
    public function kurikulum()
    {
        return view('kurikulum'); // Sesuaikan dengan nama view kamu
    }
    public function matakuliah()
    {
        return view('matakuliah'); // Sesuaikan dengan nama view kamu
    }
    public function dosenajar()
    {
        return view('dosenajar'); // Sesuaikan dengan nama view kamu
    }
    public function presensi()
    {
        return view('presensi'); // Sesuaikan dengan nama view kamu
    }
    public function nilai()
    {
        return view('nilai'); // Sesuaikan dengan nama view kamu
    }
    public function khskrs()
    {
        return view('khskrs'); // Sesuaikan dengan nama view kamu
    }

}
