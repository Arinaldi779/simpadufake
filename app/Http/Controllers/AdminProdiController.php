<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\SiapKurikulum;
use App\Models\MataKuliah;
use App\Models\Prodi;
use App\Models\SiapKelasMK;

class AdminProdiController extends Controller
{
    public function kurikulumCreate(Request $request)
    {
        // 🔍 Lihat isi inputan sebelum divalidasi
        dd($request->all());
        $validated = $request->validate([
            'id_mk' => 'required|integer',
            'id_thn_ak' => 'required|integer',
            'ket' => 'nullable|string',
        ]);

        // ✅ 2. Debug hasil input yang sudah divalidasi
        dd($validated);

        // ✅ 3. Proses penyimpanan ke database
        SiapKurikulum::create([
            'id_mk' => $validated['id_mk'],
            'id_thn_ak' => $validated['id_thn_ak'],
            'ket' => $validated['ket'] ?? null,
        ]);

        return redirect()->route('kurikulum')->with('success', 'Kurikulum berhasil ditambahkan.');
    }

    //Tambah Mata Kuliah
    public function mkCreate(Request $request)
    {

        dd($request->all());

        $validateData = $request->validate([
            'kode_mk' => 'required|integer',
            'nama_mk' => 'required|string|max:255',
            'id_prodi' => 'required|integer',
            'sks' => 'required|integer',
            'jam' => 'required|integer',

            // Tambahkan validasi lainnya sesuai kebutuhan
        ]);

        $MKCreate = MataKuliah::create([
            'kode_mk' => $validateData['kode_mk'],
            'nama_mk' => $validateData['nama_mk'],
            'id_prodi' => $validateData['id_prodi'],
            'sks' => $validateData['sks'],
            'jam' => $validateData['jam'],
        ]);

        // Cek apakah data berhasil disimpan
        if (!$MKCreate) {
            return redirect()->back()->with('error', 'Gagal menambahkan Mata Kuliah.');
            dd('tolol');
        }

        // dd($request->all());

        return redirect()->route('matakuliah')->with('success', 'Mata Kuliah berhasil ditambahkan.');
    }



    // Input dosen ajar
    public function dosenAjarCreate(Request $request)
    {
        // dd($request->all());
        $validateData =  $request->validate([
            'id_kelas' => 'required|integer',
            'id_kurikulum' => 'required|integer',
            'id_dosen' => 'required|integer',
        ]);

        // Logika untuk menyimpan data dosen ajar
        $store = SiapKelasMK::create([
            'id_kelas' => $validateData['id_kelas'],
            'id_kurikulum' => $validateData['id_kurikulum'],
            'id_pegawai' => $validateData['id_dosen'],
        ]);

        // dd($validateData);

        if ($store) {
            return redirect()->route('dosenajar')->with('success', 'Dosen ajar berhasil ditambahkan.');
        } else {
            return redirect()->back()->with('error', 'Gagal menambahkan dosen ajar.');
        }
    }
}
