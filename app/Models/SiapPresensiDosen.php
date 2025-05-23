<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\SiapKelasMK;

class SiapPresensiDosen extends Model
{
    // Nama tabel
    protected $table = 'siap_presensi_dosen';

    // Primary key
    protected $primaryKey = 'id_presensi_dosen';

    // Tipe primary key auto increment
    public $incrementing = true;

    // Tidak menggunakan timestamps (created_at, updated_at)
    public $timestamps = false;

    // Tipe primary key
    protected $keyType = 'int';

    // Kolom yang dapat diisi
    protected $fillable = [
        'id_kelas_mk',
        'pertemuan_ke',
        'tgl_presesi',
        'waktu_presensi',
        'status_presensi_dosen',
    ];

    // Relasi ke kelas_mk
    public function kelasMk()
    {
        return $this->belongsTo(SiapKelasMK::class, 'id_kelas_mk', 'id_kelas_mk');
    }
}
