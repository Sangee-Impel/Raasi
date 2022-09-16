import VueSelect from 'vue-multiselect';
import { ToggleButton } from 'vue-js-toggle-button';
import 'viewerjs/dist/viewer.css';
import 'vue-ctk-date-time-picker/dist/vue-ctk-date-time-picker.css';
import Datetime from 'vue-ctk-date-time-picker';
import Viewer from 'v-viewer'
import Vue from 'vue'
import { VueTabs, VTab } from 'vue-nav-tabs';
Vue.use(Viewer);
var bigdecimal = require("bigdecimal");
var bigDecimal = require('js-big-decimal');
Vue.component('ToggleButton', ToggleButton);
import TypeDefs from './type-defs';
import CommonMethods from './../__globals/common-methods';
Vue.component('transaction', {
    components: {
        'v-select': VueSelect,
        'v-date-picker': Datetime,
        VueTabs,
        VTab,
        CommonMethods
    },
    data() {
        return {
            types: TypeDefs,
            displayStatus: {
                from_dep: false,
                from_emp: false,
                to_dep: false,
                to_emp: false
            },
            multiLoading: false,
            tabStatus: "issue",
            isLoading: false,
            isAdminStatus: true,
            form: this.getFormData(),
            options: { "button": true, "navbar": false, "zoomable": true, "toolbar": true, "play": false },
            from_department: null,
            from_employee: null,
            to_employee: null,
            to_department: null,
            login_user: null,

            department_options: [],
            from_department_options: [],
            to_department_options: [],
            employee_options: [],
            user_options: [],
            from_employee_options: [],
            to_employee_options: [],
            bag_options: [],
            selected_bag: null,
            merge_bag_options: [],
            merge_selected_bag: null,

            transaction_items: [],
            last_transaction_items: [],
            total_quantity: 0,
            total_weight: 0,
            total_receive_weight: 0,
            total_loss_weight: 0,
            total_loss_quantity: 0,
            viewedStyleIndex: 0,
            viewedStyle: {},
            display_style: false,
            display_loss_details: false,
            display_scrap_details: false,
            display_loss_details_report: false,
            uom_options: [],
            other_accessories_options: [],

            searchBagString: "",
            is_eod_reporting: false,
            is_job_card_search: true,
            transferItemIndex: 0,

            selectedTransferItem: [],
            selectedMaxLossWeight: 0,
            viewedSplitIndex: 0,
            displayMode: {
                transfer_item_mode: true,
                split_mode: false,
                merge_mode: false,
            },
            display_bag_style_images: false,
            bag_style_images_view: [],

        };
    },

    created() {
        this.form.errors.forget(); //to reset validation errors
    },
    beforeDestroy() { },
    computed: {
        isAllowedToSplitOrMerge() {
            let isValid = false;
            let transaction_items = this.transaction_items;
            let qty = 0;
            if (transaction_items.length > 0) {
                isValid = true;
                for (var index in transaction_items) {
                    // if ((transaction_items[index].quantity <= 1 && transaction_items[index].other_accessories.id === undefined) || this.form.transaction_item_loss_detail_status)
                    //     isValid = false;
                    if ((transaction_items[index].other_accessories.id === undefined) || this.form.transaction_item_loss_detail_status) {
                        qty += transaction_items[index].quantity;
                    }
                }
            }
            if (qty <= 1) {
                isValid = false;
            }

            if (isValid && !this.form.transaction_item_loss_detail_status) {
                isValid = true;
            }
            return isValid;
        },
        checkBagStyleImagesStatus() {
            if (this.viewedStyle.bag_style) {
                if (this.viewedStyle.bag_style.style != null) {
                    if (this.viewedStyle.bag_style.style.style_images && this.viewedStyle.bag_style.style.style_images.length > 0)
                        return true;
                }
            }
            return false;
        },
        //hot key mapping, refer inline template view file for attribute {{v-hotkey="keymap"}}
        keymap() {
            return {
                'ctrl+enter': this.addOtherAccessories,
                'del': this.deleteOtherAccessories,
                'up': this.upArrowOtherAccessories,
                'down': this.downArrowOtherAccessories,

            }
        },
        getTransferItemTotal() {
            let totalWeight = 0;
            let totalQuantity = 0;
            let transaction_items = this.transaction_items;
            var pre_loss_weight = 0;
            var pre_loss_quantity = 0;
            if (this.selected_bag != null) {
                if (this.selected_bag.last_transaction != null) {
                    pre_loss_weight = this.selected_bag.last_transaction.total_loss_weight;
                    pre_loss_quantity = this.selected_bag.last_transaction.total_loss_quantity;
                }
            }
            let totalReceiveWeight = (this.form.total_receive_weight == undefined) ? 0 : this.form.total_receive_weight;
            if (transaction_items.length > 0) {
                for (var index = 0; index <= transaction_items.length; index++) {
                    if (transaction_items[index] != undefined) {
                        let weight = parseFloat(transaction_items[index].weight);
                        let quantity = parseInt(transaction_items[index].quantity);
                        transaction_items[index].receive_weight = weight;
                        if (!isNaN(weight)) {
                            totalWeight = CommonMethods.BigDecimalFunction("add", totalWeight, weight);
                        }
                        if (!isNaN(quantity)) {
                            totalQuantity = CommonMethods.BigDecimalFunction("add", totalQuantity, quantity);
                        }
                    }
                }
                totalWeight = totalWeight - pre_loss_weight;
                totalQuantity = totalQuantity - pre_loss_quantity;
            }

            // totalReceiveWeight  = CommonMethods.precisionRound( this.form.total_receive_weight - pre_loss_weight );
            totalReceiveWeight = (parseFloat(this.form.total_transfer_weight).toFixed(3) != parseFloat(totalWeight).toFixed(3)) ? totalWeight : totalReceiveWeight;
            if (totalWeight < totalReceiveWeight) {
                totalReceiveWeight = totalWeight;
            }
            //console.log(totalReceiveWeight);
            this.form.total_transfer_weight = parseFloat(totalWeight).toFixed(3);
            this.form.total_transfer_quantity = parseInt(totalQuantity);
            this.form.total_receive_weight = this.isFloat(totalReceiveWeight) ? parseFloat(totalReceiveWeight).toFixed(3) : totalReceiveWeight;
            this.form.total_loss_weight = CommonMethods.precisionRound(totalWeight - totalReceiveWeight);
            this.form.total_loss_quantity = CommonMethods.precisionRound(pre_loss_quantity);
            //console.log(totalQuantity);
            this.form.max_loss_weight = CommonMethods.precisionRound(totalWeight - totalReceiveWeight);
            // this.last_transaction_items.total_loss_weight   = CommonMethods.precisionRound( pre_loss_weight - this.form.total_loss_weight );

            this.form.transaction_item_loss_detail_status = true;
            if (this.form.max_loss_weight <= 0) {
                this.form.transaction_item_loss_detail_status = false;
            }
        },

        /*getSplitTransferItemTotal(){
            let totalWeight         = 0;
            let totalQuantity       = 0;
            let totalReceiveWeight  = 0;
            let transaction_items   = this.transaction_items;
            if( transaction_items.length > 0 ){
                for( var index= 0; index <= transaction_items.length;index++ ){
                    if( transaction_items[index] != undefined ){
                        let receive_weight  = parseFloat(transaction_items[index].split.receive.weight)
                        let quantity        = parseFloat(transaction_items[index].split.receive.transfer_quantity);
                        let weight          = parseFloat(transaction_items[index].split.receive.transfer_weight);

                        if( !isNaN(weight) ) {
                            totalWeight = CommonMethods.BigDecimalFunction("add", totalWeight, weight);
                        }
                        if( !isNaN(quantity) ) {
                            totalQuantity = CommonMethods.BigDecimalFunction("add", totalQuantity, quantity);
                        }
                        if( !isNaN(receive_weight) ) {
                            totalReceiveWeight = CommonMethods.BigDecimalFunction("add", totalReceiveWeight, receive_weight);
                        }
                    }
                }
            }
            this.form.split_max_loss_weight           = CommonMethods.precisionRound( totalReceiveWeight - totalWeight );
            this.form.transaction_item_loss_detail_status = true;
            if( this.form.split_max_loss_weight <= 0 )
            {
                this.form.transaction_item_loss_detail_status = false;
            }
        },*/
        checkTotalScrapLossWeight() {
            if (this.selectedTransferItem.transaction_item_loss_details != undefined) {
                let totalScrapLossQuantityForSelectedItem = 0;
                let totalScrapLossQuantity = 0;
                let transaction_item_loss_details = this.selectedTransferItem.transaction_item_loss_details;
                let user_scrap_weight = 0;
                let user_loss_weight = 0;
                let user_channam_weight = 0;
                if (transaction_item_loss_details.length > 0) {
                    for (var index = 0; index < transaction_item_loss_details.length; index++) {
                        let transaction_item_loss_detail = transaction_item_loss_details[index];
                        let type_drop_down = transaction_item_loss_detail.type_drop_down;
                        let weight = isNaN(parseFloat(transaction_item_loss_detail.weight)) ? 0 : parseFloat(transaction_item_loss_detail.weight);
                        let quantity = isNaN(parseFloat(transaction_item_loss_detail.quantity)) ? 0 : parseFloat(transaction_item_loss_detail.quantity);
                        totalScrapLossQuantityForSelectedItem += weight;
                        totalScrapLossQuantity += quantity;
                        if (type_drop_down != null) {
                            if (type_drop_down.id == this.types.findTransactionType('scrap', 'value', 'transaction_item_loss_type')['id']) {
                                user_scrap_weight += weight;
                            } else if (type_drop_down.id == this.types.findTransactionType('channam', 'value', 'transaction_item_loss_type')['id']) {
                                user_channam_weight += weight;
                            } else {
                                user_loss_weight += weight;
                            }
                        }
                    }
                }
                this.viewedStyle.user_loss_scrap_weight = CommonMethods.precisionRound(totalScrapLossQuantityForSelectedItem);
                this.viewedStyle.user_scrap_weight = CommonMethods.precisionRound(user_scrap_weight);
                this.viewedStyle.user_loss_weight = CommonMethods.precisionRound(user_loss_weight);
                this.viewedStyle.user_channam_weight = CommonMethods.precisionRound(user_channam_weight);

                this.selectedTransferItem.user_loss_scrap_weight = CommonMethods.precisionRound(totalScrapLossQuantityForSelectedItem);
                this.selectedTransferItem.user_loss_scrap_quantity = CommonMethods.precisionRound(totalScrapLossQuantity);
                this.selectedTransferItem.user_scrap_weight = CommonMethods.precisionRound(user_scrap_weight);
                this.selectedTransferItem.user_loss_weight = CommonMethods.precisionRound(user_loss_weight);
                this.selectedTransferItem.user_channam_weight = CommonMethods.precisionRound(user_channam_weight);
                this.selectedTransferItem.remaining_loss = CommonMethods.precisionRound(this.form.max_loss_weight - totalScrapLossQuantityForSelectedItem);

                var pre_loss_weight = 0;
                if (this.selected_bag != null) {
                    if (this.selected_bag.last_transaction != null) {
                        pre_loss_weight = this.selected_bag.last_transaction.total_loss_weight;
                    }
                }
                console.log("3. this.form.total_loss_weight " + this.form.total_loss_weight);
                this.form.total_loss_weight = CommonMethods.precisionRound(totalScrapLossQuantityForSelectedItem + pre_loss_weight);
                console.log("4. this.form.total_loss_weight " + this.form.total_loss_weight);
            }
        }
    },
    mounted() {
        this.loadDropDownData(null, "issue");
        // this.isLoading = false;
    },
    methods: {
        changeCheckBoxStatus() {
            this.is_job_card_search = !(this.is_job_card_search);
            //this.clearFromToDropDown();
            this.clearBagData();
        },
        isFloat(n) {
            return Number(n) === n && n % 1 !== 0;
        },
        deleteOtherAccessories() {
            let selectedItem = this.transaction_items[this.viewedStyleIndex];
            if (selectedItem != undefined && (selectedItem.type != undefined)) {
                if (selectedItem.type != this.types.findTransactionType('bag', 'value', 'transaction_type')['id']) {
                    swal({
                        title: "Are you sure?",
                        text: "Selected item will be deleted!",
                        icon: "warning",
                        buttons: true,
                        dangerMode: true,
                    }).then(isConfirm => {
                        if (isConfirm) {
                            this.transaction_items.splice(this.viewedStyleIndex, 1);
                            if (this.viewedStyleIndex != 0) {
                                this.viewedStyleIndex -= 1;
                            }
                            swal("Item removed successfully!", 'Deleted');
                        }
                    });
                } else {
                    swal("Selected item can't deleted ");
                }
            }
        },
        inprogressAlert() {
            swal("In-Progress");
        },
        upArrowOtherAccessories() {
            let selectedIndex = 0;
            if (this.viewedStyleIndex != 0) {
                selectedIndex = this.viewedStyleIndex - 1;
            }
            this.showStyleModel(selectedIndex);
        },
        downArrowOtherAccessories() {
            let selectedIndex = this.viewedStyleIndex + 1;
            if (selectedIndex >= this.transaction_items.length) {
                selectedIndex = (this.transaction_items.length - 1);
            }
            this.showStyleModel(selectedIndex);
        },
        submit() {
            if (this.checkTransferItemError()) {
                this.formAssign();
                this.isLoading = true;
                console.log("FORM DATA : ");
                console.log(this.form);
                var method = this.currentRecordId == null ? Spark.post : Spark.put;
                let url = this.currentRecordId == null ? '/api/transaction' : '/api/transaction/' + this.currentRecordId;
                method(url, this.form)
                    .then(response => {
                        this.$snotify.success(response.name, 'saved!');
                        this.showGrid();
                        window.location.reload();
                    })
                    .catch(reason => {
                        this.$snotify.error(reason.message);
                    })
                    .finally(() => {
                        this.isLoading = false;
                    });
            }
        },
        checkTransferItemError() {
            let transaction_items = this.transaction_items;
            let isValid = true;
            let error = "";
            if (transaction_items.length > 0) {
                for (var loopIndex in transaction_items) {
                    let transaction_item = transaction_items[loopIndex];
                    let transaction_item_loss_details = transaction_item.transaction_item_loss_details;
                    if (isValid) {
                        let max_loss_weight = CommonMethods.precisionRound(parseFloat(this.form.max_loss_weight));
                        let user_loss_scrap_weight = CommonMethods.precisionRound(parseFloat(this.selectedTransferItem.user_loss_scrap_weight));
                        //#error check method....!
                        if (transaction_item.type == this.types.findTransactionType('bag', 'value', 'transaction_type')['id']) {
                            if (transaction_item.bag_style.style != null) {
                                error = transaction_item.bag_style.style.sku
                            } else {
                                error = transaction_item.other_accessories.name;
                            }
                        } else {
                            error = transaction_item.other_accessories.name;
                        }

                        if (max_loss_weight > 0) {

                            if (CommonMethods.CheckDifference(max_loss_weight, user_loss_scrap_weight) != 0) {
                                error += " Item didn't tally, please add weight loss/scrap weight";
                                isValid = false;
                            } else {
                                if (transaction_item_loss_details.length > 0) {
                                    for (var lossDetailIndex in transaction_item_loss_details) {
                                        if (isValid) {
                                            let transaction_item_loss_detail = transaction_item_loss_details[lossDetailIndex];
                                            let type_drop_down = transaction_item_loss_detail.type_drop_down;
                                            let user = transaction_item_loss_detail.user;
                                            /*if( type_drop_down != null ){
                                                if( user == null ){
                                                    if( type_drop_down.id == this.types.findTransactionType('scrap','value','transaction_item_loss_type')['id'] ){
                                                        error += " item type is scrap so user is required";
                                                        isValid  = false;
                                                    }
                                                }
                                            }else{
                                                error += " loss/scrap type didn't picked";
                                                isValid  = false;
                                            }*/
                                            if (type_drop_down == null) {
                                                error += " loss/scrap type didn't picked";
                                                isValid = false;
                                            }

                                        }
                                    }
                                }
                            }
                        }
                        if (CommonMethods.CheckDifference(transaction_item.weight, CommonMethods.precisionRound(transaction_item.receive_weight)) < 0) {
                            isValid = false;
                            error += " receive quantity is greater than item quantity";
                        }
                    }
                }
            }
            if (this.form.total_loss_weight < 0) {
                isValid = false;
                error = "Total receive quantity is greater than total item quantity";
            }
            if (!isValid) {
                swal(error);
            }
            return isValid;
        },
        formAssign() {
            let transaction_items = this.transaction_items;
            if (transaction_items.length > 0) {
                for (var loopIndex in transaction_items) {
                    let transaction_item = transaction_items[loopIndex];
                    transaction_item.status = this.types.findTransactionType('completed', 'value', 'transaction_item_status')['id'];
                    //transaction_item.status = this.types.findTransactionType('completed','value','transaction_item_status')['id']
                    transaction_items[loopIndex].weight = CommonMethods.precisionRound(parseFloat(transaction_items[loopIndex].weight));
                    transaction_items[loopIndex].receive_weight = CommonMethods.precisionRound(parseFloat(transaction_items[loopIndex].receive_weight));
                    transaction_items[loopIndex].max_loss_weight = CommonMethods.precisionRound(parseFloat(this.form.max_loss_weight));
                    transaction_items[loopIndex].user_loss_scrap_weight = CommonMethods.precisionRound(parseFloat(this.selectedTransferItem.user_loss_scrap_weight));
                    transaction_items[loopIndex].max_loss_weight = CommonMethods.precisionRound(parseFloat(transaction_items[loopIndex].max_loss_weight));


                    let transaction_item_loss_details = transaction_item.transaction_item_loss_details;
                    if (transaction_item_loss_details.length > 0) {
                        for (var lossDetailIndex in transaction_item_loss_details) {
                            let transaction_item_loss_detail = transaction_item_loss_details[lossDetailIndex];
                            let type_drop_down = transaction_item_loss_detail.type_drop_down;
                            //let user = transaction_item_loss_detail.user;
                            if (type_drop_down != null) {
                                transaction_item_loss_detail.type = type_drop_down.id;
                                if (type_drop_down.id == this.types.findTransactionType('loss', 'value', 'transaction_item_loss_type')['id']) {
                                    if (CommonMethods.CheckDifference(transaction_item.user_loss_weight, transaction_item_loss_detail.admin_approval_loss_weight) > 0) {
                                        // transaction_item.status = this.types.findTransactionType('admin_loss_approval','value','transaction_item_status')['id']
                                        // this.form.status = this.types.findTransactionType('admin_loss_approval','value','transaction_status')['id']
                                    }
                                }
                            }
                            /*if( user != null )
                                transaction_item_loss_detail.user_id = user.id;*/

                        }
                    }
                }
            }

            this.form.transaction_items = this.transaction_items;
            this.form.transaction_item_loss_details = this.selectedTransferItem.transaction_item_loss_details;
            this.form.bag_id = null;
            if (this.selected_bag != null) {
                this.form.bag_id = this.selected_bag.id;
                this.form.bag_styles = this.selected_bag.bag_styles;
            }
            this.form.from_department_id = null;
            if (this.from_department != null)
                this.form.from_department_id = this.from_department.id;

            this.form.from_employee_id = null;
            if (this.from_employee != null)
                this.form.from_employee_id = this.from_employee.id;

            this.form.to_employee_id = null;
            if (this.to_employee != null) {
                this.form.to_employee_id = this.to_employee.id;
                if (this.form.to_department_id == null) {
                    this.form.to_department_id = this.to_employee.department_id;
                }
            }
            console.log("1 . this.form.total_loss_weight" + parseInt(this.form.total_loss_weight));
            if (parseInt(this.form.total_loss_weight) == 0) {
                console.log("Selected Bag" + this.selected_bag);
                if (this.selected_bag.last_transaction != undefined) {
                    this.form.total_loss_weight = this.selected_bag.last_transaction.total_loss_weight;
                }
            }
            console.log("2. this.form.total_loss_weight" + parseInt(this.form.total_loss_weight));

            this.form.is_eod_reporting = 0;
            if (this.is_eod_reporting) {
                this.form.is_eod_reporting = 1;
                this.form.to_department_id = 1;
            }

            if (this.to_department != null) {
                this.form.to_department_id = this.to_department.id;
                if (this.form.to_department_id == 1) {
                    this.form.is_eod_reporting = 1;
                }
            }
        },
        checkChangeStatus(index) {
            let isValidUser = true;
            if (this.login_user.employee != null) {
                if (this.to_department != null) {
                    if (this.login_user.employee.department.id != this.to_department.id) {
                        isValidUser = false;
                    }
                }
                if (this.to_employee != null) {
                    if (this.login_user.employee.id != this.to_employee.id) {
                        isValidUser = false;
                    }
                }
            }
            if (isValidUser) {
                if (this.transaction_items[index].id > 0) {
                    if (this.types.findTransactionType(this.transaction_items[index].status, 'id', 'transaction_item_status')['value'] == 'completed') {
                        return true;
                    }
                }
            }
            return false;
        },
        changeEod(e) {
            console.log(e);
        },
        loadBags(query) {
            if ((query.length) >= 2) {
                this.multiLoading = true;
                this.searchBagString = query;
                this.searchBags(this);
            }
        },
        searchBags: _.debounce((self) => {
            let from_department_id = null;
            let to_department_id = null;
            let from_employee_id = null;
            let to_employee_id = null;

            if (self.from_department != null)
                from_department_id = self.from_department.id;

            if (self.from_employee != null)
                from_employee_id = self.from_employee.id;

            if (self.to_department != null)
                to_department_id = self.to_department.id;

            if (self.to_employee != null)
                to_employee_id = self.to_employee.id;


            let data = {
                q: self.searchBagString,
                is_job_card_search: self.is_job_card_search,
                from_department_id: from_department_id,
                to_department_id: to_department_id,
                from_employee_id: from_employee_id,
                to_employee_id: to_employee_id,
            };
            axios.post('/api/transaction/bagSearch', data)
                .then(response => {
                    self.bag_options = response.data;
                })
                .catch(reason => {
                    swal("Something went wrong");
                })
                .finally(response => {
                    self.multiLoading = false;
                });
        }),
        loadMergeBags(query) {
            if ((query.length) >= 2) {
                this.multiLoading = true;
                this.searchMergeBags(query, this);
            }
        },
        searchMergeBags: _.debounce((searchBagString, self) => {
            let selectedBag = null;
            if (self.selected_bag != null) {
                selectedBag = self.selected_bag.id;
            }
            let data = {
                q: searchBagString,
                from_department_id: null,
                to_department_id: null,
                from_employee_id: null,
                to_employee_id: null,
                bag_id: selectedBag
            };
            axios.post('/api/transaction/bagSearch', data)
                .then(response => {
                    self.merge_bag_options = response.data;
                })
                .catch(reason => {
                    swal("Something went wrong");
                })
                .finally(response => {
                    self.multiLoading = false;
                });
        }),
        addOtherAccessories() {
            this.transaction_items.push({
                id: 0,
                status: this.types.findTransactionType("completed", 'value', 'transaction_item_status')['id'],
                type: this.types.findTransactionType("other_accessories", 'value', 'transaction_type')['id'],
                bag_style: null,
                other_accessories: {},
                other_accessories_id: null,
                bag_style_id: null,
                quantity: 1,
                weight: 0,
                receive_weight: 0,
                uom: "",
                uom_id: null,
                uom_name: "",
                max_loss_weight: 0,
                transaction_item_loss_detail_status: false,
                transaction_item_loss_details: [{
                    id: 0,
                    type: this.types.findTransactionType('scrap', 'value', 'transaction_item_loss_type')['id'],
                    type_drop_down: this.types.findTransactionType('scrap', 'value', 'transaction_item_loss_type'),
                    weight: 0,
                    admin_approval_loss_weight: 0,
                },
                {
                    id: 0,
                    type: this.types.findTransactionType('loss', 'value', 'transaction_item_loss_type')['id'],
                    type_drop_down: this.types.findTransactionType('loss', 'value', 'transaction_item_loss_type'),
                    weight: 0,
                    admin_approval_loss_weight: 0,
                },
                {
                    id: 0,
                    type: this.types.findTransactionType('channam', 'value', 'transaction_item_loss_type')['id'],
                    type_drop_down: this.types.findTransactionType('channam', 'value', 'transaction_item_loss_type'),
                    weight: 0,
                    admin_approval_loss_weight: 0,
                }
                ],
                user_loss_scrap_quantity: 0,
                user_loss_scrap_weight: 0,
                user_scrap_weight: 0,
                user_loss_weight: 0,
                user_channam_weight: 0,

                split: {
                    transfer: {
                        weight: 0,
                        quantity: 0,
                        transfer_quantity: 0,
                        transfer_weight: 0,
                        class: ""
                    },
                    receive: {
                        weight: 0,
                        quantity: 0,
                        transfer_quantity: 0,
                        transfer_weight: 0,
                        class: ""
                    },
                },
            });
            this.showStyleModel(this.viewedStyleIndex);
        },
        bindAccessories(index) {
            let selectedItem = this.transaction_items[index];
            let isValid = true;
            if (selectedItem.other_accessories != null) {
                //#block to check it already there or not...!
                /*  let transaction_items = this.transaction_items;
                  if( transaction_items.length > 0 ){
                      for( var loopIndex in transaction_items ){
                          if( isValid ){
                              let selectedAccessories = transaction_items[loopIndex].other_accessories;
                              if( selectedAccessories != null &&  loopIndex != index){
                                  if( selectedAccessories.id ==  selectedItem.other_accessories.id ){
                                      isValid = false;
                                  }
                              }
                          }
                      }
                  }
                  if( !isValid ){
                      selectedItem.other_accessories = null;
                      swal("This accessories already exists");
                      return false;
                  }*/
                selectedItem.other_accessories_id = selectedItem.other_accessories.id;
                selectedItem.uom_id = selectedItem.other_accessories.uom.id;
                selectedItem.uom_name = selectedItem.other_accessories.uom.name;
            }

        },
        clearFromToDropDown() {
            this.to_department = null;
            this.to_employee = null;
            this.from_department = null;
            this.from_employee = null;
        },
        clearReadOnlyStatus() {
            //#change from and to employee readonly...!
            this.displayStatus.from_dep = false;
            this.displayStatus.from_emp = false;
            this.displayStatus.to_dep = false;
            this.displayStatus.to_emp = false;
        },
        bindDepartmentAndEmployee() {
            this.clearFromToDropDown();
            this.clearReadOnlyStatus();
            if (this.selected_bag != null) {
                this.displayStatus.from_dep = true;
                this.displayStatus.from_emp = true;
                this.from_department = this.selected_bag.department;
                this.from_employee = this.selected_bag.employee;
                if (this.selected_bag.last_transaction != undefined && this.selected_bag.last_transaction.is_eod_reporting == "1") {
                    this.to_department = this.selected_bag.last_transaction.from_department;
                    this.to_employee = this.selected_bag.last_transaction.from_employee;
                }
            }
            if (this.login_user != null) {
                if (this.login_user.employee != null || this.login_user.department != null) {
                    this.isAdminStatus = false;
                    if (this.tabStatus == "receive") {
                        if (this.login_user.employee != null)
                            this.displayStatus.to_emp = true;
                        if (this.login_user.department != null)
                            this.displayStatus.to_dep = true;

                        this.to_employee = this.login_user.employee;
                        this.to_department = this.login_user.department;
                    } else {
                        if (this.login_user.employee != null)
                            this.displayStatus.from_emp = true;
                        if (this.login_user.department != null)
                            this.displayStatus.from_dep = true;

                        this.from_employee = this.login_user.employee;
                        this.from_department = this.login_user.department;
                    }
                    //this.clearBagData();
                }
            }
        },
        bindEODPopUp() {
            if (this.selected_bag != null) {
                if (this.selected_bag.last_transaction != undefined && this.selected_bag.last_transaction.is_eod_reporting == "1") {
                    swal({
                        title: "Are you sure?",
                        text: "Do you want to issue ...!",
                        icon: "warning",
                        buttons: true,
                        dangerMode: true,
                    }).then(isConfirm => {
                        if (isConfirm) {
                            this.submit();
                        }
                    });
                }
            }
        },
        changeBag() {
            this.resetMergeBag();
            this.transaction_items = [];
            this.bindDepartmentAndEmployee();
            this.loadDropDownData();
            if (this.selected_bag.last_transaction != null) {
                this.last_transaction_items = this.selected_bag.last_transaction;
            }
            if (this.selected_bag != null) {
                for (var i = 0; i < this.selected_bag.bag_styles.length; i++) {
                    let selectedBagStyle = this.selected_bag.bag_styles[i];
                    let uom = {};
                    let other_accessories = {};
                    if (selectedBagStyle.other_accessories != null) {
                        other_accessories = selectedBagStyle.other_accessories;
                        uom = selectedBagStyle.other_accessories.uom
                    } else {
                        uom = selectedBagStyle.style.uom;
                    }
                    let weight = CommonMethods.precisionRound(parseFloat(selectedBagStyle.weight).toFixed(3));
                    this.transaction_items.push({
                        id: 1,
                        status: this.types.findTransactionType("completed", 'value', 'transaction_item_status')['id'],
                        type: this.types.findTransactionType("bag", 'value', 'transaction_type')['id'],
                        bag_style: selectedBagStyle,
                        other_accessories: other_accessories,
                        other_accessories_id: null,
                        bag_style_id: selectedBagStyle.id,
                        quantity: selectedBagStyle.quantity,
                        weight: weight,
                        receive_weight: weight,
                        uom_id: uom.id,
                        uom: uom.uom,
                        uom_name: uom.name,
                        max_loss_weight: 0,
                        transaction_item_loss_detail_status: false,
                        transaction_item_loss_details: [{
                            id: 0,
                            type: this.types.findTransactionType('scrap', 'value', 'transaction_item_loss_type')['id'],
                            type_drop_down: this.types.findTransactionType('scrap', 'value', 'transaction_item_loss_type'),
                            weight: 0,
                            admin_approval_loss_weight: 0,
                        },
                        {
                            id: 0,
                            type: this.types.findTransactionType('loss', 'value', 'transaction_item_loss_type')['id'],
                            type_drop_down: this.types.findTransactionType('loss', 'value', 'transaction_item_loss_type'),
                            weight: 0,
                            admin_approval_loss_weight: 0,
                        },
                        {
                            id: 0,
                            type: this.types.findTransactionType('channam', 'value', 'transaction_item_loss_type')['id'],
                            type_drop_down: this.types.findTransactionType('channam', 'value', 'transaction_item_loss_type'),
                            weight: 0,
                            admin_approval_loss_weight: 0,
                        }
                        ],
                        old_transaction_item_loss_details: selectedBagStyle.transaction_item_loss_details,
                        user_loss_scrap_weight: 0,
                        user_loss_scrap_quantity: 0,
                        user_scrap_weight: 0,
                        user_loss_weight: 0,
                        user_channam_weight: 0,
                        split: {
                            transfer: {
                                weight: 0,
                                quantity: 0,
                                transfer_quantity: 0,
                                transfer_weight: 0,
                                class: ""
                            },
                            receive: {
                                weight: 0,
                                quantity: 0,
                                transfer_quantity: 0,
                                transfer_weight: 0,
                                class: ""
                            },
                        },
                    });
                    console.log("Transaction Details");
                    console.log(this.transaction_items);
                }
            }
            this.showStyleModel(0);
            this.bindEODPopUp();
        },
        checkWastageType(lossDetailIndex) {
            let isValid = true;
            let selectedTransferItemLossDetails = this.selectedTransferItem.transaction_item_loss_details;
            let type_drop_down = selectedTransferItemLossDetails[lossDetailIndex].type_drop_down;
            if (type_drop_down != null && type_drop_down['id'] == this.types.findTransactionType('loss', 'value', 'transaction_item_loss_type')['id']) {
                for (var i = 0; i < selectedTransferItemLossDetails.length; i++) {
                    if (isValid) {
                        let loopDropDown = selectedTransferItemLossDetails[i].type_drop_down;
                        if (loopDropDown != null && loopDropDown['id'] == this.types.findTransactionType('loss', 'value', 'transaction_item_loss_type')['id'] && lossDetailIndex != i)
                            isValid = false;
                    }
                }
            }
            if (!isValid) {
                swal("Only one loss record will be allowed");
                let scrap = this.types.findTransactionType('scrap', 'value', 'transaction_item_loss_type');
                this.selectedTransferItem.transaction_item_loss_details[lossDetailIndex].type_drop_down = scrap;
            }
        },
        checkScrapUserDuplicate(lossDetailIndex) {
            let isValid = true;
            let selectedTransferItemLossDetails = this.selectedTransferItem.transaction_item_loss_details;
            let selectedUser = selectedTransferItemLossDetails[lossDetailIndex].user;
            if (selectedUser != null) {
                if (selectedTransferItemLossDetails.length > 0) {
                    for (var index in selectedTransferItemLossDetails) {
                        if (isValid) {
                            let loopUser = selectedTransferItemLossDetails[index].user;
                            if ((lossDetailIndex != index) && (loopUser != null)) {
                                if (selectedUser.id == loopUser.id) {
                                    isValid = false;
                                }
                            }
                        }
                    }
                }
            }
            if (!isValid) {
                swal("User already picked");
                this.selectedTransferItem.transaction_item_loss_details[lossDetailIndex].user = null;
            }
        },
        deleteLossRecord(lossDetailIndex) {
            swal({
                title: "Are you sure?",
                text: "Do you want to delete this loss/scrap item...!",
                icon: "warning",
                buttons: true,
                dangerMode: true,
            }).then(isConfirm => {
                if (isConfirm) {
                    this.selectedTransferItem.transaction_item_loss_details.splice(lossDetailIndex, 1);
                }
            });
        },
        customEmployeeLabel({ code, name }) {
            let string = code + "-" + name;
            return `${string}`;
        },
        getFormData() {
            return new SparkForm({
                transaction_date: moment().format("YYYY-MM-DD"),
                transaction_type: false,
                bag_id: null,
                from_department_id: null,
                from_employee_id: null,
                to_department_id: null,
                to_employee_id: null,
                description: "",
                total_transfer_quantity: 0,
                total_transfer_weight: 0,
                total_receive_weight: 0,
                max_loss_weight: 0,
                split_max_loss_weight: 0,
                transaction_item_loss_detail_status: false,
                bag_styles: [],
                transaction_items: [],
                is_eod_reporting: 0,
                transaction_mode: 0,
                status: TypeDefs.findTransactionType('completed', 'value', 'transaction_status')['id'],
                merge: {
                    transfer: null, //#selected bag to transfer...!
                    receive: null, //#merge bag to receive...!
                }
            });
        },
        changeTabStatus(status) {
            this.tabStatus = status;
            this.clearBagData();
            this.bindDepartmentAndEmployee();
            this.loadDropDownData();
        },
        loadDropDownData(type, checkTabStatus) {
            let from_department_id = null;
            let from_employee_id = null;
            let to_department_id = null;
            if (this.from_department != null) {
                from_department_id = this.from_department.id
            }
            if (this.from_employee != null) {
                from_employee_id = this.from_employee.id
            }
            if (this.to_department != null) {
                to_department_id = this.to_department.id
            }
            console.log(from_department_id);
            let data = {
                from_department_id: from_department_id,
                from_employee_id: from_employee_id,
                to_department_id: to_department_id,
                tab_status: this.tabStatus
            };
            this.isLoading = true;
            axios.post('/api/transaction/get-drop-down-data', data)
                .then(response => {
                    let dropDownData = response.data;
                    if (type == "from_department") {
                        this.from_employee = null;
                        this.clearBagData();
                    }
                    if (type == "to_department") {
                        this.to_employee = null;
                    }
                    this.department_options = dropDownData.department;
                    this.from_department_options = dropDownData.form_department;
                    this.to_department_options = dropDownData.to_department;
                    this.from_employee_options = dropDownData.form_employee;
                    this.to_employee_options = dropDownData.to_employee;
                    // this.bag_options = dropDownData.bags;
                    this.login_user = dropDownData.login_user_details;
                    this.other_accessories_options = dropDownData.other_accessories;
                    this.user_options = dropDownData.users;
                    if (checkTabStatus != undefined) {
                        this.changeTabStatus(checkTabStatus);
                    }
                })
                .catch(reason => {
                    console.log(reason.message);
                }).finally(() => {
                    this.isLoading = false;
                });

        },
        clearBagData() {
            this.selected_bag = null;
            this.bag_options = [];
            this.transaction_items = [];
            this.resetMergeBag();
            this.resetViewMode();
            this.displayMode.transfer_item_mode = true;
        },
        showGrid() {
            //clear data
            this.form = this.getFormData();
            this.selected_bag = null;
            this.transaction_items = [];
            this.from_department = null;
            this.from_employee = null;
            this.to_employee = null;
            this.to_department = null;
            this.viewedStyle = {};
            this.viewedStyleIndex = 0;
            this.bag_options = [];
            this.is_eod_reporting = false;

            this.resetViewMode();
            this.displayMode.transfer_item_mode = true;
            this.form.transaction_mode = this.types.findTransactionType("default_mode", "value", "transaction_mode")['id'];
            this.changeTabStatus("issue");



            //console.log("child function");
            //this.$parent.showGrid();
        },
        showStyleModel(selectedStyleIndex) {
            let selectedStyle = this.transaction_items[selectedStyleIndex];
            if (selectedStyle == undefined) {
                selectedStyle = {};
            }
            this.viewedStyle = selectedStyle;
            this.viewedStyleIndex = selectedStyleIndex;
        },
        closeStyleModel() {
            this.display_style = false;
        },
        showLossDetailModel(index = 0) {
            this.transferItemIndex = 0;
            this.selectedTransferItem = {
                transaction_item_loss_details: [{
                    id: 0,
                    type: this.types.findTransactionType('scrap', 'value', 'transaction_item_loss_type')['id'],
                    type_drop_down: this.types.findTransactionType('scrap', 'value', 'transaction_item_loss_type'),
                    quantity: 0,
                    weight: 0,
                    admin_approval_loss_weight: 0,
                },
                {
                    id: 0,
                    type: this.types.findTransactionType('loss', 'value', 'transaction_item_loss_type')['id'],
                    type_drop_down: this.types.findTransactionType('loss', 'value', 'transaction_item_loss_type'),
                    weight: 0,
                    quantity: 0,
                    admin_approval_loss_weight: 0,
                },
                {
                    id: 0,
                    type: this.types.findTransactionType('channam', 'value', 'transaction_item_loss_type')['id'],
                    type_drop_down: this.types.findTransactionType('channam', 'value', 'transaction_item_loss_type'),
                    weight: 0,
                    quantity: 0,
                    admin_approval_loss_weight: 0,
                }
                ],
            }
            // console.log(this.selectedTransferItem);
            //this.selectedMaxLossWeight = this.transaction_items[transferItemIndex].max_loss_weight;
            //this.selectedTransferItemLossDetails = this.transaction_items[transferItemIndex].transaction_item_loss_details;
            if (index === 0) {
                this.display_loss_details = true;
            } else {
                this.display_scrap_details = true;
            }

        },
        closeScrapDetailModel() {
            this.display_scrap_details = false;
        },
        closeLossDetailModel() {
            this.display_loss_details = false;
        },
        saveLossDetailModel() {
            let max_loss = this.form.max_loss_weight;
            if (parseFloat(max_loss) != parseFloat(this.selectedTransferItem.user_loss_scrap_weight)) {
                swal("Loss Weight should full fill then only it will save");
                return false;
            }
            let selectedIndex = 0;
            if (this.viewedStyleIndex != 0) {
                selectedIndex = this.viewedStyleIndex - 1;
            }
            this.showStyleModel(selectedIndex);
            this.closeLossDetailModel();
        },
        onToEmployee(event) {
            console.log(event);
        },
        saveScrapDetailModel() {
            this.form.from_department_id = null;
            if (this.from_department != null)
                this.form.from_department_id = this.from_department.id;

            this.form.from_employee_id = null;
            if (this.from_employee != null)
                this.form.from_employee_id = this.from_employee.id;

            this.form.to_employee_id = null;
            if (this.to_employee != null) {
                this.form.to_employee_id = this.to_employee.id;
                if (this.form.to_department_id == null) {
                    this.form.to_department_id = this.to_employee.department_id;
                }
            }

            let employee_id = this.form.from_employee_id;
            if (employee_id === null) {
                employee_id = this.form.to_employee_id;
            }

            if (employee_id === null) {
                swal("Please select from emplyee id after to do split the scrap");
                return false;
            }
            let max_loss_quantity = this.form.total_transfer_quantity;
            if (parseFloat(max_loss_quantity) < parseFloat(this.selectedTransferItem.user_loss_scrap_quantity)) {
                swal("Loss Quantity should full fill then only it will save");
                return false;
            }
            let max_loss = this.form.total_receive_weight;
            if (parseFloat(max_loss) < parseFloat(this.selectedTransferItem.user_loss_scrap_weight)) {
                swal("Loss Weight should full fill then only it will save");
                return false;
            }

            this.form.total_receive_weight = String(parseFloat(this.form.total_receive_weight) - parseFloat(this.selectedTransferItem.user_loss_scrap_weight));
            if (this.selected_bag.last_transaction != undefined) {
                this.form.total_loss_quantity = parseFloat(this.selected_bag.last_transaction.total_loss_quantity) + parseFloat(this.selectedTransferItem.user_loss_scrap_quantity);
                console.log(this.form.total_loss_quantity);
            } else {
                this.form.total_loss_quantity = parseFloat(this.selectedTransferItem.user_loss_scrap_quantity);
            }

            let selectedIndex = 0;
            if (this.viewedStyleIndex != 0) {
                selectedIndex = this.viewedStyleIndex - 1;
            }
            this.showStyleModel(selectedIndex);
            this.closeScrapDetailModel();
            this.submit();
        },
        addTransferItemLossAndScrapItem() {
            this.transaction_items[this.transferItemIndex].transaction_item_loss_details.push({
                id: 0,
                type: this.types.findTransactionType('scrap', 'value', 'transaction_item_loss_type')['id'],
                type_drop_down: this.types.findTransactionType('scrap', 'value', 'transaction_item_loss_type'),
                /*user                :   null,
                user_id             :   null,*/
                weight: 0,
            });
        },
        viewTransactionItemLossDetails() {
            this.display_loss_details_report = true;
        },
        closeViewLossDetailModel() {
            this.display_loss_details_report = false;
        },
        getScrapLossDetailType(type) {
            if (type == undefined) {
                type = this.types.findTransactionType('loss', 'value', 'transaction_item_loss_type')['id']
            }
            return this.types.findTransactionType(type, 'id', 'transaction_item_loss_type')['name'];
        },
        splitBag() {
            if (this.checkTransferItemError()) {
                swal({
                    title: "Are you sure?",
                    text: "Do you want to split the bag...!",
                    icon: "warning",
                    buttons: true,
                    dangerMode: true,
                }).then(isConfirm => {
                    if (isConfirm) {
                        this.resetViewMode();
                        this.displayMode.split_mode = true;
                        this.form.transaction_mode = this.types.findTransactionType("split_mode", "value", "transaction_mode")['id'];
                        let transaction_items = this.transaction_items;

                        if (transaction_items.length > 0) {
                            var transfer_quantity = 0;
                            var transfer_weight = parseFloat(0);
                            var t_transfer_weight = parseFloat(0);
                            for (var index in transaction_items) {
                                let transfer_transaction_item = Object.assign({}, transaction_items[index]);

                                if (transfer_transaction_item["other_accessories_id"] == null && transaction_items[index].other_accessories.id === undefined) {
                                    transfer_quantity += transfer_transaction_item["quantity"];
                                }
                                transfer_weight += parseFloat(transfer_transaction_item["receive_weight"]);
                            }
                            transfer_weight = CommonMethods.precisionRound(transfer_weight) - CommonMethods.precisionRound(this.last_transaction_items.total_loss_weight);
                            var total_loss = CommonMethods.precisionRound(this.last_transaction_items.total_loss_weight);
                            for (var index in transaction_items) {
                                let transfer_transaction_item = Object.assign({}, transaction_items[index]);
                                //if (transaction_items[index].other_accessories.id === undefined) {
                                if (total_loss > 0) {
                                    t_transfer_weight = CommonMethods.precisionRound(transfer_transaction_item["receive_weight"]) - CommonMethods.precisionRound(total_loss);
                                    total_loss = CommonMethods.precisionRound(total_loss) - CommonMethods.precisionRound(transfer_transaction_item["receive_weight"]);
                                } else {
                                    t_transfer_weight = CommonMethods.precisionRound(transfer_transaction_item["receive_weight"]);
                                }
                                console.log(total_loss);
                                transaction_items[index].split.transfer = {
                                    weight: parseFloat(t_transfer_weight).toFixed(3),
                                    quantity: transfer_transaction_item["quantity"],
                                    transfer_quantity: 0,
                                    transfer_weight: 0,
                                    class: ""
                                };
                                transaction_items[index].split.receive = {
                                    weight: parseFloat(0).toFixed(3),
                                    quantity: 0,
                                    transfer_quantity: 0,
                                    transfer_weight: 0,
                                    class: ""
                                };
                                // }

                            }
                        }
                    }
                });
            }
        },
        mergeBag() {
            if (this.checkTransferItemError()) {
                swal({
                    title: "Are you sure?",
                    text: "Do you want to merge the bag...!",
                    icon: "warning",
                    buttons: true,
                    dangerMode: true,
                }).then(isConfirm => {
                    if (isConfirm) {
                        this.resetMergeBag();
                        this.resetViewMode();
                        this.displayMode.merge_mode = true;
                        this.form.transaction_mode = this.types.findTransactionType("merge_mode", "value", "transaction_mode")['id'];
                    }
                });
            }
        },
        mergeSelectedBag() {
            if (this.merge_selected_bag != null) {
                this.resetMergeBag(true);

                //this.form.merge.transfer = this.selected_bag;
                let transferItem = [];
                let transaction_items = this.transaction_items;
                let t_transfer_weight = '';
                let total_loss = CommonMethods.precisionRound(this.last_transaction_items.total_loss_weight);
                if (transaction_items.length > 0) {
                    for (var index in transaction_items) {
                        let transfer_transaction_item = Object.assign({}, transaction_items[index]);
                        if (total_loss > 0) {
                            t_transfer_weight = CommonMethods.precisionRound(transfer_transaction_item.weight) - CommonMethods.precisionRound(total_loss);
                            // t_transfer_weight = CommonMethods.precisionRound(transfer_transaction_item.weight);
                            total_loss = CommonMethods.precisionRound(total_loss) - CommonMethods.precisionRound(transfer_transaction_item.weight);
                        } else {
                            t_transfer_weight = CommonMethods.precisionRound(transfer_transaction_item.weight);
                        }
                        transfer_transaction_item.weight = CommonMethods.precisionRound(t_transfer_weight);
                        transfer_transaction_item.class = "";
                        transfer_transaction_item.transfer_quantity = "";
                        transfer_transaction_item.transfer_weight = "";
                        transfer_transaction_item.disabled = true;
                        transferItem.push(transfer_transaction_item);
                    }
                }

                let mergeReceiveBag = [];
                let total_receive_loss = CommonMethods.precisionRound(this.merge_selected_bag.last_transaction.total_loss_weight);
                let t_transfer_receive_weight = '';
                this.merge_selected_bag.bag_styles.forEach((item) => {

                    let isDuplicate = false;
                    let uom = {};
                    let other_accessories = {};
                    if (item.other_accessories != null) {
                        other_accessories = item.other_accessories;
                        uom = item.other_accessories.uom
                    } else {
                        uom = item.style.uom;
                    }
                    if (total_receive_loss > 0) {
                        // t_transfer_receive_weight = CommonMethods.precisionRound(item.weight) - CommonMethods.precisionRound(total_receive_loss);
                        t_transfer_receive_weight = CommonMethods.precisionRound(item.weight);
                        total_receive_loss = CommonMethods.precisionRound(total_receive_loss) - CommonMethods.precisionRound(item.weight);
                    } else {
                        t_transfer_receive_weight = CommonMethods.precisionRound(item.weight);
                    }

                    item.weight = CommonMethods.precisionRound(parseFloat(t_transfer_receive_weight));
                    mergeReceiveBag.push(item);
                    let type = this.types.findTransactionType('bag', 'value', 'transaction_type')['id'];
                    if (item.style == null) {
                        type = this.types.findTransactionType('other_accessories', 'value', 'transaction_type')['id'];
                    }
                    if (transferItem.length > 0) {
                        for (var itemIndex in transferItem) {
                            if (transferItem[itemIndex].type == this.types.findTransactionType('bag', 'value', 'transaction_type')['id']) {
                                if (item.style_id == transferItem[itemIndex].bag_style.style_id) {
                                    transferItem[itemIndex].disabled = false;
                                    isDuplicate = true;
                                }
                            } else {
                                if (item.other_accessories != null) {
                                    if (transferItem[itemIndex].bag_style != null) {
                                        if (transferItem[itemIndex].bag_style.other_accessories != null) {
                                            if (item.other_accessories.id == transferItem[itemIndex].bag_style.other_accessories.id) {
                                                transferItem[itemIndex].disabled = false;
                                                isDuplicate = true;
                                            }
                                        }
                                    } else {
                                        if (transferItem[itemIndex].other_accessories != null) {
                                            if (item.other_accessories.id == transferItem[itemIndex].other_accessories.id) {
                                                transferItem[itemIndex].disabled = false;
                                                isDuplicate = true;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    if (!isDuplicate) {
                        transferItem.push({
                            id: 0,
                            status: this.types.findTransactionType("completed", 'value', 'transaction_item_status')['id'],
                            type: type,
                            bag_style: item,
                            other_accessories: other_accessories,
                            other_accessories_id: null,
                            bag_style_id: item.id,
                            quantity: 0,
                            weight: 0,
                            uom_id: uom.id,
                            uom: uom.uom,
                            uom_name: uom.name,
                            transfer_quantity: 0,
                            transfer_weight: 0,
                            class: "",
                            disabled: false,

                        });
                    }
                });
                console.log(mergeReceiveBag);
                this.merge_selected_bag.bag_styles = mergeReceiveBag;
                this.form.merge.receive = this.merge_selected_bag;
                this.form.merge.transfer = transferItem;
            } else {
                swal("Please select merge bag");
            }
        },
        splitItemSelected(index) {
            this.viewedSplitIndex = index;
        },
        resetViewMode() {
            this.displayMode.transfer_item_mode = false;
            this.displayMode.merge_mode = false;
            this.displayMode.split_mode = false;
        },
        closeSplitMode() {
            swal({
                title: "If you close split screen?",
                text: "You will lose the data..!",
                icon: "warning",
                buttons: true,
                dangerMode: true,
            }).then(isConfirm => {
                if (isConfirm) {
                    this.resetViewMode();
                    this.displayMode.transfer_item_mode = true;
                    this.form.transaction_mode = this.types.findTransactionType("default_mode", "value", "transaction_mode")['id'];
                }
            });
        },
        closeMergeMode() {
            swal({
                title: "If you close merge screen?",
                text: "You will lose the data..!",
                icon: "warning",
                buttons: true,
                dangerMode: true,
            }).then(isConfirm => {
                if (isConfirm) {
                    this.resetMergeBag();
                    this.resetViewMode();
                    this.displayMode.transfer_item_mode = true;
                    this.form.transaction_mode = this.types.findTransactionType("default_mode", "value", "transaction_mode")['id'];
                }
            });
        },
        splitBagTransferReceive(type) {
            swal({
                title: "Are you sure",
                text: "Do you want to transfer the split item...!",
                icon: "warning",
                buttons: true,
                dangerMode: true,
            }).then(isConfirm => {
                if (isConfirm) {
                    let ErrorData = {
                        status: false,
                        sting: "Something went wrong"
                    };
                    if (type == undefined) {
                        type = "transfer";
                    }
                    let transaction_items = this.transaction_items;
                    if (transaction_items.length > 0) {
                        //#check error...!
                        for (var index in transaction_items) {
                            if (!ErrorData.status) {
                                let transaction_item = transaction_items[index];
                                let transfer_quantity = 0;
                                let transfer_weight = 0;
                                let item = transaction_item.split.receive;
                                if (type == "transfer") {
                                    item = transaction_item.split.transfer;
                                }
                                item.class = "";
                                let quantity = parseInt(item.quantity);
                                let weight = parseFloat(item.weight);
                                if (!isNaN(parseInt(item.transfer_quantity))) {
                                    transfer_quantity = parseInt(item.transfer_quantity);
                                    if (transfer_quantity > quantity) {
                                        ErrorData.status = true;
                                        ErrorData.sting = "Transfer quantity should not greater than quantity";
                                    }
                                }
                                if (!isNaN(parseFloat(item.transfer_weight))) {
                                    transfer_weight = parseFloat(item.transfer_weight);
                                    if (transfer_weight > weight) {
                                        ErrorData.status = true;
                                        ErrorData.sting = "Transfer weight should not greater than weight";
                                    }
                                }
                                if ((transfer_quantity > 0 && transfer_weight <= 0) || (transfer_weight > 0 && transfer_quantity <= 0)) {
                                    ErrorData.status = true;
                                    ErrorData.sting = "Transfer quantity and weight must be greater than zero";
                                }
                                if (((transfer_weight == weight) && transfer_quantity != quantity) || ((transfer_weight != weight) && transfer_quantity == quantity)) {
                                    ErrorData.status = true;
                                    ErrorData.sting = "Weight or quantity not full filled";
                                }
                                if (ErrorData.status) {
                                    item.class = "red";
                                }
                            }
                        }
                        if (ErrorData.status) {
                            swal(ErrorData.sting);
                            return false;
                        }

                        for (var index in transaction_items) {
                            console.log(transaction_items);
                            let isReceiveLoopValid = false;
                            let transaction_item = transaction_items[index];
                            let transfer_quantity = 0;
                            let transfer_weight = 0;
                            let fromItem = transaction_item.split.receive;
                            if (type == "transfer")
                                fromItem = transaction_item.split.transfer;

                            if (!isNaN(parseInt(fromItem.transfer_quantity)))
                                transfer_quantity = parseInt(fromItem.transfer_quantity);

                            if (!isNaN(parseFloat(fromItem.transfer_weight)))
                                transfer_weight = parseFloat(fromItem.transfer_weight);

                            if ((transfer_weight > 0) || (transfer_quantity > 0))
                                isReceiveLoopValid = true;
                            if (isReceiveLoopValid) {
                                let toItem = transaction_item.split.receive;
                                if (type != "transfer")
                                    toItem = transaction_item.split.transfer;
                                toItem.quantity += transfer_quantity;
                                toItem.class = typeof transaction_items[index].other_accessories.id !== 'undefined' ? transaction_items[index].other_accessories.id : 0;
                                toItem.weight = CommonMethods.BigDecimalFunction("add", toItem.weight, transfer_weight);
                                fromItem.quantity -= transfer_quantity;
                                fromItem.weight = CommonMethods.BigDecimalFunction("subtract", fromItem.weight, transfer_weight);
                                fromItem.transfer_quantity = 0;
                                fromItem.transfer_weight = 0;
                            }
                        }
                    }
                }
            });
        },
        checkAdminAllowedMaximumLossesString(lossDetailIndex) {
            let selectedTransferItem = this.selectedTransferItem;
            let adminAllowed = "";
            let styleDepartmentLossDetail = {};
            if (this.from_department != null) {
                if (selectedTransferItem.transaction_item_loss_details[lossDetailIndex].type == this.types.findTransactionType('loss', 'value', 'transaction_item_loss_type')['id']) {
                    if (selectedTransferItem.bag_style != null) {
                        if (selectedTransferItem.bag_style.style != null) {
                            let style_department_loss_approval = selectedTransferItem.bag_style.style.style_department_loss_approval;
                            if (style_department_loss_approval != null && style_department_loss_approval.length > 0) {
                                for (var index in style_department_loss_approval) {
                                    if (this.from_department.id == style_department_loss_approval[index].department_id) {
                                        styleDepartmentLossDetail = style_department_loss_approval[index];
                                    }
                                }
                            }
                        }
                    }
                }
            }
            selectedTransferItem.transaction_item_loss_details[lossDetailIndex].admin_approval_loss_weight = 0;
            if (styleDepartmentLossDetail.percentage != undefined) {
                let allowedLossInWeight = CommonMethods.BigDecimalFunction("multiply", CommonMethods.BigDecimalFunction("divide", selectedTransferItem.weight, 100), styleDepartmentLossDetail.percentage);
                selectedTransferItem.transaction_item_loss_details[lossDetailIndex].admin_approval_loss_weight = allowedLossInWeight;
                selectedTransferItem.admin_approval_loss_weight = allowedLossInWeight;
                adminAllowed += "Loss allowed without approval with in " + styleDepartmentLossDetail.percentage + "% or with in " + allowedLossInWeight;
            }
            return adminAllowed;
        },
        viewBagStyleImage() {
            this.display_bag_style_images = true;
            this.bag_style_images_view = [];
            let bag_style = this.viewedStyle.bag_style.style;
            if (bag_style != null) {
                if (bag_style.style_images.length > 0) {
                    for (var index in bag_style.style_images) {
                        this.bag_style_images_view.push({ title: bag_style.style_images[index].upload.file_name, url: bag_style.style_images[index].upload.uploaded_path });
                    }
                }
            }

        },
        closeViewBagStyleImageModel() {
            this.display_bag_style_images = false;
        },
        resetMergeBag(resetMergeSelectedBag) {
            if (resetMergeSelectedBag == undefined)
                this.merge_selected_bag = null;
            this.merge_bag_options = [];
            this.form.merge.transfer = null;
            this.form.merge.receive = null;
        },
        mergeBagTransferReceive(type) {
            if (type == undefined) {
                type = "transfer";
            }
            let ErrorData = {
                status: false,
                sting: "Something went wrong"
            };
            //#check errors...!
            let checkItem = this.form.merge.transfer;
            if (type != "transfer") {
                let receive = this.form.merge.receive;
                if (receive != null)
                    checkItem = receive.bag_styles;
            }
            if (checkItem.length > 0) {
                for (var index in checkItem) {
                    let item = checkItem[index];
                    item.class = "";
                    if (!ErrorData.status) {
                        let transfer_quantity = isNaN(parseInt(item.transfer_quantity)) ? 0 : parseInt(item.transfer_quantity);
                        let transfer_weight = isNaN(parseFloat(item.transfer_weight)) ? 0 : parseFloat(item.transfer_weight);
                        if ((transfer_quantity > 0 && transfer_weight <= 0) || (transfer_weight > 0 && transfer_quantity <= 0)) {
                            ErrorData.status = true;
                            ErrorData.sting = "Transfer quantity and weight must be greater than zero";
                        }
                        if (!isNaN(parseInt(item.transfer_quantity))) {
                            if (transfer_quantity >= item.quantity) {
                                ErrorData.status = true;
                                ErrorData.sting = "Transfer quantity should not greater than or equal to quantity";
                            }
                        }
                        if (!isNaN(parseFloat(item.transfer_weight))) {
                            if (transfer_weight >= item.weight) {
                                ErrorData.status = true;
                                ErrorData.sting = "Transfer weight should not greater than or equal to weight";
                            }
                        }
                        if (ErrorData.status) {
                            item.class = "red";
                        }
                    }
                }
                if (ErrorData.status) {
                    swal(ErrorData.sting);
                    return false;
                }
            }
            if (type != "transfer") {
                let bag_styles = this.form.merge.receive.bag_styles;
                if (bag_styles.length > 0) {
                    for (var index in bag_styles) {
                        let item = bag_styles[index];
                        let transfer_quantity = parseInt(item.transfer_quantity);
                        let transfer_weight = parseFloat(item.transfer_weight);
                        if (transfer_quantity > 0 && transfer_quantity > 0) {
                            let transferItem = this.form.merge.transfer;
                            if (transferItem.length > 0) {
                                for (var itemIndex in transferItem) {
                                    let isDuplicate = false;
                                    if (transferItem[itemIndex].type == this.types.findTransactionType('bag', 'value', 'transaction_type')['id']) {
                                        if (item.style_id == transferItem[itemIndex].bag_style.style_id)
                                            isDuplicate = true;
                                    } else {
                                        if (item.other_accessories != null) {
                                            if (transferItem[itemIndex].bag_style != null) {
                                                if (transferItem[itemIndex].bag_style.other_accessories != null) {
                                                    if (item.other_accessories.id == transferItem[itemIndex].bag_style.other_accessories.id)
                                                        isDuplicate = true;

                                                }
                                            } else {
                                                if (transferItem[itemIndex].other_accessories != null) {
                                                    if (item.other_accessories.id == transferItem[itemIndex].other_accessories.id)
                                                        isDuplicate = true;

                                                }
                                            }
                                        }


                                    }
                                    if (isDuplicate) {
                                        transferItem[itemIndex].quantity = parseInt(transferItem[itemIndex].quantity) + transfer_quantity;
                                        bag_styles[index].quantity = parseInt(bag_styles[index].quantity) - transfer_quantity;
                                        //transferItem[itemIndex].quantity += transfer_quantity;
                                        //bag_styles[index].quantity -= transfer_quantity;
                                        transferItem[itemIndex].weight = CommonMethods.BigDecimalFunction("add", transferItem[itemIndex].weight, transfer_weight);
                                        bag_styles[index].weight = CommonMethods.BigDecimalFunction("subtract", bag_styles[index].weight, transfer_weight);
                                        item.transfer_quantity = 0;
                                        item.transfer_weight = 0;
                                    }
                                }
                            }
                        }

                    }
                }
            }
            //#todo for receive...!

        }
    }
});