<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class BlockIp
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        $blockedIps = ['111.111.111.111', '123.123.123.123']; // IP bot
        if (in_array($request->ip(), $blockedIps)) {
            abort(403, 'Akses Diblokir.');
        }
        return $next($request);
    }
}
