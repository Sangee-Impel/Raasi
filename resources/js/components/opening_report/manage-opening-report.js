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
                trash: 0
            },
            isLoading: false,
            is_advance_search: true

        };
    },

    created() {

    },
    beforeDestroy() {

    },
    mounted() {
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
        },
        clearDataTable() {
            this.vueTableParams.filter = '';
            this.reloadDataTable(false);
        },
        onFilterSearch() {
            this.isLoading = true;

            this.vueTableParams.advanceFilter.user_id = null;

            this.reloadDataTable(false);
            this.isLoading = false;
        },
    }
});
