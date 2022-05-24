import Vuetable from 'vuetable-2/src/components/Vuetable'
import VuetablePagination from 'vuetable-2/src/components/VuetablePagination'
import VuetablePaginationInfo from 'vuetable-2/src/components/VuetablePaginationInfo'
import FieldDefs from './field-defs'
import TypeDefs from './type-defs'
import VueSelect from 'vue-multiselect';

Vue.component('manage-bag', {

    components: {
        'vue-table': Vuetable,
        'vuetable-pagination': VuetablePagination,
        VuetablePaginationInfo,
        'v-select': VueSelect,
    },
    data() {
        return {
            fields: FieldDefs,
            types: TypeDefs,
            displayForm: false,
            currentRecord: null,
            isLoading: false,
            is_advance_search: true,
            trash_off: true,
            trashText: 'Trash',
            department: null,
            employee: null,
            vueTableParams: {
                trash: 0,
                advanceFilter: {
                    department_id: null,
                    employee_id: null,
                }
            },
            department_options: [],
            employee_options: [],
            all_employee_options: [],
            isViewMode: false,
            isEditMode: false,
            props: ['props'],
            bagCancelOtpModel: false,
            cancel_bag: {
                id: null,
                otp: ""
            }


        };
    },

    created() {

    },
    beforeDestroy() {

    },

    mounted() {
        this.loadDropDown();
        console.log("list");

        // this.isLoading = false;
    },

    computed: {
        vueTableFetch: function () {
            return axios.get;
        }
    },

    methods: {
        checkEditStatus(rowData) {
            if (this.vueTableParams.trash == 0) {
                if (rowData.status == this.types.findBagType("in_progress", "value", "bag_status")['id'])
                    return true;
            }
            return false;
        },
        changeBagStatus(value) {
            return this.types.findBagType(value, "id", "bag_status")["name"];
        },
        bindEmployee() {
            if (this.department != null) {
                this.employee = null;
                this.employee_options = this.department.employees;
            } else {
                this.employee_options = this.all_employee_options;
            }
        },
        loadDropDown() {
            this.isLoading = true;
            axios.post('/api/get-dropdown-data')
                .then(response => {
                    let dropDownData = response.data;
                    this.department_options = dropDownData.department;
                    this.employee_options = dropDownData.employee;
                    this.all_employee_options = dropDownData.employee;
                    //
                })
                .catch(reason => {
                    console.log(reason.message);
                }).finally(() => {
                    this.isLoading = false;
                });
        },


        reloadDataTable(dontResetPageNumber) {
            console.log("Dont Reset Page Number => " + (dontResetPageNumber ? "TRUE" : "FALSE"));
            if (dontResetPageNumber) {
                this.$refs.vuetable.reload();
            } else {
                this.$refs.vuetable.refresh();
            }
        },

        onPaginationData(paginationData) {
            console.log(this.tableData);
            this.$refs.pagination.setPaginationData(paginationData)
            this.$refs.paginationInfo.setPaginationData(paginationData)
        },
        onChangePage(page) {
            this.$refs.vuetable.changePage(page)
        },

        onAction(action, data, index) {
            var self = this;
            console.log('slot) action: ' + action, data.title, index)
            switch (action) {
                case 'edit-item':
                    axios.get('/api/bag/' + data.id)
                        .then(response => {
                            //console.log(response);
                            this.isEditMode = true;
                            this.isViewMode = true;
                            this.currentRecord = response.data;
                            this.showForm();
                        }).catch(reason => {
                            console.log(reason);
                            this.$snotify.error(reason);
                        })
                    break;
                case 'cancel-item':
                    self.isLoading = true;
                    swal({
                        title: "Are you sure?",
                        text: "Do you want to cancel this bag!",
                        icon: "warning",
                        buttons: true,
                        dangerMode: true,
                    }).then(isConfirm => {
                        if (isConfirm) {
                            this.generateOTP(data.id);
                        } else {
                            self.isLoading = false;
                        }
                    });
                    break;
                case "view-item":
                    axios.get('/api/bag/' + data.id)
                        .then(response => {
                            this.isViewMode = true;
                            this.isEditMode = false;
                            //console.log(response);
                            this.currentRecord = response.data;
                            this.showForm();
                        }).catch(reason => {
                            console.log(reason);
                            this.$snotify.error(reason);
                        })
                    break;
                case 'restore-item':
                    swal({
                        title: "Are you sure?",
                        text: "Bag  will be Restored!",
                        icon: "warning",
                        buttons: true,
                        dangerMode: true,
                    }).then(isConfirm => {
                        if (isConfirm) {
                            axios.get('/api/bag/restore/' + data.id)
                                .then(response => {
                                    console.log(response);
                                    self.$snotify.success('Restored!');
                                    self.showGrid();
                                    self.actionTrash();
                                    self.isLoading = false;
                                }).catch(reason => {
                                    console.log(reason);
                                    self.$snotify.error(reason);

                                }).finally(() => { self.isLoading = false; });
                        } else {
                            self.isLoading = false;
                        }
                    });

                    break;
                case 'delete-item':
                    swal({
                        title: "Are you sure?",
                        text: "Bag will be deleted!",
                        icon: "warning",
                        buttons: true,
                        dangerMode: true,
                    }).then(isConfirm => {
                        if (isConfirm) {
                            axios.delete('/api/bag/' + data.id + "?trash=" + this.vueTableParams.trash)
                                .then(response => {
                                    self.$snotify.success('Deleted!');
                                    self.$refs.vuetable.reload();

                                })
                                .catch(reason => {
                                    self.$snotify.error('Cannot delete Bag');

                                }).finally(() => { self.isLoading = false; });
                        } else {
                            self.isLoading = false;
                        }
                    });

                    break;
            }
        },

        createBag() {
            this.isViewMode = false;
            this.showForm();
        },
        showForm() {
            this.displayForm = true;
            console.log(this.displayForm);

        },
        /**
         * This method will be called from child component (form-client)
         */
        showGrid() {
            console.log("Parent function");
            this.displayForm = false;
            this.currentRecord = null;
        },
        actionTrash() {
            if (this.vueTableParams.trash == this.$root.trashFields.trashOff) {
                this.vueTableParams.trash = this.$root.trashFields.trashOn;
            } else {
                this.vueTableParams.trash = this.$root.trashFields.trashOff;
            }
            this.$refs.vuetable.reload();
        },
        onFilter() {
            this.reloadDataTable(false);
        },
        clearDataTable() {
            this.vueTableParams.filter = '';
            this.reloadDataTable(false);
        },
        closeAdvanceFilter() {
            console.log("close");
            this.is_advance_search = true;
            this.employee = null;
            this.department = null;

            this.onFilterSearch();
        },
        onFilterSearch() {
            this.isLoading = true;
            this.reference_options = [];

            this.vueTableParams.advanceFilter.employee_id = null;
            if (this.employee != null)
                this.vueTableParams.advanceFilter.employee_id = this.employee.id;
            this.vueTableParams.advanceFilter.department_id = null;
            if (this.department != null)
                this.vueTableParams.advanceFilter.department_id = this.department.id;

            this.reloadDataTable(false);
            this.isLoading = false;
        },
        showAdvanceFilterBlock() {
            this.is_advance_search = false;
        },
        generateOTP(id) {
            this.isLoading = true;
            axios.get('/api/bag/generate-otp/' + id)
                .then(response => {
                    console.log(response);
                    this.cancel_bag.id = id;
                    this.bagCancelOtpModel = true;
                })
                .catch(reason => {
                    let message = "Given data is invalid";
                    if (reason.response) {
                        if (reason.response.data.errors)
                            message = reason.response.data.errors;
                    }
                    this.$snotify.error(message);
                }).finally(() => { this.isLoading = false; });
            // this.cancel_bag.id = id;
            // this.bagCancelOtpModel = true;
            // this.isLoading = false;
        },
        onCancelBag() {
            this.isLoading = true;
            axios.post('/api/bag/cancel', this.cancel_bag)
                .then(response => {
                    this.bagCancelOtpModel = false;
                    this.$snotify.success('Bag status updated successfully!');
                    this.reloadDataTable();
                })
                .catch(reason => {
                    let message = "Given data is invalid";
                    if (reason.response) {
                        if (reason.response.data.errors)
                            message = reason.response.data.errors;
                    }
                    this.$snotify.error(message);
                }).finally(() => {
                    this.isLoading = false;
                });
        }

    }
});