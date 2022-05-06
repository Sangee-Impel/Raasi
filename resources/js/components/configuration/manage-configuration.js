import { VueEditor } from 'vue2-editor';
import VueSelect from 'vue-multiselect';

Vue.component('manage-configuration', {
    components: {
        VueEditor,
        'v-select': VueSelect,

    },
    data() {
        return {
            form: this.getFormData(),
            department_options: [],
            isLoading: false,
            formTitle: 'Create',
        };
    },

    created() {
        this.form.errors.forget(); //to reset validation errors
    },
    beforeDestroy() {

    },

    mounted() {
        this.getConfigurationData();
    },

    computed: {

    },

    methods: {
        getConfigurationData() {
            this.isLoading = true;
            axios.post('/api/configuration/get-configuration-data', {})
                .then(response => {
                    let data = response.data;
                    let alreadyConfigurationValue = data.configration;
                    this.department_options = data.departments;
                    if (alreadyConfigurationValue.length > 0) {
                        for (var index = 0; index <= alreadyConfigurationValue.length; index++) {
                            let configrationIndex = alreadyConfigurationValue[index];
                            switch (configrationIndex.config_key) {
                                case "precision":
                                    this.form.precision.config_value = configrationIndex.config_value;
                                    break;
                                case "bag_starting_department":
                                    this.form.bag_starting_department.department = configrationIndex.bag_starting_department;
                                    break;
                                case "otp_number_1":
                                    this.form.otp_number_1.config_value = configrationIndex.config_value;
                                    break;
                                    case "otp_number_2":
                                        this.form.otp_number_2.config_value = configrationIndex.config_value;
                                        break;
                                default:
                                    this.form.bag_cancel_number.config_value = configrationIndex.config_value;
                                    break;
                                //this.form.precision = config_value;
                            }
                        }
                    }
                })
                .catch(reason => {
                    //this.$snotify.error(reason.message);
                })
                .finally(() => {
                    this.isLoading = false;
                });
        },
        getFormData() {
            return new SparkForm({
                precision: {
                    config_value: ""
                },
                bag_cancel_number: {
                    config_value: ""
                },
                otp_number_1: {
                    config_value: ""
                },
                otp_number_2: {
                    config_value: ""
                },
                bag_starting_department: {
                    department: null,
                    bag_starting_department_id: null,
                    config_value: 0
                },

            });
        },
        submit() {
            this.formAssign();
            this.isLoading = true;
            Spark.post('/api/configuration/save', this.form)
                .then(response => {
                    this.$snotify.success(response.name, 'saved!');

                })
                .catch(reason => {
                    this.$snotify.error(reason.message);
                })
                .finally(() => {
                    this.isLoading = false;
                });
        },
        formAssign() {
            this.form.bag_starting_department.bag_starting_department_id = null;
            if (this.form.bag_starting_department.department != null) {
                this.form.bag_starting_department.bag_starting_department_id = this.form.bag_starting_department.department.id;
            }
        },

    }
});
