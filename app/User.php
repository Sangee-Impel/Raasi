<?php

namespace App;


use App\Models\Department;
use App\Models\Employee;
use App\Models\Role;
use App\Models\RoleUser;
use App\Models\Uploads;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Notifications\Notifiable;
use jeremykenedy\LaravelRoles\Traits\HasRoleAndPermission;
use Laravel\Spark\User as SparkUser;
use Illuminate\Support\Facades\Auth;
use Laravel\Passport\HasApiTokens;
class User extends SparkUser
{
    use HasApiTokens,Notifiable,HasRoleAndPermission,SoftDeletes;


    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name',
        'email',
        'password',
        'department_id'
    ];

    /**
     * The attributes excluded from the model's JSON form.
     *
     * @var array
     */
    protected $hidden = [
        'password',
        'remember_token',
        'authy_id',
        'country_code',
        'phone',
        'two_factor_reset_code',
        'card_brand',
        'card_last_four',
        'card_country',
        'billing_address',
        'billing_address_line_2',
        'billing_city',
        'billing_zip',
        'billing_country',
        'extra_billing_information',
    ];


    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'trial_ends_at' => 'datetime',
        'uses_two_factor_auth' => 'boolean',
    ];


    public function roleUser(){
        return $this->hasMany(RoleUser::class);
    }
    /**
     * The roles that belong to the user.
     */
    public function roles()
    {
        $query = $this->belongsToMany(Role::class, 'role_user');
        //$query->where('slug', 'developer');
        return $query;
    }
    public function role_user()
    {
        return $this->belongsTo(RoleUser::class,'id','user_id')->with('role')->withTrashed();
    }
    

    public function uploads() {
        return $this->belongsToMany(Uploads::class,'user_id');
    }
    public function employee(){
        return $this->hasOne(Employee::class,'user_id','id')->with(['department']);
    }
    public function department(){
        return $this->belongsTo(Department::class,'department_id','id');
    }

    public static function getUserDetails($userID = null){
        $userID = (is_null($userID))?Auth::user()['id']:$userID;
        $user = User::findOrFail($userID);
        $user->department;
        $user->employee;
        return $user;
    }

}
