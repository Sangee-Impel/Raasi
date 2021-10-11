@extends('layouts.home')

@section('content')
<manage-transaction inline-template>
    <div class="padding">
        @include('__global.loading')
        <div v-if="displayForm">
            <div>
                <form-transaction inline-template ref="roleForm" class="sub_content">
                    <div class="row">
                        @include('__global.loading')
                        <div class="col-sm-12 col-md-12 col-lg-12">
                            <div class="box">
                                <div class="box-body">
                                    <div class="row">
                                        <div class="col-lg-12 ">
                                            <form class="ui form  fix-sui">
                                                <div class="row">
                                                    <div class="col-lg-10 offset-lg-1">
                                                        <div class="ui message">
                                                            <div class="header">
                                                                Note
                                                            </div>
                                                            <p>Before Scan Lot,Please Pick From Department and Employee</p>
                                                        </div>
                                                        <div class="row">
                                                            <!--<div class="col-lg-2">
                                                                <div class="field">
                                                                    <label>Transfer Type</label>
                                                                    <toggle-button class="mt-2"
                                                                                   :disabled="true"
                                                                                   v-model="form.transaction_type"
                                                                                   color="#a1c573"
                                                                                   :sync="true"
                                                                                   :width="130"
                                                                                   :height="30"
                                                                                   :labels="{checked: 'Received', unchecked: 'Issue'}" ></toggle-button>
                                                                </div>
                                                            </div>-->
                                                            <div class="col-lg-6">
                                                                <div class="field custom_date">
                                                                    <label>Transfer Date*</label>
                                                                    <v-date-picker
                                                                        v-model="form.transaction_date"
                                                                        :disabled="isViewMode"
                                                                        class="date-picker-customize"
                                                                        enable-button-validate
                                                                        format="YYYY-MM-DD"
                                                                        formatted="D MMM YYYY"
                                                                        label=" "
                                                                        only-date
                                                                        auto-close
                                                                        title="Payment date">
                                                                    </v-date-picker>
                                                                    <div class="ui pointing red basic label"
                                                                         v-show="form.errors.has('transaction_date')">
                                                                        @{{ form.errors.get('transaction_date') }}
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-6">
                                                                <div class="field">
                                                                    <label>Scan Lot*</label>
                                                                    <!--<div class="ui action input">
                                                                        <input type="text" name="Scan Job Card" v-model="form.job_card_no" :disabled="true" placeholder="Job Card">
                                                                        <button class="ui button "> <i class="fa fa-eye"></i></button>
                                                                    </div>-->
                                                                    <v-select
                                                                        v-model="selected_bag"
                                                                        :disabled="isViewMode"
                                                                        :options="bag_options"
                                                                        :searchable="true"
                                                                        :multiple="false"
                                                                        label="bag_number"
                                                                        track-by="id"
                                                                        :show-labels="false"
                                                                        @input="changeBag()"
                                                                    ></v-select>
                                                                    <div class="ui pointing red basic label"
                                                                         v-show="form.errors.has('bag_id')">
                                                                        @{{ form.errors.get('bag_id') }}
                                                                    </div>

                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row mt-3">
                                                            <div class="col-lg-6">
                                                                <div class="field">
                                                                    <label class="text-black">From Department *</label>
                                                                    <v-select
                                                                        v-model="from_department"
                                                                        :options="department_options"
                                                                        :searchable="true"
                                                                        :multiple="false"
                                                                        label="name"
                                                                        track-by="id"
                                                                        :disabled="(!isAdminStatus) || isViewMode"
                                                                        :show-labels="false"
                                                                        @input="loadDropDownData('from_department')"
                                                                    ></v-select>
                                                                    <div class="ui pointing red basic label"
                                                                         v-show="form.errors.has('from_department_id')">
                                                                        @{{ form.errors.get('from_department_id') }}
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-6">
                                                                <div class="field">
                                                                    <label class="text-black">From Employee*</label>
                                                                    <v-select
                                                                        v-model="from_employee"
                                                                        :options="from_employee_options"
                                                                        :searchable="true"
                                                                        :multiple="false"
                                                                        label="name"
                                                                        track-by="id"
                                                                        :disabled="(!isAdminStatus) || isViewMode"
                                                                        :show-labels="false"
                                                                        :custom-label="customEmployeeLabel"
                                                                        @input="loadDropDownData('from_employee')"
                                                                    ></v-select>
                                                                    <div class="ui pointing red basic label"
                                                                         v-show="form.errors.has('from_employee_id')">
                                                                        @{{ form.errors.get('from_employee_id') }}
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row mt-3">
                                                            <div class="col-lg-6">
                                                                <div class="field">
                                                                    <label class="text-black">To Department *</label>
                                                                    <v-select
                                                                        v-model="to_department"
                                                                        :disabled="isViewMode"
                                                                        :options="department_options"
                                                                        :searchable="true"
                                                                        :multiple="false"
                                                                        label="name"
                                                                        track-by="id"
                                                                        :show-labels="false"
                                                                        @input="loadDropDownData('to_department')"
                                                                    ></v-select>
                                                                    <div class="ui pointing red basic label"
                                                                         v-show="form.errors.has('to_department_id')">
                                                                        @{{ form.errors.get('to_department_id') }}
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-6">
                                                                <div class="field">
                                                                    <label class="text-black">To Employee*</label>
                                                                    <v-select
                                                                        v-model="to_employee"
                                                                        :disabled="isViewMode"
                                                                        :options="to_employee_options"
                                                                        :searchable="true"
                                                                        :multiple="false"
                                                                        label="name"
                                                                        track-by="id"
                                                                        :show-labels="false"
                                                                        :custom-label="customEmployeeLabel"
                                                                    ></v-select>
                                                                    <div class="ui pointing red basic label"
                                                                         v-show="form.errors.has('to_employee_id')">
                                                                        @{{ form.errors.get('to_employee_id') }}
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row mt-3">
                                                            <div class="col-lg-12">
                                                                <div class="box">
                                                                    <div class="box-header">
                                                                        <div class="row">
                                                                            <div class="col-lg-8 ">
                                                                                <h3>Transfer Item</h3>
                                                                            </div>
                                                                            <!--<div class="col-lg-4 " v-if="!isViewMode">
                                                                                <button class="btn btn-fw info pull-right" type="button" ><i class="fa fa-plus"></i>Add Item</button>
                                                                            </div>-->
                                                                        </div>
                                                                    </div>
                                                                    <div class="box-body">
                                                                        <div class="table-responsive">
                                                                            <table class="ui celled table">
                                                                                <thead>
                                                                                <tr>
                                                                                    <th>S.No</th>
                                                                                    <th>Image</th>
                                                                                    <th>Style Sku</th>
                                                                                    <th>Uom</th>
                                                                                    <th>Quantity</th>
                                                                                    <th>Weight</th>
                                                                                    <th v-if="isViewMode">Status</th>
                                                                                    <th>Action</th>
                                                                                </tr>
                                                                                </thead>
                                                                                <tbody >
                                                                                <tr   v-for="(transaction_item,index) in transaction_items">
                                                                                    <td>@{{index+1}}</td>
                                                                                    <td>
                                                                                        <viewer :options="options" v-if="transaction_item.bag_style.upload != null">
                                                                                            <img class="ui tiny image"  :src="transaction_item.bag_style.upload.uploaded_path"  class="center">
                                                                                        </viewer>
                                                                                        <div v-else>-</div>
                                                                                    </td>
                                                                                    <td>@{{transaction_item.bag_style.style.sku}}</td>
                                                                                    <td>@{{transaction_item.bag_style.style.uom.name}}</td>
                                                                                    <td>@{{transaction_item.bag_style.quantity}}</td>
                                                                                    <td>@{{transaction_item.bag_style.weight}}</td>
                                                                                    <td v-if="isViewMode">@{{types.findTransactionType(transaction_item.status,'id','transaction_type')['name']}}</td>
                                                                                    <td>
                                                                                        <button type="button" class="btn btn-icon indigo" @click="showStyleModel(index)">
                                                                                            <i class="fa fa-eye"></i>
                                                                                        </button>
                                                                                        <button type="button" v-if="checkChangeStatus(index)" @click="changeTransferItemStatus(transaction_item.id,index)" class="btn btn-icon yellow">
                                                                                            <i class="fa fa-arrow-right"></i>
                                                                                        </button>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr v-if="transaction_items.length == 0">
                                                                                    <td col-span="7">No Data</td>
                                                                                </tr>
                                                                                </tbody>
                                                                            </table>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <sui-modal v-model="display_style" >
                                                            <sui-modal-header>Style Details</sui-modal-header>
                                                            <sui-modal-content >
                                                                <sui-modal-description>
                                                                    <div class="ui message ">
                                                                        <div class="ui grid">
                                                                            <div class="two wide column">
                                                                                <div v-if="viewedStyle.upload_id != null ">
                                                                                    <div class="ui centered card">
                                                                                        <div class="image">
                                                                                            <viewer :options="options">
                                                                                                <img :src="viewedStyle.upload.uploaded_path" width="100%" height="100%" />
                                                                                            </viewer>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="twelve wide column">
                                                                                <div class="three fields">
                                                                                    <div class="field">
                                                                                        <label>Sku</label>
                                                                                        <input type="text" disabled="disabled" :value="viewedStyle.sku"  placeholder="Sku" >
                                                                                    </div>
                                                                                    <div class="field">
                                                                                        <label>Weight</label>
                                                                                        <input type="text" disabled="disabled" :value="viewedStyle.weight"  placeholder="Weight" >
                                                                                    </div>
                                                                                    <div class="field">
                                                                                        <label>Uom</label>
                                                                                        <v-select
                                                                                            v-model="viewedStyle.uom"
                                                                                            :options="uom_options"
                                                                                            disabled="disabled"
                                                                                            :searchable="true"
                                                                                            :multiple="false"
                                                                                            label="name"
                                                                                            track-by="id"
                                                                                            :show-labels="false"
                                                                                        ></v-select>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="three fields" v-if="viewedStyle.product!=null">
                                                                                    <div class="field">
                                                                                        <label>Product Category</label>
                                                                                        <input type="text" disabled="disabled"  :value="(viewedStyle.product.product_category != null)? viewedStyle.product.product_category.name : ''"  placeholder="Product Category" >
                                                                                    </div>
                                                                                    <div class="field">
                                                                                        <label>Product Name</label>
                                                                                        <input type="text" disabled="disabled"   :value="viewedStyle.product.name"  placeholder="Product Name" >
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
                                                                        </div>
                                                                    </div>
                                                                </sui-modal-description>
                                                            </sui-modal-content>
                                                            <sui-modal-actions>
                                                                <button class="ui button medium" @click="closeStyleModel" type="button">Cancel</button>
                                                            </sui-modal-actions>
                                                        </sui-modal>
                                                        <div class="row mt-3">
                                                            <div class="col-lg-12">
                                                                <div class="field">
                                                                    <div class="one field">
                                                                        <label>Description</label>
                                                                        <vue-editor name="description" :disabled="isViewMode"
                                                                                    v-model="form.description"></vue-editor>
                                                                        <div class=" ui pointing red basic label"
                                                                             v-show="form.errors.has('description')">
                                                                            @{{ form.errors.get('description') }}
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row mt-3">
                                                            <div class="col-lg-12 ">
                                                                <div class="m-b btn-groups float-right">
                                                                    <button v-if="!isViewMode" class="btn btn-fw success " type="button" @click="submit">
                                                                        Submit
                                                                    </button>
                                                                    <button class="btn btn-fw dark " type="button" @click="showGrid">
                                                                        Cancel
                                                                    </button>
                                                                </div>
                                                            </div>
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
                </form-transaction>
            </div>
        </div>
    </div>
</manage-transaction>
@endsection


