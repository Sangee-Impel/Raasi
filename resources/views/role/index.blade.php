@extends('layouts.home')

@section('content')
    <manage-roles inline-template>
        <div class="padding">
            @include('__global.loading')
            <div class="row"  v-if="displayForm == false">
                <div class="col-sm-12 col-md-12 col-lg-12">
                    <div class="box">
                        <div class="box-header">
                            <div class="row">
                                <div class="col-lg-6">
                                    <h2 class="pt-3">Roles</h2>
                                </div>
                                <div class="col-lg-6 ">
                                    @include('__global.search_bar')
                                    @permission('index.role')
                                    <button class="btn btn-fw " v-bind:class="vueTableParams.trash | trashClass" @click="actionTrash">@{{vueTableParams.trash | trashText}}</button>
                                    @endpermission
                                    @permission('store.role')
                                    <button class="btn btn-fw info" @click="showForm">Create</button>
                                    @endpermission
                                </div>
                            </div>
                        </div>
                        <div class="box-body">
                            <div class="row">
                                @permission('index.role')
                                <div class="col-sm-12 col-md-12 col-lg-12 vue-table-grid">
                                    <vue-table ref="vuetable"
                                               api-url="{{ URL::route('roles.index') }}"
                                               :fields="fields"
                                               pagination-path=""
                                               :http-fetch="vueTableFetch"
                                               @vuetable:pagination-data="onPaginationData"
                                               :append-params="vueTableParams"
                                    >
                                        <template slot="actions" scope="props">
                                            <div class="custom-actions">
                                                @permission('update.role')
                                                <button title="Edit Role" v-if="vueTableParams.trash == 0" type="button" class="btn btn-icon indigo"
                                                        @click="onAction('edit-item', props.rowData, props.rowIndex, props)">
                                                    <i class="fa fa-edit"></i>
                                                </button>
                                                @endpermission
                                                @permission('restore.role')
                                                <button v-if="vueTableParams.trash == 1" type="button" class="btn btn-icon orange"
                                                        @click="onAction('restore-item', props.rowData, props.rowIndex, props)">
                                                    <i class="fa fa-refresh"></i>
                                                </button>
                                                @endpermission
                                                @permission('destroy.role')
                                                <button class="btn btn-icon danger" type="button"
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
                    <form-roles inline-template  ref="roleForm" class="sub_content" >
                        <div class="row">
                            @include('__global.loading')
                            <div class="col-sm-12 col-md-12 col-lg-12">
                                <div class="box">
                                    <div class="box-header">
                                        <div class="row">
                                            <div class="col-lg-8 offset-lg-2">
                                                <div class="row">
                                                    <div class="col-lg-8">
                                                        <h3>@{{ formTitle }} Role</h3>
                                                    </div>
                                                    <div class="col-lg-4">
                                                        <button class="btn btn-fw info pull-right" @click="showGrid">Manage</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div class="row">
                                            <div class="col-lg-8 offset-lg-2">
                                                <form>
                                                    <div class="form-group col-lg-4">
                                                        <label>Role Name *</label>
                                                        <input type="text" class="form-control"  v-model="form.name" placeholder="Role Name">
                                                        <div class="ui pointing red basic label" v-show="form.errors.has('name')">
                                                            @{{ form.errors.get('name') }}
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <div class="ui pointing below red basic label" v-show="form.errors.has('permission_id')">
                                                            @{{ form.errors.get('permission_id') }}
                                                        </div>
                                                        <label>Permissions *</label>
                                                        <div class="m-b btn-groups ">
                                                            <button  @click="CheckAll({{ $permissions }},false)" class="btn btn-fw success" type="button">Uncheck All</button>
                                                            <button  @click="CheckAll({{ $permissions }},true)" class="btn btn-fw success" type="button">Check All</button>
                                                        </div>
                                                        <sui-segment>
                                                            <v-treeview
                                                                :items="{{ $permissions }}"
                                                                v-model="form.permission_id"
                                                                selectable
                                                            ></v-treeview>
                                                        </sui-segment>
                                                    </div>
                                                    <div class="m-b btn-groups pull-right">
                                                        <button class="btn btn-fw success" type="button" @click="submit">Submit</button>
                                                        <button class="btn btn-fw dark " type="button" @click="showGrid">Cancel</button>
                                                    </div>
                                                </form>
                                            </div>

                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </form-roles>
                </div>
            </div>
        </div>
    </manage-roles>
@endsection
