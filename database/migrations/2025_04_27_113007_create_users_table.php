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
        Schema::create('users', function (Blueprint $table) {
            $table->integer('id_user', true);
            $table->smallInteger('level');
            $table->char('username', 35)->unique('username');
            $table->string('password', 100)->nullable();
            $table->string('nama_lengkap', 100)->nullable();
            $table->string('email', 100)->nullable();
            $table->string('no_telp', 100)->nullable();
            $table->rememberToken(); // <-- Ini yang baru untuk Remember Me
            $table->timestamps();    // <-- Ini untuk created_at & updated_at
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('users');
    }
};
