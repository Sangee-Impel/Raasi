<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateTransactionItemTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('transaction_item', function (Blueprint $table) {
            $table->engine = 'InnoDB';
            $table->bigIncrements('id');
            
            $table->unsignedBigInteger('transaction_id');
            $table->foreign('transaction_id')->references('id')->on('transaction')->onDelete('restrict');

            $table->unsignedBigInteger('bag_style_id')->nullable();;
            $table->foreign('bag_style_id')->references('id')->on('bag_styles')->onDelete('restrict');
            $table->integer('status')->comment('0-completed,1-hold')->default(0);
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
        Schema::dropIfExists('transaction_item');
    }
}
