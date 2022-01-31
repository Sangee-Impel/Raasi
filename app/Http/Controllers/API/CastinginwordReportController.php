<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\CastingWeight;
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
    self::hasPermission('index.castinginwordreport');

    $query = CastingWeight::query()->select(
      "bag.id",
      "bag.bag_number",
      "bag.order_number",
      "casting_weights.weight",
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
    $query->groupBy('bag.id', 'bag.bag_number', 'bag.order_number');
    $query->orderBy('bag.id', 'DESC');

    return XModel::preparePagination($query, $request, ['bag.bag_number', 'bag.order_number']);
  }
}
