import Datetime from 'vue-ctk-date-time-picker';
import VueSelect from 'vue-multiselect';
import TypeDefs from '../transaction/type-defs';
Vue.component('manage-transaction-history', {

    components : {
        'v-date-picker'   : Datetime,
        'v-select': VueSelect,
    },
    data() {
        return {
            types          : TypeDefs,
            displayForm     : false,
            currentRecord   : null,
            isLoading       : false,
            is_advance_search:false,
            trash_off       : true,
            trashText       : 'Trash',
            form            : this.getFormData(),
            transaction_histories : [],
            view_bag_id     :   null,
            view_transaction_histories:{
                transaction : [],
                 bag : {}
            },
            department          :   null,
            employee            :   null,
            login_user          :   [],
            department_options  :   [],
            employee_options    :   [],
            displayStatus       :   {
                department      :   false,
                employee        :   false
            },
            transferItemModal:false,
            viewBagTransactionModal:false,
            transaction_items:[],
            props:['props']


        };
    },
    created(){

    },
    beforeDestroy(){

    },
    mounted(){
        console.log("list");
        this.loadDropDownData();

        // this.isLoading = false;
    },

    computed:{

    },

    methods : {
        loadDropDownData(){
            let department_id  = null;
            let employee_id  = null;
            if(this.department != null){
                department_id = this.department.id
            }
            if(this.employee != null){
                employee_id = this.employee.id
            }
            let data = {
                department_id   :    department_id,
                employee_id     :    employee_id,
                tab_status     :    this.form.tab_status,
            };
            this.isLoading = true;
            axios.post('/api/transaction-history/get-drop-down-data',data)
                .then(response=> {
                    let dropDownData    = response.data;
                    this.department_options     = dropDownData.department;
                    this.employee_options       = dropDownData.employee;
                    this.login_user         =    dropDownData.login_user_details;
                    if( this.login_user.employee != null ){
                        this.displayStatus.employee = true;
                        this.employee      =   this.login_user.employee;
                    }
                    if( this.login_user.department != null ){
                        this.displayStatus.department = true;
                        this.department    =   this.login_user.department;
                    }
                })
                .catch(reason=> {
                    console.log(reason.message);
                }).finally(() => {
                this.isLoading = false;
            });
        },
        getFormData(){
            return new SparkForm({
                date_range      :   null,
                tab_status      :   "issue",
                department_id   :   null,
                employee_id     :   null,
                search          :   ""
            });
        },
        changeTabStatus(status){
            this.form.tab_status = status;
        },
        assignForm(){
            this.form.department_id = null;
            this.form.employee_id = null;
            if( this.department !=null ){
                this.form.department_id =    this.department.id;
            }
            if( this.employee !=null ){
                this.form.employee_id =    this.employee.id;
            }
        },
        getTransactionHistory(){
            this.isLoading = true;
            this.assignForm();
            Spark.post('/api/transaction-history', this.form)
                .then(response => {
                    this.transaction_histories = response;
                })
                .catch(reason => {
                    this.$snotify.error(reason.message);
                })
                .finally(() => {
                    this.isLoading = false;
                });
        },
        onViewTransferItem(index){
            this.transaction_items = this.transaction_histories[index].transaction_items;
            this.transferItemViewToggle();
        },
        onViewBagTransaction(index){
            this.view_bag_id = this.transaction_histories[index].bag_id;
            this.getBagTransactionDetails();
        },
        getBagTransactionDetails(){
            axios.post('/api/transaction-bag-history',{ "bag_id" : this.view_bag_id,"tab_status":this.form.tab_status,"date_range":null})
                .then(response=> {
                    this.view_transaction_histories.transaction = response.data.transaction;
                    this.view_transaction_histories.bag = response.data.bag;
                    this.viewBagTransactionToggle();

                })
                .catch(reason=> {
                    console.log(reason.message);
                }).finally(() => {
                this.isLoading = false;
            });
        },
        viewBagTransactionToggle() {
            this.viewBagTransactionModal = !this.viewBagTransactionModal;
        },
        transferItemViewToggle() {
            this.transferItemModal = !this.transferItemModal;
        },
    }
});
