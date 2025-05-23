<?php

namespace App\Models;

use App\Models\SiapKelasMaster;
use App\Models\SiapPresensiDosen;

use Illuminate\Database\Eloquent\Model;

class SiapPresensiMhs extends Model
{
    // Nama tabel jika tidak mengikuti konvensi Laravel (plural snake_case)
    protected $table = 'siap_presensi_mhs';

    // Laravel menganggap tidak ada kolom 'id' default, jadi nonaktifkan timestamps
    public $timestamps = false;

    // Kolom yang boleh diisi secara massal
    protected $fillable = [
        'id_presensi_dosen',
        'id_kelas_master',
        'waktu_presensi',
        'status_presensi_mhs',
    ];

    // Relasi ke presensi dosen
    public function presensiDosen()
    {
        return $this->belongsTo(SiapPresensiDosen::class, 'id_presensi_dosen');
    }

    // Relasi ke kelas master
    public function kelasMaster()
    {
        return $this->belongsTo(SiapKelasMaster::class, 'id_kelas_master');
    }
}
