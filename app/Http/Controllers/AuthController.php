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

        $credentials = $request->only('email_or_nip', 'password');

        // dd($request->all());

        $user = User::where('email', $credentials['email_or_nip'])
            ->orWhere('username', $credentials['email_or_nip']) // Misal NIK disimpan di kolom username
            ->first();

        // dd($user);

        if ($user && Hash::check($credentials['password'], $user->password)) {
            Auth::login($user, $request->filled('remember'));
            // dd('LOGIN SUKSES', Auth::user());
            return redirect()->route('akademik');
        }

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
