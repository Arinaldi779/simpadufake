<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use App\Models\User;
use Illuminate\Http\Request;
use Laravel\Sanctum\PersonalAccessToken;
use App\Models\SiapKelasMaster; // Jika perlu, sesuaikan dengan model yang digunakan
use App\Models\SiapKelasMK;

class ApiAuthController extends Controller
{
    // API Login
    public function login(Request $request)
    {
        $request->validate([
            'login' => 'required',
            'password' => 'required',
        ]);

        // Ambil data dari request
        $login = $request->login;
        $password = $request->password;

        // Cari user berdasarkan email atau username
        $user = User::where('nip', $login)
            ->orWhere('nim', $login)
            ->orWhere('email', $login)
            ->first();

        // Cek apakah user ditemukan dan password cocok
        if (!$user && !Hash::check($password, $user->password)) {
            Auth::login($user); // Jika tidak perlu session API, ini bisa diabaikan


            return response()->json([
                'success' => false,
                'message' => 'Username atau Password salah.'
            ], 401); // 401 Unauthorized

        }

        // Login menggunakan Sanctum untuk menghasilkan token
        $token = $user->createToken('API Token')->plainTextToken;

        // Data dasar
        $userData = [
            'id_user' => $user->id_user,
            'email' => $user->email,
            'role' => $user->userLevel->nama_level,
        ];

        // Cek tipe user berdasarkan field yang tidak null
        if (!is_null($user->nip)) {
            // User adalah pegawai
            $userData['nip'] = $user->nip;
            $userData['id_kelas_mk'] = SiapKelasMK::where('id_pegawai', $user->id_user)->pluck('id_kelas_mk')->toArray();
        } elseif (!is_null($user->nim)) {
            // User adalah mahasiswa
            $userData['nim'] = $user->nim;
        }

        return response()->json([
            'success' => true,
            'message' => 'Login berhasil.',
            'token' => $token,
            'user' => $userData,
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
