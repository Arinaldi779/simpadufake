<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SiapProgramKelas extends Model
{
    use HasFactory;

    protected $table = 'siap_program_kelas';

    protected $primaryKey = 'id_program_kelas';

    public $incrementing = false; // karena primary key bertipe char

    protected $keyType = 'string';

    protected $fillable = [
        'id_program_kelas',
        'nama_program_kelas',
        'aktif',
    ];

    // Relasi: satu program kelas bisa punya banyak kelas
    public function siapKelas()
    {
        return $this->hasMany(SiapKelas::class, 'id_program_kelas', 'id_program_kelas');
    }
}
