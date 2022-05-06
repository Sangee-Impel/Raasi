@extends('layouts.home')

@section('content')
<manage-closing-report inline-template>
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
                                        <h2 class="pt-3">Closing Report</h2>
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
                                                        <label>From Date</label>
                                                        <input type="date" name="from_date" v-model="from_date">
                                                    </div>
                                                    <div class="field">
                                                        <label>To Date</label>
                                                        <input type="date" name="to_date" v-model="to_date">
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
                            @permission('index.closingreport')
                            <div class="col-sm-12 col-md-12 col-lg-12 center">
                                <vue-table ref="vuetable" api-url="{{ URL::route('closing-report.index') }}" :fields="fields" pagination-path="" :http-fetch="vueTableFetch" @vuetable:pagination-data="onPaginationData" :append-params="vueTableParams">
                                </vue-table>
                                <?php /*
                                <table class="ui blue selectable celled stackable attached table">
                                    <tr>
                                        <td>Opening</td>
                                        <td>
                                            <div v-html="opening"></div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Casting</td>
                                        <td>
                                            <div v-html="casting"></div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Kambi</td>
                                        <td>
                                            <div v-html="kambi"></div>
                                        </td>
                                    </tr>
                                </table> */ ?>
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
</manage-closing-report>
@endsection