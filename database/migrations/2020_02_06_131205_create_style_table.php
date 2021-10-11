<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateStyleTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('style', function (Blueprint $table) {
            $table->engine = 'InnoDB';
            $table->bigIncrements('id');
            $table->unsignedBigInteger('product_id');
            $table->foreign('product_id')->references('id')->on('product')->onDelete('restrict');
            $table->unsignedBigInteger('uom_id');
            $table->foreign('uom_id')->references('id')->on('uom')->onDelete('restrict');
            $table->unsignedBigInteger('upload_id')->nullable();
            $table->foreign('upload_id')->references('id')->on('uploads')->onDelete('restrict');
            $table->string("sku");
            $table->double("weight", null, 5);
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
        Schema::dropIfExists('style');
    }
}
