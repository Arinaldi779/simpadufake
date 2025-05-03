<?php

namespace App\Http\Controllers;

use App\Models\TahunAkademik;

use Illuminate\Http\Request;

class AdminAkademikController extends Controller
{
    //Tambah data tahun akademik
    public function tahuAkCreate(Request $request)
    {
        $request->validate([
            'id_thn_ak' => 'required|string|max:255|unique:siap_thn_ak,id_thn_ak',
            'nama_thn_ak' => 'required|string|max:255',
            'catatan' => 'nullable|string',
            'aktif' => 'required|in:Y,T',
            'tgl_awal_kuliah' => 'required|date',
            'tgl_akhir_kuliah' => 'required|date|after_or_equal:tgl_awal_kuliah',
        ]);

        TahunAkademik::create($request->all());

        return redirect()->route('tahunakademik')->with('success', 'Tahun Akademik berhasil ditambahkan.');
    }
}
