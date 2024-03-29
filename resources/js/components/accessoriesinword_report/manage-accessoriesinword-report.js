import Vuetable from 'vuetable-2/src/components/Vuetable'
import VuetablePagination from 'vuetable-2/src/components/VuetablePagination'
import VuetablePaginationInfo from 'vuetable-2/src/components/VuetablePaginationInfo'
import FieldDefs from './field-defs';
import VueSelect from 'vue-multiselect';

Vue.component('manage-accessoriesinword-report', {

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
                per_page: 100,
                advanceFilter: {
                    from_date: null,
                    to_date: null
                }
            },
            isLoading: false,
            is_advance_search: true,
            accessories: null,
            from_date: null,
            to_date: null,
            totalWeight: 0,
            accessories_options: [],
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
        loadDropDown() {
            this.isLoading = true;
            axios.post('/api/accessoriesinword-report/drop-down')
                .then(response => {
                    let dropDownData = response.data;
                    this.accessories_options = dropDownData.accessories;
                }).catch(reason => {
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
        totalCalc() {
            axios.get('/api/accessoriesinword-report', {
                params: this.vueTableParams
            }).then(response => {
                let data = response.data.data;
                this.totalWeight = parseFloat(data.reduce((a, b) => a + b.weight, 0)).toFixed(2);
            }).catch(reason => {
            }).finally(() => {
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
            this.totalCalc();
        },
        clearDataTable() {
            this.vueTableParams.filter = '';
            this.reloadDataTable(false);
            this.totalCalc();
        },
        onFilterSearch() {
            this.isLoading = true;

            this.vueTableParams.advanceFilter.from_date = null;

            if (this.accessories != null)
                this.vueTableParams.advanceFilter.accessories_id = this.accessories.id;

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
            this.isLoading = true;
            this.onFilterSearch();
            this.isLoading = false;
        },
        showAdvanceFilterBlock() {
            this.is_advance_search = false;
        },
    }
});
