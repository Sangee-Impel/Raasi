  @extends('layouts.home')

@section('content')
    <transaction inline-template>
        <div class="padding">
            @include('__global.loading')
            <div class="row">
                <div class="col-sm-12 col-md-12 col-lg-12">
                    <div class="box">
                        <div class="box-header">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="row">
                                        <div class="col-lg-8 ">
                                            <h2 class="pt-1">Transaction</h2>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="box-body">
                            <div class="row">
                                <div class="col-lg-12">
                                    <form class="ui form  fix-sui">
                                        <!--<div class="row">
                                            <div class="col-lg-2">
                                                <viewer :images="images" :options="options">
                                                    <img v-for="src in images" width="100%" :src="src" :key="src">
                                                </viewer>
                                            </div>
                                        </div>-->
                                        <div class="row">
                                            <div class="col-lg-8 offset-lg-2">
                                                <div class="row">
                                                    <div class="col-lg-2">
                                                        <div class="field">
                                                            <label>Type</label>
                                                            <toggle-button class="mt-2"
                                                                           v-model="transaction_type"
                                                                           color="#a1c573"
                                                                           :sync="true"
                                                                           :width="130"
                                                                           :height="30"
                                                                           :labels="{checked: 'Received', unchecked: 'Issue'}" ></toggle-button>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-6 offset-lg-4">
                                                        <div class="field">
                                                            <label>Scan Job Card</label>
                                                            <div class="ui action input">
                                                                <input type="text" name="department_name" v-model="job_card_no" :disabled="true" placeholder="Job Card">
                                                                <button class="ui button "> <i class="fa fa-eye"></i></button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <div class="two fields mt-2">
                                                            <div class="field">
                                                                <label class="text-black">From Department *</label>
                                                                <v-select
                                                                    v-model="from_department"
                                                                    :options="departments"
                                                                    :searchable="true"
                                                                    :multiple="false"
                                                                    label="name"
                                                                    track-by="id"
                                                                    :show-labels="false"
                                                                    name="unit_id"
                                                                ></v-select>
                                                            </div>
                                                            <div class="field">
                                                                <label class="text-black">From Employee *</label>
                                                                <v-select
                                                                    v-model="from_employee"
                                                                    :options="employee"
                                                                    :searchable="true"
                                                                    :multiple="false"
                                                                    label="name"
                                                                    track-by="id"
                                                                    :show-labels="false"
                                                                    name="unit_id"
                                                                ></v-select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <div class="two fields">
                                                            <div class="field">
                                                                <label class="text-black">To Department *</label>
                                                                <v-select
                                                                    v-model="to_department"
                                                                    :options="departments"
                                                                    :searchable="true"
                                                                    :multiple="false"
                                                                    label="name"
                                                                    track-by="id"
                                                                    :show-labels="false"
                                                                    name="unit_id"
                                                                ></v-select>
                                                            </div>
                                                            <div class="field">
                                                                <label class="text-black">To Employee *</label>
                                                                <v-select
                                                                    v-model="to_employee"
                                                                    :options="employee"
                                                                    :searchable="true"
                                                                    :multiple="false"
                                                                    label="name"
                                                                    track-by="id"
                                                                    :show-labels="false"
                                                                    name="unit_id"
                                                                ></v-select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--<div class="col-lg-4">
                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <div class="box">
                                                            <div class="box-header">
                                                                <h3>Job Card Details</h3>
                                                            </div>
                                                            <div class="box-body">
                                                                <div class="table-responsive">
                                                                    <table class="ui celled table">
                                                                        <tbody>
                                                                        <tr>
                                                                            <td>
                                                                                Bag Name
                                                                            </td>
                                                                            <td>JCID-0001</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                Image
                                                                            </td>
                                                                            <td class="text-center">
                                                                                <img width="60%" src="{{asset('images/ring.jpg')}}" alt="ring" class="center"></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                Product :
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <table class="ui celled table m-0">
                                                                                    <thead>
                                                                                    <tr>
                                                                                        <td>Name</td>
                                                                                        <td>Uom</td>
                                                                                    </tr>
                                                                                    </thead>
                                                                                    <tbody>
                                                                                    <tr>
                                                                                        <td>Ring</td>
                                                                                        <td>Piece</td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>Stone</td>
                                                                                        <td>Piece</td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>Coil</td>
                                                                                        <td>Weight</td>
                                                                                    </tr>
                                                                                    </tbody>
                                                                                </table>
                                                                            </td>
                                                                        </tr>
                                                                        </tbody>
                                                                    </table>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>-->
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <div class="box">
                                                    <div class="box-header">
                                                        <div class="row">
                                                            <div class="col-lg-8 ">
                                                                <h3>Transfer Item</h3>
                                                            </div>
                                                            <div class="col-lg-4 ">
                                                                <button class="btn btn-fw info pull-right" type="button" @click="addItem"><i class="fa fa-plus"></i>Add Item</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="box-body">
                                                        <div class="table-responsive">
                                                            <table class="ui celled table">
                                                                <thead>
                                                                <tr>
                                                                    <th>S.No</th>
                                                                    <th>Image</th>
                                                                    <th>Product Name</th>
                                                                    <th>Uom</th>
                                                                    <th>Quantity</th>
                                                                    <th>Weight</th>
                                                                    <th>Action</th>
                                                                </tr>
                                                                </thead>
                                                                <tbody>
                                                                <tr>
                                                                    <td>1</td>
                                                                    <td>
                                                                        <viewer :options="options">
                                                                            <img width="100px" src="{{asset('images/ring.jpg')}}" alt="ring" class="center">
                                                                        </viewer>
                                                                    </td>
                                                                    <td>Ring</td>
                                                                    <td>Piece</td>
                                                                    <td>5</td>
                                                                    <td>100 g</td>
                                                                    <td></td>
                                                                </tr>
                                                                <tr>
                                                                    <td>2</td>
                                                                    <td>
                                                                        <viewer :options="options">
                                                                            <img width="100px" src="{{asset('images/stone.jpeg')}}" alt="stone" class="center">
                                                                        </viewer>
                                                                    </td>
                                                                    <td>Stone</td>
                                                                    <td>Piece</td>
                                                                    <td>100</td>
                                                                    <td>50 g</td>
                                                                    <td></td>
                                                                </tr>
                                                                <tr v-for="(otherItem,index) in otherItems">
                                                                    <td>@{{index+2}}</td>
                                                                    <td>
                                                                        <viewer :options="options">
                                                                            <img width="100px" :src="otherItem.item.image_url" class="center">
                                                                        </viewer>
                                                                    </td>
                                                                    <td>
                                                                        <v-select
                                                                            v-model="otherItem.item"
                                                                            :options="additionalItem"
                                                                            :searchable="true"
                                                                            :multiple="false"
                                                                            label="name"
                                                                            track-by="id"
                                                                            :show-labels="false"
                                                                        ></v-select>
                                                                    </td>
                                                                    <td>@{{otherItem.item.uom}}</td>
                                                                    <td>@{{otherItem.item.quantity}}</td>
                                                                    <td>@{{otherItem.item.weight}}</td>
                                                                    <td> 
                                                                        <button class="btn btn-icon danger"
                                                                                 @click="removeItem(index)"
                                                                        >
                                                                            <i class="fa fa-remove"></i>
                                                                        </button>
                                                                    </td>
                                                                </tr>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="m-b btn-groups pull-right">
                                            <button class="btn btn-fw success " v-if="!transaction_type" type="button" >Issue</button>
                                            <button class="btn btn-fw success " v-if="transaction_type"  type="button" >Receive</button>
                                            <button class="btn btn-fw dark " type="button" >Cancel</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </transaction>
@endsection
