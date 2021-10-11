import Vuetable from 'vuetable-2/src/components/Vuetable';
import VuetablePagination from 'vuetable-2/src/components/VuetablePagination';
import VuetablePaginationInfo from 'vuetable-2/src/components/VuetablePaginationInfo';
import FieldDefs from './field-defs';
Vue.component('home', {
    props: ['user'],

    components:{
        'vue-table':Vuetable,
        'vuetable-pagination':VuetablePagination,
        VuetablePaginationInfo,
    },
    data(){
      return { 
          counter: 1,
          trash_off:   true,
          fields              : FieldDefs,
          vueTableParams : {
              filter: '',
              department:'',
              line:'',
              start_date:'',
              end_date:'',
              date:'',
              trash:''
          },

      }
    },

    created(){


    },

    mounted() {

    },
    methods : {
        onPaginationData (paginationData) {
            this.$refs.pagination.setPaginationData(paginationData)
            this.$refs.paginationInfo.setPaginationData(paginationData)
        },
        onChangePage (page) {
            this.$refs.vuetable.changePage(page)
        },
    }
});
