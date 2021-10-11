import Datetime from 'vue-ctk-date-time-picker';
import VueSelect from 'vue-multiselect';
Vue.component('manage-tally-report', {

    components : {
        'v-date-picker'   : Datetime,
        'v-select': VueSelect,
    },
    data() {
        return {
            isLoading       : false,
            form            : this.getFormData(),
            transaction_histories : [],
            transaction_sum :   {
                total_loss : 0,
                total_receive_weight : 0,
                total_scrab : 0,
                total_transfer_quantity : 0,
                total_transfer_weight : 0,
            }

        };
    },
    created(){

    },
    beforeDestroy(){

    },
    mounted(){
        console.log("list");


        // this.isLoading = false;
    },

    computed:{

    },

    methods : {
        getFormData(){
            return new SparkForm({
                date      :   null,
            });
        },
        changeTabStatus(status){
            this.form.tab_status = status;
        },
        getTransactionHistory(){
            this.isLoading = true;

            Spark.post('/api/tally-report', this.form)
                .then(response => {
                    let data = response;
                    this.transaction_histories = data.transaction_data;
                    this.transaction_sum.total_loss = data.transaction_sum.total_loss;
                    this.transaction_sum.total_receive_weight = data.transaction_sum.total_receive_weight;
                    this.transaction_sum.total_scrab = data.transaction_sum.total_scrab;
                    this.transaction_sum.total_transfer_quantity = data.transaction_sum.total_transfer_quantity;
                    this.transaction_sum.total_transfer_weight = data.transaction_sum.total_transfer_weight;
                })
                .catch(reason => {
                    this.$snotify.error(reason.message);
                })
                .finally(() => {
                    this.isLoading = false;
                });
        },
        onViewTransferItem(index){
            this.transaction_items = this.transaction_histories[index].transaction_items;
            this.transferItemViewToggle();
        },
        transferItemViewToggle() {
            this.transferItemModal = !this.transferItemModal;
        },
    }
});
