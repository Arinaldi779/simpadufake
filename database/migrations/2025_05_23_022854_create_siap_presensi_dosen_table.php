<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('siap_presensi_dosen', function (Blueprint $table) {
            $table->integer('id_presensi_dosen', true);
            $table->integer('id_kelas_mk')->nullable()->index('fk_reference_13');
            $table->tinyInteger('pertemuan_ke')->nullable();
            $table->date('tgl_presesi')->nullable();
            $table->time('waktu_presensi')->nullable();
            $table->char('status_presensi_dosen', 1)->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('siap_presensi_dosen');
    }
};
