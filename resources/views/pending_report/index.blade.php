@extends('layouts.home')

@section('content')
<manage-pending-report inline-template>
    <div class="padding">
        @include('__global.loading')
        <div class="row">
            <div class="col-sm-12 col-md-12 col-lg-12">
                <div class="box">
                    <div class="box-header">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="row p-3">
                                    <div class="col-lg-6 ">
                                        <h2 class="pt-3">Pending Lot Report (Issue Department Lots)</h2>
                                    </div>
                                    <div class="col-lg-6">
                                        @include('__global.search_bar')
                                    </div>
                                </div>
                                <div class="ui centered grid" v-show="!is_advance_search">
                                    <div class="sixteen wide column">
                                        <div class="ui form ">
                                            <div class="field">
                                                <div class="three fields">
                                                    <div class="field">
                                                        <label>From Date</label>
                                                        <input type="date" name="from_date" v-model="from_date">
                                                    </div>
                                                    <div class="field">
                                                        <label>To Date</label>
                                                        <input type="date" name="to_date" v-model="to_date">
                                                    </div>
                                                    <div class="field">
                                                        <label>Department Name</label>
                                                        <v-select placeholder="Department" v-model="department" :options="department_options" :searchable="true" :multiple="false" label="name" track-by="id" :show-labels="true" @input="bindEmployee"></v-select>
                                                    </div>
                                                    <div class="field">
                                                        <label>Employee Name</label>
                                                        <v-select placeholder="Employee" v-model="employee" :options="employee_options" :searchable="true" :multiple="false" label="name" track-by="id" :show-labels="true"></v-select>
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
                            @permission('index.pendingreport')
                            <div class="col-sm-12 col-md-12 col-lg-12 center">
                                <vue-table ref="vuetable" api-url="{{ URL::route('pending-report.index') }}" :fields="fields" pagination-path="" :http-fetch="vueTableFetch" @vuetable:pagination-data="onPaginationData" :append-params="vueTableParams">
                                </vue-table>
                                <table class="ui blue selectable celled stackable attached table">
                                    <tfoot class="vuetable-body">
                                        <tr>
                                            <td style="text-align: right; width: 45.5%;">Total</td>
                                            <td style="width: 5.6%;">
                                                <div v-html="totalWeight"></div>
                                            </td>
                                            <td style="width: 4.9%;">
                                                <div v-html="totalSplitOutward"></div>
                                            </td>
                                            <td style="width: 4.9%;">
                                                <div v-html="totalCurrentInward"></div>
                                            </td>
                                            <td style="width: 4.9%;">
                                                <div v-html="totalKambiInward"></div>
                                            </td>
                                            <td style="width: 4.9%;">
                                                <div v-html="totalFancyInward"></div>
                                            </td>
                                            <td style="width: 4.9%;">
                                                <div v-html="totalOtherInward"></div>
                                            </td>
                                            <td style="width: 8.8%;">
                                                <div v-html="totalScarpWeight"></div>
                                            </td>
                                            <td style="width: 10.7%;">
                                                <div v-html="totalChanamWeight"></div>
                                            </td>
                                            <td style="width: 8.3%;">
                                                <div v-html="totalLossWeight"></div>
                                            </td>
                                            <td style="width: 8.3%;">
                                                <div v-html="totalMergeInward"></div>
                                            </td>
                                            <td style="width: 8.3%;">
                                                <div v-html="totalMergeOutward"></div>
                                            </td>
                                            <td style="width: 8.9%;">
                                                <div v-html="totalCrossWeight"></div>
                                            </td>
                                            <td></td>
                                            <td> </td>
                                            <td></td>
                                            <td> </td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                    </tfoot>
                                </table>
                                <div class="vuetable-pagination ui basic segment grid">
                                    <vuetable-pagination-info ref="paginationInfo"></vuetable-pagination-info>
                                    <vuetable-pagination ref="pagination" @vuetable-pagination:change-page="onChangePage"></vuetable-pagination>
                                </div>
                            </div>
                            @endpermission
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</manage-pending-report>
@endsection