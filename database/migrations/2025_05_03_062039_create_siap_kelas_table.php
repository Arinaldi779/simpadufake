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
        Schema::create('siap_kelas', function (Blueprint $table) {
            $table->integer('id_kelas', true);
            $table->char('id_thn_ak', 5)->index('id_thn_ak');
            $table->tinyInteger('id_prodi')->index('id_prodi');
            $table->tinyInteger('smt');
            $table->string('nama_kelas', 50);
            $table->string('alias', 5)->nullable();
            $table->char('id_program_kelas', 2)->nullable();
            $table->string('ket', 254)->default('');
            $table->char('kelas_merdeka', 1)->default('T');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('siap_kelas');
    }
};
