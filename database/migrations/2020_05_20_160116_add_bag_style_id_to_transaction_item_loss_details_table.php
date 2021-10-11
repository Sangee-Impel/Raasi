<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddBagStyleIdToTransactionItemLossDetailsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('transaction_item_loss_details', function (Blueprint $table) {
            $table->unsignedBigInteger('bag_style_id')->nullable();
            $table->foreign('bag_style_id')->references('id')->on('bag_styles')->onDelete('restrict');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('transaction_item_loss_details', function (Blueprint $table) {
            //
        });
    }
}
