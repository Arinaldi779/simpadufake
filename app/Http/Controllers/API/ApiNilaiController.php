<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\SiapNilai;
use App\Models\SiapPresensiDosen;
use App\Models\SiapPresensiMhs;
use App\Models\SiapKelasMaster; // Pastikan model ini ada
use App\Models\SiapKelasMk;


class ApiNilaiController extends Controller
{
    // Menampilkan daftar nilai mahasiswa berdasarkan ID kelas master
    public function nilaiMahasiswa($nim)
    {
        $nilaiList = SiapNilai::with(['kelasMaster.kelasMk.kurikulum.mk', 'kelasMaster.kelasMk.kelas'])
            ->whereHas('kelasMaster', function ($q) use ($nim) {
                $q->where('nim', $nim);
            })
            ->get();

        $result = [];

        foreach ($nilaiList as $nilai) {
            $kelasMk = $nilai->kelasMaster->kelasMk;

            $result[] = [
                'nama_mk' => $kelasMk->kurikulum->mk->nama_mk,
                'kelas'   => $kelasMk->kelas->nama_kelas,
                'n_angka' => $nilai->n_angka,
                'n_huruf' => $nilai->n_huruf,
            ];
        }

        return response()->json($result);
    }



    // Menampilkan jadwal mata kuliah mahasiswa berdasarkan ID kelas master
    public function jadwalMahasiswa($id_kelas_master)
    {
        $data = SiapNilai::where('id_kelas_master', $id_kelas_master)
            ->with('kelasMk.kurikulum.mataKuliah')
            ->get();

        return response()->json($data);
    }

    // todo Dosen menginput nilai ke tabel Nilai
    public function inputNilaiDosen(Request $request)
    {
        $request->validate([
            'id_kelas_master' => 'required|integer',
            'id_kelas_mk'     => 'required|integer',
            'nilai_dosen'     => 'required|numeric|min:0|max:100',
        ]);

        // Hitung jumlah kehadiran mahasiswa
        $jumlahHadir = SiapPresensiMhs::where('id_kelas_master', $request->id_kelas_master)
            ->where('status_presensi_mhs', 1)
            ->count();

        // Hitung total pertemuan dosen
        $totalPertemuan = SiapPresensiDosen::where('id_kelas_mk', $request->id_kelas_mk)->count();

        // Hitung persentase kehadiran
        $persentaseHadir = $totalPertemuan > 0
            ? ($jumlahHadir / $totalPertemuan) * 100
            : 0;

        // Hitung nilai akhir (70% dari nilai dosen, 30% dari kehadiran)
        $n_angka = round(($request->nilai_dosen * 0.7) + ($persentaseHadir * 0.3), 2);

        // Konversi ke huruf
        $n_huruf = match (true) {
            $n_angka >= 85 => 'A',
            $n_angka >= 75 => 'B',
            $n_angka >= 65 => 'C',
            $n_angka >= 50 => 'D',
            default        => 'E',
        };

        // Simpan/update ke tabel siap_nilai
        $nilai = SiapNilai::updateOrCreate(
            [
                'id_kelas_master' => $request->id_kelas_master,
            ],
            [
                'id_kelas_mk' => $request->id_kelas_mk,
                'n_angka'     => $n_angka,
                'n_huruf'     => $n_huruf,
            ]
        );

        return response()->json([
            'message' => 'Nilai berhasil dihitung dan disimpan',
            'n_angka' => $n_angka,
            'n_huruf' => $n_huruf,
        ]);
    }
}
