<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Jurusan extends Model
{
    protected $table = 'kol_jurusan';
    protected $primaryKey = 'id_jurusan';
    public $incrementing = false;
    protected $keyType = 'int';
    public $timestamps = false;

    protected $fillable = [
        'id_jurusan',
        'nama_jurusan',
        'id_kajur',
        'id_sekjur',
        'visi',
        'misi',
    ];

    /**
     * Relasi dengan model Prodi.
     */
    public function prodis()
    {
        return $this->hasMany(Prodi::class, 'id_jurusan', 'id_jurusan');
    }
}
