<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class MataKuliah extends Model
{
    // Nama tabel
    protected $table = 'siap_mk';

    // Primary key
    protected $primaryKey = 'id_mk';

    // Tidak auto-increment karena tidak didefinisikan sebagai auto-increment
    public $incrementing = false;

    // Tipe primary key
    protected $keyType = 'int';

    // Tidak menggunakan timestamps
    public $timestamps = false;

    // Kolom yang bisa diisi (mass assignable)
    protected $fillable = [
        'id_mk',
        'kode_mk',
        'nama_mk',
        'sks',
    ];
}
