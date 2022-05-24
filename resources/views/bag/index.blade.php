@extends('layouts.home')

@section('content')
<manage-bag inline-template>
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
                                        <h2 class="pt-3">Lot</h2>
                                    </div>
                                    <div class="col-lg-5">
                                        @include('__global.search_bar')
                                        @permission('index.bag')
                                        <!--<button class="btn btn-fw "  v-bind:class="vueTableParams.trash | trashClass" @click="actionTrash">@{{vueTableParams.trash | trashText}}</button>-->
                                        @endpermission
                                        @permission('store.bag')
                                        <button class="btn btn-fw info" @click="createBag">Create</button>
                                        @endpermission
                                    </div>
                                </div>
                                <div class="ui centered grid" v-show="!is_advance_search">
                                    <div class="sixteen wide column">
                                        <div class="ui form ">
                                            <div class="field">
                                                <div class="three fields">
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
                            @permission('index.bag')
                            <div class="col-sm-12 col-md-12 col-lg-12 center">
                                <vue-table ref="vuetable" api-url="{{ URL::route('bag.index') }}" :fields="fields" pagination-path="" :http-fetch="vueTableFetch" @vuetable:pagination-data="onPaginationData" :append-params="vueTableParams">
                                    <template slot="actions" scope="props">
                                        <div class="custom-actions">
                                            <!--@permission('update.bag')
                                            <button v-if="checkEditStatus(props.rowData)" class="btn btn-icon indigo" @click="onAction('edit-item', props.rowData, props.rowIndex, props)">
                                                <i class="fa fa-edit"></i>
                                            </button>
                                            @endpermission-->
                                            <!--@permission('restore.bag')
                                                <button v-if="vueTableParams.trash == 1 " class="btn btn-icon orange"
                                                        @click="onAction('restore-item', props.rowData, props.rowIndex, props)">
                                                    <i class="fa fa-refresh"></i>
                                                </button>
                                                @endpermission-->
                                            <!--@permission('destroy.bag')
                                                <button v-if="checkEditStatus(props.rowData)"  class="btn btn-icon danger"
                                                         @click="onAction('delete-item', props.rowData, props.rowIndex)">
                                                    <i class="fa fa-remove"></i>
                                                </button>
                                                @endpermission-->
                                            @permission('index.bag')
                                            <button class="btn btn-icon orange" @click="onAction('view-item', props.rowData, props.rowIndex, props)">
                                                <i class="fa fa-eye"></i>
                                            </button>
                                            @endpermission
                                            @permission('cancel.bag')
                                            <button class="btn btn-icon red" v-if='props.rowData.status == types.findBagType("in_progress","value","bag_status")["id"]' @click="onAction('cancel-item', props.rowData, props.rowIndex, props)">
                                                <i class="fa fa-close"></i>
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
                            <sui-modal v-model="bagCancelOtpModel">
                                <sui-modal-header>Enter OTP For Lot Cancel</sui-modal-header>
                                <sui-modal-content scrolling>
                                    <sui-modal-description>
                                        <div class="row  mt-3">
                                            <div class="col-lg-12">
                                                <form class="ui form  fix-sui">
                                                    <div class="three fields">
                                                        <div class="field">
                                                            <label>OTP*</label>
                                                            <input type="text" name="otp" v-model="cancel_bag.otp" placeholder="OTP Number">
                                                            <a class="custom-hover-blue m-1" @click="generateOTP(cancel_bag.id)" href="#">Click here to resend otp</a>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </sui-modal-description>
                                </sui-modal-content>
                                <sui-modal-actions>
                                    <button class="ui button medium green" @click="onCancelBag" type="button">Save</button>
                                </sui-modal-actions>
                            </sui-modal>
                            @endpermission
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div v-if="displayForm">
            <div>
                <form-bag inline-template ref="roleForm" class="sub_content">
                    <div class="row">
                        @include('__global.loading')
                        <div class="col-sm-12 col-md-12 col-lg-12">
                            <div class="box">
                                <div class="box-header">
                                    <div class="row">
                                        <div class="col-lg-8 offset-lg-2">
                                            <div class="row">
                                                <div class="col-lg-8 ">
                                                    <h2 class="pt-1">@{{ formTitle }} Lot</h2>
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
                                        <div class="col-lg-12" v-hotkey="keymap">
                                            <form class="ui form  fix-sui">
                                                <div class="three fields">
                                                    <div class="field col-lg-6">
                                                        <label>Parent Lot Number</label>
                                                        <v-select v-model="parent_bag" open-direction="bottom" :options="bagOptions" :searchable="true" :internal-search="false" :clear-on-select="false" :multiple="false" :loading="bagLoading" label="bag_number" :options-limit="7" :limit="5" @search-change="loadBag" track-by="id" placeholder="Type 2 more characters to search " :disabled="isEditMode"></v-select>
                                                        <div class="ui pointing red basic label" v-show="form.errors.has('parent_bag_id')">
                                                            @{{ form.errors.get('parent_bag_id') }}
                                                        </div>
                                                    </div>
                                                    <div class="field" v-if="currentRecordId != null">
                                                        <label>Lot Number *</label>
                                                        <input type="text" name="bag_number" v-model="form.bag_number" placeholder="Bag Number" disabled>
                                                        <div class="ui pointing red basic label" v-show="form.errors.has('bag_number')">
                                                            @{{ form.errors.get('bag_number') }}
                                                        </div>
                                                    </div>
                                                    <div class="field">
                                                        <label>Order Number *</label>
                                                        <input type="text" name="order_number" v-model="form.order_number" placeholder="Order Number" :disabled="isViewMode">
                                                        <div class="ui pointing red basic label" v-show="form.errors.has('order_number')">
                                                            @{{ form.errors.get('order_number') }}
                                                        </div>
                                                    </div>

                                                </div>
                                                <div class="field ">
                                                    <div class="fields ui grid">
                                                        <div class="sixteen wide column">
                                                            <h4 class="ui horizontal divider header medium p-2 border-bottom-none">
                                                                <i class="sort amount up icon"></i>
                                                                Add Style's
                                                                <button class="ui button" type="button" v-if="!isViewMode" @click="addStyle()" v-if="form.bag_styles.length == 0">Add a style (Ctrl+Enter)</button>
                                                            </h4>
                                                            <div class="ui theme-message message text-white text-center" v-if="form.bag_styles.length == 0 && (!isViewMode)">
                                                                <a class="text-black hover-text-black" href="javascript:void(0)" @click="addStyle()">Click here to add a style!</a>
                                                            </div>
                                                            <div class="ui message " v-for="( bag_style,index ) in form.bag_styles">
                                                                <div class="content">
                                                                    <div class="field">
                                                                        <a class="ui right red corner label" v-if="!isViewMode" @click="removeBagStyle(index)">
                                                                            <i class="remove icon"></i>
                                                                        </a>
                                                                        <div class="row">
                                                                            <div class="col-lg-2">
                                                                                <div v-if="bag_style.upload_id != null ">
                                                                                    <div class="ui centered card">
                                                                                        <a class="ui right red corner label" @click="removeStyleUploadImage(index)" v-if="(!isViewMode)">
                                                                                            <i class="remove icon"></i>
                                                                                        </a>
                                                                                        <div class="image">
                                                                                            <viewer :options="viewerOptions">
                                                                                                <img :src="bag_style.upload.uploaded_path" width="100%" height="100%" />
                                                                                            </viewer>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <profile-file-pond v-if=" bag_style.upload_id == null && (!isViewMode)" name="attachment" ref="pond" label-idle='Drag your image or <span class="filepond--label-action">Browse</span>' image-preview-height="170" image-crop-aspect-ratio="1:1" image-resize-target-width="200" image-resize-target-height="200" style-panel-layout="compact circle" style-load-Indicator-position='center bottom' accepted-file-types="image/jpeg, image/png" style-button-remove-item-position='center bottom' allow-multiple="false" :server="filePondOptions" v-on:processfilestart="onFileUploadStart(index)" v-on:processfile="onFileUploadComplete">
                                                                                </profile-file-pond>
                                                                            </div>
                                                                            <div class="col-lg-9">
                                                                                <div class="row">
                                                                                    <div class="field col-lg-6" v-if="bag_style.other_accessories == null">
                                                                                        <label>Style Number*</label>
                                                                                        <v-select v-model="bag_style.style" open-direction="bottom" :options="styleOptions" :searchable="true" :internal-search="false" :clear-on-select="false" :multiple="false" :loading="multiLoading" label="sku" :options-limit="7" :limit="5" @search-change="loadStyles" @input="changeBagStyle(index)" track-by="id" placeholder="Type 2 more characters to search " :disabled="isViewMode"></v-select>
                                                                                        <div class="ui pointing red basic label" v-show="form.errors.has('bag_styles.'+index+'.style_id')">
                                                                                            @{{ form.errors.get('bag_styles.'+index+'.style_id') }}
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="field col-lg-6" v-else>
                                                                                        <label>Other Accessories*</label>
                                                                                        <v-select v-model="bag_style.other_accessories" :options="styleOptions" label="name" :disabled="isViewMode"></v-select>
                                                                                        <div class="ui pointing red basic label" v-show="form.errors.has('bag_styles.'+index+'.style_id')">
                                                                                            @{{ form.errors.get('bag_styles.'+index+'.style_id') }}
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="field col-lg-4">
                                                                                        <label>Quantity*</label>
                                                                                        <input type="text" v-model="bag_style.quantity" placeholder="Quantity" :disabled="isViewMode">
                                                                                        <div class="ui pointing red basic label" v-show="form.errors.has('bag_styles.'+index+'.quantity')">
                                                                                            @{{ form.errors.get('bag_styles.'+index+'.quantity') }}
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="field col-lg-2">
                                                                                        <button class="ui labeled icon button c-mt-1p5em" @click="showStyleModel(index)" type="button">
                                                                                            <i class="eye icon"></i>
                                                                                            View Style
                                                                                        </button>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="row">
                                                                                    <div class="field col-lg-6">
                                                                                        <label>Weight*</label>
                                                                                        <input type="text" v-model="bag_style.weight" placeholder="Weight" :disabled="isViewMode">
                                                                                        <div class="ui pointing red basic label" v-show="form.errors.has('bag_styles.'+index+'.weight')">
                                                                                            @{{ form.errors.get('bag_styles.'+index+'.weight') }}
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="field col-lg-6">
                                                                                        <label>Instructions</label>
                                                                                        <input type="text" v-model="bag_style.instructions" :disabled="isViewMode" placeholder="Instructions">
                                                                                        <div class="ui pointing red basic label" v-show="form.errors.has('bag_styles.'+index+'.instructions')">
                                                                                            @{{ form.errors.get('bag_styles.'+index+'.instructions') }}
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-lg-1">

                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <h4 class="ui horizontal divider header medium p-2 border-bottom-none" v-if="form.bag_styles.length > 0 && !(isViewMode)">
                                                                <button class="ui button theme-color" type="button" @click="addStyle()">Add a style (Ctrl+Enter)</button>
                                                            </h4>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="field">
                                                    <div class="one field">
                                                        <label>Instructions</label>
                                                        <vue-editor name="description" v-model="form.instructions"></vue-editor>
                                                        <div class=" ui pointing red basic label" v-show="form.errors.has('instructions')">
                                                            @{{ form.errors.get('instructions') }}
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="m-b btn-groups pull-right">
                                                    <button class="btn btn-fw success " type="button" @click="submit">Submit</button>
                                                    <button class="btn btn-fw dark " type="button" @click="showGrid">Cancel</button>
                                                </div>
                                                <sui-modal v-model="display_style">
                                                    <sui-modal-header>Style Details</sui-modal-header>
                                                    <sui-modal-content scrolling>
                                                        <sui-modal-description>
                                                            <div class="ui message ">
                                                                <div class="ui grid">
                                                                    <div class="sixteen wide column">
                                                                        <div class="three fields">
                                                                            <div class="field">
                                                                                <label>Sku</label>
                                                                                <input type="text" disabled="disabled" :value="viewedStyle.sku" placeholder="Sku">
                                                                            </div>
                                                                            <div class="field">
                                                                                <label>Weight</label>
                                                                                <input type="text" disabled="disabled" :value="viewedStyle.weight" placeholder="Weight">
                                                                            </div>
                                                                            <div class="field">
                                                                                <label>Uom</label>
                                                                                <v-select v-model="viewedStyle.uom" :options="uom_options" disabled="disabled" :searchable="true" :multiple="false" label="name" track-by="id" :show-labels="false"></v-select>
                                                                            </div>
                                                                        </div>
                                                                        <div class="three fields" v-if="viewedStyle.product!=null">
                                                                            <div class="field">
                                                                                <label>Product Category</label>
                                                                                <input type="text" disabled="disabled" :value="(viewedStyle.product.product_category != null)? viewedStyle.product.product_category.name : ''" placeholder="Product Category">
                                                                            </div>
                                                                            <div class="field">
                                                                                <label>Product Name</label>
                                                                                <input type="text" disabled="disabled" :value="viewedStyle.product.name" placeholder="Product Name">
                                                                            </div>
                                                                        </div>
                                                                        <div class="three fields" v-else>
                                                                            <div class="field">
                                                                                <label>Product Category</label>
                                                                                -
                                                                            </div>
                                                                            <div class="field">
                                                                                <label>Product Name</label>
                                                                                -
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="sixteen wide column" v-if="viewedStyle.style_images_view != undefined && viewedStyle.style_images_view.length > 0">
                                                                        <v-gallery :images="viewedStyle.style_images_view">
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </sui-modal-description>
                                                    </sui-modal-content>
                                                    <sui-modal-actions>
                                                        <button class="ui button medium" @click="closeStyleModel" type="button">Cancel</button>
                                                    </sui-modal-actions>
                                                </sui-modal>
                                            </form>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>

                    </div>
                </form-bag>

            </div>
        </div>
    </div>
</manage-bag>
@endsection