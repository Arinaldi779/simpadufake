<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\SiapKelasMaster;
use App\Models\SiapPresensiMhs;
use Illuminate\Support\Carbon;

class PresensiMhsController extends Controller
{
    public function presensiAktif($nim)
    {
        // Cek kelas master
        $kelasMhs = SiapKelasMaster::where('nim', $nim)->firstOrFail();

        // Cari presensi dosen yang aktif
        $presensiAktif = SiapPresensiMhs::with('presensiDosen')
            ->where('id_kelas_master', $kelasMhs->id_kelas_master)
            ->where('status_presensi_mhs', 0)
            ->get();

        return response()->json($presensiAktif);
    }

    public function isiPresensi(Request $request)
    {
        $request->validate([
            'nim' => 'required|string',
        ]);

        // Cari id_kelas_master berdasarkan nim
        $kelasMhs = SiapKelasMaster::where('nim', $request->nim)->first();

        // Gunakan id_kelas_master untuk cari data presensi
        $updated = SiapPresensiMhs::where('id_kelas_master', $kelasMhs->id_kelas_master)
            // Jika perlu tambahkan kondisi lain, misal id_presensi_dosen:
            // ->where('id_presensi_dosen', $someIdPresensiDosen)
            ->update([
                'status_presensi_mhs' => 1,
                'waktu_presensi' => now(),
            ]);
        if ($updated) {
            return response()->json(['message' => 'Presensi berhasil dicatat']);
        } else {
            return response()->json(['message' => 'Data presensi tidak ditemukan atau gagal update'], 404);
        }
    }
}
