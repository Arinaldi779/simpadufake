<?php

namespace App\Http\Controllers\API;

use App\Models\SiapKelasMK;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use App\Models\SiapPresensiMhs;
use App\Models\SiapPresensiDosen;
use Illuminate\Support\Facades\Log;
use App\Http\Controllers\Controller;

class PresensiController extends Controller
{
    public function matkulByDosen($id_pegawai)
    {
        try {
            $data = SiapKelasMk::with(['kelas', 'kurikulum.mataKuliah'])
                ->where('id_pegawai', $id_pegawai)
                ->get()
                ->map(function ($item) {
                    return [
                        'id_kelas_mk' => $item->id_kelas_mk,
                        'kode_mk' => $item->kurikulum->mataKuliah->kode_mk ?? null,
                        'nama_mk' => $item->kurikulum->mataKuliah->nama_mk ?? null,
                        'nama_kelas' => $item->kelas->nama_kelas ?? null,
                    ];
                });

            return response()->json($data);
        } catch (\Throwable $e) {
            // Log error ke storage/logs/laravel.log
            Log::error('Gagal mengambil data kelas MK:', [
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString(),
            ]);

            return response()->json([
                'success' => false,
                'message' => 'Terjadi kesalahan saat mengambil data.',
                'error' => $e->getMessage(), // opsional, untuk debug di dev
            ], 500);
        }
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

        // =================================================================
        // --- BAGIAN PENGECEKAN UNTUK MENCEGAH DATA GANDA ---
        // =================================================================
        // Tentukan rentang waktu, misalnya 1 menit yang lalu
        // Tentukan periode cooldown, misalnya 1 menit
        $cooldownMenit = 30;

        // Tentukan rentang waktu pengecekan
        $waktuCek = Carbon::now()->subSecond($cooldownMenit)->toTimeString();
        $tanggalSekarang = Carbon::now()->toDateString();

        // Cek apakah sudah ada presensi untuk kelas ini PADA HARI INI
        // dan DALAM rentang waktu cooldown
        $presensiTerakhir = SiapPresensiDosen::where('id_kelas_mk', $kelasMk->id_kelas_mk)
            ->where('tgl_presesi', $tanggalSekarang)
            ->where('waktu_presensi', '>=', $waktuCek)
            ->first();

        // Jika ditemukan, berarti ada percobaan buka kelas ganda. Hentikan proses.
        if ($presensiTerakhir) {
            // --- LOGIKA BARU UNTUK PESAN DINAMIS ---
            // Ambil waktu kapan presensi terakhir dibuat
            $waktuDibuat = Carbon::parse($presensiTerakhir->tgl_presesi . ' ' . $presensiTerakhir->waktu_presensi);

            // Hitung kapan API boleh diakses lagi (waktu dibuat + cooldown)
            $waktuBolehAkses = $waktuDibuat->addSecond($cooldownMenit);

            // Hitung sisa waktu dalam format yang mudah dibaca (misal: "dalam 30 detik")
            // Mengatur locale ke bahasa Indonesia ('id') agar outputnya "dalam x menit/detik"
            $sisaWaktu = $waktuBolehAkses->locale('id')->diffForHumans();

            // Kembalikan response dengan pesan yang dinamis
            return response()->json([
                'message' => 'Kelas ini baru saja dibuka. Silakan coba lagi ' . $sisaWaktu . '.'
            ], 429); // 429 Too Many Requests
        }

        // =================================================================
        // --- AKHIR BAGIAN PENGECEKAN ---
        // =================================================================


        // Jika lolos pengecekan, baru lanjutkan proses di bawah ini
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
            'message' => 'Presensi berhasil dibuka untuk kelas: ' . ($kelasMk->nama_matkul ?? 'Kelas'),
            'id_kelas_mk' => $kelasMk->id_kelas_mk,
            'id_presensi_dosen' => $presensi->id_presensi_dosen,
            'pertemuan' => $pertemuanKe,
        ], 201); // Gunakan status 201 Created karena berhasil membuat resource baru

    }

    //Index Presensi Dosen
    public function indexPresensiDosen($id)
    {
        $data = SiapKelasMK::find($id);
        $dataPresensi = SiapPresensiDosen::where('id_kelas_mk', $data->id_kelas_mk);

        return response()->json([
            'kelas' => $data,
            'presensi' => $dataPresensi->get(),
        ]);
    }
}
