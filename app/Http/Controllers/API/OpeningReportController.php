<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Bag;
use App\Models\BagStyle;
use App\Models\Department;
use App\Models\Employee;
use App\Models\Transaction;
use App\Models\TransactionItem;
use App\Models\TransactionItemLossDetails;
use App\User;
use Illuminate\Http\Request;
use App\GenXCommon\XModel;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Config;
use Illuminate\Support\Facades\DB;

class OpeningReportController extends Controller
{
    /**
     * Getting grid data
     *
     */

    public function getIndex()
    {
        self::hasPermission('index.openingreport');
        return view("opening_report.index");
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        self::hasPermission('index.openingreport');
        $query          =   Bag::query()->select(['bag.*'])->where("bag.department_id", 1);

        $query->with(['bagStyles', 'department', 'employee']);


        return XModel::preparePagination($query, $request, ['bag.bag_number', 'bag.order_number', 'bagStyles.']);
    }

    public function dropDown(Request $request)
    {
        $post_all = $request->all();
        $user = User::query()->select('users.*')->join('employee', 'employee.user_id', '=', 'users.id')->get();
        $result         =   [
            "user"      =>  $user
        ];
        return $result;
    }
}
