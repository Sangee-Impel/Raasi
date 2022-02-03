<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Bag;
use App\User;
use Illuminate\Http\Request;
use App\GenXCommon\XModel;
use Illuminate\Support\Facades\DB;

class ClosingReportController extends Controller
{
  /**
   * Getting grid data
   *
   */

  public function getIndex()
  {
    self::hasPermission('index.closingreport');
    return view("closing_report.index");
  }
  /**
   * Display a listing of the resource.
   *
   * @return \Illuminate\Http\Response
   */
  public function index(Request $request)
  {
    self::hasPermission('index.closingreport');

    $query = Bag::query()->select(
      DB::raw("(select IFNULL(sum(bs1.weight), 0) from bag_styles bs1 where bs1.bag_id=bag.id) as opening"),
      DB::raw("(SELECT IFNULL(sum(cw1.weight), 0) FROM casting_weights cw1 where cw1.bag_id=bag.id and cw1.adjustment='Lot_Deduct' and cw1.casting_id = 1) as casting_inward"),
      DB::raw("(SELECT IFNULL(sum(cw2.weight), 0) FROM casting_weights cw2 join transaction t2 on t2.id=cw2.transaction_id where t2.bag_id=bag.id and cw2.adjustment='Transaction_Deduct' and cw2.casting_id <> 1) as accessories_inward"),
      DB::raw("(SELECT IFNULL(sum(til3.weight), 0) FROM transaction_item_loss_details til3 join transaction t3 on t3.id=til3.transaction_id where t3.bag_id=bag.id and til3.type in (1, 2)) as scrap_channam"),
      DB::raw("(SELECT IFNULL(sum(til4.weight), 0) FROM transaction_item_loss_details til4 join transaction t4 on t4.id=til4.transaction_id where t4.bag_id=bag.id and til4.type=0) as loss"),
      DB::raw("(select IFNULL(sum(bs2.weight), 0) from bag_styles bs2 join bag b2 on bs2.bag_id=b2.id where b2.id=bag.id and b2.department_id=8) as fc_delivery")
    );

    if ($request->has('advanceFilter')) {
      $params = json_decode($request->get('advanceFilter'), true);
      if (!is_null($params)) {
        foreach ($params  as $column => $value) {
          if (!is_null($value)) {
            switch ($column) {
              case 'from_date':
                $query->where("bag.updated_at", '>=', $value . ' 00:00:00');
                break;
              case 'to_date':
                $query->where("bag.updated_at", '<=', $value . ' 23:59:59');
                break;
            }
          }
        }
      }
    }
    //$query->groupBy('opening', 'casting_inward', 'accessories_inward', 'channam_scrap_outward', 'loss', 'fcdelivery_outward');

    return XModel::preparePagination($query, $request, ['bag.id']);
  }
}
