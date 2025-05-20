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
        Schema::create('siap_kurikulum', function (Blueprint $table) {
            $table->integer('id_kurikulum')->primary();
            $table->smallInteger('id_mk')->nullable()->index('fk_reference_1');
            $table->char('id_thn_ak', 5)->nullable()->index('fk_reference_18');
            $table->tinyInteger('id_prodi')->nullable()->index('fk_reference_17');
            $table->tinyInteger('smt')->nullable();
            $table->string('ket')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('siap_kurikulum');
    }
};
