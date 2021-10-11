<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateStyleDepartmentLossApprovalTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('style_department_loss_approval', function (Blueprint $table) {
            $table->engine = 'InnoDB';
            $table->bigIncrements('id');
            $table->unsignedBigInteger('style_id');
            $table->foreign('style_id')->references('id')->on('style')->onDelete('restrict');
            $table->unsignedBigInteger('department_id');
            $table->foreign('department_id')->references('id')->on('department')->onDelete('restrict');
            $table->double("percentage", null, 2);
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
        Schema::dropIfExists('style_department_loss_approval');
    }
}
