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
        Schema::create('siap_presensi_mhs', function (Blueprint $table) {
            $table->integer('id_presensi_dosen')->nullable()->index('fk_reference_11');
            $table->bigInteger('id_kelas_master')->nullable()->index('fk_reference_12');
            $table->time('waktu_presensi')->nullable();
            $table->char('status_presensi_mhs', 1)->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('siap_presensi_mhs');
    }
};
