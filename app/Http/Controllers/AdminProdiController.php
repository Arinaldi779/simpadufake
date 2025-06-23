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
        $request->validate([
            'id_mk' => 'required|string|max:255',
            'id_thn_ak' => 'required|string|max:255',
            'ket' => 'nullable|string',
        ]);

        SiapKurikulum::create([
            'id_mk' => $request->id_mk,
            'id_thn_ak' => $request->id_thn_ak,
            'ket' => $request->ket,
        ]);


        // dd($request->all());

        return redirect()->route('kurikulum')->with('success', 'Kurikulum berhasil ditambahkan.');
    }

    //Tambah Mata Kuliah
    public function mkCreate(Request $request)
    {

        // dd($request->all());

        $request->validate([
            'kode_mk' => 'required|string|max:255',
            'nama_mk' => 'required|string|max:255',
            'id_prodi' => 'required|integer',
            'sks' => 'required|integer',
            'jam' => 'required|integer',

            // Tambahkan validasi lainnya sesuai kebutuhan
        ]);



        MataKuliah::create($request->all());

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
