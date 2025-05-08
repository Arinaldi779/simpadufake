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
        Schema::create('siap_mk_kelompok', function (Blueprint $table) {
            $table->char('id_kelompok_mk', 2);
            $table->string('nama_kelompok', 30);
            $table->enum('aktif', ['Y', 'N'])->default('Y');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('siap_mk_kelompok');
    }
};
