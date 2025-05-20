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
            $table->tinyInteger('id_prodi')->primary();
            $table->string('kode_prodi', 11)->nullable();
            $table->string('nama_prodi', 100)->nullable();
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
