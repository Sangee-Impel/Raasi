<?php

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        $this->call(\Database\Seeds\PermissionsTableSeeder::class);
        $this->call(\Database\Seeds\RolesTableSeeder::class);
        $this->call(UserTableSeeder::class);
    }
}
