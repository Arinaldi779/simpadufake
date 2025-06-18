<?php

namespace App\Http\Controllers;

use App\Models\Prodi;
use App\Models\SiapKelas;
use App\Models\MataKuliah;
use Illuminate\Http\Request;
use App\Models\SiapKurikulum;
use App\Models\SiapKelasMK;
use App\Models\SiapKelasMaster;
use Illuminate\Support\Facades\DB;


use App\Models\TahunAkademik;
use Illuminate\Support\Facades\Http;

class HomeController extends Controller
{
    // Halaman Login
    public function login()
    {
        return view('login');
    }

    public function indexThnAk(Request $request)
    {
        // Jika kamu ingin menggunakan filter, bisa ditambahkan di sini
        $query = TahunAkademik::query();

        if ($request->filled('tahun')) {
            $query->where('nama_thn_ak', $request->tahun);
        }

        if ($request->filled('status')) {
            $query->where('aktif', $request->status);
        }

        // Untuk pagination
        $data = $query->paginate(10);
        $dataAll = TahunAkademik::all();
        // $data = $query->get();

        if ($data->isEmpty()) {
            // Jika tidak ada data, tampilkan pesan error
            $message = 'Data tidak ditemukan';
            return view('tahunakademik', compact('data', 'dataAll', 'message'));
        }

        // dd($data);

        return view('tahunakademik', compact('data', 'dataAll'));
    }


    // Halaman Kelas
    public function kelas(Request $request)
    {
        // Jika kamu ingin menggunakan filter, bisa ditambahkan di sini
        $query = SiapKelas::query();

        if ($request->filled('prodi')) {
            $query->where('id_prodi', $request->prodi);
        }

        if ($request->filled('thnAk')) {
            $query->where('id_thn_ak', $request->thnAk);
        }

        // Untuk pagination
        $data = $query->paginate(10);
        // $data = $query->get();
        $dataAll = SiapKelas::all(); // Ambil semua data kelas beserta relasi dengan prodi dan tahun akademik
        $dataProdi = Prodi::all(); // Ambil semua data prodi
        $dataThnAk = TahunAkademik::all(); // Ambil semua data tahun akademik
        if ($data->isEmpty() && $dataAll->isEmpty() && $dataProdi->isEmpty() && $dataThnAk->isEmpty()) {
            // Jika tidak ada data, tampilkan pesan error
            $message = 'Data tidak ditemukan';
            return view('kelas', compact('data', 'dataAll', 'message'));
        }


        return view('kelas', compact('data', 'dataAll', 'dataProdi', 'dataThnAk'));
    }

    // Halaman Mahasiswa
    public function mahasiswa(Request $request)
    {

        // $search = $request->input('search');
        $response = Http::get('https://ti054d03.agussbn.my.id/api/mahasiswa/list_mahasiswa');
        if ($response->successful()) {
            $dataJson = json_decode($response->body());
        } else {
            return response()->json([
                'message' => 'Gagal mengambil data mahasiswa',
                'status' => $response->status()
            ], $response->status());
        }
        $dataAll = SiapKelasMaster::all();
        $data = SiapKelasMaster::paginate(10);
        $dataKelas = SiapKelas::all();

        // return view('mahasiswa', compact('dataJson', 'dataAll', 'dataKelas', 'dataProdi'));
        return view('mahasiswa', compact('dataJson', 'dataAll', 'dataKelas', 'data'));
    }

    public function toggleStatus($id)
    {
        $tahun = DB::table('siap_thn_ak')->where('id_thn_ak', $id)->first();

        $newStatus = $tahun->status === 'Y' ? 'T' : 'Y';

        DB::table('siap_thn_ak')
            ->where('id_thn_ak', $id)
            ->update(['status' => $newStatus]);

        return redirect()->back()->with('success', 'Status berhasil diubah.');
    }

    public function mhsStatus($id)
    {
        $kelasMaster = DB::table('siap_kelas_master')->where('id_kelas_master', $id)->first();

        $newStatus = $kelasMaster->status === 'Y' ? 'T' : 'Y';

        DB::table('siap_kelas_master')
            ->where('id_kelas_master', $id)
            ->update(['status' => $newStatus]);

        return redirect()->back()->with('success', 'Status mahasiswa berhasil diubah.');
    }


    public function updateStatus(Request $request)
    {
        $request->validate([
            'id' => 'required|exists:siap_thn_ak,id_thn_ak',
            'status' => 'required|string|in:T,Y',
        ]);

        $tahunAk = TahunAkademik::find($request->id);
        if (!$tahunAk) {
            return response()->json(['success' => false, 'message' => 'Data tidak ditemukan']);
        }

        $tahunAk->status = $request->status;
        $saved = $tahunAk->save();

        return response()->json(['success' => $saved]);
    }

    public function akademik()
    {
        return view('akademik'); // Sesuaikan dengan nama view kamu
    }
    public function prodi()
    {
        return view('prodi'); // Sesuaikan dengan nama view kamu
    }

    // Halaman Kurikulum
    public function kurikulum(Request $request)
    {

        // Jika kamu ingin menggunakan filter, bisa ditambahkan di sini
        $query = SiapKurikulum::query();

        if ($request->filled('mk')) {
            $query->where('id_mk', $request->mk);
        }

        if ($request->filled('thnAk')) {
            $query->where('id_thn_ak', $request->thnAk);
        }

        // Untuk pagination
        $data = $query->paginate(10);
        // $data = $query->get();
        $dataAll = SiapKurikulum::with('mataKuliah', 'tahunAkademik')->get();
        $dataMK = MataKuliah::all();
        $dataThnAk = TahunAkademik::all();

        if ($data->isEmpty()) {
            // Jika tidak ada data, tampilkan pesan error
            $message = 'Data tidak ditemukan';
            return view('kurikulum', compact('data', 'dataAll', 'message', 'dataMK', 'dataThnAk'));
        }



        return view('kurikulum', compact('data', 'dataAll', 'dataMK', 'dataThnAk'));
    }

    // Halaman MATAKULIAH
    public function matakuliah(Request $request)
    {

        // Jika kamu ingin menggunakan filter, bisa ditambahkan di sini
        $query = MataKuliah::query();

        if ($request->filled('mk')) {
            $query->where('nama_mk', $request->mk);
        }

        if ($request->filled('kodeMk')) {
            $query->where('kode_mk', $request->kodeMk);
        }

        // Untuk pagination
        $data = $query->paginate(10);
        // $data = $query->get();
        $dataThnAk = TahunAkademik::all();
        $dataProdi = Prodi::all();
        if ($data->isEmpty() && $dataThnAk->isEmpty() && $dataProdi->isEmpty()) {
            // Jika tidak ada data, tampilkan pesan error
            $message = 'Data tidak ditemukan';
            return view('matakuliah', compact('data', 'message', 'dataThnAk', 'dataProdi'));
        }

        // dd($data);

        return view('matakuliah', compact('data', 'dataThnAk', 'dataProdi'));
    }

    // Dosen Ajar atau siapKelaMK
    public function dosenajar(Request $request)
    { {
            // Ambil Api Kelompok 2 pegawai
            // $response = Http::get('https://e8e5-2404-c0-4cb0-00-f8e-d5d1.ngrok-free.app/api/pegawai-id-nip');
            // if ($response->successful()) {
            //     $dataJson = json_decode($response->body());
            // } else {
            //     return response()->json([
            //         'message' => 'Gagal mengambil data mahasiswa',
            //         'status' => $response->status()
            //     ], $response->status());
            // }
            $dataJson = 1;
            // Jika kamu ingin menggunakan filter, bisa ditambahkan di sini
            $query = SiapKelasMK::query();
            // Untuk pagination
            $data = $query->paginate(10);
            $dataAll = SiapKelasMK::with('kelas', 'kurikulum')->get();
            $dataKelas = SiapKelas::all();
            $dataKurikulum = SiapKurikulum::all();

            // $data = $query->get();

            if ($data->isEmpty() && $dataAll->isEmpty() && $dataKelas->isEmpty() && $dataKurikulum->isEmpty()) {
                // Jika tidak ada data, tampilkan pesan error
                $message = 'Data tidak ditemukan';
                return view('dosenajar', compact('data', 'dataAll', 'message', 'dataJson', 'dataKurikulum', 'dataKelas'));
            }

            // dd($data);
            $message = 'Data ditemukan';
            return view('dosenajar', compact('data', 'dataAll', 'message', 'dataJson', 'dataKurikulum', 'dataKelas'));
        }
    }
    public function presensi()
    {
        return view('presensi'); // Sesuaikan dengan nama view kamu
    }
    public function nilai()
    {
        return view('nilai'); // Sesuaikan dengan nama view kamu
    }
    public function khskrs()
    {
        return view('khskrs'); // Sesuaikan dengan nama view kamu
    }
    public function editta(TahunAkademik $tahunAkademik)
    {

        // dd($tahunAkademik);
        return view('edit.editta', ['data' => $tahunAkademik]);
    }

    public function editkls()
    {
        return view('edit.editkls'); // Sesuaikan dengan nama view kamu
    }
    public function editmhs()
    {
        return view('edit.editmhs'); // Sesuaikan dengan nama view kamu
    }
    public function editkur()
    {
        return view('edit.editkur'); // Sesuaikan dengan nama view kamu
    }
    public function editmk()
    {
        return view('edit.editmk'); // Sesuaikan dengan nama view kamu
    }
    public function editdosen()
    {
        return view('edit.editdosen'); // Sesuaikan dengan nama view kamu
    }
    public function editpresensi()
    {
        return view('edit.editpresensi'); // Sesuaikan dengan nama view kamu
    }
    public function editpresensidosen()
    {
        return view('edit.editpresensidosen'); // Sesuaikan dengan nama view kamu
    }
    public function editpresensimahasiswa()
    {
        return view('edit.editpresensimahasiswa'); // Sesuaikan dengan nama view kamu
    }

    public function editnilai()
    {
        return view('edit.editnilai'); // Sesuaikan dengan nama view kamu
    }

    public function editkhs()
    {
        return view('edit.editkhs'); // Sesuaikan dengan nama view kamu
    }
    public function editkrs()
    {
        return view('edit.editkrs'); // Sesuaikan dengan nama view kamu
    }
}
