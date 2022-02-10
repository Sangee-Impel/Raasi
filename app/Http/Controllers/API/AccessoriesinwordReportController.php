<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\CastingWeight;
use Illuminate\Http\Request;
use App\GenXCommon\XModel;
use Illuminate\Support\Facades\DB;

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
    $query->groupBy('bag.id', 'bag.bag_number', 'bag.order_number', 'casting_weights.weight');
    $query->orderBy('bag.id', 'DESC');

    return XModel::preparePagination($query, $request, ['bag.bag_number', 'bag.order_number']);
  }
}
