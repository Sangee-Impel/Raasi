<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\CastingWeight;
use App\Models\Bag;
use Illuminate\Http\Request;
use App\GenXCommon\XModel;
use Illuminate\Support\Facades\DB;

class CastinginwordReportController extends Controller
{
  /**
   * Getting grid data
   *
   */

  public function getIndex()
  {
    self::hasPermission('index.castinginwordreport');
    return view("castinginword_report.index");
  }
  /**
   * Display a listing of the resource.
   *
   * @return \Illuminate\Http\Response
   */
  public function index(Request $request)
  {
    self::hasPermission('index.pendingreport');

    $query = Bag::query()->select(
      "bag.*",
      "bag.parent_bag_id",
      "bag.bag_number",
      "bag.order_number",
      "department.name as department",
      DB::raw("DATE_FORMAT(bag_styles.updated_at, '%d/%c/%Y %r') as time"),
      DB::raw("SUM(bag_styles.quantity) as quantity"),
      DB::raw("IFNULL(
      (CASE 
      WHEN (IFNULL((SELECT count(1) FROM transaction t1 WHERE t1.bag_id = bag.id), 0) > 0) THEN 
        IFNULL((SELECT t2.total_transfer_weight FROM transaction t2 WHERE bag.id=t2.bag_id ORDER BY t2.id ASC LIMIT 1), 0) -
        IFNULL((SELECT SUM(bs.weight) FROM bag_styles bs WHERE bs.bag_id in (SELECT t3.to_bag_id FROM transaction t3 WHERE  t3.bag_id = bag.id AND t3.transaction_mode = 1) AND bs.style_id != ''), 0) 
      ELSE 
        ROUND(SUM(bag_styles.weight), 3) 
      END) 
      , 0) as weight"),
      DB::raw("GROUP_CONCAT(bag_styles.style_id) as style"),
      DB::raw("GROUP_CONCAT(bag_styles.instructions) instruction"),
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
                $query->where("bag_styles.created_at", '>=', $value . ' 00:00:00');
                break;
              case 'to_date':
                $query->where("bag_styles.created_at", '<=', $value . ' 23:59:59');
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

    $query->where("bag_styles.style_id", "!=", '');
    $query->whereNotIn("bag.status", array(2, 4));
    $query->groupBy('bag.id', 'bag.parent_bag_id', 'bag.bag_number', 'bag.order_number');
    $query->orderBy('bag.id', 'DESC');

    return XModel::preparePagination($query, $request, ['bag.bag_number', 'bag.order_number']);
  }

  public function indexold(Request $request)
  {
    self::hasPermission('index.castinginwordreport');

    $query = CastingWeight::query()->select(
      "bag.id",
      "bag.bag_number",
      "bag.order_number",
      DB::raw("ROUND(casting_weights.weight, 3) as weight"),
      DB::raw("DATE_FORMAT(casting_weights.updated_at, '%d/%c/%Y %r') as time"),
      DB::raw("sum(bag_styles.quantity) as quantity"),
      DB::raw("GROUP_CONCAT(style.sku) sku")
    );

    $query->leftJoin('bag', 'bag.id', '=', 'casting_weights.bag_id');
    $query->leftJoin('bag_styles', 'bag_styles.bag_id', '=', 'bag.id');
    $query->leftJoin('style', 'bag_styles.style_id', '=', 'style.id');

    if ($request->has('advanceFilter')) {
      $params = json_decode($request->get('advanceFilter'), true);
      if (!is_null($params)) {
        foreach ($params  as $column => $value) {
          if (!is_null($value)) {
            switch ($column) {
              case 'from_date':
                $query->where("casting_weights.updated_at", '>=', $value . ' 00:00:00');
                break;
              case 'to_date':
                $query->where("casting_weights.updated_at", '<=', $value . ' 23:59:59');
                break;
            }
          }
        }
      }
    }

    $query->where("casting_weights.adjustment", "=", "Lot_Deduct");
    $query->where("casting_weights.casting_id", "=", 1);
    $query->where("bag_styles.style_id", "!=", '');
    $query->where("bag.status", "!=", '2');
    $query->groupBy('bag.id', 'bag.bag_number', 'bag.order_number');
    $query->orderBy('bag.id', 'DESC');

    return XModel::preparePagination($query, $request, ['bag.bag_number', 'bag.order_number']);
  }
}
