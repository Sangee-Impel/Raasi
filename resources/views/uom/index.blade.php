@extends('layouts.home')

@section('content')
    <manage-uom inline-template>
        <div class="padding">
            @include('__global.loading')
            <div class="row"  v-if="displayForm == false">
                <div class="col-sm-12 col-md-12 col-lg-12">
                    <div class="box">
                        <div class="box-header">
                            <div class="row">
                                <div class="col-lg-1"></div>
                                <div class="col-lg-10">
                                    <div class="row">
                                        <div class="col-lg-6 ">
                                            <h2 class="pt-3">Uom</h2>
                                        </div>
                                        <div class="col-lg-6">
                                            @include('__global.search_bar')
                                            @permission('index.uom')
                                            <button class="btn btn-fw "  v-bind:class="vueTableParams.trash | trashClass" @click="actionTrash">@{{vueTableParams.trash | trashText}}</button>
                                            @endpermission
                                            @permission('store.uom')
                                            <button class="btn btn-fw info" @click="showForm">Create</button>
                                            @endpermission
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="box-body">
                            <div class="row center">
                                @permission('index.uom')
                                <div class="col-sm-12 col-md-12 col-lg-12 center">
                                    <vue-table ref="vuetable"
                                               api-url="{{ URL::route('uom.index') }}"
                                               :fields="fields"
                                               pagination-path=""
                                               :http-fetch="vueTableFetch"
                                               @vuetable:pagination-data="onPaginationData"
                                               :append-params="vueTableParams"
                                    >
                                        <template slot="actions" scope="props">
                                            <div class="custom-actions">
                                                @permission('update.uom')
                                                <button v-if="vueTableParams.trash == 0" class="btn btn-icon indigo"
                                                        @click="onAction('edit-item', props.rowData, props.rowIndex, props)">
                                                    <i class="fa fa-edit"></i>
                                                </button>
                                                @endpermission
                                                @permission('restore.uom')
                                                <button v-if="vueTableParams.trash == 1 " class="btn btn-icon orange"
                                                        @click="onAction('restore-item', props.rowData, props.rowIndex, props)">
                                                    <i class="fa fa-refresh"></i>
                                                </button>
                                                @endpermission
                                                @permission('destroy.uom')
                                                <button  class="btn btn-icon danger"
                                                         @click="onAction('delete-item', props.rowData, props.rowIndex)">
                                                    <i class="fa fa-remove"></i>
                                                </button>
                                                @endpermission
                                            </div>
                                        </template>
                                    </vue-table>
                                    <div class="vuetable-pagination ui basic segment grid">
                                        <vuetable-pagination-info ref="paginationInfo"></vuetable-pagination-info>
                                        <vuetable-pagination
                                            ref="pagination"
                                            @vuetable-pagination:change-page="onChangePage"
                                        ></vuetable-pagination>
                                    </div>
                                </div>

                                @endpermission
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div  v-if="displayForm">
                <div>
                    <form-uom inline-template  ref="roleForm" class="sub_content" >
                        <div class="row">
                            @include('__global.loading')
                            <div class="col-sm-12 col-md-12 col-lg-12">
                                <div class="box">
                                    <div class="box-header">
                                        <div class="row">
                                            <div class="col-lg-8 offset-lg-2">
                                                <div class="row">
                                                    <div class="col-lg-8 ">
                                                        <h2 class="pt-1">@{{ formTitle }} Uom</h2>
                                                    </div>
                                                    <div class="col-lg-4 ">
                                                        <button class="btn btn-fw info pull-right" @click="showGrid">Manage</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div class="row">
                                            <div class="col-lg-8 offset-lg-2">
                                                <form class="ui form  fix-sui">
                                                    <div class="three fields">
                                                        <div class="field">
                                                            <label>Uom Name *</label>
                                                            <input type="text" name="product_category_name" v-model="form.name" placeholder="Uom name">
                                                            <div class="ui pointing red basic label" v-show="form.errors.has('name')">
                                                                @{{ form.errors.get('name') }}
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="field">
                                                        <div class="one field">
                                                            <label>Description</label>
                                                            <vue-editor name="description" v-model="form.description"></vue-editor>
                                                            <div class=" ui pointing red basic label" v-show="form.errors.has('description')">
                                                                @{{ form.errors.get('description') }}
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="m-b btn-groups pull-right">
                                                        <button class="btn btn-fw success " type="button" @click="submit">Submit</button>
                                                        <button class="btn btn-fw dark " type="button" @click="showGrid">Cancel</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </form-uom>

                </div>
            </div>
        </div>
    </manage-uom>
@endsection


