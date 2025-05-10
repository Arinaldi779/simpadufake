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
            $table->integer('id_kurikulum', true);
            $table->smallInteger('id_mk')->index('id_mk');
            $table->char('id_thn_ak', 5)->index('id_thn_ak');
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
