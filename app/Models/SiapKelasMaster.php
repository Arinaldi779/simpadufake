<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class SiapKelasMaster extends Model
{
    // Nama tabel
    protected $table = 'siap_kelas_master';

    // Primary key
    protected $primaryKey = 'id_kelas_master';

    // Tidak auto-increment karena tidak didefinisikan auto increment
    public $incrementing = false;

    // Tipe primary key
    protected $keyType = 'int';

    // Tidak menggunakan timestamps
    public $timestamps = false;

    // Kolom yang bisa diisi
    protected $fillable = [
        'id_kelas_master',
        'no_absen',
        'id_kelas',
        'nim',
        'status',
    ];

    // Relasi ke tabel SiapKelas
    public function kelas()
    {
        return $this->belongsTo(SiapKelas::class, 'id_kelas', 'id_kelas');
    }
}
