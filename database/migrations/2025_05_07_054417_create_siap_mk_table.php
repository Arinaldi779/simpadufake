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
        Schema::create('siap_mk', function (Blueprint $table) {
            $table->smallInteger('id_mk', true);
            $table->string('kode_mk', 15)->index('kode_mk');
            $table->char('tp', 2)->default('T');
            $table->string('nama_mk', 100);
            $table->string('nama_alias', 100)->nullable();
            $table->tinyInteger('id_prodi')->index('id_prodi');
            $table->tinyInteger('smt');
            $table->float('sks', 5);
            $table->tinyInteger('jam');
            $table->char('id_kelompok_mk', 2)->nullable();
            $table->char('id_thn_ak_aktif', 5)->nullable();
            $table->char('id_thn_ak_pasif', 5)->nullable();
            $table->string('ket', 200)->nullable();
            $table->boolean('id_mk_wajib')->nullable();
            $table->smallInteger('id_mk_lama')->nullable();
            $table->float('sks_tatap_muka', 5)->nullable();
            $table->float('sks_praktikum', 5)->nullable();
            $table->float('sks_praktik_lapangan', 5)->nullable();
            $table->float('sks_simulasi', 5);
            $table->enum('ket_rps', ['Y', 'T']);
            $table->char('id_jenis_mk', 1)->nullable();
            $table->char('status_rps', 1)->default('0');
            $table->tinyInteger('id_jenis_evaluasi')->default(0);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('siap_mk');
    }
};
