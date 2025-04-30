<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use App\Models\User;
use Illuminate\Http\Request;

class ApiAuthController extends Controller
{
    // API Login
    public function login(Request $request)
    {
        $request->validate([
            'email_or_nip' => 'required',
            'password' => 'required',
        ]);

        $credentials = $request->only('email_or_nip', 'password');

        $user = User::where('email', $credentials['email_or_nip'])
            ->orWhere('username', $credentials['email_or_nip'])
            ->first();

        if (!$user || !Hash::check($credentials['password'], $user->password)) {
            return response()->json([
                'success' => false,
                'message' => 'Username atau Password salah.'
            ], 401); // 401 = Unauthorized
        }

        Auth::login($user);

        // Generate token API (opsional, kalau mau pakai sanctum atau passport)
        // $token = $user->createToken('API Token')->plainTextToken;

        return response()->json([
            'success' => true,
            'message' => 'Login berhasil.',
            'user' => $user,
            // 'token' => $token // kalau pakai sanctum/passport
        ]);
    }

    // API Logout
    public function logout(Request $request)
    {
        Auth::logout();

        $request->session()->invalidate();
        $request->session()->regenerateToken();

        return response()->json([
            'success' => true,
            'message' => 'Logout berhasil.'
        ]);
    }
}
