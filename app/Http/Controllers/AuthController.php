<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Auth;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;

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
}
