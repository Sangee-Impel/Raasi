import Vuetable from 'vuetable-2/src/components/Vuetable'
//import vuetify_css from 'vuetify/dist/vuetify.min.css'
import VuetablePagination from 'vuetable-2/src/components/VuetablePagination'
import VuetablePaginationInfo from 'vuetable-2/src/components/VuetablePaginationInfo'
import FieldDefs from './field-defs'
import VTreeview from "v-treeview"
import Vuetify from 'vuetify';

Vue.use(Vuetify, {
    iconfont: 'md'
});
Vue.use(Vuetify);
Vue.component('manage-product-category', {

    components : {
        'vue-table':Vuetable,
        'vuetable-pagination':VuetablePagination,
         VuetablePaginationInfo,
    },
    data() {
        return {
            fields          : FieldDefs,
            displayForm     : false,
            currentRecord   : null,
            isLoading       : false,
            is_advance_search:false,
            trash_off       : true,
            trashText       : 'Trash',
            vueTableParams : {
                trash     : 0
            },
            treeViewModal: false,
            treeViewValue : [],
            treeViewParams : {
                openOnClickStatus :true,
                openBlock: ['Ring'],
                openAllStatus  :true
            },
            open: [1, 2],
            props:['props']


        };
    },

    created(){

    },
    beforeDestroy(){

    },
    mounted(){
        console.log("list");

        // this.isLoading = false;
    },

    computed:{
        vueTableFetch: function() {
            return axios.get;
        }
    },

    methods : {

        treeViewToggle() {
            this.treeViewModal = !this.treeViewModal;
        },


        reloadDataTable(dontResetPageNumber){
            console.log("Dont Reset Page Number => "+ (dontResetPageNumber ? "TRUE":"FALSE"));
            if(dontResetPageNumber){
                this.$refs.vuetable.reload();
            }else{
                this.$refs.vuetable.refresh();
            }
        },

        onPaginationData (paginationData) {
            console.log(this.tableData);
            this.$refs.pagination.setPaginationData(paginationData)
            this.$refs.paginationInfo.setPaginationData(paginationData)
        },
        onChangePage (page) {
            this.$refs.vuetable.changePage(page)
        },

        onAction (action, data, index) {
            var self = this;
            // console.log('slot) action: ' + action, data.title, index)
            switch (action) {
                case 'edit-item':
                    axios.get('/api/product-category/'+data.id)
                        .then(response => {
                            //console.log(response);
                            this.currentRecord = response.data;
                            this.showForm();


                        })
                        .catch(reason => {
                            console.log(reason);
                            this.$snotify.error(reason);

                        })
                    break;
                case 'view-item':
                    self.isLoading = true;
                    axios.post('/api/product-category/view',{"id":data.id})
                        .then(response => {
                            this.treeViewValue =  response.data;
                            this.treeViewToggle();
                        })
                        .catch(reason => {
                            console.log(reason);
                            this.$snotify.error(reason);

                        }).finally(() => {self.isLoading = false;});
                    break;
                case 'restore-item':
            swal({
                    title: "Are you sure?",
                    text: "Product Category  will be Restored!",
                    icon: "warning",
                     buttons: true,
                     dangerMode: true,
                }).then(isConfirm =>{
                if (isConfirm) {
                    axios.get('/api/product-category/restore/'+data.id)
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

                }).finally(() => {self.isLoading = false;});
                }else{
                    self.isLoading = false;
        }
        });

                    break;
                case 'delete-item':
            swal({
                    title: "Are you sure?",
                    text: "Product Category will be deleted!",
                    icon: "warning",
                    buttons: true,
                    dangerMode: true,
                }).then(isConfirm =>{
                if (isConfirm) {
                    axios.delete('/api/product-category/'+data.id +"?trash="+this.vueTableParams.trash)
                        .then(response => {
                        self.$snotify.success('Deleted!');
                        self.$refs.vuetable.reload();

                })
                .catch(reason => {
                    self.$snotify.error('Cannot delete Product Category');

                })  .finally(() => {self.isLoading = false;});
                }else{
                    self.isLoading = false;
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
            console.log("Parent function");
            this.displayForm = false;
            this.currentRecord = null;
        },
        actionTrash(){
            if(this.vueTableParams.trash == this.$root.trashFields.trashOff){
                this.vueTableParams.trash = this.$root.trashFields.trashOn;
            }else{
                this.vueTableParams.trash = this.$root.trashFields.trashOff;
            }
            this.$refs.vuetable.reload();
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
