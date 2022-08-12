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
            inward_total: 0,
            outward_total: 0,
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
        vueTableFetch: function() {
            return axios.get;
        },
    },

    methods: {
        reloadDataTable(dontResetPageNumber) {
            this.toalCalc();
        },
        toalCalc() {
            axios.get('/api/closing-report', {
                params: this.vueTableParams
            }).then(response => {
                let data = response.data.data[0];
                this.opening = parseFloat(data.opening).toFixed(3);
                this.closing = parseFloat(data.closing).toFixed(3);
                this.kambi = parseFloat(data.kambi_inward).toFixed(3);
                this.casting = parseFloat(data.casting_inward).toFixed(3);
                this.scrap = parseFloat(data.scrap).toFixed(3);
                this.chanam = parseFloat(data.channam).toFixed(3);
                this.loss = parseFloat(data.loss).toFixed(3);
                this.fancy_inward = parseFloat(data.fancy_inward).toFixed(3);
                this.fc_delivery = parseFloat(data.fc_delivery).toFixed(3);
                this.others_inward = parseFloat(data.others_inward).toFixed(3);
                this.pending_bag = parseFloat(data.pending_bag).toFixed(3);
                this.eod_bag = parseFloat(data.eod_bag).toFixed(3);
                this.inward_total = parseFloat(parseFloat(data.opening) + parseFloat(data.casting_inward) + parseFloat(data.kambi_inward) + parseFloat(data.fancy_inward) + parseFloat(data.others_inward)).toFixed(3);
                this.outward_total = parseFloat(parseFloat(data.scrap) + parseFloat(data.channam) + parseFloat(data.loss) + parseFloat(data.fc_delivery)).toFixed(3);
            }).catch(reason => {}).finally(() => {
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