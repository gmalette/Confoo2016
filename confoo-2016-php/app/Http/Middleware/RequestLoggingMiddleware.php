<?php

namespace App\Http\Middleware;

use Closure;

class RequestLoggingMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
        \Log::info(
            sprintf(
                "\n\n[Request] Started to %s routed to %s",
                $request->path(),
                $request->route()->getAction()['controller']
            )
        );
        $before = microtime(true);
        $response = $next($request);
        $after = microtime(true);
        \Log::info(
            sprintf(
                "[Request] Responded %d in %dms",
                $response->status(),
                ($after - $before) * 1000
            )
        );
        return $response;
    }
}
