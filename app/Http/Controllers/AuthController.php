<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Auth;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;
use Tymon\JWTAuth\Facades\JWTAuth;

use Illuminate\Http\Request;

class AuthController extends Controller
{
    public function login(Request $request)
    {
        $request->validate([
            'login' => 'required',
            'password' => 'required',
        ]);

        // dd($request->all());

        $credentials = $request->only('login', 'password');

        // Coba cari user berdasarkan email atau username
        $userCek = User::where(function ($query) use ($credentials) {
            $query->where('nip', $credentials['login'])
                ->orWhere('nim', $credentials['login'])
                ->orWhere('email', $credentials['login']);
        })->first();

        // dd(Hash::make($request->password));

        $auth = $userCek && Hash::check($credentials['password'], $userCek->password);

        // dd($auth);

        // Cek jika user ditemukan dan password cocok
        if ($auth == true) {

            // Buat token JWT
            $token = JWTAuth::fromUser($userCek);

            // Simpan ke session (agar bisa digunakan oleh middleware `auth.jwt`)
            session(['jwt_token' => $token]);

            Auth::login($userCek, $request->filled('remember'));

            $role = $userCek->userLevel->nama_level;

            // redirect berdasarkan role
            return match ($role) {
                'Admin Prodi' => redirect()->route('prodi'), // Arahkan ke halaman dashboard
                'Admin Akademik' => redirect()->route('akademik'), // Arahkan ke halaman dashboard
                'Super Admin' => redirect()->route('akademik'), // Arahkan ke halaman dashboard
                default => redirect()->route('login')->with('error', 'Role tidak dikenali.'),
            };
        }

        // dd($auth);

        return back()->withErrors([
            'login' => 'Username/Password Tidak Sesuai.',
        ])->onlyInput('login');
    }

    // Logout
    public function logout(Request $request)
    {
        Auth::logout();

        $request->session()->invalidate();
        $request->session()->regenerateToken();

        return redirect()->route('login'); // Arahkan balik ke halaman login
    }

    // Create User
    public function createUser(Request $request)
    {
        $validateData = $request->validate([
            'nip' => 'required|string|max:255',
            'level' => 'required|exists:user_level,id_level',
            'email' => 'nullable|email|max:255',
            'no_telp' => 'nullable|string|max:15',
            'password' => 'required|string',
        ]);

        // Cek apakah user dengan NIP sudah ada
        $existingUser = User::where('nip', $validateData['nip'])->first();
        if ($existingUser) {
            return redirect()->back()->withErrors(['nip' => 'NIP sudah terdaftar.']);
        }

        // Buat user baru
        $user = User::create([
            'nip' => $validateData['nip'],
            'level' => $validateData['level'],
            'email' => $validateData['email'],
            'no_telp' => $validateData['no_telp'],
            'password' => $validateData['password'],
        ]);

        if ($user) {
            Log::info('User created successfully: ' . $user->nip);
            return redirect()->route('login')->with('success', 'User Berhasil dibuat.');
        } else {
            Log::error('Failed to create user: ' . $validateData['nip']);
            return redirect()->back()->withErrors(['error' => 'Failed to create user.']);
        }
    }
}
