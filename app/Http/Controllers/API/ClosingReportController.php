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

    $from_date = date('Y-m-d') . ' 00:00:00';
    $to_date = date('Y-m-d') . ' 23:59:59';
    if ($request->has('advanceFilter')) {
      $params = json_decode($request->get('advanceFilter'), true);
      if (!is_null($params)) {
        foreach ($params  as $column => $value) {
          if (!is_null($value)) {
            switch ($column) {
              case 'from_date':
                $from_date = $value . ' 00:00:00';
                break;
              case 'to_date':
                $to_date = $value . ' 23:59:59';
                break;
            }
          }
        }
      }
    }
    $prev_date = date('Y-m-d', strtotime('-1 day', strtotime($from_date)));

    $query =  "SELECT (ROUND(SUM(b3.opening), 3) + ROUND(SUM(b3.bs_opening),3) - ROUND(SUM(b3.bs_closing), 3)) as opening, ";
    $query .= "ROUND(SUM(b3.casting_inward),3) as casting_inward, ";
    $query .= "ROUND(SUM(b3.accessories_inward),3) as accessories_inward, ";
    $query .= "ROUND(SUM(b3.scrap_outward),3) as scrap, ";
    $query .= "ROUND(SUM(b3.channam_outward),3) as channam, ";
    $query .= "ROUND(SUM(b3.loss),3) as loss, ";
    $query .= "ROUND(SUM(b3.fcdelivery_outward),3) as fc_delivery, ";
    $query .= "ROUND(((ROUND(SUM(b3.opening), 3) + ROUND(SUM(b3.bs_opening),3) - ROUND(SUM(b3.bs_closing), 3)) + SUM(b3.casting_inward) + SUM(b3.accessories_inward)) - (SUM(b3.scrap_outward) + SUM(b3.channam_outward) + SUM(b3.loss) + SUM(b3.fcdelivery_outward)), 3) as closing ";
    $query .= "FROM ( ";
    $query .= "SELECT (SELECT IFNULL(sum(t1.total_receive_weight), 0) FROM transaction t1 WHERE t1.bag_id = b.id AND t1.transaction_date <= '" . $prev_date . "' AND t1.to_department_id<>9 order by t1.id desc limit 1) as opening, ";
    $query .= "(SELECT IFNULL(sum(bs1.weight), 0) FROM bag_styles bs1 JOIN bag b1 on bs1.bag_id=b1.id WHERE b1.id=b.id AND b1.department_id<>9 AND b1.created_at < '" . $from_date . "' and b1.id not in (SELECT t1.bag_id FROM transaction t1 WHERE t1.bag_id = b.id AND t1.transaction_date <= '" . $prev_date . "' AND t1.to_department_id<>9)) as bs_opening, ";
    $query .= "(SELECT IFNULL(sum(t1.total_receive_weight), 0) FROM transaction t1 WHERE t1.bag_id = b.id AND t1.transaction_date <= '" . $prev_date . "' AND t1.to_department_id=9 order by t1.id desc limit 1) as bs_closing, ";
    //$query .= "(SELECT IFNULL(sum(cw1.weight), 0) FROM casting_weights cw1 WHERE cw1.bag_id=b.id AND cw1.adjustment='Lot_Deduct' AND cw1.casting_id = 1) as casting_inward, ";
    //$query .= "(SELECT IFNULL(sum(cw2.weight), 0) FROM casting_weights cw2 JOIN transaction t2 on t2.id=cw2.transaction_id WHERE t2.bag_id=b.id AND cw2.adjustment='Transaction_Deduct' AND cw2.casting_id <> 1) as accessories_inward, ";
    $query .= "(select IFNULL(sum(bs2.weight), 0) from bag_styles bs2 JOIN bag b2 on bs2.bag_id=b2.id WHERE b2.id=b.id AND bs2.style_id is not null AND bs2.created_at >= '" . $from_date . "' AND bs2.created_at <= '" . $to_date . "') as casting_inward, ";
    $query .= "(select IFNULL(sum(bs2.weight), 0) from bag_styles bs2 JOIN bag b2 on bs2.bag_id=b2.id WHERE b2.id=b.id AND bs2.style_id is null AND bs2.other_accessories_id is not null AND bs2.created_at >= '" . $from_date . "' AND bs2.created_at <= '" . $to_date . "') as accessories_inward, ";
    $query .= "(SELECT IFNULL(sum(til3.weight), 0) FROM transaction_item_loss_details til3 JOIN transaction t3 on t3.id=til3.transaction_id WHERE t3.bag_id=b.id AND til3.type=1 AND til3.date >= '" . $from_date . "' AND til3.date <= '" . $to_date . "') as scrap_outward, ";
    $query .= "(SELECT IFNULL(sum(til3.weight), 0) FROM transaction_item_loss_details til3 JOIN transaction t3 on t3.id=til3.transaction_id WHERE t3.bag_id=b.id AND til3.type=2 AND til3.date >= '" . $from_date . "' AND til3.date <= '" . $to_date . "') as channam_outward, ";
    $query .= "(SELECT IFNULL(sum(til4.weight), 0) FROM transaction_item_loss_details til4 JOIN transaction t4 on t4.id=til4.transaction_id WHERE t4.bag_id=b.id AND til4.type=0 AND til4.date >= '" . $from_date . "' AND til4.date <= '" . $to_date . "') as loss, ";
    //$query .= "(select IFNULL(sum(bs2.weight), 0) from bag_styles bs2 JOIN bag b2 on bs2.bag_id=b2.id WHERE b2.id=b.id AND b2.department_id=9 AND b2.updated_at >= '" . $from_date . "' AND b2.updated_at <= '" . $to_date . "') as fcdelivery_outward ";
    $query .= "(SELECT IFNULL(sum(t1.total_receive_weight), 0) FROM transaction t1 WHERE t1.bag_id = b.id AND t1.transaction_date >= '" . $from_date . "' AND t1.transaction_date <= '" . $to_date . "' AND t1.to_department_id=9 order by t1.id desc limit 1) as fcdelivery_outward ";
    $query .= "FROM bag b ";
    $query .= "WHERE b.status not in (2, 4) ";
    // if (trim($from_date) != '') {
    //   $query .= "AND b.updated_at >= '" . $from_date . "' ";
    // }
    // if (trim($to_date) != '') {
    //   $query .= "AND b.updated_at <= '" . $to_date . "' ";
    // }
    $query .= "group by b.id) b3";
    // print_r($query);exit;

    $data = [
      'current_page' => 1,
      'data' => DB::select($query),
      'total' => 1,
      'first_page_url' => '',
      'from' => 1,
      'last_page' => 1,
      'last_page_url' => '',
      'next_page_url' => '',
      'path' => '',
      'per_page' => 1,
      'prev_page_url' => '',
      'to' => 1
    ];
    return $data;
  }
}
