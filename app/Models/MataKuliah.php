<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class MataKuliah extends Model
{
    protected $table = 'siap_mk';
    protected $primaryKey = 'id_mk';
    public $incrementing = true;
    protected $keyType = 'int';
    public $timestamps = false;

    protected $fillable = [
        'kode_mk',
        'tp',
        'nama_mk',
        'nama_alias',
        'id_prodi',
        'smt',
        'sks',
        'jam',
        'id_kelompok_mk',
        'id_thn_ak_aktif',
        'id_thn_ak_pasif',
        'ket',
        'id_mk_wajib',
        'id_mk_lama',
        'sks_tatap_muka',
        'sks_praktikum',
        'sks_praktik_lapangan',
        'sks_simulasi',
        'ket_rps',
        'id_jenis_mk',
        'status_rps',
        'id_jenis_evaluasi',
    ];

    /**
     * Relasi ke model Prodi
     */
    public function prodi()
    {
        return $this->belongsTo(Prodi::class, 'id_prodi', 'id_prodi');
    }

    /**
     * Relasi ke model TahunAkademik
     */
    public function tahunAkademikAktif()
    {
        return $this->belongsTo(TahunAkademik::class, 'id_thn_ak_aktif', 'id_thn_ak');
    }
}
