<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class KelompokMK extends Model
{
    protected $table = 'siap_mk_kelompok';
    protected $primaryKey = 'id_kelompok_mk';
    public $incrementing = false;
    protected $keyType = 'string';
    public $timestamps = false;

    protected $fillable = [
        'id_kelompok_mk',
        'nama_kelompok',
        'aktif',
    ];

    /**
     * Relasi ke MataKuliah
     */
    public function mataKuliahs()
    {
        return $this->hasMany(MataKuliah::class, 'id_kelompok_mk', 'id_kelompok_mk');
    }
}
