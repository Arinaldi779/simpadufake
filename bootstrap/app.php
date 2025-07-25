<?php

use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;
use Laravel\Sanctum\Http\Middleware\EnsureFrontendRequestsAreStateful;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__ . '/../routes/web.php',
        api: __DIR__ . '/../routes/api.php',
        commands: __DIR__ . '/../routes/console.php',
        health: '/up',
    )
    ->withMiddleware(function (Middleware $middleware) {
        $middleware->group(
            'api',
            [
                'throttle:api',
                \Illuminate\Routing\Middleware\SubstituteBindings::class,
                \App\Http\Middleware\BlockIp::class, // Middleware untuk memblokir IP tertentu
            ]
        );
        $middleware->alias([
            'roleAccess' => App\Http\Middleware\RoleAccess::class,
            'auth.jwt' => \App\Http\Middleware\JwtSessionAuth::class,
        ]);
    })
    ->withExceptions(function (Exceptions $exceptions) {
        $exceptions->render(function (Illuminate\Auth\AuthenticationException $e, Illuminate\Http\Request $request) {
            if ($request->expectsJson()) {
                return response()->json([
                    'message' => 'Unauthenticated.'
                ], 401);
            }

            // Jika bukan request JSON (artinya dari web biasa), redirect ke login
            return redirect()->guest(route('login'));
        });
    })->create();
