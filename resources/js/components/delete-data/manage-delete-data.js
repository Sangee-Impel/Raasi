import Vuetable from 'vuetable-2/src/components/Vuetable'
import VuetablePagination from 'vuetable-2/src/components/VuetablePagination'
import VuetablePaginationInfo from 'vuetable-2/src/components/VuetablePaginationInfo'
import VueSelect from 'vue-multiselect';

Vue.component('manage-delete-data', {

    components: {
        'v-select': VueSelect,
        'vue-table': Vuetable,
        'vuetable-pagination': VuetablePagination,
        VuetablePaginationInfo,
    },
    data() {
        return {
            isLoading: false,
        };
    },
    created() {

    },
    beforeDestroy() {

    },
    mounted() {
    },

    computed: {
    },

    methods: {
    }
});