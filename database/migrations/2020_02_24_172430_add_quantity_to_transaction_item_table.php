<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddQuantityToTransactionItemTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('transaction_item', function (Blueprint $table) {

            $table->unsignedBigInteger('other_accessories_id')->nullable();
            $table->foreign('other_accessories_id')->references('id')->on('other_accessories')->onDelete('restrict');
            $table->unsignedBigInteger('uom_id');
            $table->foreign('uom_id')->references('id')->on('uom')->onDelete('restrict');
            $table->double("quantity", null, 5);
            $table->double("weight", null, 5);
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
