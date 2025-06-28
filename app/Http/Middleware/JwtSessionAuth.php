<?php

namespace App\Http\Middleware;

use Closure;
use Tymon\JWTAuth\Facades\JWTAuth;
use Illuminate\Support\Facades\Auth;
use Tymon\JWTAuth\Exceptions\JWTException;
use Tymon\JWTAuth\Exceptions\TokenExpiredException;
use Tymon\JWTAuth\Exceptions\TokenInvalidException;

class JwtSessionAuth
{
    public function handle($request, Closure $next)
    {
        $token = session('jwt_token');

        if (! $token) {
            return redirect()->route('login')->with('error', 'Silakan login terlebih dahulu.');
        }

        try {
            JWTAuth::setToken($token);
            $user = JWTAuth::authenticate();

            if (! $user) {
                return redirect()->route('login')->with('error', 'User tidak ditemukan.');
            }

            // Pastikan login ke guard `web`
            Auth::guard('web')->login($user);
        } catch (TokenExpiredException $e) {
            return redirect()->route('login')->with('error', 'Token sudah kedaluwarsa.');
        } catch (TokenInvalidException $e) {
            return redirect()->route('login')->with('error', 'Token tidak valid.');
        } catch (JWTException $e) {
            return redirect()->route('login')->with('error', 'Token tidak ditemukan atau error.');
        }

        return $next($request);
    }
}
