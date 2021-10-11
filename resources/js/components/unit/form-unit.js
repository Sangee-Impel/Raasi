import { VueEditor } from 'vue2-editor'
Vue.component('form-unit', {
    components: {
        VueEditor,

    },
    data() {
        return {
            form: this.getFormData(),
            currentRecordId : null,
            isLoading : false,
            details: [],
            formTitle:'Create',


        }
    },
    created(){

        this.form.errors.forget(); //to reset validation errors
    },
    mounted(){
        if(this.$parent.currentRecord != null){
            var record                    = this.$parent.currentRecord;
            this.form.name                = record.name;
            this.form.description         = record.description;
            this.formTitle                = 'Update';
            this.currentRecordId          = record.id;
           }
    },

    methods : {
    getFormData(){
    return new SparkForm({
        name : "",
        description : ""
        });
       },
        submit(){
            this.isLoading = true;
            var method = this.currentRecordId == null ? Spark.post : Spark.put;
            let url = this.currentRecordId == null ? '/api/unit' : '/api/unit/'+this.currentRecordId;
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
        }
    }
})
