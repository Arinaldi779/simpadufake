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

    // // Menampilkan Data di Halaman Tahun Akademik
    // public function indexThnAk()
    // {
    //     // $data = TahunAkademik::paginate(10);
    //     $data = TahunAkademik::all();

    //     return view('tahunakademik', compact('data'));
    // }

    public function indexThnAk(Request $request)
    {
        // Jika kamu ingin menggunakan filter, bisa ditambahkan di sini
        $query = TahunAkademik::query();

        if ($request->filled('tahun')) {
            $query->where('nama_thn_ak', $request->tahun);
        }

        if ($request->filled('status')) {
            $query->where('aktif', $request->status);
        }

        // Untuk pagination
        $data = $query->paginate(10);
        // $data = $query->get();

        if ($data->isEmpty()) {
            // Jika tidak ada data, tampilkan pesan error
            $message = 'Data tidak ditemukan';
            return view('tahunakademik', compact('data', 'message'));
        }

        // dd($data);

        return view('tahunakademik', compact('data'));
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
}
