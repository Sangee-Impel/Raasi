import Vuetable from 'vuetable-2/src/components/Vuetable'
import VuetablePagination from 'vuetable-2/src/components/VuetablePagination'
import VuetablePaginationInfo from 'vuetable-2/src/components/VuetablePaginationInfo'
import FieldDefs from './field-defs';

Vue.component('manage-audit', {
    props       : ['customer_id'],
    components  : {
        'vue-table':Vuetable,
        'vuetable-pagination':VuetablePagination,
         VuetablePaginationInfo,
    },
    data() {
        return {
            fields         : FieldDefs,
            displayForm     : false,
            currentRecord   : null,
            isLoading       : false,
            is_advance_search:false,
            vueTableParams  : {
                trash       : this.$root.trashFields.trashOff,
                customer_id : this.customer_id
            }
        };
    },

    created(){

    },
    beforeDestroy(){

    },
    mounted(){

    },
    computed:{
        vueTableFetch: function() {
            return axios.get;
        }
    },
    filters : {
        getTrashName(value){
            return this.$root.trashFields.findByValue(value).text;
        },

    },

    methods : {
        reloadDataTable(dontResetPageNumber){
            if(dontResetPageNumber){
                this.$refs.vuetable.reload();
            }else{
                this.$refs.vuetable.refresh();
            }
        },
        changeDateFormat(value) {
            return moment(value).format("DD-MM-YYYY hh:mm a");
        },
        onPaginationData (paginationData) {
            this.$refs.pagination.setPaginationData(paginationData)
            this.$refs.paginationInfo.setPaginationData(paginationData)
        },
        onChangePage (page) {
            this.$refs.vuetable.changePage(page)
        },
        convertObject(value) {
            return JSON.parse(value);
        },
        onAction (action, data, index) {
            var self = this;
            // console.log('slot) action: ' + action, data.title, index)
            switch (action) {
                case 'edit-item':
                    axios.get('/api/reason/'+data.id)
                        .then(response => {
                            console.log(response);
                            this.currentRecord = response.data;
                            this.showForm();
                    })
                        .catch(reason => {
                            console.log(reason);
                            this.$snotify.error(reason);

                        })
                    break;
                case 'restore-item':
            swal({
                    title: "Are you sure?",
                    text: "Reason will be Restored!",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonClass: "ui button danger",
                    confirmButtonText: "Yes",
                    cancelButtonText: "No",
                    closeOnConfirm: true,
                    closeOnCancel: true
                },
                (isConfirm) =>{
                if (isConfirm) {
                    axios.get('/api/reason/restore/'+data.id)
                        .then(response => {
                        console.log(response);
                    self.$snotify.success('Restored!');
                    self.showGrid();
                    self.actionTrash();
                    self.isLoading = false;

                })
                .catch(reason => {
                        console.log(reason);
                    self.$snotify.error(reason);

                })
                }else{
                    this.isLoading = false;
        }
        });

                    break;
                case 'delete-item':
            swal({
                    title: "Are you sure?",
                    text: "Reason will be deleted!",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonClass: "ui button danger",
                    confirmButtonText: "Yes",
                    cancelButtonText: "No",
                    closeOnConfirm: true,
                    closeOnCancel: true
                },
                (isConfirm) =>{
                if (isConfirm) {
                    axios.delete('/api/reason/'+data.id+"?trash="+this.vueTableParams.trash )
                        .then(response => {

                        self.$snotify.success('Deleted!');
                    self.$refs.vuetable.reload();
                    self.isLoading = false;
                })
                .catch(reason => {
                        console.log(reason);
                    self.$snotify.error('Cannot delete reason');
                    self.isLoading = false;
                })
                }else{
                    this.isLoading = false;
        }
        });

            break;
            }
        },


        showForm(){
            this.displayForm = true;
            console.log(this.displayForm);

        },
        /**
         * This method will be called from child component (form-client)
         */
        showGrid(){
            this.displayForm = false;
            this.currentRecord = null;
        },
        actionTrash(){
            if(this.vueTableParams.trash == this.$root.trashFields.trashOff){
                this.vueTableParams.trash = this.$root.trashFields.trashOn;
            }else{
                this.vueTableParams.trash = this.$root.trashFields.trashOff;
            }
            this.reloadDataTable(false);
        },
        onFilter() {
            this.reloadDataTable(false);
        },
        clearDataTable(){
            this.vueTableParams.filter='';
            this.reloadDataTable(false);
        },
    }
});
