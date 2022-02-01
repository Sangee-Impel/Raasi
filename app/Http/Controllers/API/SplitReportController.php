<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Transaction;
use App\User;
use Illuminate\Http\Request;
use App\GenXCommon\XModel;
use Illuminate\Support\Facades\DB;

class SplitReportController extends Controller
{
  /**
   * Getting grid data
   *
   */

  public function getIndex()
  {
    self::hasPermission('index.splitreport');
    return view("split_report.index");
  }
  /**
   * Display a listing of the resource.
   *
   * @return \Illuminate\Http\Response
   */
  public function index(Request $request)
  {
    self::hasPermission('index.splitreport');

    $query = Transaction::query()->select(
      "transaction.*",
      DB::raw("(select bag_number from bag b1 where b1.id = bag.parent_bag_id) as from_bag"),
      "bag.bag_number as to_bag",
      //DB::raw("(select bag_number from bag b2 where b2.id = transaction.bag_id LIMIT 1) as to_bag"),
      // "from_bag.bag_number as from_bag",
      "department.name as department",
      "employee.name as employee",
      DB::raw("DATE_FORMAT(transaction.updated_at, '%d/%c/%Y %r') as time"),
      DB::raw("(select GROUP_CONCAT(distinct(s.sku)) from style s left join bag_styles bs on bs.bag_id = transaction.bag_id where bs.style_id = s.id) as sku")
    );

    $query->leftJoin('bag', 'bag.id', '=', 'transaction.bag_id');
    //$query->leftJoin('bag as from_bag', 'from_bag.id', '=', 'bag.parent_bag_id');

    //$query->leftJoin('bag_styles', 'bag_styles.bag_id', '=', 'transaction.bag_id');
    //$query->leftJoin('style', 'bag_styles.style_id', '=', 'style.id');

    $query->leftJoin('department', 'department.id', '=', 'transaction.to_department_id');
    $query->leftJoin('employee', 'employee.id', '=', 'transaction.to_employee_id');

    $query->where("transaction.transaction_mode", 1);
    $query->orderBy('transaction.bag_id', 'ASC');
    return XModel::preparePagination($query, $request, ['bag.bag_number', 'bag.order_number']);
  }
}
