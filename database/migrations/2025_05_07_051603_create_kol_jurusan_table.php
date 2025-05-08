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
        Schema::create('kol_jurusan', function (Blueprint $table) {
            $table->tinyInteger('id_jurusan')->default(0)->primary();
            $table->string('nama_jurusan', 100);
            $table->smallInteger('id_kajur');
            $table->smallInteger('id_sekjur');
            $table->text('visi');
            $table->text('misi');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('kol_jurusan');
    }
};
