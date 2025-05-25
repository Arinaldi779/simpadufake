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
        Schema::create('siap_nilai', function (Blueprint $table) {
            $table->bigInteger('id_nilai')->primary();
            $table->integer('id_kelas_mk')->nullable()->index('fk_reference_15');
            $table->bigInteger('id_kelas_master')->nullable()->index('fk_reference_14');
            $table->tinyInteger('n_angka')->nullable();
            $table->char('n_huruf', 5)->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('siap_nilai');
    }
};
