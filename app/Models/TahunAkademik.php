<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TahunAkademik extends Model
{
    protected $table = 'siap_thn_ak';
    protected $primaryKey = 'id_thn_ak';
    public $incrementing = false; // karena primary key-nya bertipe char
    protected $keyType = 'string'; // untuk mendukung tipe char
    public $timestamps = false; // jika tidak ada kolom created_at dan updated_at

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


    // Tambahkan 'status_aktif' ke output saat model diubah jadi array atau JSON
    protected $appends = ['status_aktif'];

    /**
     * Accessor untuk mengubah nilai kolom 'aktif' menjadi teks
     * - 't' => 'Aktif'
     * - selain itu => 'Tidak Aktif'
     */
    public function getStatusAktifAttribute()
    {
        return $this->aktif === 'T' ? 'Tidak Aktif' : 'Aktif';
    }

    // Relasi dengan SiapKelas
    public function siapKelas()
    {
        return $this->hasMany(SiapKelas::class, 'id_thn_ak', 'id_thn_ak');
    }
}
