<?php

namespace App\Providers;

use Log;
use DB;
use Illuminate\Support\ServiceProvider;

class QueryLoggingProvider extends ServiceProvider
{
    /**
     * Bootstrap the application services.
     *
     * @return void
     */
    public function boot()
    {
        DB::listen(function($sql) {
            foreach ($sql->bindings as $i => $binding) {
                if ($binding instanceof \DateTime) {
                    $sql->bindings[$i] = $binding->format('\'Y-m-d H:i:s\'');
                } else {
                    if (is_string($binding)) {
                        $sql->bindings[$i] = "'$binding'";
                    }
                }
            }

            // Insert bindings into query
            $query = str_replace(array('%', '?'), array('%%', '%s'), $sql->sql);

            $query = vsprintf($query, $sql->bindings);
            Log::info("[SQL] " . $query . sprintf(" (%s ms)", $sql->time));
        });
    }

    /**
     * Register the application services.
     *
     * @return void
     */
    public function register()
    {
        //
    }
}
