<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateUploadsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('uploads', function (Blueprint $table) {
            $table->engine='InnoDB';
            $table->BigIncrements('id');
            $table->text('file_name');
            $table->text('file_size');
            $table->string('random_key')->unique();
            $table->index('random_key');
            $table->text('uploaded_path');
            $table->tinyInteger('is_tmp')->default(1);
            $table->integer('user_id')->unsigned();
            $table->index('user_id');
            $table->foreign('user_id')->references('id')->on('users')->onDelete('restrict');
            $table->engine = 'InnoDB';
            $table->nullableTimestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('uploads', function (Blueprint $table) {
            $table->dropForeign('uploads_user_id_foreign');
            $table->dropIndex('uploads_user_id_index');
        });
        Schema::dropIfExists('uploads');
    }
}
