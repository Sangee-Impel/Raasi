<?php

use Illuminate\Database\Seeder;
use App\User;
use jeremykenedy\LaravelRoles\Models\Role;

class UserTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $email  = 'admin@gmail.com';
        $user = User::where('email','=',$email)->first();
        if(is_null($user)) {
            $user = User::create(
                array(
                    'name' => 'admin',
                    'email' => $email,
                    'password' => bcrypt('r0xs0ft007')
                )
            );

            $role = Role::where('slug', 'admin')->first();
            if(  !is_null($role) ) {
                $user->attachRole($role);
            }
        }
    }
}
