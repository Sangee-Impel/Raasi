import {VueEditor} from 'vue2-editor';
import VueSelect from 'vue-multiselect';
import vueFilePond from 'vue-filepond';
import Avatar from 'vue-avatar';
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
    maxFilesize : 5,
    process: {
        headers:{
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
    },
    revert: {
        headers:{
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
    },
    load: {
        headers:{
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
    },
    restore: {
        headers:{
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
    },
    fetch:null
};
const ProfileFilePond = vueFilePond(
    FilePondPluginFileValidateType,
    FilePondPluginImageExifOrientation,
    FilePondPluginImageResize
);
Vue.component('form-product', {
    components: {
        VueEditor,
        'v-select': VueSelect,
        'file-pond':ProfileFilePond,
        Avatar,
    },
    data() {
        return {
            viewerOptions:{"button": true,"navbar": false,"zoomable":true,"toolbar":true,"play":false },
            form: this.getFormData(),
            currentRecordId: null,
            isLoading: false,
            details: [],
            formTitle: 'Create',
            product_category_options: [],
            uom_options             : [],
            department_options      : [],
            selected_product_category: null,
            filePondOptions         : FilePondOptions,
            currentFileUploadIndex  : null,



        }
    },
    created(){

        this.form.errors.forget(); //to reset validation errors
    },
    computed: {
        //hot key mapping, refer inline template view file for attribute {{v-hotkey="keymap"}}
        keymap () {
            return {
                'ctrl+enter':this.addStyle
            }
        },
    },
    mounted(){
        this.loadDropDown();
        if (this.$parent.currentRecord != null) {
            var record = this.$parent.currentRecord;
            this.form.name = record.name;
            this.form.description = record.description;
            this.form.product_category_id = record.product_category_id;
            this.form.styles = record.styles;
            this.selected_product_category         = record.product_category;
            this.formTitle = 'Update';
            this.currentRecordId = record.id;
        }
    },

    methods: {
        getFormData(){
            return new SparkForm({
                product_category_id: "",
                name: "",
                description: "",
                styles : []
            });
        },
        submit(){
            this.formAssign();
            this.isLoading = true;
            var method = this.currentRecordId == null ? Spark.post : Spark.put;
            let url = this.currentRecordId == null ? '/api/product' : '/api/product/' + this.currentRecordId;
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
                    if (dropDownData.uom != null) {
                        this.uom_options = dropDownData.uom;
                    }
                    if (dropDownData.department != null) {
                        this.department_options = dropDownData.department;
                    }
                    console.log(response.data);
                    //
                })
                .catch(reason=> {
                    console.log(reason.message);
                }).finally(() => {
                this.isLoading = false;
            });
        },
        addStyle(){
            this.form.styles.push({
                id          :   null,
                sku         :   '',
                weight      :   '',
                upload_id   :   null,
                upload      :   '',
                uom_id      :   null,
                uom         :   null,
                style_department_loss_approval : [],
                style_images:[],
            });
        },
        addStyleDepartmentLossApproval(index){
            this.form.styles[index].style_department_loss_approval.push({
                id          :   null,
                department_id      :   null,
                department         :   null,
                percentage         :   0,
            });
        },
        formAssign(){
            this.form.product_category_id = null;
            if (this.selected_product_category != null) {
                this.form.product_category_id = this.selected_product_category.id;
            }
            let styles = this.form.styles;
            for( let index in styles ){
                styles[index].uom_id = null;
                if(styles[index].uom != null)
                    styles[index].uom_id = styles[index].uom.id;
                let style_department_loss_approval = styles[index].style_department_loss_approval;
                if( style_department_loss_approval.length > 0 ){
                    for( let style_department_loss_index in style_department_loss_approval ){
                        style_department_loss_approval[style_department_loss_index].department_id = null;
                        if(style_department_loss_approval[style_department_loss_index].department != null)
                            style_department_loss_approval[style_department_loss_index].department_id = style_department_loss_approval[style_department_loss_index].department.id;
                    }
                }
            }
        },
        onFileUploadComplete(error, fileObject){
            let file_details = JSON.parse(fileObject.serverId);
            this.form.styles[this.currentFileUploadIndex].style_images.push({
                id:null,
                upload_id : file_details['id'],
                upload  : file_details
            });
        },
        removeStyleUploadImages(index,styleImage){
            swal({
                title: "Are you sure?",
                text: "Do you want to delete style image!",
                icon: "warning",
                buttons: true,
                dangerMode: true,
            }).then(isConfirm =>{
                if( isConfirm ){
                    let removeFromArray = ()=>{
                        this.form.styles[index].style_images.splice(styleImage, 1);
                        swal("Style image moved successfully!", 'Deleted');
                    };
                    let selectedImage = this.form.styles[index].style_images[styleImage];
                    console.log(selectedImage);
                    if( selectedImage['id'] != null){
                        //#need to throw ajax call....!
                        this.isLoading = true;
                        axios.delete('/api/product/delete-product-style-image/'+selectedImage['id'])
                            .then((responce)=>{
                                removeFromArray();
                            })
                            .catch((reason)=>{
                                this.$snotify.error(reason.message, 'Error!');
                            })
                            .finally(()=>{
                                this.isLoading = false;
                            })

                    }else{
                        removeFromArray();
                    }


                }
            });
        },
        onFileUploadStart(index){
            this.currentFileUploadIndex = index;
        },
        removeStyle(index){
            swal({
                title: "Are you sure?",
                text: "Do you want to delete product style!",
                icon: "warning",
                buttons: true,
                dangerMode: true,
            }).then(isConfirm =>{
                if( isConfirm ){
                    let removeFromArray = ()=>{
                        this.form.styles.splice(index, 1);
                        swal("Product style removed successfully!", 'Deleted');
                    };
                    let style = this.form.styles[index];
                    if( style['id'] != null ){
                        this.isLoading = true;
                        axios.delete('/api/product/delete-product-style/'+style['id'])
                            .then((responce)=>{
                                removeFromArray();
                            })
                            .catch((reason)=>{
                                this.$snotify.error(reason.message, 'Error!');
                            })
                            .finally(()=>{
                                this.isLoading = false;
                            })
                    }else{
                        removeFromArray();
                    }
                }
            });
        },
        removeStyleDepartmentLoss(index,style_department_loss_index){
            swal({
                title: "Are you sure?",
                text: "Do you want to delete product style department losses!",
                icon: "warning",
                buttons: true,
                dangerMode: true,
            }).then(isConfirm =>{
                if( isConfirm ){
                    let removeFromArray = ()=>{
                        this.form.styles[index].style_department_loss_approval.splice(style_department_loss_index, 1);
                        swal("Product style department losses removed successfully!", 'Deleted');
                    };
                    let styleDepartment = this.form.styles[index].style_department_loss_approval[style_department_loss_index];
                    if( styleDepartment['id'] != null ){
                        this.isLoading = true;
                        axios.delete('/api/product/delete-product-style-department-loss/'+styleDepartment['id'])
                            .then((responce)=>{
                                removeFromArray();
                            })
                            .catch((reason)=>{
                                this.$snotify.error(reason.message, 'Error!');
                            })
                            .finally(()=>{
                                this.isLoading = false;
                            })
                    }else{
                        removeFromArray();
                    }
                }
            });
        },
        removeStyleUploadImage(index){
            swal({
                title: "Are you sure?",
                text: "Do you want to delete product style image!",
                icon: "warning",
                buttons: true,
                dangerMode: true,
            }).then(isConfirm =>{
                if( isConfirm ){
                    let style = this.form.styles[index];
                    style.upload_id = null;
                    style.upload = null;
                    //this.form.styles.splice(index, 1);
                    swal("Product style image moved successfully!", 'Deleted');
                }
            });
        },
        checkDuplicateDepartment(index,style_department_loss_index){
            let isValid = true;
            let style_department_loss_approval = this.form.styles[index].style_department_loss_approval;
            let selectedDepartment = style_department_loss_approval[style_department_loss_index].department;
            if( selectedDepartment != null ){
                if( style_department_loss_approval.length > 0 ){
                    for( var loopDepartmentIndex in style_department_loss_approval ){
                        if( isValid ){
                            let loopDepartment = style_department_loss_approval[loopDepartmentIndex].department;
                            if( ( style_department_loss_index != loopDepartmentIndex ) && ( loopDepartment != null)){
                                if( selectedDepartment.id  == loopDepartment.id ){
                                    isValid = false;
                                }
                            }
                        }
                    }
                }
            }
            if( !isValid ){
                swal("Department already picked");
                this.form.styles[index].style_department_loss_approval[style_department_loss_index].department = null;
            }
        }
    }
})
