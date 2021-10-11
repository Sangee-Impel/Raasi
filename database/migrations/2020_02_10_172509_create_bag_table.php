<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateBagTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('bag', function (Blueprint $table) {
            $table->engine = 'InnoDB';
            $table->bigIncrements('id');
            $table->unsignedBigInteger('parent_bag_id')->nullable();
            $table->foreign('parent_bag_id')->references('id')->on('bag')->onDelete('restrict');
            $table->string("bag_number");
            $table->string("order_number");
            $table->longText("instructions")->nullable();
            $table->integer("status")->default(0)->comment("0=>in progress,1=>completed,2=>splitted");
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
        Schema::dropIfExists('bag');
    }
}
