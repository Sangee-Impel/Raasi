@extends('layouts.home')

@section('content')
<manage-loss-approval inline-template>
    <div class="padding">
        @include('__global.loading')
        <div class="row">
            <div class="col-sm-12 col-md-12 col-lg-12">
                <div class="box">
                    <div class="box-header">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="row p-3">
                                    <div class="col-lg-2 ">
                                        <h2 class="pt-3">Loss Approval</h2>
                                    </div>
                                    <div class="col-lg-10">
                                        @include('__global.search_bar')
                                    </div>
                                </div>
                                <div class="ui centered grid" v-show="!is_advance_search">
                                    <div class="sixteen wide column">
                                        <div class="ui form ">
                                            <div class="field">
                                                <div class="three fields">
                                                    <div class="field">
                                                        <label>User Name</label>
                                                        <v-select placeholder="User" v-model="user" :options="user_options" :searchable="true" :multiple="false" label="name" track-by="id" :show-labels="true"></v-select>
                                                    </div>
                                                    <div class="field">
                                                        <label>Status</label>
                                                        <v-select placeholder="Status" v-model="status" :options="types.transaction_item_loss_status" :searchable="true" :multiple="false" label="name" track-by="id" :show-labels="true"></v-select>
                                                    </div>
                                                    <div class="field pt-4 mt-2">
                                                        <button class="btn btn-fw info" @click="onFilterSearch">Filter</button>
                                                        <button class="btn btn-fw " @click="closeAdvanceFilter">Close</button>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!--Advance filtter search-->

                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="box-body">
                        <div class="row center">
                            @permission('index.lossapproval')
                            <div class="col-sm-12 col-md-12 col-lg-12 center">
                                <vue-table ref="vuetable" api-url="{{ URL::route('loss-approval.index') }}" :fields="fields" pagination-path="" :http-fetch="vueTableFetch" @vuetable:pagination-data="onPaginationData" :append-params="vueTableParams">
                                    <template slot="actions" scope="props">
                                        <div class="custom-actions">
                                            <button class="btn btn-icon green" v-if="checkLossStatus(props.rowData.status)" @click="openReasonModelPopup(props.rowData)">
                                                <i class="fa fa-check"></i>
                                            </button>
                                        </div>
                                    </template>
                                </vue-table>
                                <table class="ui blue selectable celled stackable attached table">
                                    <tfoot class="vuetable-body">
                                        <tr>
                                            <td style="text-align: right; width: 50.6%;">Total</td>
                                            <td style="width: 11.8%;">
                                                <div v-html="totalWeight"></div>
                                            </td>
                                            <td style="width: 7.4%;">
                                                <div v-html="totalAdminWeight"></div>
                                            </td>
                                            <td style="width:117.79px"></td>
                                            <td></td>
                                        </tr>
                                    </tfoot>
                                </table>
                                <div class="vuetable-pagination ui basic segment grid">
                                    <vuetable-pagination-info ref="paginationInfo"></vuetable-pagination-info>
                                    <vuetable-pagination ref="pagination" @vuetable-pagination:change-page="onChangePage"></vuetable-pagination>
                                </div>
                            </div>
                            <sui-modal v-model="lossReasonModel">
                                <sui-modal-header>Reason for approval</sui-modal-header>
                                <sui-modal-content scrolling>
                                    <sui-modal-description>
                                        <div class="row  mt-3">
                                            <div class="col-lg-12">
                                                <form class="ui form  fix-sui">
                                                    <div class="three fields">
                                                        <div class="field">
                                                            <label>Reason*</label>
                                                            <v-select placeholder="Reason" v-model="form.reason_type" :options="types.loss_reason_type" :searchable="true" :multiple="false" label="name" track-by="id" :allow-empty="false" open-direction="bottom"></v-select>
                                                            <div class="ui pointing red basic label" v-show="form.errors.has('reason_type_id')">
                                                                @{{ form.errors.get('reason_type_id') }}
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="field" v-if="checkReasonStatus">
                                                        <div class="one field">
                                                            <label>Reason Description *</label>
                                                            <vue-editor v-model="form.loss_description"></vue-editor>
                                                            <div class="ui pointing red basic label" v-show="form.errors.has('loss_description')">
                                                                @{{ form.errors.get('loss_description') }}
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </sui-modal-description>
                                </sui-modal-content>
                                <sui-modal-actions>
                                    <button class="ui button medium green" @click="onSubmit" type="button">Save</button>
                                    <button class="ui button medium" @click="onCancel" type="button">Cancel</button>
                                </sui-modal-actions>
                            </sui-modal>
                            @endpermission
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</manage-loss-approval>
@endsection