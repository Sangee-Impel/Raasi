<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\CastingWeight;
use App\Models\Bag;
use Illuminate\Http\Request;
use App\GenXCommon\XModel;
use Illuminate\Support\Facades\DB;
use App\Models\OtherAccessories;

class AccessoriesinwordReportController extends Controller
{
  /**
   * Getting grid data
   *
   */

  public function getIndex()
  {
    self::hasPermission('index.accessoriesinwordreport');
    return view("accessoriesinword_report.index");
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
      "bag_styles.id as bag_style_id",
      "bag.*",
      "bag.parent_bag_id",
      "bag.bag_number",
      "bag.order_number",
      "department.name as department",
      DB::raw("DATE_FORMAT(bag_styles.updated_at, '%d/%c/%Y %r') as time"),
      DB::raw("SUM(bag_styles.quantity) as quantity"),
      DB::raw("ROUND(SUM(bag_styles.weight), 3) as weight"),
      DB::raw("GROUP_CONCAT(bag_styles.style_id) as style"),
      DB::raw("GROUP_CONCAT(bag_styles.instructions) instruction"),
      DB::raw("GROUP_CONCAT(style.sku) sku"),
      "employee.name as employee",
      "other_accessories.name as casting",
    );

    $query->leftJoin('bag_styles', 'bag_styles.bag_id', '=', 'bag.id');
    $query->leftJoin('style', 'bag_styles.style_id', '=', 'style.id');
    //$query->leftJoin('transaction_item', 'transaction_item.bag_style_id', '=', 'bag_styles.id');
    //$query->leftJoin('transaction', 'transaction.id', '=', 'transaction_item.transaction_id');
    //$query->leftJoin('department', 'department.id', '=', 'transaction.from_department_id');
    //$query->leftJoin('employee', 'employee.id', '=', 'transaction.from_employee_id');
    $query->leftJoin('department', 'department.id', '=', 'bag.department_id');
    $query->leftJoin('employee', 'employee.id', '=', 'bag.employee_id');
    $query->leftJoin('other_accessories', 'other_accessories.id', '=', 'bag_styles.other_accessories_id');

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
              case 'accessories_id':
                $query->where("bag_styles.other_accessories_id", '=', $value);
                break;
            }
          }
        }
      }
    }

    $query->where("bag_styles.other_accessories_id", ">", '0');
    //$query->where("transaction_item.type", 1);
    $query->whereNotIn("bag.status", array(2, 4, 5));
    $query->groupBy('bag_styles.id', 'bag.id', 'bag.parent_bag_id', 'bag.bag_number', 'bag.order_number', 'bag_styles.other_accessories_id');
    $query->orderBy('bag.id', 'DESC');

    return XModel::preparePagination($query, $request, ['bag.bag_number', 'bag.order_number']);
  }

  public function indexold(Request $request)
  {
    self::hasPermission('index.accessoriesinwordreport');

    $query = CastingWeight::query()->select(
      "bag.id",
      "bag.bag_number",
      "bag.order_number",
      DB::raw("ROUND(casting_weights.weight,3) as weight"),
      DB::raw("DATE_FORMAT(casting_weights.updated_at, '%d/%c/%Y %r') as time"),
      "casting_weights.quantity",
      DB::raw("GROUP_CONCAT(style.sku) sku"),
      "casting.name as casting",
      "employee.name as employee",
      "department.name as department",
    );

    $query->leftJoin('transaction', 'transaction.id', '=', 'casting_weights.transaction_id');
    $query->leftJoin('bag', 'bag.id', '=', 'transaction.bag_id');
    $query->leftJoin('bag_styles', 'bag_styles.bag_id', '=', 'bag.id');
    $query->leftJoin('style', 'bag_styles.style_id', '=', 'style.id');
    $query->leftJoin('casting', 'casting.id', '=', 'casting_weights.casting_id');
    $query->leftJoin('employee', 'employee.id', '=', 'transaction.to_employee_id');
    $query->leftJoin('department', 'department.id', '=', 'transaction.to_department_id');

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

    $query->where("casting_weights.adjustment", "=", 'Transaction_Deduct');
    $query->where("bag.status", "!=", '2');
    $query->groupBy('bag.id', 'bag.bag_number', 'bag.order_number', 'casting_weights.weight');
    $query->orderBy('bag.id', 'DESC');

    return XModel::preparePagination($query, $request, ['bag.bag_number', 'bag.order_number']);
  }

  public function dropDown(Request $request)
  {
    $post_all = $request->all();
    $accessories = OtherAccessories::query()->select('other_accessories.*')->get();
    $result         =   [
      "accessories"      =>  $accessories
    ];
    return $result;
  }
}
