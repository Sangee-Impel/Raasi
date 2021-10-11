<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddParentBagStyleIdToBagStylesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('bag_styles', function (Blueprint $table) {
            $table->unsignedBigInteger('parent_bag_style_id')->nullable();
            $table->foreign('parent_bag_style_id')->references('id')->on('bag_styles')->onDelete('restrict');
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
