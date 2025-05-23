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
        Schema::create('siap_kelas_mk', function (Blueprint $table) {
            $table->integer('id_kelas_mk');
            $table->integer('id_kelas')->nullable()->index('fk_reference_10');
            $table->integer('id_kurikulum')->nullable()->index('fk_reference_2');
            $table->smallInteger('id_pegawai')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('siap_kelas_mk');
    }
};
