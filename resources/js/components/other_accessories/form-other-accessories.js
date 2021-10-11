import {VueEditor} from 'vue2-editor';
import VueSelect from 'vue-multiselect';
Vue.component('form-other-accessories', {
    components: {
        VueEditor,
        'v-select': VueSelect,
    },
    data() {
        return {
            form: this.getFormData(),
            selected_uom:null,
            uom_options:[],
            currentRecordId: null,
            isLoading: false,
            details: [],
            formTitle: 'Create',


        }
    },
    created(){

        this.form.errors.forget(); //to reset validation errors
    },
    mounted(){
        this.loadDropDown();
        if (this.$parent.currentRecord != null) {
            var record = this.$parent.currentRecord;
            this.form.name = record.name;
            this.form.description = record.description;
            this.form.uom_id = record.uom_id;
            this.selected_uom = record.uom;
            this.formTitle = 'Update';
            this.currentRecordId = record.id;
        }
    },

    methods: {
        getFormData(){
            return new SparkForm({
                name: "",
                uom_id: "",
                description: "",
            });
        },
        submit(){
            this.formAssign();
            this.isLoading = true;
            var method = this.currentRecordId == null ? Spark.post : Spark.put;
            let url = this.currentRecordId == null ? '/api/other-accessories' : '/api/other-accessories/' + this.currentRecordId;
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
        formAssign(){
            if( this.selected_uom != null ){
                this.form.uom_id = this.selected_uom.id;
            }
        },
        loadDropDown(){
            this.isLoading = true;
            axios.post('/api/get-dropdown-data')
                .then(response=> {
                    let dropDownData = response.data;
                    if (dropDownData.uom != null) {
                        this.uom_options = dropDownData.uom;
                    }
                    //
                })
                .catch(reason=> {
                    console.log(reason.message);
                }).finally(() => {
                this.isLoading = false;
            });
        },

    }
})
