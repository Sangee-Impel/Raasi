import Datetime from 'vue-ctk-date-time-picker';
import VueCtkDateTimePicker from 'vue-ctk-date-time-picker';
import 'vue-ctk-date-time-picker/dist/vue-ctk-date-time-picker.css';
import VueSelect from 'vue-multiselect';
import { ToggleButton } from 'vue-js-toggle-button';
import { VueEditor } from 'vue2-editor'
import VueTagsInput from '@johmun/vue-tags-input';

Vue.component('form-reason', {
    components: {
        VueEditor
    },
    data() {
        return {
            formTitle : 'Create',
            currentRecordId:null,
            form: this.getFormData(),
            isLoading : false,
        }
    },
    created(){
        this.form.errors.forget(); //to reset validation errors
    },
    mounted(){
        if(this.$parent.currentRecord != null){
            this.formTitle = 'Update';
            var record = this.$parent.currentRecord;
            this.form.name = record.name;
            this.form.code = record.code;
            this.form.description = record.description;
            this.currentRecordId = record.id;
        }
    },
    methods : {
        getFormData(){
            return new SparkForm({
                code : "",
                name : "",
                description : ""
            });
        },
        
        submit() {
            this.isLoading = true;
            var method = this.currentRecordId == null ? Spark.post : Spark.put;
            let url = this.currentRecordId == null ? '/api/reason' : '/api/reason/'+this.currentRecordId;
            method(url, this.form)
                .then(response => {
                    this.$snotify.success(response.name, 'saved!');
                    this.showGrid();
                    this.isLoading = false;
        })
        .catch(reason => {
                this.$snotify.error(reason.message);
            this.isLoading = false;
        });
        },
        showGrid(){
            //console.log("child function");
            this.$parent.showGrid();
        },
    }
})
