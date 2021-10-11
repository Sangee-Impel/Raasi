import {VueEditor} from 'vue2-editor';
import VueSelect from 'vue-multiselect';
Vue.component('form-uom', {
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
            this.formTitle = 'Update';
            this.currentRecordId = record.id;
        }
    },

    methods: {
        getFormData(){
            return new SparkForm({
                name: "",
                description: "",
            });
        },
        submit(){
            this.isLoading = true;
            var method = this.currentRecordId == null ? Spark.post : Spark.put;
            let url = this.currentRecordId == null ? '/api/uom' : '/api/uom/' + this.currentRecordId;
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
        loadDropDown(){
            this.isLoading = true;
            axios.post('/api/get-dropdown-data')
                .then(response=> {
                    let dropDownData = response.data;
                    if (dropDownData.product_category != null) {
                        this.product_category_options = dropDownData.product_category;
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
