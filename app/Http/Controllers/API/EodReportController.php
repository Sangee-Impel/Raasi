<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Bag;
use App\User;
use Illuminate\Http\Request;
use App\GenXCommon\XModel;
use Illuminate\Support\Facades\DB;

class EodReportController extends Controller
{
  /**
   * Getting grid data
   *
   */

  public function getIndex()
  {
    self::hasPermission('index.eodreport');
    return view("eod_report.index");
  }
  /**
   * Display a listing of the resource.
   *
   * @return \Illuminate\Http\Response
   */
  public function index(Request $request)
  {
    self::hasPermission('index.eodreport');

    $query = Bag::query()->select(
      "bag.*",
      "bag.parent_bag_id",
      "bag.bag_number",
      "bag.order_number",
      "department.name as department",
      DB::raw("DATE_FORMAT(bag.updated_at, '%d/%c/%Y %r') as time"),
      DB::raw("SUM(bag_styles.quantity) as quantity"),
      DB::raw("ROUND(SUM(bag_styles.weight), 3) as weight"),
      DB::raw("(SELECT IFNULL(sum(til3.weight), 0) FROM transaction_item_loss_details til3 JOIN transaction t3 on t3.id=til3.transaction_id WHERE t3.bag_id=bag.id AND til3.type=1) as scrap"),
      DB::raw("(SELECT IFNULL(sum(til3.weight), 0) FROM transaction_item_loss_details til3 JOIN transaction t3 on t3.id=til3.transaction_id WHERE t3.bag_id=bag.id AND til3.type=2) as channam"),
      DB::raw("(SELECT IFNULL(sum(til3.weight), 0) FROM transaction_item_loss_details til3 JOIN transaction t3 on t3.id=til3.transaction_id WHERE t3.bag_id=bag.id AND til3.type=0) as loss"),
      DB::raw("IFNULL((SELECT t3.total_receive_weight FROM transaction t3 WHERE t3.bag_id=bag.id ORDER BY ID DESC LIMIT 1), ROUND(SUM(bag_styles.weight), 3))  as cross_weight"),
      DB::raw("GROUP_CONCAT(bag_styles.style_id) as style"),
      //DB::raw("GROUP_CONCAT(bag_styles.instructions) instruction"),
      DB::raw("GROUP_CONCAT(style.sku) sku"),
      "employee.name as employee",
    );

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
                $query->where("transaction_item_loss_details.updated_at", '>=', $value . ' 00:00:00');
                break;
              case 'to_date':
                $query->where("transaction_item_loss_details.updated_at", '<=', $value . ' 23:59:59');
                break;
              case 'employee_id':
                $query->where("employee.id", '=', $value);
                break;
              case 'department_id':
                $query->where("department.id", '=', $value);
                break;
            }
          }
        }
      }
    }

    $query->where("bag.status", "!=", "1");
    $query->where("bag.department_id", "!=", "9");
    $query->where("bag.department_id", "!=", "1");
    $query->whereNotIn("bag.status", array(2, 4, 5));
    $query->groupBy('bag.id', 'bag.parent_bag_id', 'bag.bag_number', 'bag.order_number');
    $query->orderBy('bag.id', 'DESC');

    return XModel::preparePagination($query, $request, ['bag.bag_number', 'bag.order_number', 'bag.instructions']);
  }
}
