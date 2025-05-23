<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\SiapKelasMK;
use App\Models\SiapPresensiDosen;
use App\Models\SiapPresensiMhs;

class PresensiController extends Controller
{
    public function matkulByDosen($id_pegawai)
    {
        $data = SiapKelasMk::with(['kelas', 'kurikulum.mataKuliah'])
            ->where('id_pegawai', $id_pegawai)
            ->get();

        return response()->json($data);
    }

    public function bukaPresensi(Request $request)
    {
        $request->validate([
            'id_pegawai' => 'required|integer',
        ]);

        $kelasMks = SiapKelasMK::with(['kelas.SiapKelasMaster'])
            ->where('id_pegawai', $request->id_pegawai)
            ->get();

        if ($kelasMks->isEmpty()) {
            return response()->json(['message' => 'Tidak ada kelas ditemukan untuk pegawai ini'], 404);
        }

        $responseData = [];

        foreach ($kelasMks as $kelasMk) {
            $pertemuanKe = SiapPresensiDosen::where('id_kelas_mk', $kelasMk->id_kelas_mk)->count() + 1;

            $presensi = SiapPresensiDosen::create([
                'id_kelas_mk' => $kelasMk->id_kelas_mk,
                'pertemuan_ke' => $pertemuanKe,
                'tgl_presesi' => now()->toDateString(),
                'waktu_presensi' => now()->toTimeString(),
                'status_presensi_dosen' => true,
            ]);

            foreach ($kelasMk->kelas->SiapKelasMaster as $mhs) {
                SiapPresensiMhs::create([
                    'id_presensi_dosen' => $presensi->id_presensi_dosen,
                    'id_kelas_master' => $mhs->id_kelas_master,
                    'status_presensi_mhs' => false,
                ]);
            }

            $responseData[] = [
                'id_kelas_mk' => $kelasMk->id_kelas_mk,
                'id_presensi_dosen' => $presensi->id_presensi_dosen,
                'pertemuan' => $pertemuanKe,
            ];
        }

        return response()->json([
            'message' => 'Presensi dibuka untuk semua matkul/kuliah yang diajar dosen ini.',
            'presensi_data' => $responseData
        ]);
    }
}
