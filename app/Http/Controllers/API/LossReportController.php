<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Bag;
use App\User;
use Illuminate\Http\Request;
use App\GenXCommon\XModel;
use Illuminate\Support\Facades\DB;

class LossReportController extends Controller
{
  /**
   * Getting grid data
   *
   */

  public function getIndex()
  {
    self::hasPermission('index.lossreport');
    return view("loss_report.index");
  }
  /**
   * Display a listing of the resource.
   *
   * @return \Illuminate\Http\Response
   */
  public function index(Request $request)
  {
    self::hasPermission('index.lossreport');

    $query = Bag::query()->select(
      "bag.*",
      "bag.parent_bag_id",
      "bag.bag_number",
      "bag.order_number",
      "department.name as department",
      DB::raw("DATE_FORMAT(bag.updated_at, '%r') as time"),
      DB::raw("SUM(bag_styles.quantity) as quantity"),
      DB::raw("SUM(bag_styles.weight) as weight"),
      DB::raw("GROUP_CONCAT(bag_styles.style_id) as style"),
      DB::raw("GROUP_CONCAT(style.sku) sku")
    );

    $query->leftJoin('bag_styles', 'bag_styles.bag_id', '=', 'bag.id');
    $query->leftJoin('style', 'bag_styles.style_id', '=', 'style.id');
    $query->leftJoin('department', 'department.id', '=', 'bag.department_id');

    $query->where("bag.department_id", 1);
    $query->groupBy('bag.id', 'bag.parent_bag_id', 'bag.bag_number', 'bag.order_number');
    $query->orderBy('bag.id', 'DESC');

    return XModel::preparePagination($query, $request, ['bag.bag_number', 'bag.order_number']);
  }

}
