import VueSelect from 'vue-multiselect';

let userForm;
userForm = new SparkForm({

    employee_id:'',
    password:'',
    password_confirmation:'',
    name:'',
    email:'',
    role_id:'',
    department_id:''


});

Vue.component('form-user', {
    components: {
        'v-select': VueSelect,
    },
    data() {
        return {
            form: userForm,
            roles_options       :   [],
            departments_options :   [],
            role                :   null,
            department          :   null,
            currentRecordId : null,
            isLoading : false,
            details: [],
            formTitle:'',
            status   :false,
            password :null

        }
    },
    computed:{
        checkRoleStatus: function() {
            let self = this;
            if( self.role != null){
                if(self.role.slug != "admin"){
                    return true;
                }
            }
            return false;
        }
    },
    created(){

        this.form.errors.forget(); //to reset validation errors
    },
    mounted(){
        this.loadDropDownData();
        this.form.password            = null;
        this.form.password_confirmation  = null;

        if(this.$parent.currentRecord != null){
            var record                    = this.$parent.currentRecord;
            this.form.employee_id         = record.employee_id;
            this.form.name                = record.name;
            this.form.email               = record.email;
            this.form.role_id             = record.role_user.role_id;
            this.role                     = record.role_user.role;
            this.department               = record.department;
            this.formTitle                = 'Update';
            this.currentRecordId          = record.id;
            this.status                   = false;
        }else{
            this.form.employee_id         = null;
            this.form.name                = null;
            this.form.email               = null;
            this.form.role_id             = null;
            this.currentRecordId          = null;
            this.formTitle                = 'Create';
        }


    },

    methods : {
        loadDropDownData(){
            this.isLoading = true;
            axios.post('/api/user/get-drop-down-data',{})
                .then(response=> {
                    let dropDownData = response.data;
                    this.departments_options =  dropDownData.departments;
                    this.roles_options =  dropDownData.roles;
                })
                .catch(reason=> {
                    console.log(reason.message);
                }).finally(() => {
                this.isLoading = false;
            });
        },
        formAssign(){
            if( this.role != null ){
                this.form.role_id = this.role.id;
            }
            if( this.checkRoleStatus ){
                if( this.department != null ){
                    this.form.department_id = this.department.id;
                }
            }
        },
        submit(){
            this.formAssign();
            if(this.$parent.currentRecord != null){
                if(this.form.password!=this.form.password_confirmation){
                    swal("password and  confirm password doesn't match!");
                    return;
                }
            }
            this.isLoading = true;
            if (this.currentRecordId == null) {
                Spark.post('/api/user', this.form)
                    .then(response => {
                    console.log(response);
                this.$snotify.success(response.title, 'created!');
                this.showGrid();
                this.isLoading = false;
            })
            .catch(reason => {
                    this.$snotify.error(reason.message);
                this.isLoading = false;
            });
            } else {
                Spark.put('/api/user/'+ this.currentRecordId, this.form)
                    .then(response => {
                    console.log(response);
                this.$snotify.success(response.title, 'updated!');
                this.showGrid();
                this.isLoading = false;
            })
            .catch(reason => {
                    this.isLoading = false;
                this.$snotify.error(reason.message);
            });
            }

        },
        showGrid(){
            //console.log("child function");
            this.$parent.showGrid();
        }
    }
})
