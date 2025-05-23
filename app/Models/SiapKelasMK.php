<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\SiapKelas;
use App\Models\SiapKurikulum;

class SiapKelasMK extends Model
{
    // Nama tabel jika tidak mengikuti konvensi Laravel
    protected $table = 'siap_kelas_mk';

    // Jika primary key bukan 'id'
    protected $primaryKey = 'id_kelas_mk';

    // Jika tidak menggunakan timestamps (created_at, updated_at)
    public $timestamps = false;

    // Field yang dapat diisi
    protected $fillable = [
        'id_kelas',
        'id_kurikulum',
        'id_pegawai',
    ];

    // Relasi ke model lain (jika ada)
    // public function pegawai()
    // {
    //     return $this->belongsTo(Pegawai::class, 'id_pegawai', 'id_pegawai');
    // }

    public function kelas()
    {
        return $this->belongsTo(SiapKelas::class, 'id_kelas', 'id_kelas');
    }

    public function kurikulum()
    {
        return $this->belongsTo(SiapKurikulum::class, 'id_kurikulum', 'id_kurikulum');
    }
}
