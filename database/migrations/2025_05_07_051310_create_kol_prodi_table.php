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
        Schema::create('kol_prodi', function (Blueprint $table) {
            $table->tinyInteger('id_prodi')->default(0)->primary();
            $table->string('kode_prodi', 11);
            $table->char('id_prodi_bppp', 6)->default('');
            $table->tinyInteger('id_jurusan');
            $table->string('nama_prodi', 100);
            $table->string('nama_konsentrasi', 100);
            $table->string('bidang', 100);
            $table->string('singkatan', 100);
            $table->smallInteger('id_kaprodi');
            $table->string('jenjang', 5);
            $table->string('akreditasi', 100)->nullable();
            $table->string('no_sk_dikti', 100)->nullable();
            $table->date('tgl_sk_dikti')->nullable();
            $table->string('no_sk_ban', 100)->nullable();
            $table->date('tgl_sk_ban')->nullable();
            $table->date('kadaluarsa_akreditasi');
            $table->enum('aktif', ['Y', 'T']);
            $table->tinyInteger('no');
            $table->text('visi');
            $table->text('misi');
            $table->char('prefix', 3)->default('');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('kol_prodi');
    }
};
