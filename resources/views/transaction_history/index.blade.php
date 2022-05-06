@extends('layouts.home')

@section('content')
<manage-transaction-history inline-template>
    <div class="padding">
        @include('__global.loading')
        <div class="row" >
            <div class="col-sm-12 col-md-12 col-lg-12">
                <div class="box">
                    <div class="box-header">
                        <div class="row">
                            <div class="col-lg-1"></div>
                            <div class="col-lg-10">
                                <div class="row">
                                    <div class="col-lg-6 ">
                                        <h2 class="pt-3">Transactions History</h2>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="box-body">
                        <div class="row center">
                            @permission('index.transactionreport')
                            <div class="col-sm-12 col-md-12 col-lg-12 center">
                                <div class="ui centered grid">
                                    <div class="fourteen wide column">
                                        <form class="ui form  fix-sui">
                                            <div class="three fields">
                                                <div class="four wide field">
                                                    <div class="ui  buttons mt-4">
                                                        <button type="button" v-on:click="changeTabStatus('issue')" v-bind:class="{ basic : ( form.tab_status != 'issue')  }" class="ui green  button"><b>Issue  </b></button>
                                                        <button type="button" v-on:click="changeTabStatus('receive')" v-bind:class="{ basic : ( form.tab_status != 'receive')  }"class="ui blue button "><b>Receive</b></button>
                                                    </div>
                                                </div>
                                                <div class="field custom_date">
                                                    <label>Transfer Date</label>
                                                    <v-date-picker
                                                        v-model="form.date_range"
                                                        class="date-picker-customize"
                                                        enable-button-validate
                                                        format="YYYY-MM-DD"
                                                        formatted="D MMM YYYY"
                                                        label=" "
                                                        only-date
                                                        range
                                                        title="Payment date">
                                                    </v-date-picker>
                                                    <div class="ui pointing red basic label"
                                                         v-show="form.errors.has('date_range.start')">
                                                        @{{ form.errors.get('date_range.start') }}
                                                    </div>
                                                    <div class="ui pointing red basic label"
                                                         v-show="form.errors.has('date_range.end')">
                                                        @{{ form.errors.get('date_range.end') }}
                                                    </div>
                                                </div>
                                                <div class="field">
                                                    <label class="text-black">Department</label>
                                                    <v-select
                                                        placeholder="Department"
                                                        v-model="department"
                                                        :options="department_options"
                                                        :searchable="true"
                                                        :multiple="false"
                                                        label="name"
                                                        track-by="id"
                                                        :show-labels="true"
                                                        @input="loadDropDownData('department')"
                                                        :disabled="displayStatus.department"
                                                    ></v-select>
                                                    <div class="ui pointing red basic label"
                                                         v-show="form.errors.has('department_id')">
                                                        @{{ form.errors.get('department_id') }}
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="three fields">
                                                <div class="field">
                                                    <label class="text-black">Search</label>
                                                    <input type="text" v-model="form.search" placeholder="Search">
                                                </div>
                                                <div class="field">
                                                    <label class="text-black">Employee</label>
                                                    <v-select
                                                        placeholder="Employee"
                                                        v-model="employee"
                                                        :options="employee_options"
                                                        :searchable="true"
                                                        :multiple="false"
                                                        label="name"
                                                        track-by="id"
                                                        :show-labels="true"
                                                        :disabled="displayStatus.employee"
                                                    ></v-select>
                                                    <div class="ui pointing red basic label"
                                                         v-show="form.errors.has('employee_id')">
                                                        @{{ form.errors.get('employee_id') }}
                                                    </div>
                                                </div>
                                                <div class="field">
                                                    <button class="btn btn-fw success mt-4" type="button" @click="getTransactionHistory">Search</button>
                                                </div>
                                            </div>
                                            <table class="ui celled table">
                                                <thead>
                                                    <tr>
                                                        <th>S.No</th>
                                                        <th>Date</th>
                                                        <th>Lot Number</th>
                                                        <th>Order Number</th>
                                                        <th>Department</th>
                                                        <th>Employee</th>
                                                        <th>Total Transfer Quantity</th>
                                                        <th>Total Transfer Weight</th>
                                                        <th>Total Receive Weight</th>
                                                        <th>Action</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr v-for="(transaction_history,index) in transaction_histories">
                                                        <td>@{{index+1}}</td>
                                                        <td>@{{transaction_history.transaction_date | formatDate('DD-MM-YYYY')}}</td>
                                                        <td>@{{transaction_history.bag_number}}</td>
                                                        <td>@{{transaction_history.order_number}}</td>
                                                        <td>@{{transaction_history.department_name}}</td>
                                                        <td>@{{transaction_history.employee_name}}</td>
                                                        <td>@{{transaction_history.total_transfer_quantity|bindPrecisionRound}}</td>
                                                        <td>@{{transaction_history.total_transfer_weight|bindPrecisionRound}}</td>
                                                        <td>@{{transaction_history.total_receive_weight|bindPrecisionRound}}</td>
                                                        <td>
                                                            <!--<button class="btn btn-icon indigo" type="button"
                                                                    @click="onViewTransferItem(index)">
                                                                <i class="fa fa-eye"></i>
                                                            </button>-->
                                                            <button class="btn btn-icon indigo" type="button"
                                                                    @click="onViewBagTransaction(index)">
                                                                <i class="fa fa-eye"></i>
                                                            </button>
                                                        </td>
                                                    </tr>
                                                    <tr v-if="transaction_histories.length == 0">
                                                        <td col-span="7">No Data</td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <sui-modal v-model="transferItemModal">
                                                <sui-modal-header>Transfer Item</sui-modal-header>
                                                <sui-modal-content scrolling>
                                                    <sui-modal-description>
                                                        <sui-segment>
                                                            <div class="row">
                                                                <div class="col-lg-12">
                                                                    <div class="table-hover scroll-x" >
                                                                        <table class="ui celled table ">
                                                                            <thead>
                                                                            <tr>
                                                                                <th>S.No</th>
                                                                                <th>Item</th>
                                                                                <th>Uom</th>
                                                                                <th>Quantity</th>
                                                                                <th>Weight</th>
                                                                                <th>Receive Weight</th>
                                                                            </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                            <tr   v-for="(transaction_item,index) in transaction_items">
                                                                                <td >@{{index+1}}</td>
                                                                                <td>
                                                                                    <div v-if="transaction_item.type == types.findTransactionType('bag','value','transaction_type')['id']">
                                                                                        <div v-if="transaction_item.bag_style.style != null ">
                                                                                            @{{transaction_item.bag_style.style.sku}}
                                                                                        </div>
                                                                                        <div v-else>
                                                                                            @{{transaction_item.bag_style.other_accessories.name}}
                                                                                        </div>
                                                                                    </div>
                                                                                    <div v-else>
                                                                                        @{{transaction_item.other_accessories.name}}
                                                                                    </div>
                                                                                </td>
                                                                                <td>
                                                                                    @{{transaction_item.uom.name}}
                                                                                </td>
                                                                                <td>
                                                                                    @{{transaction_item.quantity|bindPrecisionRound}}
                                                                                </td>
                                                                                <td>
                                                                                    @{{transaction_item.weight|bindPrecisionRound}}
                                                                                </td>
                                                                                <td>
                                                                                    @{{transaction_item.receive_weight|bindPrecisionRound}}
                                                                                </td>
                                                                            </tr>
                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </sui-segment>
                                                    </sui-modal-description>
                                                </sui-modal-content>
                                                <sui-modal-actions>
                                                    <sui-button positive type="button" @click.native="transferItemViewToggle">
                                                        Close
                                                    </sui-button>
                                                </sui-modal-actions>
                                            </sui-modal>
                                            <sui-modal v-model="viewBagTransactionModal">
                                                <sui-modal-header>Transaction History</sui-modal-header>
                                                <sui-modal-content scrolling>
                                                    <sui-modal-description>
                                                        <sui-segment>
                                                            <div class="row m-3" >
                                                                <div class="col-lg-6" v-if="view_transaction_histories.bag.bag_number">
                                                                    <p>Lot No - <span>@{{view_transaction_histories.bag.bag_number}}</span></p>
                                                                </div>
                                                                <div class="col-lg-6" v-if="view_transaction_histories.bag.order_number">
                                                                    <p class="pull-right">Order No - <span>@{{view_transaction_histories.bag.order_number}}</span></p>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-lg-12">
                                                                    <div class="table-hover scroll-x" >
                                                                        <table class="ui celled table ">
                                                                            <thead>
                                                                            <tr>
                                                                                <th>Date</th>
                                                                                <th>Department</th>
                                                                                <th>Employee</th>
                                                                                <th>Total Transfer Quantity</th>
                                                                                <th>Total Transfer Weight</th>
                                                                                <th>Total Receive Weight</th>
                                                                                <th>Total Loss</th>
                                                                                <th>Total Scrab</th>
                                                                                <th>Total Channam</th>
                                                                            </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                            <tr   v-for="(view_transaction_history,history_index) in view_transaction_histories.transaction">
                                                                                <td>@{{view_transaction_history.transaction_date | formatDate('DD-MM-YYYY')}}</td>
                                                                                <td>@{{view_transaction_history.department_name}}</td>
                                                                                <td>@{{view_transaction_history.employee_name}}</td>
                                                                                <td>@{{view_transaction_history.total_transfer_quantity|bindPrecisionRound}}</td>
                                                                                <td>@{{view_transaction_history.total_transfer_weight|bindPrecisionRound}}</td>
                                                                                <td>@{{view_transaction_history.total_receive_weight|bindPrecisionRound}}</td>
                                                                                <td>@{{view_transaction_history.total_loss|bindPrecisionRound}}</td>
                                                                                <td>@{{view_transaction_history.total_scrab|bindPrecisionRound}}</td>
                                                                                <td>@{{view_transaction_history.total_channam|bindPrecisionRound}}</td>
                                                                            </tr>
                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </sui-segment>
                                                    </sui-modal-description>
                                                </sui-modal-content>
                                                <sui-modal-actions>
                                                    <sui-button positive type="button" @click.native="viewBagTransactionToggle">
                                                        Close
                                                    </sui-button>
                                                </sui-modal-actions>
                                            </sui-modal>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            @endpermission
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</manage-transaction-history>
@endsection


