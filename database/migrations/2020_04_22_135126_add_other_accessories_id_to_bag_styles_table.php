<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddOtherAccessoriesIdToBagStylesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('bag_styles', function (Blueprint $table) {
            $table->unsignedBigInteger('style_id')->nullable()->change();
           // $table->foreign('style_id')->references('id')->on('style')->onDelete('restrict');
            $table->unsignedBigInteger('other_accessories_id')->nullable();
            $table->foreign('other_accessories_id')->references('id')->on('other_accessories')->onDelete('restrict');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('bag_styles', function (Blueprint $table) {
            //
        });
    }
}
