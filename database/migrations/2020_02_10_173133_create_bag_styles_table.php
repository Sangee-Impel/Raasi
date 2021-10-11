<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateBagStylesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('bag_styles', function (Blueprint $table) {
            $table->engine = 'InnoDB';
            $table->bigIncrements('id');
            $table->unsignedBigInteger('bag_id');
            $table->foreign('bag_id')->references('id')->on('bag')->onDelete('restrict');
            $table->unsignedBigInteger('style_id');
            $table->foreign('style_id')->references('id')->on('style')->onDelete('restrict');
            $table->unsignedBigInteger('upload_id')->nullable();
            $table->foreign('upload_id')->references('id')->on('uploads')->onDelete('restrict');
            $table->double("quantity", null, 5);
            $table->double("weight", null, 5);
            $table->longText("instructions")->nullable();
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
        Schema::dropIfExists('bag_styles');
    }
}
