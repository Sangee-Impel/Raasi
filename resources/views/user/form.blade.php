<form-user inline-template  ref="roleForm" class="sub_content" >
    <div class="row">
        @include('__global.loading')
        <div class="col-sm-12 col-md-12 col-lg-12">
            <div class="box">
                <div class="box-header">
                    <div class="row">
                        <div class="col-lg-8 offset-lg-2">
                            <div class="row">
                                <div class="col-lg-8 ">
                                    <h2 class="pt-1">@{{ formTitle }} User</h2>
                                </div>
                                <div class="col-lg-4 " v-if="!$parent.isProfile">
                                    <button class="btn btn-fw info pull-right" @click="showGrid">Manage</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="box-body">
                    <div class="row">
                        <div class="col-lg-12">
                            <form class="ui form  fix-sui">
                                <div class="three fields">
                                    <div class="field">
                                        <label>Username *</label>
                                        <input type="text" name="username" v-model="form.name" placeholder="Username">
                                        <div class="ui pointing red basic label" v-show="form.errors.has('name')">
                                            @{{ form.errors.get('name') }}
                                        </div>
                                    </div>
                                    <div class="field" v-if="!$parent.isProfile">
                                        <label>Role *</label>
                                        <v-select
                                            v-model="role"
                                            :options="roles_options"
                                            :searchable="true"
                                            :multiple="false"
                                            label="name"
                                            track-by="id"
                                            :show-labels="false"
                                        ></v-select>
                                        <div class="ui pointing red basic label" v-show="form.errors.has('role_id')">
                                            @{{ form.errors.get('role_id') }}
                                        </div>
                                    </div>
                                    <div class="field">
                                        <label>Email *</label>
                                        <input type="email" name="employee_salary" v-model="form.email" placeholder="Email">
                                        <div class="ui pointing red basic label" v-show="form.errors.has('email')">
                                            @{{ form.errors.get('email') }}
                                        </div>
                                    </div>
                                </div>
                                <div class="three fields">
                                    <div class="field" v-if="checkRoleStatus">
                                        <label>Department *</label>
                                        <v-select
                                            v-model="department"
                                            :options="departments_options"
                                            :searchable="true"
                                            :multiple="false"
                                            label="name"
                                            track-by="id"
                                            :show-labels="false"
                                        ></v-select>
                                        <div class="ui pointing red basic label" v-show="form.errors.has('department_id')">
                                            @{{ form.errors.get('department_id') }}
                                        </div>

                                    </div>
                                    <div class="field" >
                                        <label>Password *</label>
                                        <input type="password"  autocomplete="off" name="password" v-model="form.password" placeholder="Password">
                                        <div class="ui pointing red basic label" v-show="form.errors.has('password')">
                                            @{{ form.errors.get('password') }}
                                        </div>
                                    </div>
                                    <div class="field">
                                        <label>Confrim Password *</label>
                                        <input type="password" name="confrim_password" v-model="form.password_confirmation" placeholder="Confrim Password">
                                        <div class="ui pointing red basic label" v-show="form.errors.has('password_confirmation')">
                                            @{{ form.errors.get('password_confirmation') }}
                                        </div>
                                    </div>

                                </div>
                                <div class="m-b btn-groups pull-right">
                                    <button class="btn btn-fw success " type="button" @click="submit">Submit</button>
                                    <button class="btn btn-fw dark " v-if="!$parent.isProfile" type="button" @click="showGrid">Cancel</button>
                                </div>
                            </form>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</form-user> 
