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

        $query = Bag::query()->select(
            "bag.*",
            "bag.parent_bag_id",
            "bag.bag_number",
            "bag.order_number",
            "department.name as department",
            DB::raw("DATE_FORMAT(bag.updated_at, '%d/%c/%Y %r') as time"),
            DB::raw("ROUND(SUM(bag_styles.quantity),3) as quantity"),
            DB::raw("ROUND(SUM(bag_styles.weight),3) as weight"),
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
        $query->groupBy('bag.id', 'bag.parent_bag_id', 'bag.bag_number', 'bag.order_number');
        $query->orderBy('bag.id', 'DESC');

        return XModel::preparePagination($query, $request, ['bag.bag_number', 'bag.order_number']);
    }
}
