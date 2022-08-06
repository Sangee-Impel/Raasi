import Vuetable from 'vuetable-2/src/components/Vuetable'
import VuetablePagination from 'vuetable-2/src/components/VuetablePagination'
import VuetablePaginationInfo from 'vuetable-2/src/components/VuetablePaginationInfo'
import FieldDefs from './field-defs';
import VueSelect from 'vue-multiselect';

Vue.component('manage-closing-report', {

    components: {
        'v-select': VueSelect,
        'vue-table': Vuetable,
        'vuetable-pagination': VuetablePagination,
        VuetablePaginationInfo,
    },
    data() {
        return {
            fields: FieldDefs,
            vueTableParams: {
                trash: 0,
                advanceFilter: {
                    from_date: null,
                    to_date: null
                }
            },
            isLoading: false,
            is_advance_search: true,
            from_date: null,
            to_date: null,
            opening: 0,
            closing: 0,
            kambi: 0,
            casting: 0,
            scrap: 0,
            chanam: 0,
            loss: 0,
            fancy_inward: 0,
            fc_delivery: 0,
            others_inward: 0,
        };
    },
    created() {

    },
    beforeDestroy() {

    },
    mounted() {
        this.loadDropDown();
        this.toalCalc();
    },

    computed: {
        vueTableFetch: function () {
            return axios.get;
        },
    },

    methods: {
        reloadDataTable(dontResetPageNumber) {
            console.log("Dont Reset Page Number => " + (dontResetPageNumber ? "TRUE" : "FALSE"));
            if (dontResetPageNumber) {
                this.$refs.vuetable.reload();
            } else {
                this.$refs.vuetable.refresh();
            }
        },
        toalCalc() {
            axios.get('/api/closing-report').then(response => {
                let data = response.data.data[0];
                this.opening = data.opening;
                this.closing = data.closing;
                this.kambi = data.kambi_inward;
                this.casting = data.casting_inward;
                this.scrap = data.scrap;
                this.chanam = data.channam;
                this.loss = data.loss;
                this.fancy_inward = data.fancy_inward;
                this.fc_delivery = data.fc_delivery;
                this.others_inward = data.others_inward;
            }).catch(reason => { }).finally(() => {
                this.isLoading = false;
            });
        },
        onPaginationData(paginationData) {
            this.$refs.pagination.setPaginationData(paginationData)
            this.$refs.paginationInfo.setPaginationData(paginationData)
        },
        onChangePage(page) {
            this.$refs.vuetable.changePage(page)
        },

        onAction(action, data, index) {

        },
        onFilter() {
            this.reloadDataTable(false);
        },
        clearDataTable() {
            this.vueTableParams.filter = '';
            this.reloadDataTable(false);
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

                }).finally(() => {
                    this.isLoading = false;
                });
        },
        onFilterSearch() {
            this.isLoading = true;

            this.vueTableParams.advanceFilter.from_date = null;
            if (this.from_date != null)
                this.vueTableParams.advanceFilter.from_date = this.from_date;

            this.vueTableParams.advanceFilter.to_date = null;
            if (this.to_date != null) {
                this.vueTableParams.advanceFilter.to_date = this.to_date;
            }

            this.reloadDataTable(false);
            this.isLoading = false;
        },
        closeAdvanceFilter() {
            this.is_advance_search = true;
            this.from_date = null;
            this.to_date = null;
            this.isLoading = true;
            this.onFilterSearch();
            this.isLoading = false;
        },
        showAdvanceFilterBlock() {
            this.is_advance_search = false;
        },
    }
});