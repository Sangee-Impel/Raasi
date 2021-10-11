import { VueEditor } from 'vue2-editor';
import VueSelect from 'vue-multiselect';
import TypeDefs from './type-defs'
Vue.component('form-department', {
    components: {
        VueEditor,
        'v-select'                  :   VueSelect,
    },
    data() {
        return {
            type_defs: TypeDefs,
            form: this.getFormData(),
            currentRecordId : null,
            isLoading : false,
            details: [],
            formTitle:'Create',
            unit_options:[],
            selected_unit:null,
            is_last:false,//this.TypeDefs.findDepartmentType("not_is_last","name")['value']
        }
    },
    created(){

        this.form.errors.forget(); //to reset validation errors
    },
    mounted(){
        this.loadUnits();
        if(this.$parent.currentRecord != null){
            var record                    = this.$parent.currentRecord;
            this.form.name                = record.name;
            this.form.description         = record.description;
            this.form.unit_id             = record.unit_id;
            this.form.is_last             = record.is_last;
            this.is_last                  = this.type_defs.findDepartmentType(record.is_last,"id")['value'];
            this.selected_unit          = record.unit;
            this.formTitle                = 'Update';
            this.currentRecordId          = record.id;
           }
    },

    methods : {
    getFormData(){
        return new SparkForm({
            unit_id:"",
            name : "",
            description : "",
            is_last:0//this.type_defs.findDepartmentType("not_is_last","name")['id'],
           });
          },
            submit(){

                this.formAssign();
                this.isLoading = true;
                var method = this.currentRecordId == null ? Spark.post : Spark.put;
                let url = this.currentRecordId == null ? '/api/department' : '/api/department/'+this.currentRecordId;
                method(url, this.form)
                                .then(response => {
                                    this.$snotify.success(response.name, 'saved!');
                                    this.showGrid();
                        })
                        .catch(reason => {
                                this.$snotify.error(reason.message);
                            })
                            .finally(() => {this.isLoading = false;});
               },
            showGrid(){
                //console.log("child function");
                this.$parent.showGrid();
            },
            loadUnits(){
            this.isLoading = true;
                        axios.post('/api/get-units')
                            .then(response=>{
                                this.unit_options = response.data;
                            })
                            .catch(reason=> {
                                console.log(reason.message);
                            }).finally(() => {this.isLoading = false;});
                     },
                    formAssign(){
                        this.form.unit_id   = null;
                        if( this.selected_unit != null ){
                            this.form.unit_id   =  this.selected_unit.id;
                        }
                        this.form.is_last = this.type_defs.findDepartmentType("not_is_last","name")['id'];
                        if( this.is_last ){
                            this.form.is_last = this.type_defs.findDepartmentType("is_last","name")['id'];
                        }
                    }
    }
})
