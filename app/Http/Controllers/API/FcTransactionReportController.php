<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Bag;
use App\GenXCommon\XModel;
use Illuminate\Support\Facades\DB;

class FcTransactionReportController extends Controller
{
    public function getIndex()
    {
        self::hasPermission('index.fctransactionreport');
        return view("fctransaction_report.index");
    }

    public function index(Request $request)
    {
        self::hasPermission('index.openingreport');

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

        $query = Bag::query()->select(
            "bag.*",
            "bag.parent_bag_id",
            "bag.bag_number",
            "bag.order_number",
            "department.name as department",
            DB::raw("DATE_FORMAT(bag.updated_at, '%d/%c/%Y %r') as time"),
            DB::raw("ROUND(SUM(bag_styles.quantity) - IFNULL((SELECT lst.total_loss_quantity FROM transaction lst WHERE lst.bag_id = bag.id ORDER BY lst.id DESC LIMIT 1), 0),3) as quantity"),
            //DB::raw("ROUND(SUM(bag_styles.weight),3) as weight"),
            //DB::raw("(SELECT IFNULL(sum(t1.total_receive_weight), 0) FROM transaction t1 WHERE t1.bag_id = bag.id AND t1.to_department_id=9 order by t1.id desc limit 1) as weight"),
            //DB::raw("CASE WHEN (SELECT IFNULL(sum(t1.total_receive_weight), 0) FROM transaction t1 WHERE t1.bag_id = bag.id AND t1.transaction_date >= '" . $from_date . "' AND t1.transaction_date <= '" . $to_date . "' AND t1.to_department_id=9 order by t1.id desc limit 1) > 0 THEN (SELECT IFNULL(sum(t1.total_receive_weight), 0) FROM transaction t1 WHERE t1.bag_id = bag.id AND t1.transaction_date >= '" . $from_date . "' AND t1.transaction_date <= '" . $to_date . "' AND t1.to_department_id=9 order by t1.id desc limit 1) ELSE ROUND(SUM(bag_styles.weight),3) END as weight"),
            DB::raw("
                IFNULL(
                    (
                        SELECT 
                        IFNULL(t1.total_receive_weight, 0) 
                        FROM transaction t1 
                        WHERE t1.bag_id = bag.id 
                        AND t1.to_department_id=9 
                        ORDER BY t1.id DESC LIMIT 1
                    )
                , 0) as weight"
            ),
            DB::raw("GROUP_CONCAT(bag_styles.style_id) as style"),
            DB::raw("GROUP_CONCAT(style.sku) sku")
        );

        $query->leftJoin('bag_styles', 'bag_styles.bag_id', '=', 'bag.id');
        $query->leftJoin('style', 'bag_styles.style_id', '=', 'style.id');
        $query->leftJoin('department', 'department.id', '=', 'bag.department_id');

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

        $query->where("bag.department_id", 9);
        $query->whereNotIn("bag.status", array(2, 4, 5));
        $query->groupBy('bag.id', 'bag.parent_bag_id', 'bag.bag_number', 'bag.order_number');
        $query->orderBy('bag.id', 'DESC');

        return XModel::preparePagination($query, $request, ['bag.bag_number', 'bag.order_number']);
    }
}
