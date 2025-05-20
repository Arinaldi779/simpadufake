<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SiapKelas extends Model
{
    use HasFactory;

    // Nama tabel
    protected $table = 'siap_kelas';

    // Primary key
    protected $primaryKey = 'id_kelas';

    // Primary key bukan auto-increment karena tipe integer tapi tidak disebut sebagai autoIncrement
    public $incrementing = false;

    // Tipe primary key
    protected $keyType = 'int';

    // Tidak menggunakan timestamps
    public $timestamps = false;

    // Kolom yang bisa diisi
    protected $fillable = [
        'id_kelas',
        'id_thn_ak',
        'id_prodi',
        'nama_kelas',
        'alias',
    ];

    // Relasi dengan TahunAkademik
    public function tahunAkademik()
    {
        return $this->belongsTo(TahunAkademik::class, 'id_thn_ak', 'id_thn_ak');
    }

    // Relasi dengan Prodi
    public function prodi()
    {
        return $this->belongsTo(Prodi::class, 'id_prodi', 'id_prodi');
    }
}
