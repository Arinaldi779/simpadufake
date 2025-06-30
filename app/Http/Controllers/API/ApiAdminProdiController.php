<?php

namespace App\Http\Controllers\API;

use App\Models\Prodi;
use App\Models\MataKuliah;
use App\Models\SiapKelasMK;
use Illuminate\Http\Request;
use App\Models\SiapKurikulum;
use App\Models\TahunAkademik;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use App\Http\Controllers\Controller;
use App\Models\SiapKelas;

class ApiAdminProdiController extends Controller
{


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
        $mk = MataKuliah::all();

        if ($thnAK->isEmpty() && $prodi->isEmpty()) {
            return response()->json([
                'success' => false,
                'message' => 'Tidak ada data prodi.'
            ], 404);
        }

        return response()->json([
            'success' => true,
            'message' => 'Data Prodi , Tahun Akademik, dan Mata Kuliah',
            'dataProdi' => $prodi,
            'dataTahunAkademik' => $thnAK,
            'dataMk' => $mk
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
                'nama_prodi' => $item->prodi->nama_prodi ?? 'N/A',
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
            'ket' => 'nullable|string|max:255',
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
                // 'id_mk' => $item->id_mk,
                'kode_mk' => $item->kode_mk,
                'nama_mk' => $item->nama_mk,
                // 'sks' => $item->sks,
                'smt' => $item->smt,
                // 'id_prodi' => $item->prodi->nama_prodi,
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

    // Create Mata Kuliah
    public function mkCreate(Request $request)
    {
        $validateData = $request->validate([
            'kode_mk' => 'required|string|max:255',
            'nama_mk' => 'required|string|max:255',
            'id_prodi' => 'required|integer|exists:kol_prodi,id_prodi',
            'sks' => 'required|integer',
            'jam' => 'required|integer',
        ]);

        try {
            $MKCreate = MataKuliah::create([
                'kode_mk' => $validateData['kode_mk'],
                'nama_mk' => $validateData['nama_mk'],
                'id_prodi' => $validateData['id_prodi'],
                'sks' => $validateData['sks'],
                'jam' => $validateData['jam'],
            ]);

            return response()->json([
                'success' => true,
                'message' => 'Mata Kuliah berhasil ditambahkan.',
                'data' => $MKCreate
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Gagal menambahkan Mata Kuliah.',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    //Index Dosen Ajar
    // public function indexDosenAjar()
    // {
    //     $data = SiapKelasMK::with(['kelas', 'kurikulum'])->limit(5)->get();;
    //     if ($data->isEmpty()) {
    //         return response()->json([
    //             'success' => false,
    //             'message' => 'Tidak ada data dosen ajar.'
    //         ], 404);
    //     }

    //     return response()->json([
    //         'success' => true,
    //         'message' => 'Daftar Dosen Ajar',
    //         'data' => $data->map(function ($item) {
    //             return [
    //                 'id_kelas' => $item->id_kelas,
    //                 'id_kurikulum' => $item->id_kurikulum,
    //                 'id_pegawai' => $item->id_pegawai,
    //                 'nama_kelas' => $item->kelas->nama_kelas ?? 'N/A',
    //                 'nama_mk' => $item->kurikulum->mataKuliah->nama_mk ?? 'N/A',
    //             ];
    //         })
    //     ]);
    // }

    public function indexDosenAjar()
    {
        try {
            // Ambil data dengan relasi yang diperlukan, pilih field yang penting saja
            $data = SiapKelasMK::with([
                'kelas:id_kelas,nama_kelas',
                'kurikulum:id_kurikulum,id_mk',
                'kurikulum.mataKuliah:id_mk,nama_mk',
            ])
                ->select('id_kelas_mk', 'id_kelas', 'id_kurikulum', 'id_pegawai') // Hindari ambil semua kolom
                ->limit(10) // Batasi agar ringan
                ->get();

            if ($data->isEmpty()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Tidak ada data dosen ajar.'
                ], 404);
            }

            // Mapping respons JSON agar bersih & ringan
            return response()->json([
                'success' => true,
                'message' => 'Daftar Dosen Ajar',
                'data' => $data->map(function ($item) {
                    return [
                        'id_kelas_mk' => $item->id_kelas_mk,
                        'id_kelas' => $item->id_kelas,
                        'id_kurikulum' => $item->id_kurikulum,
                        'id_pegawai' => $item->id_pegawai,
                        'nama_kelas' => $item->kelas->nama_kelas ?? 'N/A',
                        'nama_mk' => $item->kurikulum->mataKuliah->nama_mk ?? 'N/A',
                    ];
                })
            ], 200);
        } catch (\Exception $e) {
            // Logging untuk troubleshooting jika ada error berat
            Log::error('Gagal memuat data dosen ajar', [
                'error' => $e->getMessage(),
            ]);

            return response()->json([
                'success' => false,
                'message' => 'Terjadi kesalahan saat memuat data dosen ajar.',
                'error' => $e->getMessage()
            ], 500);
        }
    }




    //Menampilkan data dosen ajar berdasarkan ID
    public function showDosenAjar($id)
    {
        $data = SiapKelasMK::with(['kelas', 'kurikulum'])->find($id);

        if (!$data) {
            return response()->json([
                'success' => false,
                'message' => 'Data dosen ajar tidak ditemukan.'
            ], 404);
        }

        return response()->json([
            'success' => true,
            'message' => 'Detail Dosen Ajar',
            'data' => [
                'id_kelas' => $data->id_kelas,
                'id_kurikulum' => $data->id_kurikulum,
                'id_pegawai' => $data->id_pegawai,
                'nama_kelas' => $data->kelas->nama_kelas ?? 'N/A',
                'nama_mk' => $data->kurikulum->mataKuliah->nama_mk ?? 'N/A',
            ]
        ]);
    }

    //Create Dosen ajar 
    public function createDosenAjar(Request $request)
    {
        $validatedData = $request->validate([
            'id_kelas' => 'required|integer|exists:siap_kelas,id_kelas',
            'id_kurikulum' => 'required|integer|exists:siap_kurikulum,id_kurikulum',
            'id_pegawai' => 'required|integer',
        ]);

        try {
            $dosenAjar = SiapKelasMK::create([
                'id_kelas' => $validatedData['id_kelas'],
                'id_kurikulum' => $validatedData['id_kurikulum'],
                'id_pegawai' => $validatedData['id_pegawai'],
            ]);

            return response()->json([
                'success' => true,
                'message' => 'Dosen ajar berhasil dibuat.',
                'data' => $dosenAjar
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Gagal membuat dosen ajar.',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    //Data Kurikulum dan Kelas untuk Dosen Ajar
    public function getKurikulumKelas()
    {
        $kurikulum = SiapKurikulum::all();
        $kelas = SiapKelas::all();

        if ($kurikulum->isEmpty() || $kelas->isEmpty()) {
            return response()->json([
                'success' => false,
                'message' => 'Tidak ada data kurikulum atau kelas.'
            ], 404);
        }

        try {
            $formattedKurikulum = $kurikulum->map(function ($item) {
                return [
                    'id_kurikulum' => $item->id_kurikulum,
                    'nama_mk' => $item->mataKuliah->nama_mk ?? 'N/A',
                    'nama_tahun_akademik' => $item->tahunAkademik->nama_thn_ak,
                    'nama_prodi' => $item->prodi->nama_prodi ?? 'N/A',
                    'ket' => $item->ket,
                ];
            });

            $formattedKelas = $kelas->map(function ($item) {
                return [
                    'id_kelas' => $item->id_kelas,
                    'nama_kelas' => $item->nama_kelas,
                ];
            });

            return response()->json([
                'success' => true,
                'message' => 'Data Kurikulum dan Kelas',
                'dataKurikulum' => $formattedKurikulum,
                'dataKelas' => $formattedKelas
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Terjadi kesalahan saat mengambil data.',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
