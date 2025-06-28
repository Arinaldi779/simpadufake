<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Illuminate\Database\Eloquent\Casts\Attribute;
use Tymon\JWTAuth\Contracts\JWTSubject;


class User extends Authenticatable implements JWTSubject
{
    use Notifiable;

    protected $table = 'users'; // karena kita buat tabel users sendiri

    protected $primaryKey = 'id_user'; // primary key kamu bukan 'id' default

    public $timestamps = false; // tabel kamu tidak punya created_at / updated_at

    protected $fillable = [
        'level',
        'password',
        'nip',
        'nim',
        'email',
        'no_telp',
        'id_session',
        'remember_token', // tambah remember token
    ];

    // === JWT Auth ===
    /**
     * Mendapatkan identifier unik untuk JWT.
     * Biasanya ini adalah primary key dari model.
     */
    public function getJWTIdentifier()
    {
        return $this->getKey(); // default: id
    }

    public function getJWTCustomClaims()
    {
        return []; // bisa tambahkan custom claim kalau mau
    }

    /**
     * Auto hash password setiap set.
     */
    protected function password(): Attribute
    {
        return Attribute::make(
            set: fn(string $value) => bcrypt($value),
        );
    }

    /**
     * Relasi ke tabel user_level
     */
    public function userLevel()
    {
        return $this->belongsTo(UserLevel::class, 'level', 'id_level');
    }
}
