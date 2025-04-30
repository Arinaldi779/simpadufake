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
