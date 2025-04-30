<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\TahunAkademik;

class ApiAdminAkademikController extends Controller
{
    /**
     * Display a listing of the resource.
     */

    // * Menampilkan semua data tahun akademik
    public function indexThnAk()
    {
        $data = TahunAkademik::all();

        return response()->json([
            'success' => true,
            'message' => 'Daftar Tahun Akademik',
            'data' => $data
        ]);
    }

    // todo Cari Thn Akademik berdasarkan ID
    public function showThnAk($id)
    {
        $data = TahunAkademik::find($id);

        if (!$data) {
            return response()->json([
                'success' => false,
                'message' => 'Tahun Akademik tidak ditemukan.'
            ], 404);
        }

        return response()->json([
            'success' => true,
            'message' => 'Detail Tahun Akademik',
            'data' => $data
        ]);
    }

    // todo Menambahkan data tahun akademik
    public function createThnAk(Request $request)
    {
        // Validasi data
        $validated = $request->validate([
            'id_thn_ak' => 'required|string|unique:siap_thn_ak,id_thn_ak',
            'nama_thn_ak' => 'required|string',
            'catatan' => 'nullable|string',
            'aktif' => 'required|boolean',
            'tgl_awal_kuliah' => 'required|date',
            'tgl_akhir_kuliah' => 'required|date',
            'tgl_awal_kuesioner' => 'nullable|date',
        ]);

        // Simpan data
        $tahunAkademik = TahunAkademik::create($validated);

        // Respon sukses
        return response()->json([
            'success' => true,
            'message' => 'Tahun Akademik berhasil ditambahkan.',
            'data' => $tahunAkademik
        ], 201);
    }

    public function ThnAkademik() {}
}
