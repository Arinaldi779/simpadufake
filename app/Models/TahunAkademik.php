<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TahunAkademik extends Model
{
    protected $table = 'siap_thn_ak';
    protected $primaryKey = 'id_thn_ak';
    public $incrementing = false; // karena primary key-nya bertipe char
    protected $keyType = 'string'; // untuk mendukung tipe char

    protected $fillable = [
        'id_thn_ak',
        'nama_thn_ak',
        'catatan',
        'aktif',
        'tgl_awal_kuliah',
        'tgl_akhir_kuliah',
        'tgl_awal_kuesioner',
    ];

    protected $casts = [
        'tgl_awal_kuliah' => 'date',
        'tgl_akhir_kuliah' => 'date',
        'tgl_awal_kuesioner' => 'date',
    ];
}
