<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Transaction;
use App\User;
use Illuminate\Http\Request;
use App\GenXCommon\XModel;
use Illuminate\Support\Facades\DB;

class MergeReportController extends Controller
{
  /**
   * Getting grid data
   *
   */

  public function getIndex()
  {
    self::hasPermission('index.mergereport');
    return view("merge_report.index");
  }
  /**
   * Display a listing of the resource.
   *
   * @return \Illuminate\Http\Response
   */
  public function index(Request $request)
  {
    self::hasPermission('index.mergereport');

    $query = Transaction::query()->select(
      "transaction.*",
      "from_bag.bag_number as from_bag",
      "to_bag.bag_number as to_bag",
      "department.name as department",
      "employee.name as employee",
      DB::raw("DATE_FORMAT(transaction.updated_at, '%d/%c/%Y %r') as time"),
      DB::raw("(select GROUP_CONCAT(distinct(s.sku)) from style s left join bag_styles bs on bs.bag_id = `to_bag`.`id` where bs.style_id = s.id) as sku")
    );

    $query->leftJoin('bag as from_bag', 'from_bag.id', '=', 'transaction.bag_id');

    $query->leftJoin('bag as to_bag', 'to_bag.id', '=', 'transaction.to_bag_id');

    $query->leftJoin('bag_styles', 'bag_styles.bag_id', '=', 'to_bag.id');
    $query->leftJoin('style', 'bag_styles.style_id', '=', 'style.id');

    $query->leftJoin('department', 'department.id', '=', 'transaction.to_department_id');
    $query->leftJoin('employee', 'employee.id', '=', 'transaction.to_employee_id');

    $query->where("transaction.transaction_mode", 2);
    $query->orderBy('transaction.id', 'DESC');
    return XModel::preparePagination($query, $request, ['bag.bag_number', 'bag.order_number']);
  }
}
