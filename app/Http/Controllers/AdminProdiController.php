<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\SiapKurikulum;
use App\Models\MataKuliah;
use App\Models\Prodi;

class AdminProdiController extends Controller
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
}
