
/*
 |--------------------------------------------------------------------------
 | Laravel Spark Bootstrap
 |--------------------------------------------------------------------------
 |
 | First, we will load all of the "core" dependencies for Spark which are
 | libraries such as Vue and jQuery. This also loads the Spark helpers
 | for things such as HTTP calls, forms, and form validation errors.
 |
 | Next, we'll create the root Vue application for Spark. This will start
 | the entire application and attach it to the DOM. Of course, you may
 | customize this script as you desire and load your own components.
 |
 */

require('spark-bootstrap');

require('./components/bootstrap');


import SuiVue from 'semantic-ui-vue';

import TrashFieldDefs from './components/__globals/trash_fields';

import swal from 'sweetalert';

import 'viewerjs/dist/viewer.css'
import Viewer from 'v-viewer'


Vue.use(Viewer);
Vue.use(SuiVue);
import vGallery from 'v-gallery'
Vue.use(vGallery)



import Snotify, { SnotifyPosition } from 'vue-snotify'
const options = {
    toast: {
        position: SnotifyPosition.rightTop,
    },
    timeout: 5000
}

Vue.use(Snotify, options)

// import "vue-snotify/styles/simple.css";
import "vue-snotify/styles/material.css";

import VueHotkey from 'v-hotkey'
Vue.use(VueHotkey)

//https://github.com/euvl/vue-js-modal/blob/master/README.md
import VModal from 'vue-js-modal'

Vue.use(VModal)


import PrettyInput from 'pretty-checkbox-vue/input';
import PrettyCheck from 'pretty-checkbox-vue/check';
import PrettyRadio from 'pretty-checkbox-vue/radio';

Vue.component('p-input', PrettyInput);
Vue.component('p-check', PrettyCheck);
Vue.component('p-radio', PrettyRadio);



import VTooltip from 'v-tooltip'
Vue.use(VTooltip)



var app = new Vue({
    mixins: [require('spark')],
    data(){
        return {
            trashFields      :TrashFieldDefs,
            displayNewTicket : false,
            isLoading : true, refCount:0,
            sideBarActiveElement : null,
        }
    },
    mounted() {
        document.addEventListener('click', this.onClick);
    },
    created() {
        axios.interceptors.request.use((config) => {
            // trigger 'loading=true' event here
            this.setLoading(true);
            return config;
        }, (error) => {
            this.setLoading(false);
            // trigger 'loading=false' event here
            return Promise.reject(error);
        });

        axios.interceptors.response.use((response) => {
            // trigger 'loading=false' event here
            this.setLoading(false);
            return response;
        }, (error) => {
            this.setLoading(false);
            // trigger 'loading=false' event here
            return Promise.reject(error);
        });
    },
    methods : {
        setLoading(isLoading) {
            if (isLoading) {
                this.refCount++;
                this.isLoading = true;
            } else if (this.refCount > 0) {
                this.refCount--;
                this.isLoading = (this.refCount > 0);
                if(!this.isLoading){
                    console.log("Loading done")
                }
            }
        },
        onClick(event) {
            var $trigger = $(".main-menu");
            if($trigger !== event.target && !$trigger.has(event.target).length){
                this.sideBarActiveElement = null;
            }
        }
    }
});
