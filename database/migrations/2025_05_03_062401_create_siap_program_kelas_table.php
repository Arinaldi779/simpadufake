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
        Schema::create('siap_program_kelas', function (Blueprint $table) {
            $table->char('id_program_kelas', 2)->primary();
            $table->string('nama_program_kelas');
            $table->enum('aktif', ['Y', 'N'])->default('N');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('siap_program_kelas');
    }
};
