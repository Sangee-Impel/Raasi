<?php

namespace Database\Seeds;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Seeder;
use jeremykenedy\LaravelRoles\Models\Permission;

class PermissionsTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $defaults = array('index', 'store', 'update', 'destroy', 'restore');
        $list_data = array(
            "User"      =>$defaults,
            "Role"      =>$defaults,
            "Unit"      =>$defaults,
            "Department"=>$defaults,
            "Employee"  =>$defaults,
            "Process"  =>$defaults,
            "ProductCategory"  =>$defaults,
            "Product"   =>$defaults,
            "Uom"       =>$defaults,
            "Bag"       =>array_merge($defaults,['cancel']),
            "Transaction"=>['store','merge','split'],
            "TransactionReport"=>['index'],
            "Configuration"=>['index'],
            "OtherAccessories"  =>$defaults,
            "LossApproval"  =>['index'],
            "TallyReport"  =>['index'],
        );
        foreach ($list_data as $key=>$value) {
            $modelPermission = Permission::where('slug', strtolower( $key ))->first();
            if ( $modelPermission === null) {
                $modelPermission = Permission::create([
                    'name'        => preg_replace('/(?<!\ )[A-Z]/', ' $0', $key),
                    'slug'        => $key, #index.Unit
                    'description' => $key,
                    'model'       => $key,
                ]);
            }
            $id = $modelPermission->id;
            if(count($value)) {
                $model_name = str_replace(" ", "",$key);
                foreach ($value as $in => $permission) {
                    $name = $permission;
                    if( !in_array($permission, $defaults) ){
                        $name = ucwords(str_replace("_", " ", $permission));
                    }else {
                        if ($permission === "index")        $name = "View/List " . $key;
                        else if ($permission === "store")   $name = "Create New " . $key;
                        else if ($permission === "update")  $name = "Edit/Update " . $key;
                        else if ($permission === "destroy") $name = "Trash/Destory " . $key;
                        else if ($permission === "restore") $name = "Restore " . $key;
                        else if ($permission === "view")    $name = "View " . $key;
                        else if ($permission === "list")    $name = "List " . $key;
                        else if ($permission === "test")    $name = "Listtest " . $key;
                    }
                    $slug_val = $permission.'.'.$key;
                    if (Permission::where('slug', strtolower( str_replace('_','',$slug_val) ))->first() === null) {
                        $model            = Permission::create([
                            'name'        => $name,
                            'slug'        => $slug_val, #index.Unit
                            'description' => $key,
                            'parent_id'   => $modelPermission->id,
                            'model'       => $model_name,
                        ]);
                    }
                }
            }
        }

    }
}
