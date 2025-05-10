<?php

namespace App\Http\Controllers;

use App\Models\TahunAkademik;
use App\Models\MataKuliah;

use Illuminate\Http\Request;

class HomeController extends Controller
{
    // Halaman Login
    public function login()
    {
        return view('login');
    }

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

    // Halaman Edit Tahun Akademik
    public function editThnAk($id)
    {
        $data = TahunAkademik::findOrFail($id);

        return view('edittahunakademik', compact('data'));
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
    public function matakuliah(Request $request)
    {

        // Jika kamu ingin menggunakan filter, bisa ditambahkan di sini
        $query = MataKuliah::query();

        if ($request->filled('mk')) {
            $query->where('nama_mk', $request->mk);
        }

        if ($request->filled('kodeMk')) {
            $query->where('kode_mk', $request->kodeMk);
        }

        // Untuk pagination
        $data = $query->paginate(10);
        // $data = $query->get();

        if ($data->isEmpty()) {
            // Jika tidak ada data, tampilkan pesan error
            $message = 'Data tidak ditemukan';
            return view('matakuliah', compact('data', 'message'));
        }

        // dd($data);

        return view('matakuliah', compact('data'));
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
