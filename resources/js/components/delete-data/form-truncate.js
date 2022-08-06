import { VueEditor } from 'vue2-editor';
import VueSelect from 'vue-multiselect';
Vue.component('form-truncate', {
    components: {
        VueEditor,
        'v-select': VueSelect
    },
    data() {
        return {
            viewerOptions: { "button": true, "navbar": false, "zoomable": true, "toolbar": true, "play": false },
            form: this.getFormData(),
        }
    },
    methods: {
        getFormData() {
            return new SparkForm({
                id: null,
                name: "",
                weight: 0,
            });
        },
        submit() {
            var method = Spark.post;
            let url = '/api/delete-data';
            method(url, this.form)
                .then(response => {
                    this.$snotify.success(response.name, 'Data truncated successfully');
                })
                .catch(reason => {
                    this.$snotify.error(reason.message);
                })
                .finally(() => {
                    this.isLoading = false;
                });
        }
    }
})