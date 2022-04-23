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
      DB::raw("(transaction.total_transfer_quantity - IFNULL((SELECT t3.total_transfer_quantity FROM transaction t3 JOIN bag as oldbag ON t3.bag_id=oldbag.id WHERE oldbag.bag_number=frombag.bag_number AND oldbag.status=4 ORDER BY t3.ID DESC LIMIT 1), 0) - IFNULL((SELECT sum(bs1.quantity) FROM bag_styles bs1 JOIN bag as oldbag1 ON bs1.bag_id=oldbag1.id WHERE oldbag1.bag_number=frombag.bag_number AND bs1.other_accessories_id IS NOT NULL AND bs1.style_id IS NULL AND oldbag1.status=4),0)) as transferred_qty"),
      DB::raw("(transaction.total_receive_weight - IFNULL((SELECT t3.total_receive_weight FROM transaction t3 JOIN bag as oldbag ON t3.bag_id=oldbag.id WHERE oldbag.bag_number=frombag.bag_number AND oldbag.status=4 ORDER BY t3.ID DESC LIMIT 1), 0) - IFNULL((SELECT sum(bs1.weight) FROM bag_styles bs1 JOIN bag as oldbag1 ON bs1.bag_id=oldbag1.id WHERE oldbag1.bag_number=frombag.bag_number AND bs1.other_accessories_id IS NOT NULL AND bs1.style_id IS NULL AND oldbag1.status=4),0)) as transferred_weight"),
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
    $query->groupBy('transaction.id');
    $query->orderBy('transaction.id', 'DESC');
    return XModel::preparePagination($query, $request, ['bag.bag_number', 'bag.order_number']);
  }
}
