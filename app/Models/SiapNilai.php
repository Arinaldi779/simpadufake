<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\SiapKelasMK;
use App\Models\SiapKelasMaster;
use App\Models\SiapPresensiMhs;

class SiapNilai extends Model
{
    // Nama tabel yang digunakan
    protected $table = 'siap_nilai';

    // Laravel secara default menganggap ada kolom `id` sebagai primary key
    // Karena di sini menggunakan `id_nilai`, kita set secara manual
    protected $primaryKey = 'id_nilai';

    // Kalau `id_nilai` bukan auto-increment
    public $incrementing = false;

    // Jika tipe primary key bukan integer
    protected $keyType = 'int';

    // Jika tidak menggunakan timestamps (created_at, updated_at)
    public $timestamps = false;

    // Kolom yang dapat diisi secara mass-assignment
    protected $fillable = [
        'id_nilai',
        'id_kelas_mk',
        'id_kelas_master',
        'n_angka',
        'n_huruf',
    ];

    // Contoh relasi ke kelas_mk (jika ada model relasinya)
    public function kelasMk()
    {
        return $this->belongsTo(SiapKelasMK::class, 'id_kelas_mk', 'id_kelas_mk');
    }

    public function kelasMaster()
    {
        return $this->belongsTo(SiapKelasMaster::class, 'id_kelas_master', 'id_kelas_master');
    }
}
