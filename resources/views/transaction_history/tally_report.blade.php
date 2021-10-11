
@extends('layouts.home')

@section('content')
<manage-tally-report inline-template>
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
                                        <h2 class="pt-3">Tally Report</h2>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="box-body">
                        <div class="row center">
                            @permission('index.tallyreport')
                            <div class="col-sm-12 col-md-12 col-lg-12 center">
                                <div class="ui centered grid">
                                    <div class="fourteen wide column">
                                        <form class="ui form  fix-sui">
                                            <div class="three fields">
                                                <div class="field custom_date">
                                                    <label>Transfer Date *</label>
                                                    <v-date-picker
                                                        v-model="form.date"
                                                        class="date-picker-customize"
                                                        enable-button-validate
                                                        format="YYYY-MM-DD"
                                                        formatted="D MMM YYYY"
                                                        label=" "
                                                        only-date

                                                        title="Payment date">
                                                    </v-date-picker>
                                                    <div class="ui pointing red basic label"
                                                         v-show="form.errors.has('date')">
                                                        @{{ form.errors.get('date') }}
                                                    </div>
                                                </div>
                                                <div class="field">
                                                    <button class="btn btn-fw success mt-4" type="button" @click="getTransactionHistory">Search</button>
                                                </div>

                                            </div>
                                            <div class="ui three column grid">
                                                <div class="column">
                                                    <div class="ui fluid card green">
                                                        <div class="content">
                                                            <div class="header">Total Transfer Quantity</div>
                                                        </div>
                                                        <div class="extra content">
                                                            @{{transaction_sum.total_transfer_quantity}}
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="column">
                                                    <div class="ui fluid card red">
                                                        <div class="content">
                                                            <div class="header">Total Transfer Weight</div>
                                                        </div>
                                                        <div class="extra content">
                                                            @{{transaction_sum.total_transfer_weight|bindPrecisionRound}}
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="column">
                                                    <div class="ui fluid card orange">
                                                        <div class="content">
                                                            <div class="header">Total Receive Weight</div>
                                                        </div>
                                                        <div class="extra content">
                                                            @{{transaction_sum.total_receive_weight|bindPrecisionRound}}
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="column">
                                                    <div class="ui fluid card yellow">
                                                        <div class="content">
                                                            <div class="header">Total Loss</div>
                                                        </div>
                                                        <div class="extra content">
                                                            @{{transaction_sum.total_loss|bindPrecisionRound}}
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="column">
                                                    <div class="ui fluid card pink">
                                                        <div class="content">
                                                            <div class="header">Total Scrab</div>
                                                        </div>
                                                        <div class="extra content">
                                                            @{{transaction_sum.total_scrab|bindPrecisionRound}}
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <table class="ui celled table">
                                                <thead>
                                                <tr>
                                                    <th>S.No</th>
                                                    <th>Date</th>
                                                    <th>Lot Number</th>
                                                    <th>Order Number</th>
                                                    <th>Total Transfer Quantity</th>
                                                    <th>Total Transfer Weight</th>
                                                    <th>Total Receive Weight</th>
                                                    <th>Total Loss</th>
                                                    <th>Total Scrab</th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                <tr v-for="(transaction_history,index) in transaction_histories">
                                                    <td>@{{index+1}}</td>
                                                    <td>@{{transaction_history.transaction_date | formatDate('DD-MM-YYYY')}}</td>
                                                    <td>@{{transaction_history.bag_number}}</td>
                                                    <td>@{{transaction_history.order_number}}</td>
                                                    <td>@{{transaction_history.total_transfer_quantity}}</td>
                                                    <td>@{{transaction_history.total_transfer_weight|bindPrecisionRound}}</td>
                                                    <td>@{{transaction_history.total_receive_weight|bindPrecisionRound}}</td>
                                                    <td>@{{transaction_history.total_loss|bindPrecisionRound}}</td>
                                                    <td>@{{transaction_history.total_scrab|bindPrecisionRound}}</td>
                                                </tr>
                                                <tr v-if="transaction_histories.length == 0">
                                                    <td colspan="9">No Data</td>
                                                </tr>
                                                <tr v-else>
                                                    <td colspan="4">Total</td>
                                                    <td>@{{transaction_sum.total_transfer_quantity}}</td>
                                                    <td>@{{transaction_sum.total_transfer_weight|bindPrecisionRound}}</td>
                                                    <td>@{{transaction_sum.total_receive_weight|bindPrecisionRound}}</td>
                                                    <td>@{{transaction_sum.total_loss|bindPrecisionRound}}</td>
                                                    <td>@{{transaction_sum.total_scrab|bindPrecisionRound}}</td>
                                                </tr>
                                                </tbody>
                                            </table>

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
</manage-tally-report>
@endsection


