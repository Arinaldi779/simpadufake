<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\SiapKurikulum;


class ApiAdminProdiController extends Controller
{
    public function indexSiapKurikulum()
    {
        // Mengambil semua data siap kurikulum
        $data = SiapKurikulum::all();
        if ($data->isEmpty()) {
            return response()->json([
                'success' => false,
                'message' => 'Tidak ada data siap kurikulum.'
            ], 404);
        }

        // Ambil semua data
        return response()->json([
            'success' => true,
            'message' => 'Daftar Siap Kurikulum',
            'data' => $data
        ]);

        return response()->json($data);
    }

    // todo Menampilkan data siap kurikulum berdasarkan ID
    public function showSiapKurikulum($id)
    {
        $data = SiapKurikulum::find($id);

        if (!$data) {
            return response()->json([
                'success' => false,
                'message' => 'Data siap kurikulum tidak ditemukan.'
            ], 404);
        }

        return response()->json([
            'success' => true,
            'message' => 'Detail Siap Kurikulum',
            'data' => $data
        ]);
    }
}
