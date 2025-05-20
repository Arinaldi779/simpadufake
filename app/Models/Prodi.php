<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Prodi extends Model
{
    // Nama tabel
    protected $table = 'kol_prodi';

    // Primary key
    protected $primaryKey = 'id_prodi';

    // Tidak auto-increment karena tipe primary key adalah tinyInteger dan tidak dideklarasikan auto-increment
    public $incrementing = false;

    // Tipe primary key
    protected $keyType = 'int';

    // Tidak menggunakan timestamps
    public $timestamps = false;

    // Kolom yang bisa diisi
    protected $fillable = [
        'id_prodi',
        'kode_prodi',
        'nama_prodi',
    ];
}
