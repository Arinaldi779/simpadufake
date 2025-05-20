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
        Schema::create('siap_thn_ak', function (Blueprint $table) {
            $table->char('id_thn_ak', 5)->primary();
            $table->string('nama_thn_ak', 50)->nullable();
            $table->string('smt', 10)->nullable();
            $table->char('status', 1)->nullable();
            $table->date('tgl_awal_kuliah')->nullable();
            $table->date('tgl_akhir_kuliah')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('siap_thn_ak');
    }
};
