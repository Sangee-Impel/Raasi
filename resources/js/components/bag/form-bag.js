import { VueEditor } from 'vue2-editor';
import VueSelect from 'vue-multiselect';
import vueFilePond from 'vue-filepond';
// Import FilePond styles
import 'filepond/dist/filepond.min.css';
// Import image preview and file type validation plugins
import FilePondPluginFileValidateType from 'filepond-plugin-file-validate-type';
import FilePondPluginImagePreview from 'filepond-plugin-image-preview';
import FilePondPluginImageResize from 'filepond-plugin-image-resize';
import FilePondPluginImageCrop from 'filepond-plugin-image-crop';
import FilePondPluginImageTransform from 'filepond-plugin-image-transform';
import FilePondPluginImageEdit from 'filepond-plugin-image-edit';
import FilePondPluginImageExifOrientation from 'filepond-plugin-image-exif-orientation';
import 'filepond/dist/filepond.min.css';
import 'filepond-plugin-image-preview/dist/filepond-plugin-image-preview.min.css';
let FilePondOptions = {
    url: '/upload',
    maxFilesize: 5,
    process: {
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
    },
    revert: {
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
    },
    load: {
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
    },
    restore: {
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
    },
    fetch: null
};
const ProfileFilePond = vueFilePond(
    FilePondPluginFileValidateType,
    FilePondPluginImageExifOrientation,
    FilePondPluginImagePreview,
    FilePondPluginImageCrop,
    FilePondPluginImageResize,
    FilePondPluginImageTransform,
    FilePondPluginImageEdit
);
Vue.component('form-bag', {
    components: {
        VueEditor,
        'v-select': VueSelect,
        'profile-file-pond': ProfileFilePond,
    },
    data() {
        return {
            viewerOptions: { "button": true, "navbar": false, "zoomable": true, "toolbar": true, "play": false },
            form: this.getFormData(),
            multiLoading: false,
            bagLoading: false,
            currentRecordId: null,
            isLoading: false,
            details: [],
            formTitle: 'Create',
            filePondOptions: FilePondOptions,
            currentFileUploadIndex: null,
            styleOptions: [],
            searchStyleString: "",
            searchBagString: "",
            viewedStyle: {},
            uom_options: [],
            display_style: false,
            parent_bag: null,
            bagOptions: [],
            isViewMode: false,
            isEditMode: false,
        }
    },
    created() {

        this.form.errors.forget(); //to reset validation errors
    },
    computed: {
        //hot key mapping, refer inline template view file for attribute {{v-hotkey="keymap"}}
        keymap() {
            return {
                'ctrl+enter': this.addStyle
            }
        },
    },
    mounted() {
        this.isViewMode = this.$parent.isViewMode;
        this.loadDropDown();
        if (this.$parent.currentRecord != null) {
            var record = this.$parent.currentRecord;
            this.form.bag_number = record.bag_number;
            this.form.order_number = record.order_number;
            this.form.instructions = record.instructions;
            this.form.bag_styles = record.bag_styles;
            this.parent_bag = record.parent_bag;
            this.formTitle = 'Update';
            this.currentRecordId = record.id;
        }
    },

    methods: {
        closeStyleModel() {
            this.display_style = false;
        },
        showStyleModel(selectedStyleIndex) {
            let selectedStyle = this.form.bag_styles[selectedStyleIndex];
            this.viewedStyle = {};

            if (selectedStyle.style != null) {
                selectedStyle.style.style_images_view = [];
                let style_images = selectedStyle.style.style_images;
                if (style_images.length > 0) {
                    for (var index in style_images) {
                        selectedStyle.style.style_images_view.push({ title: style_images[index].upload.file_name, url: style_images[index].upload.uploaded_path });
                    }
                }

                this.viewedStyle = selectedStyle.style;
            }

            this.display_style = true;
        },

        getFormData() {
            return new SparkForm({
                id: null,
                bag_number: "",
                parent_bag_id: "",
                order_number: "",
                instructions: "",
                bag_styles: []
            });
        },
        submit() {
            this.formAssign();
            this.isLoading = true;
            var method = this.currentRecordId == null ? Spark.post : Spark.put;
            let url = this.currentRecordId == null ? '/api/bag' : '/api/bag/' + this.currentRecordId;
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
        loadBag(query) {
            if ((query.length) >= 2) {
                this.bagLoading = true;
                this.searchBagString = query;
                this.searchBags(this);
            }
        },
        searchBags: _.debounce((self) => {
            let data = {
                q: self.searchBagString,
                id: self.form.id
            };
            axios.post('/api/bag/search', data)
                .then(response => {
                    self.bagOptions = response.data;
                })
                .catch(reason => {
                    swal("Something went wrong");
                })
                .finally(response => {
                    console.log("sad");
                    self.bagLoading = false;
                });
        }),
        loadStyles(query) {
            if ((query.length) >= 2) {
                this.multiLoading = true;
                this.searchStyleString = query;
                this.searchStyles(this);
            }
        },
        searchStyles: _.debounce((self) => {
            let data = {
                q: self.searchStyleString
            };
            axios.post('/api/style/search', data)
                .then(response => {
                    self.styleOptions = response.data;
                })
                .catch(reason => {
                    swal("Something went wrong");
                })
                .finally(response => {
                    console.log("sad");
                    self.multiLoading = false;
                });
        }),
        showGrid() {
            //console.log("child function");
            this.$parent.showGrid();
        },
        addStyle() {
            this.form.bag_styles.push({
                id: null,
                style_id: null,
                style: null,
                other_accessories: null,
                quantity: 1,
                weight: 0,
                upload_id: null,
                upload: "",
                instructions: "",

            });
        },
        changeBagStyle(index) {
            let selectedBag = this.form.bag_styles[index];
            /*if( selectedBag.style != null ){
                swal("ASD");
            }*/
            /*if( selectedBag.upload_id == null ){
                selectedBag.upload = selectedBag.style.upload;
                selectedBag.upload_id = selectedBag.style.upload_id;
            }*/

            console.log(selectedBag);

        },
        loadDropDown() {
            this.isLoading = true;
            axios.post('/api/get-dropdown-data')
                .then(response => {
                    let dropDownData = response.data;
                    if (dropDownData.product_category != null) {
                        this.product_category_options = dropDownData.product_category;
                    }
                    //
                })
                .catch(reason => {
                    console.log(reason.message);
                }).finally(() => {
                    this.isLoading = false;
                });
        },
        onFileUploadComplete(error, fileObject) {
            let file_details = JSON.parse(fileObject.serverId);
            let currentIndex = this.form.bag_styles[this.currentFileUploadIndex];
            if (currentIndex != undefined) {
                currentIndex['upload_id'] = file_details['id'];
                currentIndex['upload'] = file_details;
            }
        },
        removeBagStyle(index) {
            swal({
                title: "Are you sure?",
                text: "Do you want to delete bag style!",
                icon: "warning",
                buttons: true,
                dangerMode: true,
            }).then(isConfirm => {
                if (isConfirm) {
                    let removeFromArray = () => {
                        this.form.bag_styles.splice(index, 1);
                        swal("Bag style removed successfully!", 'Deleted');
                    };
                    let bagStyle = this.form.bag_styles[index];
                    console.log(bagStyle);
                    if (bagStyle['id'] != null) {
                        this.isLoading = true;
                        axios.delete('/api/bag/delete-bag-style/' + bagStyle['id'])
                            .then((responce) => {
                                removeFromArray();
                            })
                            .catch((reason) => {
                                this.$snotify.error(reason.message, 'Error!');
                            })
                            .finally(() => {
                                this.isLoading = false;
                            })
                    } else {
                        removeFromArray();
                    }
                }
            });
        },
        removeStyleUploadImage(index) {
            swal({
                title: "Are you sure?",
                text: "Do you want to delete Bag style image!",
                icon: "warning",
                buttons: true,
                dangerMode: true,
            }).then(isConfirm => {
                if (isConfirm) {
                    let style = this.form.bag_styles[index];
                    style.upload_id = null;
                    style.upload = null;
                    swal("Bag style image moved successfully!", 'Deleted');
                }
            });
        },

        formAssign() {
            this.form.parent_bag_id = null;
            if (this.parent_bag != null) {
                this.form.parent_bag_id = this.parent_bag.id;
            }
            let bag_styles = this.form.bag_styles;
            for (let index in bag_styles) {
                bag_styles[index].style_id = null;
                if (bag_styles[index].style != null) {
                    bag_styles[index].style_id = bag_styles[index].style.id;
                }
            }
        },
        onFileUploadStart(index) {
            this.currentFileUploadIndex = index;
        },

    }
})
