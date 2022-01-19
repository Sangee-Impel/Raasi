import Vuetable from 'vuetable-2/src/components/Vuetable'
import VuetablePagination from 'vuetable-2/src/components/VuetablePagination'
import VuetablePaginationInfo from 'vuetable-2/src/components/VuetablePaginationInfo'
import FieldDefs from './field-defs'
import TypeDefs from './type-defs'
Vue.component('manage-transaction', {

    components: {
        'vue-table': Vuetable,
        'vuetable-pagination': VuetablePagination,
        VuetablePaginationInfo,
    },
    data() {
        return {
            fields: FieldDefs,
            displayForm: false,
            currentRecord: null,
            isLoading: false,
            is_advance_search: false,
            trash_off: true,
            trashText: 'Trash',
            types: TypeDefs,
            vueTableParams: {
                trash: 0
            },
            props: ['props']


        };
    },

    created() {

    },
    beforeDestroy() {

    },
    mounted() {
        console.log("list");

        // this.isLoading = false;
    },

    computed: {
        vueTableFetch: function () {
            return axios.get;
        }
    },

    methods: {
        changeDateFormat(value) {
            if (value != null) {
                return moment(value).format("DD-MM-YYYY");
            }
            return "-";
        },
        changeTransactionStatus(value) {
            if (value != null) {
                return this.types.findTransactionType(value, 'id', 'transaction')['name'];
            }
            return "-";
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
            // console.log('slot) action: ' + action, data.title, index)
            switch (action) {
                case 'edit-item':
                    axios.get('/api/transaction/' + data.id)
                        .then(response => {
                            //console.log(response);
                            this.currentRecord = response.data;
                            this.showForm();


                        })
                        .catch(reason => {
                            console.log(reason);
                            this.$snotify.error(reason);

                        })
                    break;
                case 'view-item':
                    self.isLoading = true;
                    axios.get('/api/transaction/' + data.id)
                        .then(response => {
                            //console.log(response);
                            this.currentRecord = response.data;
                            this.showForm();


                        })
                        .catch(reason => {
                            console.log(reason);
                            this.$snotify.error(reason);

                        }).finally(() => { self.isLoading = false; });
                    break;
                case 'restore-item':
                    swal({
                        title: "Are you sure?",
                        text: "Transaction  will be Restored!",
                        icon: "warning",
                        buttons: true,
                        dangerMode: true,
                    }).then(isConfirm => {
                        if (isConfirm) {
                            axios.get('/api/transaction/restore/' + data.id)
                                .then(response => {
                                    console.log(response);
                                    self.$snotify.success('Restored!');
                                    self.showGrid();
                                    self.actionTrash();
                                    self.isLoading = false;

                                })
                                .catch(reason => {
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
                        text: "Transaction will be deleted!",
                        icon: "warning",
                        buttons: true,
                        dangerMode: true,
                    }).then(isConfirm => {
                        if (isConfirm) {
                            axios.delete('/api/transaction/' + data.id + "?trash=" + this.vueTableParams.trash)
                                .then(response => {
                                    self.$snotify.success('Deleted!');
                                    self.$refs.vuetable.reload();

                                })
                                .catch(reason => {
                                    self.$snotify.error('Cannot delete Transaction');

                                }).finally(() => { self.isLoading = false; });
                        } else {
                            self.isLoading = false;
                        }
                    });

                    break;
            }

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

    }
});
