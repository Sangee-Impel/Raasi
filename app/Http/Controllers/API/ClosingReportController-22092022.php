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
    //$to_date = date('Y-m-d', strtotime('+1 day', strtotime($from_date))) . ' 00:00:00';

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
    $from_date_raw = date('Y-m-d', strtotime($from_date));

    $query =  "SELECT 
      ROUND(
        (
          SUM(b3.pre_casting_inward) + 
          SUM(b3.pre_kambi_inward) + 
          SUM(b3.pre_fancy_inward) + 
          SUM(b3.pre_others_inward)
        ) - 
        (
          SUM(b3.pre_scrap_outward) + 
          SUM(b3.pre_channam_outward) + 
          SUM(b3.pre_loss) + 
          (
            SUM(b3.bs_closing1)
          )
        )
      ,3) as opening, ";
    $query .= "ROUND(SUM(b3.casting_inward),3) as casting_inward, ";
    $query .= "ROUND(SUM(b3.kambi_inward),3) as kambi_inward, ";
    $query .= "ROUND(SUM(b3.fancy_inward),3) as fancy_inward, ";
    $query .= "ROUND(SUM(b3.others_inward),3) as others_inward, ";
    $query .= "ROUND(
      (
        SUM(b3.scrap_outward)
      )
    ,3) as scrap, ";
    $query .= "ROUND(
      (
        SUM(b3.channam_outward)
      )
    ,3) as channam, ";
    $query .= "ROUND(
      (
        SUM(b3.loss)
      )
    ,3) as loss, ";
    $query .= "ROUND(SUM(b3.fc_bag_bs_total), 3) as fc_delivery, ";
    $query .= "ROUND(
      (
        SUM(b3.pre_casting_inward) + 
        SUM(b3.pre_kambi_inward) +
        SUM(b3.pre_fancy_inward) + 
        SUM(b3.pre_others_inward) + 
        SUM(b3.casting_inward) + 
        SUM(b3.kambi_inward) + 
        SUM(b3.fancy_inward) + 
        SUM(b3.others_inward)
      ) - 
      (
        SUM(b3.pre_scrap_outward) + 
        SUM(b3.pre_channam_outward) + 
        SUM(b3.pre_loss) + 
        (
          SUM(b3.bs_closing1)
        ) + 
        SUM(b3.scrap_outward) + 
        SUM(b3.channam_outward) + 
        SUM(b3.loss) + 
        (
          SUM(b3.fc_bag_bs_total)
        )
      )
    ,3) as closing, ";
    $query .= "ROUND(SUM(b3.pending_bag),3) as pending_bag, ";
    $query .= "ROUND(SUM(b3.eod_bag),3) as eod_bag ";
    $query .= "FROM ( ";
    $query .= "SELECT ";
    $query .= "IFNULL(sum(";
    $query .= "(CASE WHEN (SELECT IFNULL(t1.total_receive_weight, 0) FROM transaction t1 WHERE t1.bag_id = b.id AND t1.transaction_date < '" . $from_date_raw . "' AND t1.to_department_id=9 order by t1.id desc limit 1) > 0 THEN ";
    $query .= "(SELECT IFNULL(t1.total_receive_weight, 0) FROM transaction t1 WHERE t1.bag_id = b.id AND t1.transaction_date < '" . $from_date_raw . "' AND t1.to_department_id=9 order by t1.id desc limit 1) ";
    $query .= "ELSE (select IFNULL(bs2.weight, 0) from bag_styles bs2 JOIN bag b2 on bs2.bag_id=b2.id WHERE b2.department_id=9 AND b2.id=b.id AND b2.updated_at < '" . $from_date_raw . "') END) ";
    $query .= "), 0) as bs_closing, ";

    $query .= "IFNULL((SELECT IFNULL(t1.total_receive_weight, 0) FROM transaction t1 WHERE t1.bag_id = b.id AND t1.transaction_date < '" . $from_date_raw . "' AND t1.to_department_id=9 order by t1.id desc limit 1), 0) as bs_closing1, ";

    $query .= "ROUND(
      (
        IFNULL(
          (CASE 
            WHEN (IFNULL((SELECT count(1) FROM transaction t1 WHERE t1.bag_id in (SELECT b1.id FROM bag b1 WHERE b1.id=b.id AND b1.created_at >= '" . $from_date . "' AND b1.created_at <= '" . $to_date . "') AND t1.transaction_date >= '" . $from_date . "' AND t1.transaction_date <= '" . $to_date . "'), 0) > 0) THEN 
              IFNULL(
                (SELECT t2.total_transfer_weight FROM transaction t2 WHERE t2.bag_id in (SELECT b1.id FROM bag b1 WHERE b1.id=b.id AND b1.created_at >= '" . $from_date . "' AND b1.created_at <= '" . $to_date . "')  AND t2.transaction_date >= '" . $from_date . "' AND t2.transaction_date <= '" . $to_date . "' ORDER BY t2.id ASC LIMIT 1)
              ,0)
            ELSE 
              ROUND((SELECT IFNULL(sum(bs2.weight), 0) FROM bag_styles bs2 WHERE bs2.bag_id=b.id AND bs2.style_id is not null AND bs2.created_at >= '" . $from_date . "' AND bs2.created_at <= '" . $to_date . "'), 3) 
            END
          ) 
        ,0)
      ) 
      -
      (
        IFNULL(
          (
            SELECT 
              ROUND((SELECT IFNULL(sum(bs2.weight), 0) from bag_styles bs2 WHERE bs2.bag_id=t1.to_bag_id AND bs2.style_id IS NOT NULL), 3) 
            FROM  transaction t1
            WHERE t1.bag_id in (SELECT b1.id FROM bag b1 WHERE b1.id=b.id AND b1.created_at >= '" . $from_date . "' AND b1.created_at <= '" . $to_date . "') 
            AND   t1.transaction_mode=1
            AND   t1.transaction_date >= '" . $from_date . "' 
            AND   t1.transaction_date <= '" . $to_date . "'
          )
        ,0) 
      )
    ,3) as casting_inward, ";

    $query .= "(select IFNULL(sum(bs2.weight), 0) from bag_styles bs2 JOIN bag b2 on bs2.bag_id=b2.id WHERE b2.id=b.id AND bs2.other_accessories_id=1 AND bs2.created_at >= '" . $from_date . "' AND bs2.created_at <= '" . $to_date . "') as kambi_inward, ";
    $query .= "(select IFNULL(sum(bs2.weight), 0) from bag_styles bs2 JOIN bag b2 on bs2.bag_id=b2.id WHERE b2.id=b.id AND bs2.other_accessories_id=2 AND bs2.created_at >= '" . $from_date . "' AND bs2.created_at <= '" . $to_date . "') as fancy_inward, ";
    $query .= "(select IFNULL(sum(bs2.weight), 0) from bag_styles bs2 JOIN bag b2 on bs2.bag_id=b2.id WHERE b2.id=b.id AND bs2.other_accessories_id>2 AND bs2.created_at >= '" . $from_date . "' AND bs2.created_at <= '" . $to_date . "') as others_inward, ";
    $query .= "(SELECT IFNULL(sum(til3.weight), 0) FROM transaction_item_loss_details til3 JOIN transaction t3 on t3.id=til3.transaction_id WHERE t3.bag_id=b.id AND til3.type=1 AND til3.created_at >= '" . $from_date . "' AND til3.created_at <= '" . $to_date . "') as scrap_outward, ";
    $query .= "(SELECT IFNULL(sum(til3.weight), 0) FROM transaction_item_loss_details til3 JOIN transaction t3 on t3.id=til3.transaction_id WHERE t3.bag_id=b.id AND til3.type=2 AND til3.created_at >= '" . $from_date . "' AND til3.created_at <= '" . $to_date . "') as channam_outward, ";
    $query .= "(SELECT IFNULL(sum(til4.weight), 0) FROM transaction_item_loss_details til4 JOIN transaction t4 on t4.id=til4.transaction_id WHERE t4.bag_id=b.id AND til4.type=0 AND til4.created_at >= '" . $from_date . "' AND til4.created_at <= '" . $to_date . "') as loss, ";

    $query .= "ROUND(
      (
        IFNULL(
          (CASE 
            WHEN (IFNULL((SELECT count(1) FROM transaction t1 WHERE t1.bag_id in (SELECT b1.id FROM bag b1 WHERE b1.id=b.id AND b1.created_at < '" . $from_date_raw . "') AND t1.transaction_date < '" . $from_date_raw . "'), 0) > 0) THEN 
              IFNULL(
                (SELECT t2.total_transfer_weight FROM transaction t2 WHERE t2.bag_id in (SELECT b1.id FROM bag b1 WHERE b1.id=b.id AND b1.created_at < '" . $from_date_raw . "')  AND t2.transaction_date < '" . $from_date_raw . "' ORDER BY t2.id ASC LIMIT 1)
              ,0)
            ELSE 
              ROUND((SELECT IFNULL(sum(bs2.weight), 0) FROM bag_styles bs2 WHERE bs2.bag_id=b.id AND bs2.style_id is not null AND bs2.created_at < '" . $from_date_raw . "'), 3) 
            END
          ) 
        ,0)
      ) 
      -
      (
        IFNULL(
          (
            SELECT 
              ROUND((SELECT IFNULL(sum(bs2.weight), 0) from bag_styles bs2 WHERE bs2.bag_id=t1.to_bag_id AND bs2.style_id IS NOT NULL), 3) 
            FROM  transaction t1
            WHERE t1.bag_id in (SELECT b1.id FROM bag b1 WHERE b1.id=b.id AND b1.created_at < '" . $from_date_raw . "') 
            AND   t1.transaction_mode=1
            AND   t1.transaction_date < '" . $from_date_raw . "'
          )
        ,0) 
      )
    , 3) as pre_casting_inward, ";

    $query .= "(select IFNULL(sum(bs2.weight), 0) from bag_styles bs2 JOIN bag b2 on bs2.bag_id=b2.id WHERE b2.id=b.id AND bs2.other_accessories_id=1 AND bs2.created_at < '" . $from_date_raw . "') as pre_kambi_inward, ";
    $query .= "(select IFNULL(sum(bs2.weight), 0) from bag_styles bs2 JOIN bag b2 on bs2.bag_id=b2.id WHERE b2.id=b.id AND bs2.other_accessories_id=2 AND bs2.created_at < '" . $from_date_raw . "') as pre_fancy_inward, ";
    $query .= "(select IFNULL(sum(bs2.weight), 0) from bag_styles bs2 JOIN bag b2 on bs2.bag_id=b2.id WHERE b2.id=b.id AND bs2.other_accessories_id>2 AND bs2.created_at < '" . $from_date_raw . "') as pre_others_inward, ";
    $query .= "(SELECT IFNULL(sum(til3.weight), 0) FROM transaction_item_loss_details til3 JOIN transaction t3 on t3.id=til3.transaction_id WHERE t3.bag_id=b.id AND til3.type=1 AND til3.created_at < '" . $from_date_raw . "') as pre_scrap_outward, ";
    $query .= "(SELECT IFNULL(sum(til3.weight), 0) FROM transaction_item_loss_details til3 JOIN transaction t3 on t3.id=til3.transaction_id WHERE t3.bag_id=b.id AND til3.type=2 AND til3.created_at < '" . $from_date_raw . "') as pre_channam_outward, ";
    $query .= "(SELECT IFNULL(sum(til4.weight), 0) FROM transaction_item_loss_details til4 JOIN transaction t4 on t4.id=til4.transaction_id WHERE t4.bag_id=b.id AND til4.type=0 AND til4.created_at < '" . $from_date_raw . "') as pre_loss, ";
    // Previous Date Data
    $query .= "IFNULL(SUM(";
    $query .= "(CASE WHEN (SELECT IFNULL(t1.total_receive_weight, 0) FROM transaction t1 WHERE t1.bag_id = b.id AND t1.transaction_date < '" . $from_date_raw . "' AND t1.to_department_id=9 order by t1.id desc limit 1) > 0 THEN ";
    $query .= "(SELECT IFNULL(t1.total_receive_weight, 0) FROM transaction t1 WHERE t1.bag_id = b.id AND t1.transaction_date < '" . $from_date_raw . "' AND t1.to_department_id=9 order by t1.id desc limit 1) ";
    $query .= "ELSE (select IFNULL(bs2.weight, 0) from bag_styles bs2 JOIN bag b2 on bs2.bag_id=b2.id WHERE b2.department_id=9 AND b2.id=b.id AND b2.updated_at < '" . $from_date_raw . "') END) ";
    $query .= "), 0) as pre_fcdelivery_outward, ";

    $query .= "IFNULL(SUM(";
    $query .= "(CASE WHEN (SELECT IFNULL(t1.total_receive_weight, 0) FROM transaction t1 WHERE t1.bag_id = b.id AND t1.transaction_date >= '" . $from_date . "' AND t1.transaction_date <= '" . $to_date . "' AND t1.to_department_id=9 order by t1.id desc limit 1) > 0 THEN ";
    $query .= "(SELECT IFNULL(t1.total_receive_weight, 0) FROM transaction t1 WHERE t1.bag_id = b.id AND t1.transaction_date >= '" . $from_date . "' AND t1.transaction_date <= '" . $to_date . "' AND t1.to_department_id=9 order by t1.id desc limit 1) ";
    $query .= "ELSE (select IFNULL(bs2.weight, 0) from bag_styles bs2 JOIN bag b2 on bs2.bag_id=b2.id WHERE b2.department_id=9 AND b2.id=b.id AND bs2.updated_at >= '" . $from_date . "' AND bs2.updated_at <= '" . $to_date . "') END) ";
    $query .= "), 0) as fcdelivery_outward, ";

    $query .= "IFNULL((SELECT IFNULL(t1.total_receive_weight, 0) FROM transaction t1 WHERE t1.bag_id = b.id AND t1.transaction_date >= '" . $from_date . "' AND t1.transaction_date <= '" . $to_date . "' AND t1.to_department_id=9 order by t1.id desc limit 1), 0) as fc_bag_bs_total, ";

    $query .= "
    IFNULL(
      (
        SELECT 
          ROUND(
            (
              IFNULL(
              (
                CASE 
                WHEN (IFNULL((SELECT count(1) FROM transaction t1 WHERE t1.bag_id=b2.id), 0) > 0) THEN 
                  IFNULL((SELECT t2.total_transfer_weight FROM transaction t2 WHERE t2.bag_id=b2.id ORDER BY t2.id ASC LIMIT 1), 0)
                ELSE 
                  ROUND((SELECT IFNULL(sum(bs2.weight), 0) FROM bag_styles bs2 WHERE bs2.bag_id=b2.id AND bs2.style_id is not null), 3) 
                END
              ) 
              , 0) +
              IFNULL(
              (SELECT 
                ROUND(SUM(
                IFNULL(t1.total_receive_weight, 0) - IFNULL((SELECT t3.total_receive_weight FROM transaction t3 WHERE t3.bag_id=t1.bag_id AND t3.id < t1.id ORDER BY t3.id DESC LIMIT 1), 0)
                ), 3)
              FROM  transaction t1
              WHERE t1.bag_id=b2.id 
              AND   t1.transaction_mode=2)
              ,0) + 
              ROUND((select IFNULL(sum(bs2.weight), 0) from bag_styles bs2 WHERE bs2.bag_id=b2.id AND bs2.other_accessories_id=1), 3) + 
              ROUND((select IFNULL(sum(bs2.weight), 0) from bag_styles bs2 WHERE bs2.bag_id=b2.id AND bs2.other_accessories_id=2), 3) + 
              ROUND((select IFNULL(sum(bs2.weight), 0) from bag_styles bs2 WHERE bs2.bag_id=b2.id AND bs2.other_accessories_id>2), 3) 
            ) 
            -
            (
              (SELECT IFNULL(sum(til3.weight), 0) FROM transaction_item_loss_details til3 JOIN transaction t3 on t3.id=til3.transaction_id WHERE t3.bag_id=b2.id AND til3.type=1) +
              (SELECT IFNULL(sum(til3.weight), 0) FROM transaction_item_loss_details til3 JOIN transaction t3 on t3.id=til3.transaction_id WHERE t3.bag_id=b2.id AND til3.type=2) +
              (SELECT IFNULL(sum(til3.weight), 0) FROM transaction_item_loss_details til3 JOIN transaction t3 on t3.id=til3.transaction_id WHERE t3.bag_id=b2.id AND til3.type=0) +
              IFNULL((SELECT 
              ROUND(SUM(
                IFNULL(t1.total_receive_weight, 0) - IFNULL((SELECT t3.total_receive_weight FROM transaction t3 WHERE t3.bag_id=t1.bag_id AND t3.id < t1.id ORDER BY t3.id DESC LIMIT 1), 0)
              ), 3)
              FROM  transaction t1
              WHERE t1.to_bag_id=b2.id 
              AND   t1.transaction_mode=2)
              , 0) + 
              IFNULL(
              (
                SELECT 
                ROUND((SELECT IFNULL(sum(bs2.weight), 0) from bag_styles bs2 WHERE bs2.bag_id=t1.to_bag_id AND bs2.style_id IS NOT NULL), 3) 
                FROM  transaction t1
                WHERE t1.bag_id=b2.id 
                AND   t1.transaction_mode=1
              )
              , 0) 
            )
          , 3)
        FROM bag b2 WHERE b2.id=b.id AND b2.status not in (1,2,4,5) AND b2.department_id not in (1,9)
      ) 
    ,0) as pending_bag, ";

    $query .= "
    IFNULL(
      (
        SELECT 
          ROUND(
          (
            IFNULL(
            (CASE 
            WHEN (IFNULL((SELECT count(1) FROM transaction t1 WHERE t1.bag_id = b2.id), 0) > 0) THEN 
              IFNULL((SELECT t2.total_transfer_weight FROM transaction t2 WHERE b2.id=t2.bag_id ORDER BY t2.id ASC LIMIT 1), 0)
            ELSE 
              ROUND((SELECT IFNULL(sum(bs2.weight), 0) FROM bag_styles bs2 WHERE bs2.bag_id=b2.id AND bs2.style_id is not null), 3) 
            END) 
            , 0) +
            IFNULL(
            (SELECT 
              ROUND(SUM(
              IFNULL(t1.total_receive_weight, 0) - IFNULL((SELECT t3.total_receive_weight FROM transaction t3 WHERE t3.bag_id=t1.bag_id AND t3.id < t1.id ORDER BY t3.id DESC LIMIT 1), 0)
              ), 3)
            FROM  transaction t1
            WHERE t1.bag_id=b2.id 
            AND   t1.transaction_mode=2)
            ,0) + 
            ROUND((select IFNULL(sum(bs2.weight), 0) from bag_styles bs2 WHERE bs2.bag_id=b2.id AND bs2.other_accessories_id=1), 3) + 
            ROUND((select IFNULL(sum(bs2.weight), 0) from bag_styles bs2 WHERE bs2.bag_id=b2.id AND bs2.other_accessories_id=2), 3) + 
            ROUND((select IFNULL(sum(bs2.weight), 0) from bag_styles bs2 WHERE bs2.bag_id=b2.id AND bs2.other_accessories_id>2), 3) 
          ) 
          -
          (
            (SELECT IFNULL(sum(til3.weight), 0) FROM transaction_item_loss_details til3 JOIN transaction t3 on t3.id=til3.transaction_id WHERE t3.bag_id=b2.id AND til3.type=1) +
            (SELECT IFNULL(sum(til3.weight), 0) FROM transaction_item_loss_details til3 JOIN transaction t3 on t3.id=til3.transaction_id WHERE t3.bag_id=b2.id AND til3.type=2) +
            (SELECT IFNULL(sum(til3.weight), 0) FROM transaction_item_loss_details til3 JOIN transaction t3 on t3.id=til3.transaction_id WHERE t3.bag_id=b2.id AND til3.type=0) +
            IFNULL((SELECT 
            ROUND(SUM(
              IFNULL(t1.total_receive_weight, 0) - IFNULL((SELECT t3.total_receive_weight FROM transaction t3 WHERE t3.bag_id=t1.bag_id AND t3.id < t1.id ORDER BY t3.id DESC LIMIT 1), 0)
            ), 3)
            FROM  transaction t1
            WHERE t1.to_bag_id=b2.id 
            AND   t1.transaction_mode=2)
            , 0) + 
            IFNULL(
            (
              SELECT 
              ROUND((SELECT IFNULL(sum(bs2.weight), 0) from bag_styles bs2 WHERE bs2.bag_id=t1.to_bag_id AND bs2.style_id IS NOT NULL), 3) 
              FROM  transaction t1
              WHERE t1.bag_id=b2.id 
              AND   t1.transaction_mode=1
            )
            , 0) 
          )
          , 3)
        FROM bag b2 WHERE b2.id=b.id AND b2.status not in (1,2,4,5) AND b2.department_id=1
      )
    ,0) as eod_bag ";

    $query .= "FROM bag b ";
    $query .= "WHERE b.status not in (2, 4) ";

    $query .= "group by b.id) b3";
    // print_r($query);
    // exit;

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
