@extends('layouts.home')

@section('content')
<manage-eod-report inline-template>
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
                                        <h2 class="pt-3">EOD Report (Processing Lots)</h2>
                                    </div>
                                    <div class="col-lg-6">
                                        @include('__global.search_bar')
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="box-body">
                        <div class="row center">
                            @permission('index.eodreport')
                            <div class="col-sm-12 col-md-12 col-lg-12 center">
                                <vue-table ref="vuetable" api-url="{{ URL::route('eod-report.index') }}" :fields="fields" pagination-path="" :http-fetch="vueTableFetch" @vuetable:pagination-data="onPaginationData" :append-params="vueTableParams">
                                </vue-table>
                                <table class="ui blue selectable celled stackable attached table">
                                    <tfoot class="vuetable-body">
                                        <tr>
                                            <td style="text-align: right; width: 51.4%;">Total</td>
                                            <td style="width: 4.9%;">
                                                <div v-html="totalWeight"></div>
                                            </td>
                                            <td style="width: 8%;">
                                                <div v-html="totalScarpWeight"></div>
                                            </td>
                                            <td style="width: 9.7%;">
                                                <div v-html="totalChanamWeight"></div>
                                            </td>
                                            <td style="width: 7.4%;">
                                                <div v-html="totalLossWeight"></div>
                                            </td>
                                            <td style="width: 8.1%;">
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
</manage-eod-report>
@endsection