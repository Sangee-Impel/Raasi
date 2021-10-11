<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateTransactionTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('transaction', function (Blueprint $table) {
            $table->engine = 'InnoDB';
            $table->bigIncrements('id');
            $table->date('transaction_date');
            $table->unsignedBigInteger('from_department_id')->nullable();
            $table->foreign('from_department_id')->references('id')->on('department')->onDelete('restrict');

            $table->unsignedBigInteger('from_employee_id')->nullable();
            $table->foreign('from_employee_id')->references('id')->on('employee')->onDelete('restrict');

            $table->unsignedBigInteger('to_department_id')->nullable();
            $table->foreign('to_department_id')->references('id')->on('department')->onDelete('restrict');

            $table->unsignedBigInteger('to_employee_id')->nullable();
            $table->foreign('to_employee_id')->references('id')->on('employee')->onDelete('restrict');

            $table->unsignedBigInteger('bag_id');
            $table->foreign('bag_id')->references('id')->on('bag')->onDelete('restrict');
            $table->longText("description")->nullable();
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
        Schema::dropIfExists('transaction');
    }
}
