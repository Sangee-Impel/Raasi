<?php

namespace Database\Seeds;

use App\User;
use Illuminate\Database\Seeder;
use jeremykenedy\LaravelRoles\Models\Permission;
use jeremykenedy\LaravelRoles\Models\Role;

class RolesTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        /*
         * Role Types
         *
         */
        $RoleItems = [
            [
                'name'        => 'Admin',
                'slug'        => 'admin',
                'description' => 'Admin Role',
                'level'       => 5,
            ],
            [
                'name'        => 'Staff',
                'slug'        => 'staff',
                'description' => 'Staff Role',
                'level'       => 2,
                
            ],
            [
                'name'        => 'Employee',
                'slug'        => 'employee',
                'description' => 'Employee Role',
                'level'       => 1,

            ]
        ];

        /*
         * Add Role Items
         *
         */
        foreach ($RoleItems as $RoleItem) {
            $newRoleItem = config('roles.models.role')::where('slug', '=', $RoleItem['slug'])->first();
            if ($newRoleItem === null) {
                $model = config('roles.models.role')::create([
                    'name'          => $RoleItem['name'],
                    'slug'          => $RoleItem['slug'],
                    'description'   => $RoleItem['description'],
                    'level'         => $RoleItem['level'],
                ]);
                if(  $RoleItem['level'] == 5 ){
                    $model->syncPermissions(Permission::all()->pluck('id'));
                }
            }
        }
    }
}
