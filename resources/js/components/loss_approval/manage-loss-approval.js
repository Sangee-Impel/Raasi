import Vuetable from 'vuetable-2/src/components/Vuetable'
import VuetablePagination from 'vuetable-2/src/components/VuetablePagination'
import VuetablePaginationInfo from 'vuetable-2/src/components/VuetablePaginationInfo'
import FieldDefs from './field-defs'
import TypeDefs from '../transaction/type-defs'
import VueSelect from 'vue-multiselect';

Vue.component('manage-loss-approval', {
    components: {
        'v-select': VueSelect,
        'vue-table': Vuetable,
        'vuetable-pagination': VuetablePagination,
        VuetablePaginationInfo,
    },
    data() {
        return {
            fields: FieldDefs,
            types: TypeDefs,
            vueTableParams: {
                trash: 0,
                per_page: 100,
                advanceFilter: {
                    user_id: null,
                    status: null
                }
            },
            isLoading: false,
            is_advance_search: true,
            user: null,
            status: null,
            user_options: [],
            lossReasonModel: false,
            form: this.getFormData(),
            totalWeight: 0,
            totalAdminWeight: 0
        };
    },
    created() {

    },
    beforeDestroy() {

    },
    mounted() {
        this.loadDropDown();
        this.totalCalc();
        // this.isLoading = false;
    },
    computed: {
        vueTableFetch: function () {
            return axios.get;
        },
        checkReasonStatus() {
            if (this.form.reason_type != null) {
                if (this.form.reason_type.id == this.types.findTransactionType("others", 'value', 'loss_reason_type')['id']) {
                    return true;
                }
            }
            return false;
        }
    },
    methods: {
        loadDropDown() {
            this.isLoading = true;
            axios.post('/api/loss-approval/drop-down')
                .then(response => {
                    let dropDownData = response.data;
                    this.user_options = dropDownData.user;
                }).catch(reason => {
                    console.log(reason.message);
                }).finally(() => {
                    this.isLoading = false;
                });
        },
        totalCalc() {
            axios.get('/api/loss-approval', {
                params: this.vueTableParams
            })
                .then(response => {
                    let data = response.data.data;
                    this.totalWeight = data.reduce((a, b) => a + b.weight, 0);
                    this.totalAdminWeight = data.reduce((a, b) => a + b.admin_approval_loss_weight, 0);
                }).catch(reason => {
                }).finally(() => {
                    this.isLoading = false;
                });
        },
        checkLossStatus(status) {
            if (status == this.types.findTransactionType("waiting_admin_approval", 'value', 'transaction_item_loss_status')['id']) {
                return true;
            }
            return false;
        },
        changeBagStatus(value) {
            return this.types.findTransactionType(value, "id", "transaction_item_loss_status")["name"];
        },
        getFormData() {
            return new SparkForm({
                id: null,
                reason_type: null,
                reason_type_id: null,
                loss_description: ''
            });
        },
        openReasonModelPopup(data) {
            this.form.id = data.id;
            this.lossReasonModel = true;
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
            this.$refs.pagination.setPaginationData(paginationData)
            this.$refs.paginationInfo.setPaginationData(paginationData)
        },
        onChangePage(page) {
            this.$refs.vuetable.changePage(page)
        },
        onAction(action, data, index) {
            consoel.log(data);
        },
        assignForm() {
            this.form.reason_type_id = null;
            if (this.form.reason_type != null) {
                this.form.reason_type_id = this.form.reason_type.id;
            }
        },
        onSubmit() {
            this.assignForm();
            this.isLoading = true;
            Spark.post('/api/loss-approval/status-update', this.form).then(response => {
                this.$snotify.success('Status Updated!');
                this.onCancel();
            }).catch(reason => {
                console.log(reason);
                this.$snotify.error(reason);
            }).finally(() => {
                this.isLoading = false;
            });
        },
        onCancel() {
            this.lossReasonModel = false;
            this.form = this.getFormData();
            this.onFilter();
        },
        onFilter() {
            this.reloadDataTable(false);
            this.totalCalc();
        },
        clearDataTable() {
            this.vueTableParams.filter = '';
            this.reloadDataTable(false);
            this.totalCalc();
        },
        onFilterSearch() {
            this.isLoading = true;
            this.vueTableParams.advanceFilter.user_id = null;
            if (this.user != null)
                this.vueTableParams.advanceFilter.user_id = this.user.id;

            this.vueTableParams.advanceFilter.status = null;
            if (this.status != null) {
                this.vueTableParams.advanceFilter.status = this.status.id;
            }
            this.reloadDataTable(false);
            this.totalCalc();
            this.isLoading = false;
        },
        closeAdvanceFilter() {
            this.is_advance_search = true;
            this.user = null;
            this.status = null;
            this.isLoading = true;
            this.onFilterSearch();
            this.isLoading = false;
        },
        showAdvanceFilterBlock() {
            this.is_advance_search = false;
        },
    }
});
