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
      "tobag.bag_number as from_bag",
      "frombag.bag_number as to_bag",
      "department.name as department",
      "employee.name as employee",
      DB::raw("DATE_FORMAT(transaction.updated_at, '%d/%c/%Y %r') as time"),
      DB::raw("(select GROUP_CONCAT(distinct(s.sku)) from style s where style.id = s.id) as sku")
    );

    $query->leftJoin('bag as frombag', 'frombag.id', '=', 'transaction.bag_id');
    $query->leftJoin('bag as tobag', 'tobag.id', '=', 'transaction.to_bag_id');
    $query->leftJoin('bag_styles', 'bag_styles.bag_id', '=', 'tobag.id');
    $query->leftJoin('style', 'bag_styles.style_id', '=', 'style.id');

    $query->leftJoin('department', 'department.id', '=', 'transaction.to_department_id');
    $query->leftJoin('employee', 'employee.id', '=', 'transaction.to_employee_id');

    if ($request->has('advanceFilter')) {
      $params = json_decode($request->get('advanceFilter'), true);
      if (!is_null($params)) {
        foreach ($params  as $column => $value) {
          if (!is_null($value)) {
            switch ($column) {
              case 'from_date':
                $query->where("transaction.updated_at", '>=', $value . ' 00:00:00');
                break;
              case 'to_date':
                $query->where("transaction.updated_at", '<=', $value . ' 23:59:59');
                break;
            }
          }
        }
      }
    }

    $query->where("transaction.transaction_mode", 2);
    $query->orderBy('transaction.id', 'DESC');
    return XModel::preparePagination($query, $request, ['bag.bag_number', 'bag.order_number']);
  }
}
