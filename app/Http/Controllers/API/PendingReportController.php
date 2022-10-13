<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Bag;
use App\User;
use Illuminate\Http\Request;
use App\GenXCommon\XModel;
use Illuminate\Support\Facades\DB;

class PendingReportController extends Controller
{
  /**
   * Getting grid data
   *
   */

  public function getIndex()
  {
    self::hasPermission('index.pendingreport');
    return view("pending_report.index");
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
      DB::raw("DATE_FORMAT(bag.updated_at, '%d/%c/%Y %r') as time"),
      DB::raw("(SUM(bag_styles.quantity) - IFNULL((SELECT lst.total_loss_quantity FROM transaction lst WHERE lst.bag_id = bag.id ORDER BY lst.id DESC LIMIT 1), 0)) as quantity"),
      DB::raw("IFNULL(
        (CASE 
        WHEN (IFNULL((SELECT count(1) FROM transaction t1 WHERE t1.bag_id = bag.id), 0) > 0) THEN 
          IFNULL((SELECT t2.total_transfer_weight FROM transaction t2 WHERE bag.id=t2.bag_id ORDER BY t2.id ASC LIMIT 1), 0)
        ELSE 
          ROUND(SUM(bag_styles.weight), 3) 
        END) 
        , 0) as weight"
      ),
      DB::raw("
        IFNULL(
          (SELECT 
              ROUND(SUM((SELECT IFNULL(sum(bs2.weight), 0) from bag_styles bs2 WHERE bs2.bag_id=t1.to_bag_id AND bs2.style_id IS NOT NULL)), 3) 
            FROM  transaction t1
            WHERE t1.bag_id=bag.id 
            AND   t1.transaction_mode=1)
        , 0) as split_outward"
      ),
      DB::raw("
        ROUND(
          (
            IFNULL(
            (CASE 
            WHEN (IFNULL((SELECT count(1) FROM transaction t1 WHERE t1.bag_id = bag.id), 0) > 0) THEN 
              IFNULL((SELECT t2.total_transfer_weight FROM transaction t2 WHERE bag.id=t2.bag_id ORDER BY t2.id ASC LIMIT 1), 0)
            ELSE 
              ROUND(SUM(bag_styles.weight), 3) 
            END) 
            , 0)
          ) 
          -
          (
            IFNULL((SELECT 
              ROUND(SUM((SELECT IFNULL(sum(bs2.weight), 0) from bag_styles bs2 WHERE bs2.bag_id=t1.to_bag_id AND bs2.style_id IS NOT NULL)), 3) 
            FROM  transaction t1
            WHERE t1.bag_id=bag.id 
            AND   t1.transaction_mode=1), 0) 
          )
        , 3) as current_inward"
      ),
      DB::raw("ROUND((select IFNULL(sum(bs2.weight), 0) from bag_styles bs2 WHERE bs2.bag_id=bag.id AND bs2.other_accessories_id=1), 3) as kambi_inward"),
      DB::raw("ROUND((select IFNULL(sum(bs2.weight), 0) from bag_styles bs2 WHERE bs2.bag_id=bag.id AND bs2.other_accessories_id=2), 3) as fancy_inward"),
      DB::raw("ROUND((select IFNULL(sum(bs2.weight), 0) from bag_styles bs2 WHERE bs2.bag_id=bag.id AND bs2.other_accessories_id>2), 3) as others_inward"),

      DB::raw("ROUND((SELECT IFNULL(sum(til3.weight), 0) FROM transaction_item_loss_details til3 JOIN transaction t3 on t3.id=til3.transaction_id WHERE t3.bag_id=bag.id AND til3.type=1), 3) as scrap"),
      DB::raw("ROUND((SELECT IFNULL(sum(til3.weight), 0) FROM transaction_item_loss_details til3 JOIN transaction t3 on t3.id=til3.transaction_id WHERE t3.bag_id=bag.id AND til3.type=2), 3) as channam"),
      DB::raw("ROUND((SELECT IFNULL(sum(til3.weight), 0) FROM transaction_item_loss_details til3 JOIN transaction t3 on t3.id=til3.transaction_id WHERE t3.bag_id=bag.id AND til3.type=0), 3) as loss"),
      //DB::raw("ROUND(IFNULL((SELECT t3.total_receive_weight FROM transaction t3 WHERE t3.bag_id=bag.id ORDER BY ID DESC LIMIT 1), ROUND(SUM(bag_styles.weight), 3)), 3)  as cross_weight"),
      //DB::raw("ROUND(SUM(bag_styles.weight) - (
      DB::raw("
      ROUND(
        (
          IFNULL(
            (CASE 
            WHEN (IFNULL((SELECT count(1) FROM transaction t1 WHERE t1.bag_id = bag.id), 0) > 0) THEN 
              IFNULL((SELECT t2.total_transfer_weight FROM transaction t2 WHERE bag.id=t2.bag_id ORDER BY t2.id ASC LIMIT 1), 0)
            ELSE 
              ROUND(SUM(bag_styles.weight), 3) 
            END) 
          , 0) +
          IFNULL(
            (SELECT 
              ROUND(SUM(
                IFNULL(t1.total_receive_weight, 0) - IFNULL((SELECT t3.total_receive_weight FROM transaction t3 WHERE t3.bag_id=t1.bag_id AND t3.id < t1.id ORDER BY t3.id DESC LIMIT 1), 0)
              ), 3)
            FROM  transaction t1
            WHERE t1.bag_id=bag.id 
            AND   t1.transaction_mode=2)
          ,0) + 
          ROUND((select IFNULL(sum(bs2.weight), 0) from bag_styles bs2 WHERE bs2.bag_id=bag.id AND bs2.other_accessories_id=1), 3) + 
          ROUND((select IFNULL(sum(bs2.weight), 0) from bag_styles bs2 WHERE bs2.bag_id=bag.id AND bs2.other_accessories_id=2), 3) + 
          ROUND((select IFNULL(sum(bs2.weight), 0) from bag_styles bs2 WHERE bs2.bag_id=bag.id AND bs2.other_accessories_id>2), 3) 
        ) 
        -
        (
          (SELECT IFNULL(sum(til3.weight), 0) FROM transaction_item_loss_details til3 JOIN transaction t3 on t3.id=til3.transaction_id WHERE t3.bag_id=bag.id AND til3.type=1) +
          (SELECT IFNULL(sum(til3.weight), 0) FROM transaction_item_loss_details til3 JOIN transaction t3 on t3.id=til3.transaction_id WHERE t3.bag_id=bag.id AND til3.type=2) +
          (SELECT IFNULL(sum(til3.weight), 0) FROM transaction_item_loss_details til3 JOIN transaction t3 on t3.id=til3.transaction_id WHERE t3.bag_id=bag.id AND til3.type=0) +
          IFNULL((SELECT 
            ROUND(SUM(
              IFNULL(t1.total_receive_weight, 0) - IFNULL((SELECT t3.total_receive_weight FROM transaction t3 WHERE t3.bag_id=t1.bag_id AND t3.id < t1.id ORDER BY t3.id DESC LIMIT 1), 0)
            ), 3)
            FROM  transaction t1
            WHERE t1.to_bag_id=bag.id 
            AND   t1.transaction_mode=2)
          , 0) + 
          IFNULL(
            (
              SELECT 
                ROUND(SUM((SELECT IFNULL(sum(bs2.weight), 0) from bag_styles bs2 WHERE bs2.bag_id=t1.to_bag_id AND bs2.style_id IS NOT NULL)), 3) 
              FROM  transaction t1
              WHERE t1.bag_id=bag.id 
              AND   t1.transaction_mode=1
            )
          , 0) 
        )
      , 3) as cross_weight"),
      DB::raw("GROUP_CONCAT(bag_styles.style_id) as style"),
      //DB::raw("GROUP_CONCAT(bag_styles.instructions) instruction"),
      DB::raw("GROUP_CONCAT(style.sku) sku"),
      "employee.name as employee",
      DB::raw("IFNULL((SELECT 
      ROUND(SUM(
        IFNULL(t1.total_receive_weight, 0) - IFNULL((SELECT t3.total_receive_weight FROM transaction t3 WHERE t3.bag_id=t1.bag_id AND t3.id < t1.id ORDER BY t3.id DESC LIMIT 1), 0)
      ), 3)
      FROM  transaction t1
      WHERE t1.bag_id=bag.id 
      AND   t1.transaction_mode=2),0) 
      as merge_inward"),
      DB::raw("IFNULL((SELECT 
      ROUND(SUM(
        IFNULL(t1.total_receive_weight, 0) - IFNULL((SELECT t3.total_receive_weight FROM transaction t3 WHERE t3.bag_id=t1.bag_id AND t3.id < t1.id ORDER BY t3.id DESC LIMIT 1), 0)
      ), 3)
      FROM  transaction t1
      WHERE t1.to_bag_id=bag.id 
      AND   t1.transaction_mode=2), 0) 
      as merge_outward"),
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
    $query->where("bag.department_id", "=", "1");
    $query->whereNotIn("bag.status", array(2, 4, 5));
    $query->groupBy('bag.id', 'bag.parent_bag_id', 'bag.bag_number', 'bag.order_number');
    $query->orderBy('bag.id', 'DESC');

    return XModel::preparePagination($query, $request, ['bag.bag_number', 'bag.order_number']);
  }
}
