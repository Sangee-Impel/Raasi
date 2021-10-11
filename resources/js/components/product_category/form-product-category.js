import {VueEditor} from 'vue2-editor';
import VueSelect from 'vue-multiselect';
Vue.component('form-product-category', {
    components: {
        VueEditor,
        'v-select': VueSelect,
    },
    data() {
        return {
            form: this.getFormData(),
            selected_parent_product_category:null,
            product_category_options:[],
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
            this.form.parent_product_category_id = record.parent_product_category_id;
            this.selected_parent_product_category         = record.parent_product_category;
            this.formTitle = 'Update';
            this.currentRecordId = record.id;
        }
    },

    methods: {
        getFormData(){
            return new SparkForm({
                parent_product_category_id:"",
                name: "",
                description: "",
            });
        },
        submit(){
            this.formAssign();
            this.isLoading = true;
            var method = this.currentRecordId == null ? Spark.post : Spark.put;
            let url = this.currentRecordId == null ? '/api/product-category' : '/api/product-category/' + this.currentRecordId;
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
            this.form.parent_product_category_id = null;
            if (this.selected_parent_product_category != null) {
                this.form.parent_product_category_id = this.selected_parent_product_category.id;
            }
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
