import Vuetable from 'vuetable-2/src/components/Vuetable'
import VuetablePagination from 'vuetable-2/src/components/VuetablePagination'
import VuetablePaginationInfo from 'vuetable-2/src/components/VuetablePaginationInfo'
import FieldDefs from './field-defs';
import VueSelect from 'vue-multiselect';

Vue.component('manage-opening-report', {

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
                per_page: 100
            },
            isLoading: false,
            is_advance_search: true,
            totalWeight: 0
        };
    },

    created() {

    },
    beforeDestroy() {

    },
    mounted() {
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
        totalCalc() {
            axios.get('/api/opening-report', {
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
            console.log(this.tableData);
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
            totalCalc();
        },
        onFilterSearch() {
            this.isLoading = true;
            this.vueTableParams.advanceFilter.user_id = null;
            this.reloadDataTable(false);
            this.totalCalc();
            this.isLoading = false;
        },
    }
});
