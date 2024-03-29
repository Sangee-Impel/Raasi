import Vuetable from 'vuetable-2/src/components/Vuetable'
import VuetablePagination from 'vuetable-2/src/components/VuetablePagination'
import VuetablePaginationInfo from 'vuetable-2/src/components/VuetablePaginationInfo'
import FieldDefs from './field-defs';
import VueSelect from 'vue-multiselect';

Vue.component('manage-eod-report', {

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
                trash: 0, per_page: 100000,
                advanceFilter: {
                    from_date: null,
                    to_date: null,
                    department_id: null,
                    employee_id: null
                }
            },
            department: null,
            employee: null,
            isLoading: false,
            is_advance_search: true,
            from_date: null,
            to_date: null,
            department_options: [],
            employee_options: [],
            all_employee_options: [],
            totalWeight: 0,
            totalScarpWeight: 0,
            totalChanamWeight: 0,
            totalLossWeight: 0,
            totalCrossWeight: 0,
            totalMergeInward: 0,
            totalMergeOutward: 0,
            totalSplitOutward: 0,
            totalCurrentInward: 0,
            totalKambiInward: 0,
            totalFancyInward: 0,
            totalOtherInward: 0,
        };
    },
    created() {

    },
    beforeDestroy() {

    },
    mounted() {
        this.loadDropDown();
        this.totalCalc();
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
            this.totalCalc();
        },
        clearDataTable() {
            this.vueTableParams.filter = '';
            this.reloadDataTable(false);
            this.totalCalc();
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
        totalCalc() {
            axios.get('/api/eod-report', {
                params: this.vueTableParams
            }).then(response => {
                let data = response.data.data;
                this.totalWeight = parseFloat(data.reduce((a, b) => a + b.weight, 0)).toFixed(2);
                this.totalScarpWeight = parseFloat(data.reduce((a, b) => a + b.scrap, 0)).toFixed(2);
                this.totalChanamWeight = parseFloat(data.reduce((a, b) => a + b.channam, 0)).toFixed(2);
                this.totalLossWeight = parseFloat(data.reduce((a, b) => a + b.loss, 0)).toFixed(2);
                this.totalCrossWeight = parseFloat(data.reduce((a, b) => a + b.cross_weight, 0)).toFixed(2);
                this.totalMergeInward = parseFloat(data.reduce((a, b) => a + b.merge_inward, 0)).toFixed(2);
                this.totalMergeOutward = parseFloat(data.reduce((a, b) => a + b.merge_outward, 0)).toFixed(2);
                this.totalSplitOutward = parseFloat(data.reduce((a, b) => a + b.split_outward, 0)).toFixed(2);
                this.totalCurrentInward = parseFloat(data.reduce((a, b) => a + b.current_inward, 0)).toFixed(2);
                this.totalKambiInward = parseFloat(data.reduce((a, b) => a + b.kambi_inward, 0)).toFixed(2);
                this.totalFancyInward = parseFloat(data.reduce((a, b) => a + b.fancy_inward, 0)).toFixed(2);
                this.totalOtherInward = parseFloat(data.reduce((a, b) => a + b.others_inward, 0)).toFixed(2);
            }).catch(reason => { }).finally(() => {
                this.isLoading = false;
            });
        },
        onFilterSearch() {
            this.isLoading = true;

            this.vueTableParams.advanceFilter.employee_id = null;
            if (this.employee != null) {
                this.vueTableParams.advanceFilter.employee_id = this.employee.id;
            }

            this.vueTableParams.advanceFilter.department_id = null;
            if (this.department != null) {
                this.vueTableParams.advanceFilter.department_id = this.department.id;
            }


            this.vueTableParams.advanceFilter.from_date = null;
            if (this.from_date != null)
                this.vueTableParams.advanceFilter.from_date = this.from_date;

            this.vueTableParams.advanceFilter.to_date = null;
            if (this.to_date != null) {
                this.vueTableParams.advanceFilter.to_date = this.to_date;
            }

            this.reloadDataTable(false);
            this.totalCalc();
            this.isLoading = false;
        },
        closeAdvanceFilter() {
            this.is_advance_search = true;
            this.from_date = null;
            this.to_date = null;
            this.employee = null;
            this.department = null;
            this.isLoading = true;
            this.onFilterSearch();
            this.isLoading = false;
        },
        showAdvanceFilterBlock() {
            this.is_advance_search = false;
        },
    }
});