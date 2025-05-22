<?php

namespace App\Http\Controllers;

use App\Models\Prodi;
use App\Models\SiapKelas;
use App\Models\MataKuliah;
use Illuminate\Http\Request;
use App\Models\SiapKurikulum;
use App\Models\SiapKelasMaster;

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

        if ($data->isEmpty()) {
            // Jika tidak ada data, tampilkan pesan error
            $message = 'Data tidak ditemukan';
            return view('kelas', compact('data', 'dataAll', 'message'));
        }

        $dataAll = SiapKelas::with('prodi', 'tahunAkademik')->get();

        return view('kelas', compact('data', 'dataAll'));
    }

    // Halaman Mahasiswa
    public function mahasiswa(Request $request)
    {

        // $search = $request->input('search');
        $response = Http::get('http://36.91.27.150:818/api/mahasiswa');
        if ($response->successful()) {
            $dataJson = json_decode($response->body());
        } else {
            return response()->json([
                'message' => 'Gagal mengambil data mahasiswa',
                'status' => $response->status()
            ], $response->status());
        }
        // $filterMhs = collect();

        // if ($response->successful()) {
        //     $dataJson = json_decode($response->body()); // bukan ->json(), tapi json_decode()
        //     $mhs = collect($dataJson);
        //     if ($search) {
        //         $filterMhs = $mhs->filter(function ($itemMhs) use ($search) {
        //             return stripos($itemMhs->nama_mhs, $search) !== false;
        //         });
        //     } else {
        //         $filterMhs = $mhs;
        //     }
        // } else {
        //     return response()->json([
        //         'message' => 'Gagal mengambil data mahasiswa',
        //         'status' => $response->status()
        //     ], $response->status());
        //     return view('mahasiswa')->with('error', 'Gagal mengambil data mahasiswa');
        // }

        // $query = SiapKelasMaster::with(['siapKelas.prodi']);

        // // Filter berdasarkan id_prodi dari relasi siapKelas ➝ prodi
        // if ($request->filled('prodi')) {
        //     $query->whereHas('siapKelas', function ($q) use ($request) {
        //         $q->where('id_prodi', $request->prodi);
        //     });
        // }

        // // Filter berdasarkan status (misalnya field 'status' di tabel siap_kelas_master)
        // if ($request->filled('status')) {
        //     $query->where('status', $request->status);
        // }

        // // Filter berdasarkan nama (misalnya nama_kelas atau nama_dosen?)
        // if ($request->filled('search')) {
        //     $query->where('nama', 'like', '%' . $request->search . '%'); // sesuaikan field 'nama'
        // }

        // // Ambil data
        // $dataAll = $query->paginate(10);

        // // Ambil data Prodi untuk select option
        // $dataProdi = Prodi::all();
        // // Ambil data Kelas untuk select option
        // $dataKelas = SiapKelas::all();

        // // Ambil data status jika diperlukan (misalnya enum atau ambil dari DB)
        // // $statusList = ['Aktif', 'Tidak Aktif']; // contoh static


        // // Pesan jika semua kosong
        // $message = null;
        // if ($dataAll->isEmpty() && $dataProdi->isEmpty() && $dataKelas->isEmpty()) {
        //     $message = 'Data tidak ditemukan';
        //     return view('mahasiswa', compact('message', 'dataAll', 'dataKelas', 'dataProdi'));
        // }

        $dataAll = SiapKelasMaster::paginate(10);
        $dataKelas = SiapKelas::all();

        // return view('mahasiswa', compact('dataJson', 'dataAll', 'dataKelas', 'dataProdi'));
        return view('mahasiswa', compact('dataJson', 'dataAll', 'dataKelas'));
    }
    public function updateStatus(Request $request)
    {
        $request->validate([
            'id' => 'required|integer|exists:tahun_akademiks,id',
            'status_aktif' => 'required|string|in:Aktif,Tidak Aktif',
        ]);

        $tahunAk = \App\Models\TahunAkademik::find($request->id);
        if (!$tahunAk) {
            return response()->json(['success' => false, 'message' => 'Data tidak ditemukan']);
        }

        $tahunAk->status_aktif = $request->status_aktif;
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

        if ($data->isEmpty()) {
            // Jika tidak ada data, tampilkan pesan error
            $message = 'Data tidak ditemukan';
            return view('kurikulum', compact('data', 'dataAll', 'message'));
        }

        $dataAll = SiapKurikulum::with('mataKuliah', 'tahunAkademik')->get();
        $dataMk = MataKuliah::all();
        $dataThnAk = TahunAkademik::all();

        return view('kurikulum', compact('data', 'dataAll', 'dataMk', 'dataThnAk'));
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
    public function dosenajar()
    {
        return view('dosenajar'); // Sesuaikan dengan nama view kamu
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
