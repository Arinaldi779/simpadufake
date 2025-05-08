<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Prodi extends Model
{
    protected $table = 'kol_prodi';
    protected $primaryKey = 'id_prodi';
    public $incrementing = false;
    protected $keyType = 'int';
    public $timestamps = false;

    protected $fillable = [
        'id_prodi',
        'kode_prodi',
        'id_prodi_bppp',
        'id_jurusan',
        'nama_prodi',
        'nama_konsentrasi',
        'bidang',
        'singkatan',
        'id_kaprodi',
        'jenjang',
        'akreditasi',
        'no_sk_dikti',
        'tgl_sk_dikti',
        'no_sk_ban',
        'tgl_sk_ban',
        'kadaluarsa_akreditasi',
        'aktif',
        'no',
        'visi',
        'misi',
        'prefix',
    ];

    /**
     * Relasi dengan model Jurusan.
     */
    public function jurusan()
    {
        return $this->belongsTo(Jurusan::class, 'id_jurusan', 'id_jurusan');
    }
}
