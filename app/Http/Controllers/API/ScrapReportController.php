<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\TransactionItemLossDetails;
use App\User;
use Illuminate\Http\Request;
use App\GenXCommon\XModel;
use Illuminate\Support\Facades\DB;

class ScrapReportController extends Controller
{
  /**
   * Getting grid data
   *
   */

  public function getIndex()
  {
    self::hasPermission('index.scrapreport');
    return view("scrap_report.index");
  }
  /**
   * Display a listing of the resource.
   *
   * @return \Illuminate\Http\Response
   */
  public function index(Request $request)
  {
    self::hasPermission('index.scrapreport');

    $query = TransactionItemLossDetails::query()->select(
      "bag.id",
      "bag.bag_number",
      "bag.order_number",
      "transaction_item_loss_details.weight",
      DB::raw("DATE_FORMAT(transaction_item_loss_details.updated_at, '%d/%c/%Y %r') as time"),
      DB::raw("1 as quantity"),
      DB::raw("GROUP_CONCAT(style.sku) sku"),
      "employee.name as employee",
      "department.name as department",
    );

    $query->leftJoin('transaction', 'transaction.id', '=', 'transaction_item_loss_details.transaction_id');
    $query->leftJoin('bag', 'bag.id', '=', 'transaction.bag_id');
    $query->leftJoin('bag_styles', 'bag_styles.bag_id', '=', 'bag.id');
    $query->leftJoin('style', 'bag_styles.style_id', '=', 'style.id');
    $query->leftJoin('employee', 'employee.id', '=', 'transaction.from_employee_id');
    $query->leftJoin('department', 'department.id', '=', 'transaction.from_department_id');

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

    $query->where("transaction_item_loss_details.type", "=", "1");
    $query->groupBy('bag.id', 'bag.bag_number', 'bag.order_number', 'transaction_item_loss_details.weight');
    $query->orderBy('bag.id', 'DESC');

    return XModel::preparePagination($query, $request, ['bag.bag_number', 'bag.order_number']);
  }
}
