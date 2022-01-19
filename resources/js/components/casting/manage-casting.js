import Vuetable from 'vuetable-2/src/components/Vuetable'
import VuetablePagination from 'vuetable-2/src/components/VuetablePagination'
import VuetablePaginationInfo from 'vuetable-2/src/components/VuetablePaginationInfo'
import FieldDefs from './field-defs';
import VueSelect from 'vue-multiselect';

Vue.component('manage-casting', {
    components: {
        'vue-table': Vuetable,
        'vuetable-pagination': VuetablePagination,
        VuetablePaginationInfo,
        'v-select': VueSelect,
    },
    data() {
        return {
            fields: FieldDefs,
            isLoading: false,
            displayForm: false,
            vueTableParams: {
                trash: 0
            },
            is_advance_search: false,
            isViewMode: false,
            props: ['props'],
        };
    },

    created() {

    },
    beforeDestroy() {

    },
    mounted() {
        console.log("list");
    },

    computed: {
        vueTableFetch: function () {
            return axios.get;
        }
    },
    methods: {
        onFilter() {
            this.reloadDataTable(false);
        },
        reloadDataTable(dontResetPageNumber) {
            if (dontResetPageNumber) {
                this.$refs.vuetable.reload();
            } else {
                this.$refs.vuetable.refresh();
            }
        },
        createCasting() {
            this.isViewMode = false;
            this.showForm();
        },
        onPaginationData(paginationData) {
            this.$refs.pagination.setPaginationData(paginationData)
            this.$refs.paginationInfo.setPaginationData(paginationData)
        },
        onChangePage(page) {
            this.$refs.vuetable.changePage(page)
        },
        onAction(action, data, index) {
            var self = this;
            switch (action) {
                case 'edit-item':
                    axios.get('/api/casting/' + data.id)
                        .then(response => {
                            this.currentRecord = response.data;
                            this.showForm();
                        }).catch(reason => {
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
                        self.isLoading = false;
                    });
                    break;
                }
        },
        showForm() {
            this.displayForm = true;
        },
        showGrid() {
            this.displayForm = false;
            this.currentRecord = null;
        },
    }
});
