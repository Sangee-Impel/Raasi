<?php

namespace App\Console\Commands;

use App\GenXCommon\XModel;

use Carbon\Carbon;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Config;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class CheckActivity extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'check:activity';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Activity Cron';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return mixed
     */
    public function handle()
    {


        Log::channel('cache_log')->info("Cron Runned Successfully");
    }
   
}
