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

                                <table class="ui blue selectable celled stackable attached table">
                                    <tr>
                                        <td>Opening</td>
                                        <td>
                                            <div v-html="opening"></div>
                                        </td>
                                        <td>Scrap</td>
                                        <td>
                                            <div v-html="scrap"></div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Casting</td>
                                        <td>
                                            <div v-html="casting"></div>
                                        </td>
                                        <td>Chanam</td>
                                        <td>
                                            <div v-html="chanam"></div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Kambi</td>
                                        <td>
                                            <div v-html="kambi"></div>
                                        </td>
                                        <td>Total loss</td>
                                        <td>
                                            <div v-html="loss"></div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Fancy</td>
                                        <td>
                                            <div v-html="fancy_inward"></div>
                                        </td>
                                        <td>FC</td>
                                        <td>
                                            <div v-html="fc_delivery"></div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Others</td>
                                        <td>
                                            <div v-html="others_inward"></div>
                                        </td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td>Processing Bags</td>
                                        <td>
                                            <div v-html="pending_bag"></div>
                                        </td>
                                        <td>EOD Bags</td>
                                        <td>
                                            <div v-html="eod_bag"></div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td></td>
                                        <td>Closing</td>
                                        <td> <div v-html="closing"></div></td>
                                    </tr>
                                </table>
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