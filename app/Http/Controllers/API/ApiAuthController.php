<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use App\Models\User;
use Illuminate\Http\Request;
use Laravel\Sanctum\PersonalAccessToken;

class ApiAuthController extends Controller
{
    // API Login
    public function login(Request $request)
    {
        $request->validate([
            'email_or_nip' => 'required',
            'password' => 'required',
        ]);

        // Ambil data dari request
        $login = $request->email_or_nip;
        $password = $request->password;

        // Cari user berdasarkan email atau username
        $user = User::where('email', $login)
            ->orWhere('username', $login)
            ->first();

        // Cek apakah user ditemukan dan password cocok
        if (!$user && !Hash::check($password, $user->password)) {
            Auth::login($user); // Jika tidak perlu session API, ini bisa diabaikan

            // Jika menggunakan Sanctum atau Passport, bisa generate token di sini:
            // $token = $user->createToken('API Token')->plainTextToken;

            return response()->json([
                'success' => false,
                'message' => 'Username atau Password salah.'
            ], 401); // 401 Unauthorized

        }

        // Login menggunakan Sanctum untuk menghasilkan token
        $token = $user->createToken('API Token')->plainTextToken;

        // Jika gagal login
        return response()->json([
            'success' => true,
            'message' => 'Login berhasil.',
            'token' => $token,  // Kembalikan token API
            'user' => [
                'id_user' => $user->id_user,
                'nama_lengkap' => $user->nama_lengkap,
                'email' => $user->email,
                'role' => $user->userLevel->nama_level, // atau level jika pakai itu
                // 'token' => $token, // jika pakai Sanctum
            ]
        ]);
    }


    // API Logout

    public function logout(Request $request)
    {
        $accessToken = $request->bearerToken();

        if ($accessToken) {
            $token = PersonalAccessToken::findToken($accessToken);
            if ($token) {
                $token->delete();
            }
        }

        return response()->json([
            'success' => true,
            'message' => 'Logout berhasil.'
        ]);
    }
}
