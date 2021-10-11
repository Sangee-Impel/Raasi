import Vuetify from 'vuetify';
import 'material-design-icons-iconfont/dist/material-design-icons.css'
import VTreeview from "v-treeview"
Vue.use(Vuetify, {
    iconfont: 'md'
});
Vue.use(Vuetify);
let rolesForm;
rolesForm = new SparkForm({
    /* slug: '',*/
    name:'',
    permission_id:[]

});
Vue.component('form-roles', {
    components: {Vuetify},
    data() {
        return {
            form: rolesForm,
            options:[],
            currentRecordId : null,
            isLoading : false,
            formTitle:''
        }
    },
    created(){
        this.form.errors.forget(); //to reset validation errors
    },
    mounted(){
        if(this.$parent.currentRecord != null){
            var record = this.$parent.currentRecord;
            console.log(this.$parent.currentRecord);
            console.log("sridhar");
            this.form.name = record.name;
            /* this.form.slug = record.slug;*/
            this.currentRecordId = record.id;
            this.form.permission_id=[];
            for (var x in record.permission_role){
                var value =record.permission_role[x].permission_id;
                this.form.permission_id.push(value);
            }
            this.formTitle = 'Update';
        }else{
            this.formTitle = 'Create';
            this.form.name = null;
            /*  this.form.slug = null;*/
            this.form.permission_id=[];
            this.currentRecordId = null;
        }

    },
    methods : {

        submit(){

            this.isLoading = true;
            if (this.currentRecordId == null) {
                Spark.post('/api/roles', this.form)
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
                Spark.put('/api/roles/'+ this.currentRecordId, this.form)
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
        },
        CheckAll(array,status){
            this.form.permission_id=[];
            if(status) {
                this.form.permission_id = _.map(array, function (indx) {
                    return indx.id;
                });

            }
        }


    }
})
