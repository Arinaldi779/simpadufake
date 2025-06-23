<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Dedoc\Scramble\Scramble;
use Dedoc\Scramble\Support\Generator\SecurityRequirement;
use Dedoc\Scramble\Support\Generator\SecurityScheme;





class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        Scramble::routes(function () {
            return [
                'middleware' => ['api'],
            ];
        });

        Scramble::extendOpenApi(function ($openApi) {
            $scheme = new SecurityScheme('http');
            $scheme->scheme = 'bearer';
            $scheme->bearerFormat = 'JWT';

            $openApi->components->securitySchemes['BearerAuth'] = $scheme;
            $openApi->security[] = new SecurityRequirement([
                'BearerAuth' => []
            ]);

            return $openApi;
        });
    }
}
