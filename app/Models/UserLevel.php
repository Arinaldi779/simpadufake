<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class UserLevel extends Model
{
    // Nama tabel (opsional jika sesuai konvensi)
    protected $table = 'user_level';

    // Primary key (jika bukan 'id')
    protected $primaryKey = 'id_level';

    // Menandakan bahwa primary key bukan bertipe increment biasa
    public $incrementing = true;

    // Tipe primary key (karena tinyIncrements berarti integer)
    protected $keyType = 'int';

    // Tidak menggunakan timestamps (created_at, updated_at)
    public $timestamps = false;

    // Kolom yang boleh diisi (mass assignment)
    protected $fillable = ['nama_level'];

    // Relasi dengan model User
    public function users()
    {
        return $this->hasMany(User::class, 'level', 'id_level');
    }
}
