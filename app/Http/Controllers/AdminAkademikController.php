<?php

namespace App\Http\Controllers;

use App\Models\TahunAkademik;
use App\Models\SiapKelasMaster;
use App\Models\SiapKelas;

use Illuminate\Http\Request;

class AdminAkademikController extends Controller
{
    //Tambah data tahun akademik
    public function tahuAkCreate(Request $request)
    {
        $request->validate([
            'id_thn_ak' => 'required|string|max:255|unique:siap_thn_ak,id_thn_ak',
            'nama_thn_ak' => 'required|string|max:255',
            'smt' => 'nullable|string',
            'tgl_awal_kuliah' => 'required|date',
            'tgl_akhir_kuliah' => 'required|date|after_or_equal:tgl_awal_kuliah',
            'status' => 'required|in:Y,T',
        ]);

        TahunAkademik::create($request->all());
        // dd($request->all());

        return redirect()->route('tahunakademik')->with('success', 'Tahun Akademik berhasil ditambahkan.');
    }

    // logic untuk menambah daftar kelas
    public function tambahKelas(Request $request)
    {
        $request->validate([
            'nama_kelas' => 'required|string|max:255',
            'id_thn_ak' => 'required|string|max:255',
            'id_prodi' => 'required|integer',
            'alias' => 'nullable|string|max:255',
        ]);

        $kelas =  SiapKelas::create($request->all());

        if (!$kelas) {
            return redirect()->back()->with('error', 'Gagal menambahkan kelas.');
        }

        return redirect()->route('kelas')->with('success', 'Kelas berhasil ditambahkan.');
    }

    // Logic untuk update tahun akademik
    public function thnAkUpdate(Request $request, $id)
    {
        // Validasi input
        $request->validate([
            'status' => 'required|in:Y,T',
        ]);

        // Ambil data berdasarkan ID
        $tahunAkademik = TahunAkademik::findOrFail($id);

        // Update data
        $tahunAkademik->update([
            'status' => $request->aktif,
        ]);

        // dd($tahunAkademik);

        // Redirect ke halaman index dengan pesan sukses
        return redirect()->route('tahunakademik')->with('success', 'Tahun Akademik berhasil diperbarui.');
    }

    // Logic memasukan data mahasiswa ke siap_kelas_master
    public function mhsMasterCreate(Request $request)
    {
        // Validate
        $request->validate([
            'nim' => 'required|string|max:255',
            'id_kelas' => 'required|string|max:255',
            'no_absen' => 'nullable|integer',

        ]);

        // dd($request->all());
        // Simpan data ke siap_kelas_master
        $siapKelasMaster =  SiapKelasMaster::create($request->all());
        if (!$siapKelasMaster) {
            return redirect()->back()->with('error', 'Gagal menambahkan mahasiswa ke kelas.');
        }
        return redirect()->route('mahasiswa')->with('success', 'Mahasiswa berhasil ditambahkan ke kelas.');
    }
}
