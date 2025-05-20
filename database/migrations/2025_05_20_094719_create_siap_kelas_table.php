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
            $table->integer('id_kelas')->primary();
            $table->char('id_thn_ak', 5)->nullable()->index('fk_reference_16');
            $table->tinyInteger('id_prodi')->nullable()->index('fk_reference_19');
            $table->string('nama_kelas', 50)->nullable();
            $table->string('alias', 5)->nullable();
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
