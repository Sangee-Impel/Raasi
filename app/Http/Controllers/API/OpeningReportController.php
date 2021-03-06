<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Bag;
use App\User;
use Illuminate\Http\Request;
use App\GenXCommon\XModel;
use Illuminate\Support\Facades\DB;

class OpeningReportController extends Controller
{
  /**
   * Getting grid data
   *
   */

  public function getIndex()
  {
    self::hasPermission('index.openingreport');
    return view("opening_report.index");
  }
  /**
   * Display a listing of the resource.
   *
   * @return \Illuminate\Http\Response
   */
  public function index(Request $request)
  {
    self::hasPermission('index.openingreport');

    $query = Bag::query()->select(
      "bag.*",
      "bag.parent_bag_id",
      "bag.bag_number",
      "bag.order_number",
      "department.name as department",
      DB::raw("DATE_FORMAT(bag.updated_at, '%d/%c/%Y %r') as time"),
      //DB::raw("SUM(bag_styles.quantity) as quantity"),
      DB::raw("(SUM(bag_styles.quantity) - IFNULL((SELECT lst.total_loss_quantity FROM transaction lst WHERE lst.bag_id = bag.id ORDER BY lst.id DESC LIMIT 1), 0)) as quantity"),
      DB::raw("ROUND(SUM(bag_styles.weight),3) as weight"),
      DB::raw("GROUP_CONCAT(bag_styles.style_id) as style"),
      DB::raw("GROUP_CONCAT(style.sku) sku")
    );

    $query->leftJoin('bag_styles', 'bag_styles.bag_id', '=', 'bag.id');
    $query->leftJoin('style', 'bag_styles.style_id', '=', 'style.id');
    $query->leftJoin('department', 'department.id', '=', 'bag.department_id');

    $query->where("bag.department_id", 1);
    $query->whereNotIn("bag.status", array(2, 4, 5));
    $query->groupBy('bag.id', 'bag.parent_bag_id', 'bag.bag_number', 'bag.order_number');
    $query->orderBy('bag.id', 'DESC');

    return XModel::preparePagination($query, $request, ['bag.bag_number', 'bag.order_number']);
  }
}
