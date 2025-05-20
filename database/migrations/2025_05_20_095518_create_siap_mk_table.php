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
            $table->smallInteger('id_mk')->primary();
            $table->string('kode_mk', 15)->nullable();
            $table->string('nama_mk', 100)->nullable();
            $table->tinyInteger('sks')->nullable();
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
