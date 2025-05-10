<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\TahunAkademik;

class SiapKurikulum extends Model
{
    // Nama tabel
    protected $table = 'siap_kurikulum';

    // Primary key
    protected $primaryKey = 'id_kurikulum';

    // Primary key bertipe integer auto-increment (default)
    public $incrementing = true;
    protected $keyType = 'int';

    // Tidak menggunakan timestamps
    public $timestamps = false;

    // Kolom yang bisa diisi
    protected $fillable = [
        'id_mk',
        'id_thn_ak',
        'ket',
    ];

    /**
     * Relasi ke tahun akademik
     */
    public function tahunAkademik()
    {
        return $this->belongsTo(TahunAkademik::class, 'id_thn_ak', 'id_thn_ak');
    }

    /**
     * Relasi ke mata kuliah (asumsi modelnya bernama MataKuliah)
     */
    public function mataKuliah()
    {
        return $this->belongsTo(MataKuliah::class, 'id_mk', 'id_mk');
    }
}
