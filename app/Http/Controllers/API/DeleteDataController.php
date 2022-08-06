<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\CastingWeight;
use App\Models\Bag;
use App\Models\BagStyle;
use App\Models\Transaction;
use App\Models\TransactionItem;
use App\Models\TransactionItemLossDetails;
use Exception;
use Illuminate\Support\Facades\DB;

class DeleteDataController extends Controller
{
    public function getIndex()
    {
        self::hasPermission('index.deletedata');
        return view("delete_data.index");
    }

    public function store(Request $request)
    {
        try {
            DB::statement('SET FOREIGN_KEY_CHECKS=0;');
            DB::table('bag')->truncate();
            DB::table('bag_styles')->truncate();
            DB::table('casting_weights')->truncate();
            DB::table('transaction')->truncate();
            DB::table('transaction_item')->truncate();
            DB::table('transaction_item_loss_details')->truncate();
            DB::statement('SET FOREIGN_KEY_CHECKS=1;');
        } catch (Exception $ex) {
            print_r($ex);
            exit;
        }
    }
}
