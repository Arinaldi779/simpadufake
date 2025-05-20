<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TahunAkademik extends Model
{
    // Nama tabel
    protected $table = 'siap_thn_ak';

    // Primary key bukan 'id' default
    protected $primaryKey = 'id_thn_ak';

    // Tidak auto-increment karena tipe primary key adalah char
    public $incrementing = false;

    // Tipe primary key adalah string
    protected $keyType = 'string';

    // Tidak menggunakan timestamps (created_at dan updated_at)
    public $timestamps = false;

    // Kolom yang bisa diisi (mass assignable)
    protected $fillable = [
        'id_thn_ak',
        'nama_thn_ak',
        'smt',
        'status',
        'tgl_awal_kuliah',
        'tgl_akhir_kuliah',
    ];

    protected $casts = [
        'tgl_awal_kuliah' => 'date',
        'tgl_akhir_kuliah' => 'date',
    ];


    // Tambahkan 'status_aktif' ke output saat model diubah jadi array atau JSON
    protected $appends = ['status_aktif'];

    //Untuk route bisa mencari id
    public function getRouteKeyName()
    {
        return 'id_thn_ak';
    }

    /**
     * Accessor untuk mengubah nilai kolom 'aktif' menjadi teks
     * - 't' => 'Aktif'
     * - selain itu => 'Tidak Aktif'
     */
    public function getStatusAktifAttribute()
    {
        return $this->status === 'T' ? 'Tidak Aktif' : 'Aktif';
    }

    // Relasi dengan SiapKelas
    public function siapKelas()
    {
        return $this->hasMany(SiapKelas::class, 'id_thn_ak', 'id_thn_ak');
    }
}
