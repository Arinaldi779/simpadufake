<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\SiapKurikulum;
use App\Models\MataKuliah;
use App\Models\Prodi;
use App\Models\TahunAkademik;


class ApiAdminProdiController extends Controller
{

    /**
     * @OA\Get(
     *     path="/api/users",
     *     tags={"Users"},
     *     summary="Get all users",
     *     @OA\Response(
     *         response=200,
     *         description="Successful operation"
     *     )
     * )
     */

    //Tampilkan data prodi API 
    public function indexProdi()
    {
        $data = Prodi::all();

        if ($data->isEmpty()) {
            return response()->json([
                'success' => false,
                'message' => 'Tidak ada data prodi.'
            ], 404);
        }

        return response()->json([
            'success' => true,
            'message' => 'Daftar Prodi',
            'data' => $data
        ]);
    }

    // API 3 tabel 
    public function prodiThn()
    {
        $thnAK = TahunAkademik::all();
        $prodi = Prodi::all();

        if ($thnAK->isEmpty() && $prodi->isEmpty()) {
            return response()->json([
                'success' => false,
                'message' => 'Tidak ada data prodi.'
            ], 404);
        }

        return response()->json([
            'success' => true,
            'message' => 'Data Prodi dan Tahun Akademik',
            'dataProdi' => $prodi,
            'dataTahunAkademik' => $thnAK
        ]);
    }

    public function indexSiapKurikulum()
    {
        $data = SiapKurikulum::with(['mataKuliah', 'tahunAkademik'])->get();

        if ($data->isEmpty()) {
            return response()->json([
                'success' => false,
                'message' => 'Tidak ada data siap kurikulum.'
            ], 404);
        }

        $formatted = $data->map(function ($item) {
            return [
                'id_kurikulum' => $item->id_kurikulum,
                'nama_matakuliah' => $item->mataKuliah->nama_mk ?? 'N/A',
                'nama_tahun_akademik' => $item->tahunAkademik->nama_thn_ak,
                'ket' => $item->ket,
            ];
        });

        return response()->json([
            'success' => true,
            'message' => 'Daftar Siap Kurikulum',
            'data' => $formatted
        ]);
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

        //Ambil sebagian kolom yang diinginkan

        return response()->json([
            'id_kurikulum' => $data->id_kurikulum,
            'id_mk' => $data->mataKuliah->nama_mk,
            'id_thn_ak' => $data->tahunAkademik->id_thn_ak,
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Detail Siap Kurikulum',
            'data' => $data
        ]);
    }

    // Create Kurikulum
    public function createKurikulum(Request $request)
    {
        $validatedData = $request->validate([
            'id_mk' => 'required|integer|exists:siap_mk,id_mk',
            'id_thn_ak' => 'required|integer|exists:siap_thn_ak,id_thn_ak',
            'id_prodi' => 'required|integer|exists:kol_prodi,id_prodi',
        ]);

        try {
            $kurikulum = SiapKurikulum::create($validatedData);

            return response()->json([
                'success' => true,
                'message' => 'Kurikulum berhasil dibuat.',
                'data' => $kurikulum
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Gagal membuat kurikulum.',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    // todo Menampilkan semua data mata kuliah
    public function indexMataKuliah()
    {
        // Mengambil semua data mata kuliah
        $data = MataKuliah::all();
        if ($data->isEmpty()) {
            return response()->json([
                'success' => false,
                'message' => 'Tidak ada data mata kuliah.'
            ], 404);
        }

        //Ambil sebagian kolom yang diinginkan
        $data = $data->map(function ($item) {
            return [
                'id_mk' => $item->id_mk,
                'kode_mk' => $item->kode_mk,
                'nama_mk' => $item->nama_mk,
                'sks' => $item->sks,
                'smt' => $item->smt,
                'id_prodi' => $item->prodi->nama_prodi,
            ];
        });

        // Ambil semua data
        return response()->json([
            'success' => true,
            'message' => 'Daftar Mata Kuliah',
            'data' => $data
        ]);
    }

    // todo Menampilkan data mata kuliah berdasarkan ID
    public function showMataKuliah($id)
    {
        $data = MataKuliah::find($id);

        if (!$data) {
            return response()->json([
                'success' => false,
                'message' => 'Data mata kuliah tidak ditemukan.'
            ], 404);
        }

        return response()->json([
            'success' => true,
            'message' => 'Detail Mata Kuliah',
            'data' => $data
        ]);
    }
}
