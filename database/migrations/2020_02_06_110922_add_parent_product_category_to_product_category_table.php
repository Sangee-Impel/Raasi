<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddParentProductCategoryToProductCategoryTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('product_category', function (Blueprint $table) {
            $table->unsignedBigInteger('parent_product_category_id')->nullable();
            $table->foreign('parent_product_category_id')->references('id')->on('product_category')->onDelete('restrict');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('product_category', function (Blueprint $table) {
            //
        });
    }
}
