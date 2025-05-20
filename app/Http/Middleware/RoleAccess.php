<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Symfony\Component\HttpFoundation\Response;
use App\Models\UserLevel;
use App\Models\User;

class RoleAccess
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next, ...$roles): Response
    {
        $user = Auth::user();

        // Pastikan user sudah login dan memiliki relasi userLevel
        if (!$user || !$user->userLevel) {
            return redirect()->route('login')->with('error', 'Silakan login terlebih dahulu.');
        }

        $userRole = $user->userLevel->nama_level;

        // Jika peran pengguna tidak ada dalam daftar peran yang diizinkan
        if (!in_array($userRole, $roles)) {

            switch ($userRole) {
                case 'Admin Prodi':
                    return redirect()->route('prodi')->with('error', 'Anda tidak memiliki akses ke halaman tersebut.');
                case 'Admin Akademik':
                    return redirect()->route('akademik')->with('error', 'Anda tidak memiliki akses ke halaman tersebut.');
                case 'Super Admin':
                    return redirect()->route('akademik')->with('error', 'Anda tidak memiliki akses ke halaman tersebut.');
                default:
                    return redirect()->route('login')->with('error', 'Role tidak dikenali.');
            }
        }

        return $next($request);
    }
}
