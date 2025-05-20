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

        $rolename = UserLevel::find(Auth::user()->level)->nama_level;

        // Cek apakah pengguna sudah login
        if (!Auth::check() || !in_array($rolename, $roles)) {
            // Jika pengguna belum login atau tidak memiliki akses, redirect ke halaman login
            return back()->with('error', 'Anda tidak memiliki akses ke halaman ini.');
        }
        return $next($request);
    }
}
