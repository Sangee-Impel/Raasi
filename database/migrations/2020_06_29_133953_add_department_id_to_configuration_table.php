<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddDepartmentIdToConfigurationTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('configuration', function (Blueprint $table) {
            $table->unsignedBigInteger('bag_starting_department_id')->nullable();
            $table->foreign('bag_starting_department_id')->references('id')->on('department')->onDelete('restrict');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('configuration', function (Blueprint $table) {
            //
        });
    }
}
