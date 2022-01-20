import { VueEditor } from 'vue2-editor';
import VueSelect from 'vue-multiselect';

Vue.component('form-casting', {
    components: {
        VueEditor,
        'v-select': VueSelect
    },
    data() {
        return {
            viewerOptions: { "button": true, "navbar": false, "zoomable": true, "toolbar": true, "play": false },
            form: this.getFormData(),
            multiLoading: false,
            castingLoading: false,
            currentRecordId: null,
            isLoading: false,
            details: [],
            formTitle: 'Create',
            searchAdjustmentString: "",
            searchCastingString: "",
            castingOptions: [],
            isViewMode: false,
            adjustmentOptions: [],
        }
    },
    created() {
        this.form.errors.forget(); //to reset validation errors
    },
    computed: {
        //hot key mapping, refer inline template view file for attribute {{v-hotkey="keymap"}}
        keymap() {
            return {
                'ctrl+enter': this.addWeight
            }
        },
    },
    mounted() {
        this.isViewMode = this.$parent.isViewMode;
        if (this.$parent.currentRecord != null) {
            var record = this.$parent.currentRecord;
            this.form.name = record.name;
            this.form.weight = record.weight;
            this.form.casting_weights = record.casting_weights;
            this.formTitle = 'Update';
            this.currentRecordId = record.id;
        }
    },
    methods: {
        getFormData() {
            return new SparkForm({
                id: null,
                name: "",
                weight: 0,
                casting_weights: []
            });
        },
        submit() {
            this.formAssign();
            this.isLoading = true;
            var method = this.currentRecordId == null ? Spark.post : Spark.put;
            let url = this.currentRecordId == null ? '/api/casting' : '/api/casting/' + this.currentRecordId;
            method(url, this.form)
                .then(response => {
                    this.$snotify.success(response.name, 'saved!');
                    if (response.length == 0) {
                        this.showGrid();
                    } else { this.form.weight = response.weight; }

                })
                .catch(reason => {
                    this.$snotify.error(reason.message);
                })
                .finally(() => {
                    this.isLoading = false;
                });
        },
        showGrid() {
            this.$parent.showGrid();
        },
        addWeight() {
            this.form.casting_weights.unshift({
                id: null,
                weight: 0,
                adjustment: null
            });
        },
        formAssign() {
            let casting_weights = this.form.casting_weights;            
        }
    }
});