<?php

namespace App\Providers;

use App\Models\PersonalAccessToken;
use Illuminate\Routing\UrlGenerator;
use Illuminate\Support\ServiceProvider;
use Laravel\Sanctum\Sanctum;

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
    public function boot(UrlGenerator $url): void
    {
        //
        Sanctum::usePersonalAccessTokenModel(PersonalAccessToken::class);
       if (env('APP_ENV') == 'production') {
            $url->forceScheme('https');
        }
    }
}
