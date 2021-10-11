<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddTypeToTransactionTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('transaction', function (Blueprint $table) {
            $table->integer("transaction_mode")->default(0)->comment("0-normal,1-splitted,2-merge");
            $table->unsignedBigInteger('to_bag_id')->nullable()->comment("used for split and merge");
            $table->foreign('to_bag_id')->references('id')->on('bag')->onDelete('restrict');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('transaction', function (Blueprint $table) {
            //
        });
    }
}
