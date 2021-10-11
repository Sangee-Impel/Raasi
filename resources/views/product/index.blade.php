@extends('layouts.home')

@section('content')
    <manage-product inline-template>
        <div class="padding">
            @include('__global.loading')
            <div class="row"  v-if="displayForm == false">
                <div class="col-sm-12 col-md-12 col-lg-12">
                    <div class="box">
                        <div class="box-header">
                            <form action="/product/styleUpload" method="post" id="form_import" enctype="multipart/form-data">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="row p-3">
                                            <div class="col-lg-2 ">
                                                <h2 class="pt-3">Products</h2>
                                            </div>
                                            <div class="col-lg-10">
                                                @include('__global.search_bar')
                                                {{ csrf_field() }}
                                                <div class="ui action input">
                                                    <input type="file" id="styleUploadFile" name="styleUploadFile" >
                                                    <input type="hidden" id="uploadResponce" value="{{$uploadResponce}}" >
                                                    <button class="ui icon button">
                                                        <i class="cloud upload icon"></i>
                                                    </button>
                                                </div>
                                                <a href="/file_template/style_1.xlsx" target="_blank" class="ui icon button" title="Download Template">
                                                    <i class="cloud download icon"></i>
                                                </a>
                                                @permission('index.product')
                                                <button class="btn btn-fw " type="button" v-bind:class="vueTableParams.trash | trashClass" @click="actionTrash">@{{vueTableParams.trash | trashText}}</button>
                                                @endpermission
                                                @permission('store.product')
                                                <button class="btn btn-fw info" type="button" @click="showForm">Create</button>
                                                @endpermission
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="box-body">
                            <div class="row center">
                                @permission('index.product')
                                <div class="col-sm-12 col-md-12 col-lg-12 center">
                                    <vue-table ref="vuetable"
                                               api-url="{{ URL::route('product.index') }}"
                                               :fields="fields"
                                               pagination-path=""
                                               :http-fetch="vueTableFetch"
                                               @vuetable:pagination-data="onPaginationData"
                                               :append-params="vueTableParams"
                                    >
                                        <template slot="actions" scope="props">
                                            <div class="custom-actions">
                                                @permission('update.product')
                                                <button v-if="vueTableParams.trash == 0" class="btn btn-icon indigo"
                                                        @click="onAction('edit-item', props.rowData, props.rowIndex, props)">
                                                    <i class="fa fa-edit"></i>
                                                </button>
                                                @endpermission
                                                @permission('restore.product')
                                                <button v-if="vueTableParams.trash == 1 " class="btn btn-icon orange"
                                                        @click="onAction('restore-item', props.rowData, props.rowIndex, props)">
                                                    <i class="fa fa-refresh"></i>
                                                </button>
                                                @endpermission
                                                @permission('destroy.product')
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
                    <form-product inline-template  ref="roleForm" class="sub_content" >
                        <div class="row">
                            @include('__global.loading')
                            <div class="col-sm-12 col-md-12 col-lg-12">
                                <div class="box">
                                    <div class="box-header">
                                        <div class="row">
                                            <div class="col-lg-8 offset-lg-2">
                                                <div class="row">
                                                    <div class="col-lg-8 ">
                                                        <h2 class="pt-1">@{{ formTitle }} Product</h2>
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
                                            <div class="col-lg-12 " v-hotkey="keymap">
                                                <form class="ui form  fix-sui">
                                                    <div class="three fields">
                                                        <div class="field">
                                                            <label class="text-black">Product Category *</label>
                                                            <v-select
                                                                v-model="selected_product_category"
                                                                :options="product_category_options"
                                                                :searchable="true"
                                                                :multiple="false"
                                                                label="name"
                                                                track-by="id"
                                                                :show-labels="false"
                                                                name="unit_id"
                                                            ></v-select>
                                                            <div class="ui pointing red basic label" v-show="form.errors.has('product_category_id')">
                                                                @{{ form.errors.get('product_category_id') }}
                                                            </div>
                                                        </div>
                                                        <div class="field">
                                                            <label>Product Name *</label>
                                                            <input type="text" name="product_name" v-model="form.name" placeholder="Product name">
                                                            <div class="ui pointing red basic label" v-show="form.errors.has('name')">
                                                                @{{ form.errors.get('name') }}
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="field ">
                                                        <div class="fields ui grid">
                                                            <div class="sixteen wide column">
                                                                <h4 class="ui horizontal divider header medium p-2 border-bottom-none">
                                                                    <i class="sort amount up icon"></i>
                                                                    Product Style
                                                                    <button class="ui button" type="button"
                                                                            @click="addStyle()"
                                                                            v-if="form.styles.length == 0">Add a style (Ctrl+Enter)</button>
                                                                </h4>
                                                                <div class="ui theme-message message text-white text-center" v-if="form.styles.length == 0">
                                                                    <a class="text-black hover-text-black" href="javascript:void(0)" @click="addStyle()">Click here to add a style!</a>
                                                                </div>
                                                                <div class="ui message " v-for="( style,index ) in form.styles">
                                                                    <div class="content">
                                                                        <div class="field">
                                                                            <a class="ui right red corner label" @click="removeStyle(index)">
                                                                                <i class="remove icon"></i>
                                                                            </a>
                                                                            <div class="ui grid">
                                                                                <div class="row">
                                                                                    <div class="sixteen wide column">
                                                                                        <div class="three fields">
                                                                                            <div class="field">
                                                                                                <label>Sku*</label>
                                                                                                <input type="text"  v-model="style.sku"  placeholder="Sku" >
                                                                                                <div class="ui pointing red basic label" v-show="form.errors.has('styles.'+index+'.sku')">
                                                                                                    @{{ form.errors.get('styles.'+index+'.sku') }}
                                                                                                </div>
                                                                                            </div>
                                                                                            <div class="field">
                                                                                                <label>Weight*</label>
                                                                                                <input type="text"  v-model="style.weight"  placeholder="Weight" >
                                                                                                <div class="ui pointing red basic label" v-show="form.errors.has('styles.'+index+'.weight')">
                                                                                                    @{{ form.errors.get('styles.'+index+'.weight') }}
                                                                                                </div>
                                                                                            </div>
                                                                                            <div class="field">
                                                                                                <label>Uom*</label>
                                                                                                <v-select
                                                                                                    v-model="style.uom"
                                                                                                    :options="uom_options"
                                                                                                    :searchable="true"
                                                                                                    :multiple="false"
                                                                                                    label="name"
                                                                                                    track-by="id"
                                                                                                    :show-labels="false"
                                                                                                ></v-select>
                                                                                                <div class="ui pointing red basic label" v-show="form.errors.has('styles.'+index+'.uom_id')">
                                                                                                    @{{ form.errors.get('styles.'+index+'.uom_id') }}
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="sixteen wide column">
                                                                                        <div class="box">
                                                                                            <div class="box-header">
                                                                                                <h5>Style Image</h5>
                                                                                            </div>
                                                                                            <div class="box-body">
                                                                                                <div class="row">
                                                                                                    <div class="col-lg-12">
                                                                                                        <file-pond name="attachment"
                                                                                                                            ref="multipond"
                                                                                                                            label-idle='Drag your image or <span class="filepond--label-action">Browse</span>'
                                                                                                                            accepted-file-types="image/jpeg, image/png"
                                                                                                                            allow-multiple="false"
                                                                                                                            allow-revert="false"
                                                                                                                            :server="filePondOptions"
                                                                                                                            v-on:processfilestart="onFileUploadStart(index)"
                                                                                                                            v-on:processfile="onFileUploadComplete"
                                                                                                        >
                                                                                                        </file-pond>
                                                                                                    </div>
                                                                                                    <div class="col-lg-12" v-if="style.style_images.length > 0">
                                                                                                        <div class="row">
                                                                                                            <div class="col-lg-3" v-for="( style_image,style_image_index ) in style.style_images">
                                                                                                                <div class="ui centered card">
                                                                                                                    <div class="image">
                                                                                                                        <div>
                                                                                                                            <a class="ui right red corner label"   @click="removeStyleUploadImages(index,style_image_index)">
                                                                                                                                <i class="remove icon"></i>
                                                                                                                            </a>
                                                                                                                            <img :src="style_image.upload.uploaded_path" width="100%" height="100%">
                                                                                                                        </div>
                                                                                                                    </div>
                                                                                                                </div>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </div>

                                                                                                </div>
                                                                                            </div>

                                                                                        </div>

                                                                                    </div>
                                                                                    <div class="sixteen wide column">
                                                                                        <button class="btn btn-fw yellow m-2 pull-right" type="button" @click="addStyleDepartmentLossApproval(index)" >Add Department Loss Percentage</button>
                                                                                        <table class="ui celled table">
                                                                                            <thead>
                                                                                            <tr>
                                                                                                <th>Department</th>
                                                                                                <th>Percentage %</th>
                                                                                                <th>Action</th>
                                                                                            </tr>
                                                                                            </thead>
                                                                                            <tbody>
                                                                                            <tr v-if="style.style_department_loss_approval.length == 0">
                                                                                                <td col-span="3">No Data</td>
                                                                                            </tr>
                                                                                            <tr v-for="(style_department_loss,style_department_loss_index) in style.style_department_loss_approval">
                                                                                                <td>
                                                                                                    <v-select
                                                                                                        v-model="style_department_loss.department"
                                                                                                        :options="department_options"
                                                                                                        :searchable="true"
                                                                                                        :multiple="false"
                                                                                                        label="name"
                                                                                                        track-by="id"
                                                                                                        :show-labels="false"
                                                                                                        name="department"
                                                                                                        @input="checkDuplicateDepartment(index,style_department_loss_index)"
                                                                                                    ></v-select>
                                                                                                    <div class="ui pointing red basic label" v-show="form.errors.has('styles.'+index+'.style_department_loss_approval.'+style_department_loss_index+'.department_id')">
                                                                                                        @{{ form.errors.get('styles.'+index+'.style_department_loss_approval.'+style_department_loss_index+'.department_id') }}
                                                                                                    </div>
                                                                                                </td>
                                                                                                <td>
                                                                                                    <input type="text" v-model="style_department_loss.percentage" placeholder="Percentage">
                                                                                                    <div class="ui pointing red basic label" v-show="form.errors.has('styles.'+index+'.style_department_loss_approval.'+style_department_loss_index+'.percentage')">
                                                                                                        @{{ form.errors.get('styles.'+index+'.style_department_loss_approval.'+style_department_loss_index+'.percentage') }}
                                                                                                    </div>
                                                                                                </td>
                                                                                                <td>
                                                                                                    <button class="ui icon button" type="button" @click="removeStyleDepartmentLoss(index,style_department_loss_index)">
                                                                                                        <i class="remove icon"></i>
                                                                                                    </button>
                                                                                                </td>

                                                                                            </tr>
                                                                                            </tbody>
                                                                                        </table>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <h4 class="ui horizontal divider header medium p-2 border-bottom-none"
                                                                    v-if="form.styles.length > 0" >
                                                                    <button class="ui button theme-color" type="button"
                                                                            @click="addStyle()">Add a style  (Ctrl+Enter)</button>
                                                                </h4>
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
                    </form-product>

                </div>
            </div>
        </div>
    </manage-product>
@endsection


