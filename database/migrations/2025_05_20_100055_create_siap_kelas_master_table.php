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
        Schema::create('siap_kelas_master', function (Blueprint $table) {
            $table->bigInteger('id_kelas_master')->primary();
            $table->tinyInteger('no_absen')->nullable();
            $table->integer('id_kelas')->nullable()->index('fk_reference_6');
            $table->string('nim', 15)->nullable();
            $table->char('status', 1)->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('siap_kelas_master');
    }
};
