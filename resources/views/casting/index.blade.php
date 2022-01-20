@extends('layouts.home')

@section('content')
<manage-casting inline-template>
    <div class="padding">
        @include('__global.loading')
        <div class="row" v-if="displayForm == false">
            <div class="col-sm-12 col-md-12 col-lg-12">
                <div class="box">
                    <div class="box-header">
                        <div class="row">
                            <div class="col-lg-1"></div>
                            <div class="col-lg-10">
                                <div class="row">
                                    <div class="col-lg-7 ">
                                        <h2 class="pt-3">Casting</h2>
                                    </div>
                                    <div class="col-lg-5">
                                        @include('__global.search_bar')
                                        @permission('index.casting')
                                        <!--<button class="btn btn-fw "  v-bind:class="vueTableParams.trash | trashClass" @click="actionTrash">@{{vueTableParams.trash | trashText}}</button>-->
                                        @endpermission
                                        @permission('store.casting')
                                        <button class="btn btn-fw info" @click="createCasting">Create</button>
                                        @endpermission
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="box-body">
                        <div class="row center">
                            @permission('index.casting')
                            <div class="col-sm-12 col-md-12 col-lg-12 center">
                                <vue-table ref="vuetable" api-url="{{ URL::route('casting.index') }}" :fields="fields" pagination-path="" :http-fetch="vueTableFetch" @vuetable:pagination-data="onPaginationData" :append-params="vueTableParams">
                                    <template slot="actions" scope="props">
                                        <div class="custom-actions">
                                            @permission('update.casting')
                                            <button class="btn btn-icon indigo" @click="onAction('edit-item', props.rowData, props.rowIndex, props)">
                                                <i class="fa fa-edit"></i>
                                            </button>
                                            @endpermission
                                            @permission('index.casting')
                                            <button class="btn btn-icon orange" @click="onAction('view-item', props.rowData, props.rowIndex, props)">
                                                <i class="fa fa-eye"></i>
                                            </button>
                                            @endpermission
                                        </div>
                                    </template>
                                </vue-table>
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
        <div v-if="displayForm">
            <div>
                <form-casting inline-template ref="roleForm" class="sub_content">
                    <div class="row">
                        @include('__global.loading')
                        <div class="col-sm-12 col-md-12 col-lg-12">
                            <div class="box">
                                <div class="box-header">
                                    <div class="row">
                                        <div class="col-lg-8">
                                            <div class="row">
                                                <div class="col-lg-8 ">
                                                    <h2 class="pt-1">@{{ formTitle }} Casting</h2>
                                                </div>
                                                <div class="col-lg-4 ">
                                                    <button class="btn btn-fw info pull-right" @click="showGrid">Manage</button>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="col-lg-4 " style="text-align:right">
                                            <button class="btn btn-fw success " type="button" @click="submit" v-if="!isViewMode">Submit</button>
                                            <button class="btn btn-fw dark " type="button" @click="showGrid">Cancel</button>
                                        </div>
                                    </div>
                                </div>
                                <div class="box-body">
                                    <div class="row">
                                        <div class="col-lg-12" v-hotkey="keymap">
                                            <form class="ui form  fix-sui">
                                                <div class="three fields">
                                                    <div class="field">
                                                        <label>Name *</label>
                                                        <input type="text" name="name" v-model="form.name" placeholder="Name" :disabled="isViewMode">
                                                        <div class="ui pointing red basic label" v-show="form.errors.has('name')">
                                                            @{{ form.errors.get('name') }}
                                                        </div>
                                                    </div>
                                                    <div class="field">
                                                        <label>Total Weight </label>
                                                        <span class="field_weight">@{{form.weight > 0 ? form.weight : 0 }} grms</span>
                                                    </div>

                                                </div>
                                                <div class="field ">
                                                    <div class="fields ui grid">
                                                        <div class="sixteen wide column">
                                                            <h4 class="ui horizontal divider header medium p-2 border-bottom-none">
                                                                <i class="sort amount up icon"></i>
                                                                Add weight
                                                                <button class="ui button" type="button" v-if="!isViewMode" @click="addWeight()" v-if="form.casting_weights.length == 0">Add a weight (Ctrl+Enter)</button>
                                                            </h4>
                                                            <div class="ui theme-message message text-white text-center" v-if="form.casting_weights.length == 0 && (!isViewMode)">
                                                                <a class="text-black hover-text-black" href="javascript:void(0)" @click="addWeight()">Click here to add a weight!</a>
                                                            </div>
                                                            <div class="ui message " v-for="( casting_weight,index ) in form.casting_weights">
                                                                <div class="content">
                                                                    <div class="field">
                                                                        <div class="row">
                                                                            <div class="field col-lg-3">
                                                                                <label>Weight*</label>
                                                                                <input type="text" v-model="casting_weight.weight" placeholder="Weight" :disabled="isViewMode">
                                                                                <div class="ui pointing red basic label" v-show="form.errors.has('casting_weights.'+index+'.weight')">
                                                                                    @{{ form.errors.get('casting_weights.'+index+'.weight') }}
                                                                                </div>
                                                                            </div>
                                                                            <div class="field col-lg-3">
                                                                                <label>Adjustments*</label>
                                                                                <v-select v-model="casting_weight.adjustment" open-direction="bottom" :disabled="isViewMode" :options="['Add', 'Deduct']" :searchable="false" :internal-search="false" :clear-on-select="false" :multiple="false" :loading="multiLoading">
                                                                                </v-select>
                                                                                <div class="ui pointing red basic label" v-show="form.errors.has('casting_weights.'+index+'.adjustment')">
                                                                                    @{{ form.errors.get('casting_weights.'+index+'.adjustment') }}
                                                                                </div>
                                                                            </div>
                                                                            <div class="field col-lg-3">
                                                                                <label>Instruction*</label>
                                                                                <input type="text" v-model="casting_weight.instruction" placeholder="Instruction" :disabled="isViewMode">
                                                                                <div class="ui pointing red basic label" v-show="form.errors.has('casting_weights.'+index+'.instruction')">
                                                                                    @{{ form.errors.get('casting_weights.'+index+'.instruction') }}
                                                                                </div>
                                                                            </div>
                                                                            <div class="field col-lg-3">
                                                                                <label>Date</label>
                                                                                <span>@{{casting_weight.created_at ? casting_weight.created_at : '---'}}</span>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <h4 class="ui horizontal divider header medium p-2 border-bottom-none" v-if="form.casting_weights.length > 0 && !(isViewMode)">
                                                                <button class="ui button theme-color" type="button" @click="addWeight()">Add a weight (Ctrl+Enter)</button>
                                                            </h4>
                                                        </div>
                                                    </div>
                                                </div>

                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form-casting>
            </div>
        </div>
    </div>
</manage-casting>
@endsection