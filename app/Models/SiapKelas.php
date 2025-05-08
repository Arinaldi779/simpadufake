<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SiapKelas extends Model
{
    use HasFactory;

    protected $table = 'siap_kelas';

    protected $primaryKey = 'id_kelas';

    protected $fillable = [
        'id_thn_ak',
        'id_prodi',
        'smt',
        'nama_kelas',
        'alias',
        'id_program_kelas',
        'ket',
        'kelas_merdeka',
    ];

    // Relasi dengan TahunAkademik
    public function tahunAkademik()
    {
        return $this->belongsTo(TahunAkademik::class, 'id_thn_ak', 'id_thn_ak');
    }

    // Relasi dengan Program Kelas
    public function programKelas()
    {
        return $this->belongsTo(SiapProgramKelas::class, 'id_program_kelas', 'id_program_kelas');
    }

    // Relasi dengan Prodi
    public function prodi()
    {
        return $this->belongsTo(Prodi::class, 'id_prodi', 'id_prodi');
    }
}
