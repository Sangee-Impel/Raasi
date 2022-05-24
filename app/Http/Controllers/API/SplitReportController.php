<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Bag;
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

    $query = Bag::query()->select(
      "bag.*",
      "parent.bag_number as from_bag",
      "bag.bag_number as to_bag",
      "bag.order_number",
      "department.name as department",
      "employee.name as employee",
      DB::raw("IFNULL(sum(bag_styles.weight), 0) as weight"),
      DB::raw("IFNULL(sum(bag_styles.quantity), 0) as quantity"),
      DB::raw("DATE_FORMAT(bag.updated_at, '%d/%c/%Y %r') as time"),
      DB::raw("(select GROUP_CONCAT(distinct(s.sku)) from style s where style.id = s.id) as sku")
    );

    $query->leftJoin('bag as parent', 'parent.id', '=', 'bag.parent_bag_id');
    $query->leftJoin('bag_styles', 'bag_styles.bag_id', '=', 'bag.id');
    $query->leftJoin('style', 'bag_styles.style_id', '=', 'style.id');

    $query->leftJoin('department', 'department.id', '=', 'bag.department_id');
    $query->leftJoin('employee', 'employee.id', '=', 'bag.employee_id');

    if ($request->has('advanceFilter')) {
      $params = json_decode($request->get('advanceFilter'), true);
      if (!is_null($params)) {
        foreach ($params  as $column => $value) {
          if (!is_null($value)) {
            switch ($column) {
              case 'from_date':
                $query->where("bag.created_at", '>=', $value . ' 00:00:00');
                break;
              case 'to_date':
                $query->where("bag.created_at", '<=', $value . ' 23:59:59');
                break;
            }
          }
        }
      }
    }

    $query->whereNotIn("bag.status", array(2, 4, 5));
    $query->where("parent.status", "=", '2');
    $query->where("bag_styles.style_id", "!=", '');
    $query->groupBy('bag.id', 'bag.bag_number', 'bag.order_number');
    $query->orderBy('bag.id', 'ASC');
    return XModel::preparePagination($query, $request, ['parent.bag_number', 'bag.bag_number', 'bag.order_number']);
  }

  public function indexold(Request $request)
  {
    self::hasPermission('index.splitreport');

    $query = Transaction::query()->select(
      "transaction.*",
      DB::raw("(select b1.bag_number from bag b1 where b1.id in (SELECT bs1.bag_id FROM bag_styles bs1 WHERE bs1.id = bag_styles.parent_bag_style_id)) as from_bag"),
      "bag.bag_number as to_bag",
      //DB::raw("(select bag_number from bag b2 where b2.id = transaction.bag_id LIMIT 1) as to_bag"),
      // "from_bag.bag_number as from_bag",
      "department.name as department",
      "employee.name as employee",
      DB::raw("DATE_FORMAT(bag.updated_at, '%d/%c/%Y %r') as time"),
      //DB::raw("(select GROUP_CONCAT(distinct(s.sku)) from style s left join bag_styles bs on bs.bag_id = transaction.bag_id where bs.style_id = s.id) as sku"),
      DB::raw("(select GROUP_CONCAT(distinct(s.sku)) from style s where style.id = s.id) as sku")
    );

    $query->leftJoin('bag', 'bag.id', '=', 'transaction.bag_id');
    //$query->leftJoin('bag as from_bag', 'from_bag.id', '=', 'bag.parent_bag_id');
    $query->leftJoin('bag as parent', 'bag.id', '=', 'transaction.bag_id');

    $query->leftJoin('bag_styles', 'bag_styles.bag_id', '=', 'transaction.bag_id');
    $query->leftJoin('style', 'bag_styles.style_id', '=', 'style.id');

    $query->leftJoin('department', 'department.id', '=', 'transaction.to_department_id');
    $query->leftJoin('employee', 'employee.id', '=', 'transaction.to_employee_id');

    //$query->where("transaction.transaction_mode", 1);
    $query->whereNotIn("bag.status", array(2, 4, 5));
    $query->where("bag.parent_bag_id in (select b1.id from bag b1 where b1.status=2)");
    $query->orderBy('transaction.bag_id', 'ASC');
    return XModel::preparePagination($query, $request, ['bag.bag_number', 'bag.order_number']);
  }
}
