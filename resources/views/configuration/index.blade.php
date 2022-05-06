@extends('layouts.home')

@section('content')
    <manage-configuration inline-template>
        <div class="padding">
            @include('__global.loading')
            <div>
                <div class="row">
                    @include('__global.loading')
                    <div class="col-sm-12 col-md-12 col-lg-12">
                        <div class="box">
                            <div class="box-header">
                                <div class="row">
                                    <div class="col-lg-10 offset-lg-1">
                                        <div class="row">
                                            <div class="col-lg-8 ">
                                                <h2 class="pt-1">Configuration</h2>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="box-body">
                                <div class="row">
                                    <div class="col-lg-10 offset-lg-1">
                                        <form class="ui form  fix-sui">
                                            <div class="two fields">
                                                <div class="field ">
                                                    <label>Precision*</label>
                                                    <input type="text" name="precision" v-model="form.precision.config_value" placeholder="Precision">
                                                    <div class="ui pointing red basic label" v-show="form.errors.has('precision.config_value')">
                                                        @{{ form.errors.get('precision.config_value') }}
                                                    </div>
                                                </div>
                                                <div class="field ">
                                                    <label>Bag Cancel OTP Number*</label>
                                                    <div class="ui labeled input">
                                                        <div class="ui label">
                                                           +91
                                                        </div>
                                                        <input type="text" name="bag_cancel_number" v-model="form.bag_cancel_number.config_value" placeholder="Mobile Number">
                                                    </div>
                                                    <div class="ui pointing red basic label" v-show="form.errors.has('bag_cancel_number.config_value')">
                                                        @{{ form.errors.get('bag_cancel_number.config_value') }}
                                                    </div>
                                                </div>
                                                <div class="field ">
                                                    <label>OTP Number*</label>
                                                    <div class="ui labeled input">
                                                        <div class="ui label">
                                                           +91
                                                        </div>
                                                        <input type="text" name="otp_number_1" v-model="form.otp_number_1.config_value" placeholder="Mobile Number">
                                                    </div>
                                                    <div class="ui pointing red basic label" v-show="form.errors.has('otp_number_1.config_value')">
                                                        @{{ form.errors.get('otp_number_1.config_value') }}
                                                    </div>
                                                </div>
                                                <div class="field ">
                                                    <label>OTP Number*</label>
                                                    <div class="ui labeled input">
                                                        <div class="ui label">
                                                           +91
                                                        </div>
                                                        <input type="text" name="otp_number_2" v-model="form.otp_number_2.config_value" placeholder="Mobile Number">
                                                    </div>
                                                    <div class="ui pointing red basic label" v-show="form.errors.has('otp_number_2.config_value')">
                                                        @{{ form.errors.get('otp_number_2.config_value') }}
                                                    </div>
                                                </div>
                                                <div class="field">
                                                    <label class="text-black">Bag Starting Department</label>
                                                    <v-select
                                                        placeholder="Department"
                                                        v-model="form.bag_starting_department.department"
                                                        :options="department_options"alreadyConfigurationValue
                                                        :searchable="true"
                                                        :multiple="false"
                                                        label="name"
                                                        track-by="id"
                                                        :show-labels="true"
                                                    ></v-select>
                                                    <div class="ui pointing red basic label" v-show="form.errors.has('bag_starting_department.bag_starting_department_id')">
                                                        @{{ form.errors.get('bag_starting_department.bag_starting_department_id') }}
                                                    </div>
                                                </div>

                                            </div>
                                            <div class="m-b btn-groups pull-right">
                                                <button class="btn btn-fw success " type="button" @click="submit">Submit</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </manage-configuration>
@endsection


