import Vuetable from 'vuetable-2/src/components/Vuetable'
import VuetablePagination from 'vuetable-2/src/components/VuetablePagination'
import VuetablePaginationInfo from 'vuetable-2/src/components/VuetablePaginationInfo'
import FieldDefs from './field-defs'

Vue.component('profile-user', {

    components : {
        'vue-table':Vuetable,
        'vuetable-pagination':VuetablePagination,
         VuetablePaginationInfo,
    },
    data() {
        return {
            fields          : FieldDefs,
            displayForm     : false,
            isProfile       :  true, 
            currentRecord   : null,
            isLoading       : false,
            is_advance_search:false,
            trash_off       : true,
            trashText       : 'Trash',
            vueTableParams : {
                trash     : 0
            },
            props:['props'],

            user_id         :  null,
        };
    },

    created(){

    },
    beforeDestroy(){

    },
    mounted(){
        console.log("list");
        this.displayProfileUser();

        // this.isLoading = false;
    },

    computed:{
        vueTableFetch: function() {
            return axios.get;
        }
    },

    methods : {
        displayProfileUser(){
            console.log("DSA");
            axios.get('/api/user/'+$("#user_id").val())
                .then(response => {
                    this.currentRecord = response.data;
                    this.showForm();

                })
                .catch(reason => {
                    console.log(reason);
                    this.$snotify.error(reason);

                })
        },
        showGrid(){
            console.log("Parent function");
           /* this.displayForm = false;
            this.currentRecord = null;*/
        },
        showForm(){
            
            this.displayForm = true;
            console.log(this.displayForm);

        },

    }
});
