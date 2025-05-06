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
            'email_or_nip' => 'required',
            'password' => 'required',
        ]);

        // dd($request->all());

        $credentials = $request->only('email_or_nip', 'password');

        // Coba cari user berdasarkan email atau username
        $userCek = User::where('email', $credentials['email_or_nip'])
            ->orWhere('username', $credentials['email_or_nip'])
            ->first();

        // dd(Hash::make($request->password));


        $auth = $userCek && Hash::check($credentials['password'], $userCek->password);

        // Cek jika user ditemukan dan password cocok
        if ($auth == true) {
            Auth::login($userCek, $request->filled('remember'));
            return redirect('/');
        }

        // dd($auth);

        return back()->withErrors([
            'email_or_nip' => 'Username atau Password salah.',
        ])->onlyInput('email_or_nip');
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
