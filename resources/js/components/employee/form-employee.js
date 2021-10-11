import {VueEditor} from 'vue2-editor';
import VueSelect from 'vue-multiselect';
Vue.component('form-employee', {
    components: {
        VueEditor,
        'v-select': VueSelect,
    },
    data() {
        return {
            form: this.getFormData(),
            currentRecordId: null,
            isLoading: false,
            details: [],
            formTitle: 'Create',
            department_options: [],
            process_options: [],
            selected_department: null,
            selected_process: null
        }
    },
    created(){
        this.form.errors.forget(); //to reset validation errors
    },
    mounted(){
        this.loadDropDownData();
        if (this.$parent.currentRecord != null) {
            var record = this.$parent.currentRecord;
            this.form.name = record.name;
            this.form.code = record.code;
            this.form.description = record.description;
            this.form.department_id = record.department_id;
            this.form.employee_process = record.employee_process;
            this.selected_department = record.department;
            this.formTitle = 'Update';
            this.currentRecordId = record.id;
        }
    },

    methods: {
        checkDuplicateProcess: function(index) {
            let isValid = true;
            if( this.form.employee_process[index].process.id != undefined ){
                for( var employee_process_index in this.form.employee_process){
                    if( employee_process_index != index ){
                        if( this.form.employee_process[employee_process_index].process.id != undefined ){
                            if(this.form.employee_process[index].process.id == this.form.employee_process[employee_process_index].process.id){
                                isValid = false;
                            } 
                        }
                    }

                }
            }
            if(!isValid){
                this.form.employee_process[index].process = "";
                swal("Duplicate Process Selection");
            }
        },
        getFormData(){
            return new SparkForm({
                department_id: "",
                name: "",
                code: "",
                description: "",
                employee_process:[]
            });
        },
        submit(){
            this.formAssign();
            this.isLoading = true;
            var method = this.currentRecordId == null ? Spark.post : Spark.put;
            let url = this.currentRecordId == null ? '/api/employee' : '/api/employee/' + this.currentRecordId;
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
        loadDropDownData(){
            this.isLoading = true;
            axios.post('/api/get-dropdown-data')
                .then(response=> {
                    let dropDownData = response.data;
                    if (dropDownData.department != null) {
                        this.department_options = dropDownData.department;
                        this.process_options = dropDownData.process;
                    }
                })
                .catch(reason=> {
                    console.log(reason.message);
                }).finally(() => {
                this.isLoading = false;
            });
        },
        formAssign(){
            this.form.department_id = null;
            if (this.selected_department != null) {
                this.form.department_id = this.selected_department.id;
            }
        },
        addEmployeeProcess(){
            this.form.employee_process.push({id:0,process:""});
        },
        deleteEmployeeProcess(index){
            swal({
                title: "Are you sure?",
                text: "Do you want to delete employee process!",
                icon: "warning",
                buttons: true,
                dangerMode: true,
            }).then(isConfirm =>{
                if (isConfirm) {
                    let removeFromArray = ()=>{
                        this.form.employee_process.splice(index, 1);
                        swal("Employee Process removed successfully!", 'Deleted');
                    };
                    let deletedEmployeeProcess = this.form.employee_process[index];
                    if( deletedEmployeeProcess['id'] > 0 ){
                        this.isLoading = true;
                        axios.delete('/api/employee/delete-employee-process/'+deletedEmployeeProcess['id'])
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
        }
    }
})
