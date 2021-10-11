<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddAdminApprovalLossWeightToTransactionItemLossDetailsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('transaction_item_loss_details', function (Blueprint $table) {
            $table->double("admin_approval_loss_weight", null, 4)->default(0);
            $table->integer("status")->default(0)->comment("0-approved,1-waiting for admin approval");
            $table->date("approval_date")->nullable();
            $table->unsignedInteger('admin_id')->unsigned()->index()->comment("approved or rejected user")->nullable();
            $table->foreign('admin_id')->references('id')->on('users')->onDelete('restrict');
            $table->integer("reason_type_id")->default(0)->comment("0-,1-,2-,3-others");
            $table->longText("loss_description")->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('transaction_item_loss_details', function (Blueprint $table) {
            //
        });
    }
}
