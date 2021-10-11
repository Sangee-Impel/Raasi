import {VueEditor} from 'vue2-editor';
import VueSelect from 'vue-multiselect';
import 'vue-ctk-date-time-picker/dist/vue-ctk-date-time-picker.css';
import { ToggleButton } from 'vue-js-toggle-button';
import Datetime from 'vue-ctk-date-time-picker';
import TypeDefs from './type-defs'
Vue.component('ToggleButton', ToggleButton);
Vue.component('form-transaction', {
    components: {
        VueEditor,
        'v-select': VueSelect,
        'v-date-picker'   : Datetime,
    },
    data() {
        return {
            options:{"button": true,"navbar": false,"zoomable":true,"toolbar":true,"play":false },
            uom_options:[],
            types          : TypeDefs,
            isViewMode:false,
            form: this.getFormData(),
            currentRecordId: null,
            isLoading: false,
            isAdminStatus:true,
            isReceiveUser:false,

            formTitle: 'Create',
            department_options  :   [],
            other_accessories_options  :   [],
            employee_options    :   [],

            from_employee_options    :   [],
            to_employee_options    :   [],
            bag_options            :   [],
            selected_bag                 :   null,
            transaction_items       :   [],
            from_department     :   null,
            from_employee       :   null,
            to_employee         :   null,
            to_department       :   null,

            selected_department: null,
            selected_process: null,
            login_user : [],
            viewedStyle             :  {},
            display_style           : false,

        }
    },
    created(){
        this.form.errors.forget(); //to reset validation errors
    },
    mounted(){
        this.loadDropDownData();
        if (this.$parent.currentRecord != null) {
            this.isViewMode = true;
            var record = this.$parent.currentRecord;
            this.form.transaction_date = record.transaction_date;
            this.selected_bag = record.bag;
            this.from_department = record.from_department;
            this.from_employee = record.from_employee;
            this.to_department = record.to_department;
            this.to_employee = record.to_employee;
            this.transaction_items = record.transaction_items;

            this.form.description = record.description;
            this.formTitle = 'View';
            this.currentRecordId = record.id;
        }
    },

    methods: {
        customEmployeeLabel ({ code,name }) {
            let string = code+"-"+name;
            return `${string}`;
        },
        changeBag(){
            if( this.selected_bag != null ){
                for( var i = 0; i < this.selected_bag.bag_styles.length; i++){
                    let selectedBagStyle = this.selected_bag.bag_styles[i];
                     this.transaction_items.push({
                         id:0,
                         status:this.types.findTransactionType("in_progress",'value','transaction_type')['id'],
                         bag_style:selectedBagStyle});
                }
            }else{
                this.transaction_items = [];
            }
            /*if( this.selected_bag != null ){

                this.transaction_items = this.selected_bag.bag_styles;
            }*/

        },
       getEmployeeData(){
           this.isLoading = true;

           let data = {

           };
           axios.post('/api/transaction/getData',data)
               .then(response => {
                   //console.log(response);
                   this.currentRecord = response.data;
                   this.showForm();


               })
               .catch(reason => {
                   console.log(reason);
                   this.$snotify.error(reason);

               })
               .finally(() => {
                   this.isLoading = false;
               });
       },
        getFormData(){
            return new SparkForm({
                transaction_date:"",
                transaction_type:false,
                bag_id  :   null,
                from_department_id:null,
                from_employee_id:null,
                to_department_id:null,
                to_employee_id:null,
                description: "",
                bag_styles   :   [],
                transaction_items:[],
                transaction_item_loss_details : []
            });
        },
        submit(){
            this.formAssign();
            this.isLoading = true;
            var method = this.currentRecordId == null ? Spark.post : Spark.put;
            let url = this.currentRecordId == null ? '/api/transaction' : '/api/transaction/' + this.currentRecordId;
            method(url, this.form)
                .then(response => {
                    this.$snotify.success(response.name, 'saved!');
                    this.showGrid();
                })
                .catch(reason => {
                    this.$snotify.error(reason.message);
                })
                .finally(() => {
                    this.isLoading = false;
                });
        },
        showGrid(){
            //console.log("child function");
            this.$parent.showGrid();
        },

        loadDropDownData(type){
            let from_department_id  = null;
            let from_employee_id  = null;
            let to_department_id    = null;
            if(this.from_department != null){
                from_department_id = this.from_department.id
            }
            if(this.from_employee != null){
                from_employee_id = this.from_employee.id
            }
            if(this.to_department != null){
                to_department_id = this.to_department.id
            }
            let data = {
                from_department_id  :    from_department_id,
                from_employee_id    :    from_employee_id,
                to_department_id    :    to_department_id
            };
            this.isLoading = true;
            axios.post('/api/transaction/get-drop-down-data',data)
                .then(response=> {
                    let dropDownData = response.data;
                    //#todo from employee
                    if( type == "from_department"){
                        this.from_employee = null;
                        this.selected_bag = null;
                    }
                    if( type == "to_department" ){
                        this.to_employee = null;
                    }
                    this.department_options = dropDownData.department;
                    this.other_accessories_options = dropDownData.other_accessories;
                    this.from_employee_options = dropDownData.form_employee;
                    this.to_employee_options = dropDownData.to_employee;
                    this.bag_options = dropDownData.bags;
                    this.login_user =   dropDownData.login_user_details;
                    if( dropDownData.login_user_details.employee != null ){
                        this.isAdminStatus = false;
                        this.from_employee      =   dropDownData.login_user_details.employee;
                        if( dropDownData.login_user_details.employee.department != null ){
                            this.from_department    =   dropDownData.login_user_details.employee.department;
                        }

                    }
                })
                .catch(reason=> {
                    console.log(reason.message);
                }).finally(() => {
                this.isLoading = false;
            });
        },
        checkChangeStatus(index){
            let isValidUser = true;
            if( this.login_user.employee != null ){
                if( this.to_department != null ){
                    if( this.login_user.employee.department.id != this.to_department.id ){
                        isValidUser = false;
                    }
                }
                if( this.to_employee != null ){
                    if( this.login_user.employee.id != this.to_employee.id ){
                        isValidUser = false;
                    }
                }
            }
            if( isValidUser ){
                if( this.transaction_items[index].id > 0 ){
                    if( this.types.findTransactionType(this.transaction_items[index].status,'id','transaction_type')['value'] == 'in_progress'){
                        return true;
                    }
                }
            }
            return false;
        },
        formAssign(){

            this.form.bag_id = null;
            if( this.selected_bag != null ){
                this.form.bag_id = this.selected_bag.id;
                this.form.bag_styles = this.selected_bag.bag_styles;
            }


            this.form.from_department_id = null;
            if( this.from_department != null )
                this.form.from_department_id = this.from_department.id;

            this.form.from_employee_id = null;
            if( this.from_employee != null )
                this.form.from_employee_id = this.from_employee.id;

            this.form.to_department_id = null;
            if( this.to_department != null )
                this.form.to_department_id = this.to_department.id;

            this.form.to_employee_id = null;
            if( this.to_employee != null )
                this.form.to_employee_id = this.to_employee.id;

        },
        addtransactionProcess(){
            this.form.transaction_process.push({id:0,process:""});
        },
        changeTransferItemStatus(transactionItem,index){
            let self = this;
            swal("Do you want to change the item status?", {
                buttons: {
                    received    :"Received",
                    not_reached    :"Not Reached",
                    cancel      : "Cancel",
                },
            })
                .then((value) => {
                    if( value != "cancel" ){

                        let type = this.types.findTransactionType("not_reached","value","transaction_type")['id'];
                        if( value == "received" ){
                             type = this.types.findTransactionType("received","value","transaction_type")['id'];
                        }

                        this.isLoading = true;
                        let data = {
                            "id"    : transactionItem,
                            "type"  :   type
                        };
                        axios.post('/api/transaction/change-transaction-item/',data)
                            .then((responce)=>{
                                this.transaction_items[index].status = type
                            })
                            .catch((reason)=>{
                                this.$snotify.error(reason.message, 'Error!');
                            })
                            .finally(()=>{
                                this.isLoading = false;
                            })
                    }


                });
        },
        deletetransactionProcess(index){
            swal({
                title: "Are you sure?",
                text: "Do you want to delete transaction process!",
                icon: "warning",
                buttons: true,
                dangerMode: true,
            }).then(isConfirm =>{
                if (isConfirm) {
                    let removeFromArray = ()=>{
                        this.form.transaction_process.splice(index, 1);
                        swal("transaction Process removed successfully!", 'Deleted');
                    };
                    let deletedtransactionProcess = this.form.transaction_process[index];
                    if( deletedtransactionProcess['id'] > 0 ){
                        this.isLoading = true;
                        axios.delete('/api/transaction/delete-transaction-process/'+deletedtransactionProcess['id'])
                            .then((responce)=>{
                                removeFromArray();
                            })
                            .catch((reason)=>{
                                this.$snotify.error(reason.message, 'Error!');
                            })
                            .finally(()=>{
                                this.isLoading = false;
                            })

                    }else{
                        removeFromArray();
                    }
                }
            });
            console.log();
        },
        showStyleModel (selectedStyleIndex) {
            let selectedStyle = this.transaction_items[selectedStyleIndex].bag_style;
            this.viewedStyle = {};
            if( selectedStyle.style != null ){
                this.viewedStyle = selectedStyle.style;
            }

            this.display_style = true;
        },
        closeStyleModel() {
            this.display_style = false;
        },
    }
})
