<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateTransactionItemLossDetailsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('transaction_item_loss_details', function (Blueprint $table) {
            $table->engine = 'InnoDB';
            $table->bigIncrements('id');
            $table->date('date');
            $table->unsignedBigInteger('transaction_item_id');
            $table->foreign('transaction_item_id')->references('id')->on('transaction_item')->onDelete('restrict');
            $table->unsignedBigInteger('transaction_id');
            $table->foreign('transaction_id')->references('id')->on('transaction')->onDelete('restrict');
            $table->double('weight', null, 5)->default(0);
            $table->unsignedInteger('user_id')->index()->nullable();
            $table->foreign('user_id')->references('id')->on('users')->onDelete('restrict');
            $table->integer('type')->default(0)->comment("0-loss,1-scrap");

            $table->softDeletes();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('transaction_item_loss_details');
    }
}
