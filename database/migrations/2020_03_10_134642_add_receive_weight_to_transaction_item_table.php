<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddReceiveWeightToTransactionItemTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('transaction_item', function (Blueprint $table) {
            $table->double('receive_weight', null, 5)->default(0);
            $table->integer('type')->default(0)->comment("0-bag,1-other accessories");
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('transaction_item', function (Blueprint $table) {
            //
        });
    }
}
