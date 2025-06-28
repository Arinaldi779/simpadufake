<?php

namespace App\Http\Middleware;

use Closure;
use Tymon\JWTAuth\Facades\JWTAuth;
use Illuminate\Support\Facades\Auth;
use Tymon\JWTAuth\Exceptions\JWTException;

class JwtSessionAuth
{
    public function handle($request, Closure $next)
    {
        if (! session('jwt_token')) {
            return redirect()->route('login');
        }

        try {
            JWTAuth::setToken(session('jwt_token'));
            $user = JWTAuth::authenticate();
            Auth::login($user);
        } catch (JWTException $e) {
            return redirect()->route('login');
        }

        return $next($request);
    }
}
