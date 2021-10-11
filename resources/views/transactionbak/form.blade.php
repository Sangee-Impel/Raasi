@extends('layouts.home')
@section('content')
<transaction inline-template>
    <div class="padding">
        @include('__global.loading')
        <div class="ui centered grid"  >
            <div class="sixteen wide column">
                <form class="ui big form  fix-sui" v-hotkey="keymap">
                    <div class="ui raised segment">
                        <div class="row mt-3">
                            <div class="col-lg-12">
                                <div class="ui  buttons ">
                                    <button type="button" v-on:click="changeTabStatus('issue')" v-bind:class="{ basic : ( tabStatus != 'issue')  }" class="ui green  button"><b>Issue  </b></button>
                                    <button type="button" v-on:click="changeTabStatus('receive')" v-bind:class="{ basic : ( tabStatus != 'receive')  }"class="ui blue button "><b>Receive</b></button>
                                </div>
                                <div class="ui vertical animated button" title="clear" v-on:click="changeTabStatus(tabStatus)">
                                    <div class="hidden content">Clear</div>
                                    <div class="visible content">
                                        <i class="eraser icon"></i>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-lg-6">
                                <div class="two fields">
                                    <div class="field">
                                        <label>Scan Lot</label>
                                        <div class="ui action input">
                                            <v-select
                                                v-model="selected_bag"
                                                open-direction="bottom"
                                                :options="bag_options"
                                                :searchable="true"
                                                :internal-search="false"
                                                :clear-on-select="false"
                                                :multiple="false"
                                                :loading="multiLoading"
                                                label="bag_number"
                                                :options-limit="7"
                                                :limit="5"
                                                @search-change="loadBags"
                                                @input="changeBag()"
                                                track-by="id"
                                                placeholder="Type 2 more characters to search "
                                            ></v-select>
                                           <!-- <button class="ui icon button" type="button" @click="changeCheckBoxStatus">
                                                <input type="checkbox" v-model="is_job_card_search" >
                                            </button>-->
                                        </div>
                                        <div class="ui pointing red basic label"
                                             v-show="form.errors.has('bag_id')">
                                            @{{ form.errors.get('bag_id') }}
                                        </div>

                                    </div>
                                    <div class="field custom_date">
                                        <label>Transfer Date</label>
                                        <v-date-picker
                                            v-model="form.transaction_date"
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
                                <div class="two fields">
                                    <div class="field">
                                        <div class=" ui slider checkbox mt-2">
                                            <input v-model="is_eod_reporting" type="checkbox">
                                            <label>IS EOD Reporting</label>
                                        </div>
                                    </div>
                                    <div class="field">
                                        <input type="text" name="unit_name" v-model="form.description" placeholder="Description">
                                        <div class=" ui pointing red basic label"
                                             v-show="form.errors.has('description')">
                                            @{{ form.errors.get('description') }}
                                        </div>
                                        <!--<vue-editor name="description"
                                                    v-model="form.description"></vue-editor>-->
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="two fields">
                                    <div class="field">
                                        <label class="text-black">From</label>
                                        <v-select
                                            placeholder="Department"
                                            v-model="from_department"
                                            :options="from_department_options"
                                            :searchable="true"
                                            :multiple="false"
                                            label="name"
                                            track-by="id"
                                            :disabled="displayStatus.from_dep"
                                            :show-labels="true"
                                            @input="loadDropDownData('from_department')"
                                        ></v-select>
                                        <div class="ui pointing red basic label"
                                             v-show="form.errors.has('from_department_id')">
                                            @{{ form.errors.get('from_department_id') }}
                                        </div>
                                    </div>
                                    <div class="field">
                                        <label class="text-black">To</label>
                                        <v-select
                                            placeholder="Department"
                                            v-model="to_department"
                                            :options="to_department_options"
                                            :searchable="true"
                                            :multiple="false"
                                            label="name"
                                            track-by="id"
                                            :show-labels="false"
                                            :disabled="displayStatus.to_dep"
                                            @input="loadDropDownData('to_department')"
                                        ></v-select>
                                        <div class="ui pointing red basic label"
                                             v-show="form.errors.has('to_department_id')">
                                            @{{ form.errors.get('to_department_id') }}
                                        </div>
                                    </div>
                                </div>
                                <div class="two fields">
                                    <div class="field">
                                        <v-select
                                            placeholder="Employee"
                                            v-model="from_employee"
                                            :options="from_employee_options"
                                            :searchable="true"
                                            :multiple="false"
                                            label="name"
                                            track-by="id"
                                            :disabled="displayStatus.from_emp"
                                            :show-labels="false"
                                            :custom-label="customEmployeeLabel"
                                            @input="clearBagData()"
                                        ></v-select>
                                        <div class="ui pointing red basic label"
                                             v-show="form.errors.has('from_employee_id')">
                                            @{{ form.errors.get('from_employee_id') }}
                                        </div>
                                    </div>
                                    <div class="field">
                                        <v-select
                                            v-model="to_employee"
                                            placeholder="Employee"
                                            :options="to_employee_options"
                                            :searchable="true"
                                            :multiple="false"
                                            label="name"
                                            track-by="id"
                                            :show-labels="false"
                                            :custom-label="customEmployeeLabel"
                                            :disabled="displayStatus.to_emp"
                                        ></v-select>
                                        <div class="ui pointing red basic label"
                                             v-show="form.errors.has('to_employee_id')">
                                            @{{ form.errors.get('to_employee_id') }}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-lg-12">
                                <div class="box">
                                    <div class="box-header">
                                        <div class="row">
                                            <div class="col-lg-4 ">
                                                <h3>Transfer Items</h3>
                                            </div>
                                            <div class="col-lg-8">
                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        @permission('merge.transaction')
                                                            <button class="ui inverted yellow button pull-right"  type="button" v-if="isAllowedToSplitOrMerge && (displayMode.transfer_item_mode)"  @click="mergeBag()">Merge Lot</button>
                                                        @endpermission
                                                        @permission('split.transaction')
                                                            <button class="ui inverted orange button pull-right"  type="button" v-if="isAllowedToSplitOrMerge && (displayMode.transfer_item_mode)" @click="splitBag()">Split Lot</button>
                                                        @endpermission
                                                        <button class="ui inverted red button pull-right"  type="button" v-if="displayMode.transfer_item_mode" @click="deleteOtherAccessories()">Delete(Delete)</button>
                                                        <button class="ui inverted primary button pull-right" type="button" v-if="displayMode.transfer_item_mode"  @click="addOtherAccessories()">Add(Ctrl + Enter)</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <div class="ui segment m-2">
                                                    <div class="ui blurring dimmer" :class="( !displayMode.transfer_item_mode  )?'active':''"></div>
                                                    <div class="row" >
                                                        <div class="col-lg-8">
                                                            <div class="table-hover scroll-x" >
                                                                <table class="ui celled table ">
                                                                    <thead>
                                                                    <tr>
                                                                        <th>S.No</th>
                                                                        <th>Item</th>
                                                                        <th>Uom</th>
                                                                        <th>Quantity</th>
                                                                        <th>Weight</th>
                                                                        <th>Receive Weight</th>
                                                                        <!--<th>Action</th>-->
                                                                    </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                    <tr   v-for="(transaction_item,index) in transaction_items" @click="showStyleModel(index)" :class="( viewedStyleIndex == index )?'active':''">
                                                                        <td >@{{index+1}}</td>
                                                                        <td>
                                                                            <div v-if="transaction_item.type == types.findTransactionType('bag','value','transaction_type')['id']">
                                                                                <div v-if="transaction_item.bag_style.style != null ">
                                                                                    @{{transaction_item.bag_style.style.sku}}
                                                                                </div>
                                                                                <div v-else>
                                                                                    @{{transaction_item.other_accessories.name}}
                                                                                </div>
                                                                                <div class="ui pointing red basic label wrap-normal" v-show="form.errors.has('transaction_items.'+index+'.bag_style_id')">
                                                                                    @{{ form.errors.get('transaction_items.'+index+'.bag_style_id') }}
                                                                                </div>
                                                                            </div>
                                                                            <div v-else>
                                                                                <v-select
                                                                                    v-model="transaction_item.other_accessories"
                                                                                    :options="other_accessories_options"
                                                                                    :searchable="true"
                                                                                    :multiple="false"
                                                                                    label="name"
                                                                                    track-by="id"
                                                                                    :show-labels="false"
                                                                                    @input="bindAccessories(index)"
                                                                                ></v-select>
                                                                                <div class="clear-fix"></div>
                                                                                <div class="ui pointing red basic label wrap-normal" v-show="form.errors.has('transaction_items.'+index+'.other_accessories_id')">
                                                                                    @{{ form.errors.get('transaction_items.'+index+'.other_accessories_id') }}
                                                                                </div>
                                                                            </div>
                                                                        </td>
                                                                        <td>
                                                                            @{{transaction_item.uom_name}}
                                                                            <div class="clear-fix"></div>
                                                                            <div class="ui pointing red basic label wrap-normal" v-show="form.errors.has('transaction_items.'+index+'.uom_id')">
                                                                                @{{ form.errors.get('transaction_items.'+index+'.uom_id') }}
                                                                            </div>
                                                                            <div class="ui pointing red basic label wrap-normal" v-show="form.errors.has('transaction_items.'+index+'.user_loss_scrap_weight')">
                                                                                @{{ form.errors.get('transaction_items.'+index+'.user_loss_scrap_weight') }}
                                                                            </div>
                                                                        </td>
                                                                        <td>
                                                                            <div v-if="transaction_item.type == types.findTransactionType('bag','value','transaction_type')['id']">
                                                                                @{{transaction_item.quantity}}
                                                                            </div>
                                                                            <div v-else>
                                                                                <input type="text"  v-model="transaction_item.quantity"  placeholder="quantity" >
                                                                            </div>
                                                                            <div class="clear-fix"></div>
                                                                            <div class="ui pointing red basic label wrap-normal" v-show="form.errors.has('transaction_items.'+index+'.quantity')">
                                                                                @{{ form.errors.get('transaction_items.'+index+'.quantity') }}
                                                                            </div>
                                                                        </td>
                                                                        <td>
                                                                            <div v-if="transaction_item.type == types.findTransactionType('bag','value','transaction_type')['id']">
                                                                                @{{transaction_item.weight}}
                                                                            </div>
                                                                            <div v-else>
                                                                                <input type="text" v-model="transaction_item.weight"  placeholder="weight" >
                                                                            </div>
                                                                            <div class="clear-fix"></div>
                                                                            <div class="ui pointing red basic label wrap-normal" v-show="form.errors.has('transaction_items.'+index+'.weight')">
                                                                                @{{ form.errors.get('transaction_items.'+index+'.weight') }}
                                                                            </div>
                                                                        </td>
                                                                        <td>
                                                                            <input type="text" v-model="transaction_item.receive_weight" readonly placeholder="weight" >
                                                                            <div class="ui pointing red basic label wrap-normal" v-show="form.errors.has('transaction_items.'+index+'.receive_weight')">
                                                                                @{{ form.errors.get('transaction_items.'+index+'.receive_weight') }}
                                                                            </div>
                                                                        </td>
                                                                        <!--<td>
                                                                            <button class="ui button medium yellow" v-if="transaction_item.transaction_item_loss_detail_status" @click="showLossDetailModel(index)" type="button">Add Loss/Scrap</button>
                                                                        </td>-->
                                                                    </tr>
                                                                    <tr v-if="transaction_items.length == 0">
                                                                        <td col-span="8">No Data</td>
                                                                    </tr>
                                                                    <tr v-else>

                                                                        <td colspan="3">Total</td>
                                                                        <td>@{{form.total_transfer_quantity}}
                                                                            <div class="ui pointing red basic label wrap-normal" v-show="form.errors.has('total_transfer_quantity')">
                                                                                @{{ form.errors.get('total_transfer_quantity') }}
                                                                            </div>
                                                                        </td>
                                                                        <td>@{{form.total_transfer_weight}}
                                                                            <div class="ui pointing red basic label wrap-normal" v-show="form.errors.has('total_transfer_weight')">
                                                                                @{{ form.errors.get('total_transfer_weight') }}
                                                                            </div>
                                                                        </td>
                                                                        <td>
                                                                            <input type="text" v-model="form.total_receive_weight" placeholder="weight" >
                                                                            <div class="ui pointing red basic label wrap-normal" v-show="form.errors.has('total_receive_weight')">
                                                                                @{{ form.errors.get('total_receive_weight') }}
                                                                            </div>
                                                                        </td>
                                                                        @{{getTransferItemTotal}}
                                                                        <!--<td>

                                                                        </td>-->
                                                                    </tr>
                                                                    </tbody>
                                                                </table>
                                                                <div class="text-right" v-if="form.transaction_item_loss_detail_status">
                                                                    <button class="ui button medium yellow"  @click="showLossDetailModel(index)" type="button">Add Loss/Scrap</button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-4">
                                                            <div class="ui card">
                                                                <a class="ui right blue corner label" v-if="checkBagStyleImagesStatus"  @click="viewBagStyleImage">
                                                                    <i class="eye icon"></i>
                                                                </a>
                                                                <div class="image"  v-if="viewedStyle.bag_style != undefined && viewedStyle.bag_style.upload_id != null ">

                                                                    <viewer :options="options">
                                                                        <img  :src="viewedStyle.bag_style.upload.uploaded_path" width="100%" height="100%" />
                                                                    </viewer>
                                                                </div>
                                                                <div class="image"  v-else>
                                                                    <img src="{{asset('images/no-image-available-icon.jpg')}}" width="100%" height="100%" />
                                                                </div>
                                                                <div class="content">
                                                                    <div class="description">
                                                                        <div  v-if="viewedStyle.bag_style != undefined && viewedStyle.bag_style.style != undefined && viewedStyle.bag_style.style.product!=null">
                                                                            <div><span class="_700">Style Weight -</span>@{{viewedStyle.bag_style.style.weight}} </div>
                                                                            <div><span class="_700">Product -</span>@{{viewedStyle.bag_style.style.product.name}} </div>
                                                                            <div><span class="_700">Category -</span>@{{viewedStyle.bag_style.style.product.product_category.name}} </div>
                                                                            <div><span class="_700">Instruction -</span>@{{viewedStyle.bag_style.instructions}} </div>
                                                                        </div>
                                                                        <div class="" v-else>
                                                                            <div><span class="_700">Weight</span>- </div>
                                                                            <div><span class="_700">Product Category</span> - </div>
                                                                            <div><span class="_700">Product Name</span> - </div>
                                                                            <div><span class="_700">Instruction</span> - </div>
                                                                        </div>
                                                                        <div><span class="_700">Max Loss/Scrap -</span>@{{viewedStyle.max_loss_weight}} </div>
                                                                        <div><span class="_700">User Loss/Scrap -</span>@{{viewedStyle.user_loss_scrap_weight}}
                                                                        <div><span class="_700">User Scrap -</span>@{{viewedStyle.user_scrap_weight}}
                                                                        <div><span class="_700">User Loss -</span>@{{viewedStyle.user_loss_weight}}
                                                                        <div><span class="_700">User Channam -</span>@{{viewedStyle.user_channam_weight}}
                                                                <span class="_700" v-if="viewedStyle.old_transaction_item_loss_details != undefined && viewedStyle.old_transaction_item_loss_details.length > 0">
                                                                    <button  class="btn btn-icon indigo" @click="viewTransactionItemLossDetails" type="button"><i class="fa fa-eye"></i></button>
                                                                </span>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                                    </div></div>

                                        <div class="row" v-if="displayMode.split_mode" >
                                            <div class="col-lg-12">
                                                <div class="box m-2">
                                                    <a type="button" @click="closeSplitMode" class="ui red right corner label" >
                                                        <i class="times icon"></i>
                                                    </a>
                                                    <div class="box-header">
                                                        <div class="row">
                                                            <div class="col-lg-4 ">
                                                                <h3>Split Lot</h3>
                                                            </div>

                                                        </div>
                                                    </div>
                                                    <div class="box-body">
                                                        <div class="row">
                                                            <div class="col-lg-6">
                                                                <div class="ui top attached green button" title="Click here to transfer" type="button" @click="splitBagTransferReceive('transfer')"><i class="angle double right icon"></i></div>
                                                                <div class="ui attached segment split-list-scroll">
                                                                    <div class="ui middle aligned divided list">
                                                                        <div class="ui medium header m-2" v-if="selected_bag != null">@{{selected_bag.bag_number}}</div>
                                                                        <div class="ui segment m-1 split-sender"  v-for="(split_item,split_item_index) in transaction_items" :class="[( viewedSplitIndex == split_item_index ?'active':''), (split_item.split.transfer.class)]" @click="splitItemSelected(split_item_index)" >
                                                                            <div class="row">
                                                                                <div class="col-lg-12">
                                                                                    <div class="row">
                                                                                        <div class="col-lg-8">
                                                                                            <div class="inline fields">
                                                                                                <div class="sixteen wide field">
                                                                                                    <label>Item : </label>
                                                                                                    <div v-if="split_item.type == types.findTransactionType('bag','value','transaction_type')['id']">
                                                                                                        <div v-if="split_item.bag_style.style != null ">
                                                                                                            @{{split_item.bag_style.style.sku}}
                                                                                                        </div>
                                                                                                        <div v-else>
                                                                                                            @{{split_item.other_accessories.name}}
                                                                                                        </div>
                                                                                                    </div>
                                                                                                    <div v-else>
                                                                                                        @{{split_item.other_accessories.name}}
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                        <div class="col-lg-4">
                                                                                            <div class="inline fields">
                                                                                                <div class="sixteen wide field">
                                                                                                    <label>Uom : </label>
                                                                                                    @{{split_item.uom_name}}
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="row">
                                                                                        <div class="col-lg-4">
                                                                                            <div class="inline fields">
                                                                                                <div class="sixteen wide field">
                                                                                                    <label>QTY: </label>
                                                                                                    <span class="word-break-all">@{{split_item.split.transfer.quantity}}</span>
                                                                                                    <div class="ui pointing red basic label wrap-normal" v-show="form.errors.has('transaction_items.'+split_item_index+'.split.transfer.quantity')">
                                                                                                        @{{ form.errors.get('transaction_items.'+split_item_index+'.split.transfer.quantity') }}
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                        <div class="col-lg-8">
                                                                                            <div class="inline fields">
                                                                                                <div class="sixteen wide field">
                                                                                                    <label>Transfer QTY :</label>
                                                                                                    <input type="text" v-model="split_item.split.transfer.transfer_quantity" placeholder="Receive Quantity">
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="row">
                                                                                        <div class="col-lg-4">
                                                                                            <div class="inline fields">
                                                                                                <div class="sixteen wide field">
                                                                                                    <label>Weight: </label>
                                                                                                    <span class="word-break-all">@{{split_item.split.transfer.weight}}</span>
                                                                                                    <div class="ui pointing red basic label wrap-normal" v-show="form.errors.has('transaction_items.'+split_item_index+'.split.transfer.weight')">
                                                                                                        @{{ form.errors.get('transaction_items.'+split_item_index+'.split.transfer.weight') }}
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                        <div class="col-lg-8">
                                                                                            <div class="inline fields">
                                                                                                <div class="sixteen wide field">
                                                                                                    <label>Transfer Weight :</label>
                                                                                                    <input type="text" v-model="split_item.split.transfer.transfer_weight" placeholder="Receive Weight">
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
                                                            <div class="col-lg-6">
                                                                <div class="ui top attached red button" title="Click here to transfer" type="button"  @click="splitBagTransferReceive('receive')"><i class="angle double left icon"></i></div>
                                                                <div class="ui attached segment split-list-scroll">
                                                                    <div class="ui middle aligned divided list">
                                                                        <div class="ui medium header m-2" v-if="selected_bag != null">@{{selected_bag.bag_number}}@{{types.split_string}}@{{selected_bag.iteration+1}}</div>
                                                                        <div class="ui segment m-1 split-receiver"  v-for="(split_item,split_item_index) in transaction_items"  :class="[( viewedSplitIndex == split_item_index ?'active':''), (split_item.split.receive.class)]"  @click="splitItemSelected(split_item_index)">
                                                                            <div class="row">
                                                                                <div class="col-lg-12">
                                                                                    <div class="row">
                                                                                        <div class="col-lg-8">
                                                                                            <div class="inline fields">
                                                                                                <div class="sixteen wide field">
                                                                                                    <label>Item : </label>
                                                                                                    <div v-if="split_item.type == types.findTransactionType('bag','value','transaction_type')['id']">
                                                                                                        <div v-if="split_item.bag_style.style != null ">
                                                                                                            @{{split_item.bag_style.style.sku}}
                                                                                                        </div>
                                                                                                        <div v-else>
                                                                                                            @{{split_item.other_accessories.name}}
                                                                                                        </div>
                                                                                                    </div>
                                                                                                    <div v-else>
                                                                                                        @{{split_item.other_accessories.name}}
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                        <div class="col-lg-4">
                                                                                            <div class="inline fields">
                                                                                                <div class="sixteen wide field">
                                                                                                    <label>Uom : </label>
                                                                                                    @{{split_item.uom_name}}
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="row">
                                                                                        <div class="col-lg-4">
                                                                                            <div class="inline fields">
                                                                                                <div class="sixteen wide field">
                                                                                                    <label>QTY: </label>
                                                                                                    <span class="word-break-all">@{{split_item.split.receive.quantity}}</span>
                                                                                                    <div class="ui pointing red basic label wrap-normal" v-show="form.errors.has('transaction_items.'+split_item_index+'.split.receive.quantity')">
                                                                                                        @{{ form.errors.get('transaction_items.'+split_item_index+'.split.receive.quantity') }}
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                        <div class="col-lg-8">
                                                                                            <div class="inline fields">
                                                                                                <div class="sixteen wide field">
                                                                                                    <label>Transfer QTY :</label>
                                                                                                    <input type="text" v-model="split_item.split.receive.transfer_quantity" placeholder="Receive Quantity">
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="row">
                                                                                        <div class="col-lg-4">
                                                                                            <div class="inline fields">
                                                                                                <div class="sixteen wide field">
                                                                                                    <label>Weight: </label>
                                                                                                    <span class="word-break-all">@{{split_item.split.receive.weight}}</span>
                                                                                                    <div class="ui pointing red basic label wrap-normal" v-show="form.errors.has('transaction_items.'+split_item_index+'.split.receive.weight')">
                                                                                                        @{{ form.errors.get('transaction_items.'+split_item_index+'.split.receive.weight') }}
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                        <div class="col-lg-8">
                                                                                            <div class="inline fields">
                                                                                                <div class="sixteen wide field">
                                                                                                    <label>Transfer Weight :</label>
                                                                                                    <input type="text" v-model="split_item.split.receive.transfer_weight" placeholder="Receive Weight">
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
                                                        </div>
                                                        {{--@{{getSplitTransferItemTotal}}
                                                        <div class="text-right p-t-sm" v-if="form.transaction_item_loss_detail_status">
                                                            <button class="ui button medium yellow"  @click="showLossDetailModel()" type="button">Add Loss/Scrap</button>
                                                        </div>--}}
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row" v-if="displayMode.merge_mode">
                                            <div class="col-lg-12">
                                                <div class="box m-2">
                                                    <a type="button" @click="closeMergeMode" class="ui red right corner label" >
                                                        <i class="times icon"></i>
                                                    </a>
                                                    <div class="box-header">
                                                        <div class="row">
                                                            <div class="col-lg-4 ">
                                                                <h3>Merge Lot</h3>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="box-body">
                                                        <div class="row">
                                                            <div class="col-lg-12">
                                                                <div class="two fields">
                                                                    <div class="field">
                                                                        <label>Scan Merge Lot</label>
                                                                        <div class="ui action input">
                                                                            <v-select
                                                                                v-model="merge_selected_bag"
                                                                                open-direction="bottom"
                                                                                :options="merge_bag_options"
                                                                                :searchable="true"
                                                                                :internal-search="false"
                                                                                :clear-on-select="false"
                                                                                :multiple="false"
                                                                                :loading="multiLoading"
                                                                                label="bag_number"
                                                                                :options-limit="7"
                                                                                :limit="5"
                                                                                @search-change="loadMergeBags"
                                                                                track-by="id"
                                                                                placeholder="Type 2 more characters to search "
                                                                            ></v-select>
                                                                        </div>
                                                                    </div>
                                                                    <div class="field">
                                                                        <button class="ui inverted yellow button mt-4"  type="button"  @click="mergeSelectedBag()">Get Lot</button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-6">
                                                                <!--<div class="ui top attached green button" :disabled="true" title="Click here to transfer" type="button" ><i class="angle double right icon"></i></div>-->
                                                                <div class="ui attached segment split-list-scroll">
                                                                    <div class="ui middle aligned divided list">
                                                                        <div class="ui medium header m-2" v-if="selected_bag != null">@{{selected_bag.bag_number}}</div>
                                                                        <div class="ui pointing red basic label wrap-normal" v-show="form.errors.has('merge.transfer')">
                                                                            @{{ form.errors.get('merge.transfer') }}
                                                                        </div>
                                                                        <div class="ui segment m-1 split-sender"  v-for="(transfer_item,transfer_item_index) in form.merge.transfer" :class="[(transfer_item.class)]"  >
                                                                            <div class="row">
                                                                                <div class="col-lg-12">
                                                                                    <div class="row">
                                                                                        <div class="col-lg-8">
                                                                                            <div class="inline fields">
                                                                                                <div class="sixteen wide field">
                                                                                                    <label>Item : </label>
                                                                                                    <div v-if="transfer_item.type == types.findTransactionType('bag','value','transaction_type')['id']">
                                                                                                        <div v-if="transfer_item.bag_style.style != null ">
                                                                                                            @{{transfer_item.bag_style.style.sku}}
                                                                                                        </div>
                                                                                                        <div v-else>
                                                                                                            @{{transfer_item.other_accessories.name}}
                                                                                                        </div>
                                                                                                    </div>
                                                                                                    <div v-else>
                                                                                                        @{{transfer_item.other_accessories.name}}
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                        <div class="col-lg-4">
                                                                                            <div class="inline fields">
                                                                                                <div class="sixteen wide field">
                                                                                                    <label>Uom : </label>
                                                                                                    @{{transfer_item.uom_name}}
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="row">
                                                                                        <div class="col-lg-12">
                                                                                            <div class="inline fields">
                                                                                                <div class="sixteen wide field">
                                                                                                    <label>QTY: </label>
                                                                                                    <span class="word-break-all">@{{transfer_item.quantity}}</span>

                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                        <!--<div class="col-lg-8">
                                                                                            <div class="inline fields">
                                                                                                <div class="sixteen wide field">
                                                                                                    <label>Transfer QTY :</label>
                                                                                                    <input type="text" v-model="transfer_item.transfer_quantity" :disabled="disabled" placeholder="Transfer Quantity">
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>-->
                                                                                    </div>
                                                                                    <div class="row">
                                                                                        <div class="col-lg-12">
                                                                                            <div class="inline fields">
                                                                                                <div class="sixteen wide field">
                                                                                                    <label>Weight: </label>
                                                                                                    <span class="word-break-all">@{{transfer_item.weight}}</span>

                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                        <!--<div class="col-lg-8">
                                                                                            <div class="inline fields">
                                                                                                <div class="sixteen wide field">
                                                                                                    <label>Transfer Weight :</label>
                                                                                                    <input type="text" v-model="transfer_item.transfer_weight" :disabled="transfer_item.disabled" placeholder="Transfer Weight">
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>-->
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-6">
                                                                <div class="ui pointing red basic label wrap-normal" v-show="form.errors.has('merge.receive')">
                                                                    @{{ form.errors.get('merge.receive') }}
                                                                </div>
                                                                <div class="ui top attached red button" v-if="form.merge.receive != null" title="Click here to transfer" type="button" @click="mergeBagTransferReceive('receive')" ><i class="angle double left icon"></i></div>
                                                                <div class="ui attached segment split-list-scroll">
                                                                    <div class="ui middle aligned divided list" v-if="form.merge.receive != null">
                                                                        <div class="ui medium header m-2" >@{{form.merge.receive.bag_number}}</div>
                                                                        <div class="ui segment m-1 split-receiver"  v-for="(bag_style,bag_styles_index) in form.merge.receive.bag_styles"   :class="[(bag_style.class)]">
                                                                            <div class="row">
                                                                                <div class="col-lg-12">
                                                                                    <div class="row" v-if="bag_style.style != null ">
                                                                                        <div class="col-lg-8">
                                                                                            <div class="inline fields">
                                                                                                <div class="sixteen wide field">
                                                                                                    <label>Item : </label>
                                                                                                    <div >
                                                                                                        @{{bag_style.style.sku}}
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                        <div class="col-lg-4">
                                                                                            <div class="inline fields">
                                                                                                <div class="sixteen wide field">
                                                                                                    <label>Uom : </label>
                                                                                                    @{{bag_style.style.uom.name}}
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="row" v-else>
                                                                                        <div class="col-lg-8">
                                                                                            <div class="inline fields">
                                                                                                <div class="sixteen wide field">
                                                                                                    <label>Item : </label>
                                                                                                    <div >
                                                                                                        @{{bag_style.other_accessories.name}}
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                        <div class="col-lg-4">
                                                                                            <div class="inline fields">
                                                                                                <div class="sixteen wide field">
                                                                                                    <label>Uom : </label>
                                                                                                    @{{bag_style.other_accessories.uom.name}}
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>

                                                                                    </div>
                                                                                    <div class="row">
                                                                                        <div class="col-lg-4">
                                                                                            <div class="inline fields">
                                                                                                <div class="sixteen wide field">
                                                                                                    <label>QTY: </label>
                                                                                                    <span class="word-break-all">@{{bag_style.quantity}}</span>

                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                        <div class="col-lg-8">
                                                                                            <div class="inline fields">
                                                                                                <div class="sixteen wide field">
                                                                                                    <label>Transfer QTY :</label>
                                                                                                    <input type="text" v-model="bag_style.transfer_quantity" placeholder="Transfer Quantity">
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="row">
                                                                                        <div class="col-lg-4">
                                                                                            <div class="inline fields">
                                                                                                <div class="sixteen wide field">
                                                                                                    <label>Weight: </label>
                                                                                                    <span class="word-break-all">@{{bag_style.weight}}</span>

                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                        <div class="col-lg-8">
                                                                                            <div class="inline fields">
                                                                                                <div class="sixteen wide field">
                                                                                                    <label>Transfer Weight :</label>
                                                                                                    <input type="text" v-model="bag_style.transfer_weight"  placeholder="Transfer Weight">
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
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-lg-12 ">
                                <div class="m-b btn-groups float-right">
                                    <button  class="btn btn-fw success " type="button" @click="submit">
                                        @{{tabStatus|nameToUpper}}
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <sui-modal v-model="display_loss_details" >
                                <sui-modal-header>Transfer Item Loss/Scrap Details</sui-modal-header>
                                <sui-modal-content scrolling>
                                    <sui-modal-description>
                                        <div class="ui message ">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <div class="row">
                                                        <div class="col-lg-12">
                                                            Max allowed Loss/Scrap Weight - @{{form.max_loss_weight}}
                                                        </div>
                                                        <!--<div class="col-lg-6">
                                                            <button class="ui inverted primary button pull-right" type="button" @click="addTransferItemLossAndScrapItem()">Add Loss/Scrap</button>
                                                        </div>-->
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row  mt-3">
                                                <div class="col-lg-12">
                                                    <div class="table-hover" >
                                                        <table class="ui celled table ">
                                                            <thead>
                                                            <tr>
                                                                <td>Type</td>
                                                                <!--<td>User</td>-->
                                                                <td>Weight</td>
                                                                <!--<td>Action</td>-->
                                                            </tr>
                                                            </thead>
                                                            <tbody>
                                                            <tr   v-for="(transaction_item_loss_detail,lossDetailIndex) in selectedTransferItem.transaction_item_loss_details" >
                                                                <td>
                                                                    <v-select
                                                                        placeholder="Type"
                                                                        v-model="transaction_item_loss_detail.type_drop_down"
                                                                        :options="types.transaction_item_loss_type"
                                                                        :searchable="true"
                                                                        :multiple="false"
                                                                        label="name"
                                                                        track-by="id"
                                                                        deselect-label="Can't remove this value"
                                                                        :allow-empty="false"
                                                                        @input="checkWastageType(lossDetailIndex)"
                                                                        :disabled="true"
                                                                    ></v-select>
                                                                </td>
                                                                <!--<td>
                                                                    <v-select
                                                                        v-if="transaction_item_loss_detail.type_drop_down != null &&  transaction_item_loss_detail.type_drop_down.id == types.findTransactionType('scrap','value','transaction_item_loss_type')['id']"
                                                                        placeholder="User"
                                                                        v-model="transaction_item_loss_detail.user"
                                                                        :options="user_options"
                                                                        :searchable="true"
                                                                        :multiple="false"
                                                                        label="name"
                                                                        track-by="id"
                                                                        @input="checkScrapUserDuplicate(lossDetailIndex)"
                                                                    ></v-select>
                                                                </td>-->
                                                                <td>
                                                                    <input type="text" v-model="transaction_item_loss_detail.weight"  placeholder="weight" >
                                                                    @{{checkAdminAllowedMaximumLossesString(lossDetailIndex)}}
                                                                </td>
                                                                <!--<td>
                                                                    <button  class="btn btn-icon danger" type="button"
                                                                             @click="deleteLossRecord(lossDetailIndex)">
                                                                        <i class="fa fa-remove"></i>
                                                                    </button>
                                                                </td>-->
                                                            </tr>
                                                            <tr v-if="selectedTransferItem.transaction_item_loss_details != undefined && selectedTransferItem.transaction_item_loss_details.length == 0">
                                                                <td colspan="2">No Data</td>
                                                            </tr>
                                                            <tr v-else>
                                                                <td >Total Scrap And Loss Weight</td>
                                                                @{{checkTotalScrapLossWeight}}
                                                                <td>@{{selectedTransferItem.user_loss_scrap_weight}}</td>
                                                            </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </sui-modal-description>
                                </sui-modal-content>
                                <sui-modal-actions>
                                    <button class="ui button medium green" @click="saveLossDetailModel" type="button">Save</button>
                                    <button class="ui button medium" @click="closeLossDetailModel" type="button">Cancel</button>
                                </sui-modal-actions>
                            </sui-modal>
                            <sui-modal v-model="display_loss_details_report" >
                                <sui-modal-header>View Transfer Item Loss/Scrap Details</sui-modal-header>
                                <sui-modal-content scrolling>
                                    <sui-modal-description>
                                        <div class="ui message ">
                                            <div class="row  mt-3">
                                                <div class="col-lg-12">
                                                    <div class="table-hover" >
                                                        <table class="ui celled table ">
                                                            <thead>
                                                            <tr>
                                                                <td>Type</td>
                                                                <td>Date</td>
                                                                <td>User</td>
                                                                <td>Weight</td>
                                                            </tr>
                                                            </thead>
                                                            <tbody>
                                                            <tr   v-for="(transaction_item_loss_detail,lossDetailIndex) in viewedStyle.old_transaction_item_loss_details" >
                                                                <td>
                                                                    @{{getScrapLossDetailType(transaction_item_loss_detail.type)}}
                                                                </td>
                                                                <td>
                                                                    @{{transaction_item_loss_detail.date | formatDate('DD-MM-YYYY')}}
                                                                </td>
                                                                <td>
                                                                    <div v-if="transaction_item_loss_detail.user != null">
                                                                        @{{transaction_item_loss_detail.user.name}}
                                                                    </div>
                                                                    <div v-else>-</div>
                                                                </td>
                                                                <td>
                                                                    @{{transaction_item_loss_detail.weight}}
                                                                </td>
                                                            </tr>
                                                            <tr v-if="viewedStyle.old_transaction_item_loss_details != undefined && viewedStyle.old_transaction_item_loss_details.length == 0">
                                                                <td colspan="4">No Data</td>
                                                            </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </sui-modal-description>
                                </sui-modal-content>
                                <sui-modal-actions>
                                    <button class="ui button medium" @click="closeViewLossDetailModel" type="button">Cancel</button>
                                </sui-modal-actions>
                            </sui-modal>
                            <sui-modal v-model="display_bag_style_images" >
                                <sui-modal-header>Lot Style Images</sui-modal-header>
                                <sui-modal-content scrolling>
                                    <sui-modal-description>
                                        <div class="ui message ">
                                            <div class="row  mt-3">
                                                <div class="col-lg-12">
                                                    <v-gallery :images="bag_style_images_view"  ></v-gallery>
                                                </div>
                                            </div>
                                        </div>
                                    </sui-modal-description>
                                </sui-modal-content>
                                <sui-modal-actions>
                                    <button class="ui button medium" @click="closeViewBagStyleImageModel" type="button">Cancel</button>
                                </sui-modal-actions>
                            </sui-modal>
                        </div>

                    </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</transaction>
@endsection


