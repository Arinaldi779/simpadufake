<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\TahunAkademik;
use App\Models\SiapKelas;

class ApiAdminAkademikController extends Controller
{
    /**
     * Display a listing of the resource.
     */

    // * Menampilkan semua data tahun akademik
    public function indexThnAk()
    {
        $data = TahunAkademik::all();
        if ($data->isEmpty()) {
            return response()->json([
                'success' => false,
                'message' => 'Tidak ada data tahun akademik.'
            ], 404);
        }

        // Ambil sebagian kolom yang diinginkan
        // $data = $data->map(function ($item) {
        //     return [
        //         'id_thn_ak' => $item->id_thn_ak,
        //         'nama_thn_ak' => $item->nama_thn_ak
        //     ];
        // });

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
            'status' => 'required|in:Y,T',
            'smt' => 'required|string',
            'tgl_awal_kuliah' => 'required|date',
            'tgl_akhir_kuliah' => 'required|date',
        ]);

        // Simpan data
        $tahunAkademik = TahunAkademik::create($validated);
        if (!$tahunAkademik) {
            return response()->json([
                'success' => false,
                'message' => 'Gagal menambahkan tahun akademik.'
            ], 500);
        }


        // Respon sukses
        return response()->json([
            'success' => true,
            'message' => 'Tahun Akademik berhasil ditambahkan.',
            'data' => $tahunAkademik
        ], 201);
    }

    // Tampilkan Data kelas
    public function indexSiapKelas()
    {
        $data = SiapKelas::all();
        if ($data->isEmpty()) {
            return response()->json([
                'success' => false,
                'message' => 'Tidak ada data tahun akademik.'
            ], 404);
        }

        // Ambil sebagian kolom yang diinginkan
        $data = $data->map(function ($item) {
            return [
                'id_kelas' => $item->id_kelas,
                'nama_kelas' => $item->nama_kelas,
            ];
        });

        return response()->json([
            'success' => true,
            'message' => 'Daftar kelas',
            'data' => $data
        ]);
    }

    // Tampilkan data kelas berdasarkan id
    public function showSiapKelas($id)
    {
        $data = SiapKelas::find($id);

        if (!$data) {
            return response()->json([
                'success' => false,
                'message' => 'Data kelas tidak ditemukan.'
            ], 404);
        }

        return response()->json([
            'success' => true,
            'message' => 'Detail Kelas',
            'data' => $data
        ]);
    }

    // edit data tahun akademik
    public function thnAkUpdate(Request $request, $id)
    {
        $validated = $request->validate([
            'status' => 'required|in:Y,T',
        ]);

        $tahunAkademik = TahunAkademik::find($id);
        if (!$tahunAkademik) {
            return response()->json([
                'success' => false,
                'message' => 'Tahun akademik tidak ditemukan.',
            ], 404);
        }

        $tahunAkademik->status = $validated['status'];
        $tahunAkademik->save();

        return response()->json([
            'success' => true,
            'message' => 'Status tahun akademik berhasil diperbarui.',
            'data' => $tahunAkademik
        ], 200);
    }
}
