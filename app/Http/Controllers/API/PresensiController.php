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
            'id_kelas_mk' => 'required|integer',
        ]);

        // Cari kelas MK yang sesuai id_pegawai dan id_kelas_mk yang spesifik
        $kelasMk = SiapKelasMK::with(['kelas.SiapKelasMaster'])
            ->where('id_pegawai', $request->id_pegawai)
            ->where('id_kelas_mk', $request->id_kelas_mk)
            ->first();

        if (!$kelasMk) {
            return response()->json(['message' => 'Kelas tidak ditemukan untuk pegawai ini'], 404);
        }

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
                'status_presensi_mhs' => 0,
            ]);
        }

        return response()->json([
            'message' => 'Presensi dibuka untuk kelas: ' . $kelasMk->nama_matkul ?? 'Kelas',
            'id_kelas_mk' => $kelasMk->id_kelas_mk,
            'id_presensi_dosen' => $presensi->id_presensi_dosen,
            'pertemuan' => $pertemuanKe,
        ]);
    }
}
