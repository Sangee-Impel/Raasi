<?php

/**
 * Created by IntelliJ IDEA.
 * User: baskar
 * Date: 12/9/18
 * Time: 3:03 PM
 */

namespace App\GenXCommon;


use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Config;
use OwenIt\Auditing\Contracts\Auditable;
use OwenIt\Auditing\Models\Audit;

abstract class XModel extends Model implements Auditable
{
    use SoftDeletes;
    use \OwenIt\Auditing\Auditable;

    /**
     * @param Builder | Model $builder
     * @param Request $request
     * @param array $filterColumns
     * @return \Illuminate\Contracts\Pagination\LengthAwarePaginator
     */
    public static function preparePagination($builder, Request $request, $filterColumns = [])
    {
        if (get_class($builder) == Builder::class) {
            $query = $builder;
        } elseif (is_string($builder)) {
            $query = $builder::query();
        }
        // handle sort option
        if (request()->has('sort') && strpos($request->get('sort'), '|') > -1) {
            // handle multisort
            $sorts = explode(',', request()->sort);
            foreach ($sorts as $sort) {
                list($sortCol, $sortDir) = explode('|', $sort);
                $query = $query->orderBy($sortCol, $sortDir);
            }
        } else {
            $query = $query->orderBy('id', 'desc');
        }

        if ($request->exists('filter')) {
            $query->where(function ($q) use ($request, $filterColumns) {
                $value = "%{$request->filter}%";
                foreach ($filterColumns as $inx => $column) {
                    if ($inx == 0) {
                        $q->where($column, 'like', $value);
                    } else {
                        $q->orWhere($column, 'like', $value);
                    }
                }
            });
        }
        

        $perPage = request()->has('per_page') ? (int) request()->per_page : null;
        $pagination = $query->paginate($perPage);

        $pagination->appends([
            'sort' => request()->sort,
            'filter' => request()->filter,
            'per_page' => request()->per_page
        ]);

        return $pagination;
    }


    public static function getConfigType($name = null, $type = "transaction_type", $searchKey  = "value")
    {
        $data = [];
        switch ($type) {
            case "transaction":
                $reference_type = Config::get('constants.transaction');
                break;
            case "transaction_type":
                $reference_type = Config::get('constants.transaction_type');
                break;
            case "transaction_item_loss_type":
                $reference_type = Config::get('constants.transaction_item_loss_type');
                break;
            case "transaction_item_loss_status":
                $reference_type = Config::get('constants.transaction_item_loss_status');
                break;
            case "loss_reason_type":
                $reference_type = Config::get('constants.loss_reason_type');
                break;
            case "bag_status":
                $reference_type = Config::get('constants.bag.status');
                break;
            case "split_bag_status":
                $reference_type = Config::get('constants.bag.split.status');
                break;
            case "transaction_mode":
                $reference_type = Config::get('constants.transaction_mode');
                break;
            case "transaction_item_type":
                $reference_type = Config::get('constants.transaction_item_type');
                break;
            default:
                $reference_type = Config::get('constants.transaction_type');
        }
        if (!is_null($name)) {
            $data = $reference_type[array_search($name, array_column($reference_type, $searchKey))];
        }
        return $data;
    }
}
