import FieldDefs from './field-defs'

Vue.component('sidebar', {

    components : {},
    data() {
        return {
            fields          : FieldDefs,
            user            :   {},
            userPermissions :   {},
            isLoading       :   false,
            activeClass     :   "active",
            displayBlock    :   "d-block",
            displayNone    :   "d-none",
            activeElement   :   null,
            
        };
    },

    created(){
        var currentUrl = window.location.pathname;
        currentUrl = currentUrl.replace("#","");
        var sideBarData = this.fields;
        if( sideBarData.length > 0 ){
            for( let index in sideBarData ){
                if( sideBarData[index].href == currentUrl && currentUrl != "#"){
                    sideBarData[index].dataClass += " active";
                }
                let children  = sideBarData[index].childrens;
                if( children.length > 0 ){
                    for( let childIndex in children ){
                        if( children[childIndex].href == currentUrl ){
                            sideBarData[index].dataClass += " active";
                            children[childIndex].dataClass += " active";
                        }
                    }
                }
            }
        }
    },
    beforeDestroy(){

    },
    mounted(){
        this.getUserPermissionData();
        this.user = this.$parent.user;
        this.user.photo_url = this.user.photo_url.substring(this.$parent.user.photo_url.indexOf('storage/'));
    },
    computed:{
        getChildCss(){
            return (item) => {
                let css = "list-unstyled ";
                if( this.$parent.sideBarActiveElement == item.name ){
                    css += this.displayBlock+" ";
                }else{
                    css += this.displayNone+" ";
                }
                css += item.name+" ";
                return css;
            }
        },
        getSliderCss(){
            let sideBarCss = "";
            if( this.$parent.sideBarActiveElement != null ){
                //block to check the
                var sideBarData = this.fields;
                if( sideBarData.length > 0 ){
                    for( let index in sideBarData ){
                        if(sideBarData[index].name == this.$parent.sideBarActiveElement){
                            if( sideBarData[index].childrens.length > 0 ){
                                sideBarCss += this.displayBlock+" "+this.$parent.sideBarActiveElement+" ";
                            }
                        }
                    }
                }
            }
            return sideBarCss;
        },

    },

    methods : {
        /*function for check user has permission or not..!*/
        getUserPermissionData(){
            this.isLoading = true;
            axios.post('/api/roles/gerUserPermission',{})
                .then(response=>{
                    this.userPermissions =  response.data;
                    var sideBarData = this.fields;
                    if( sideBarData.length > 0 ){
                        for( let index in sideBarData ){
                            let parentHasPermission = false;
                            let children  = sideBarData[index].childrens;
                            if( children.length > 0 ){
                                for( let childIndex in children ){
                                    children[childIndex].has_permission = this.checkPermission(children[childIndex].permission_slug);
                                    if(!parentHasPermission)
                                        parentHasPermission = children[childIndex].has_permission;
                                }
                                sideBarData[index].has_permission = parentHasPermission;
                            }else
                                sideBarData[index].has_permission = this.checkPermission(sideBarData[index].permission_slug);
                        }
                    }
                })
                .catch(reason=> {
                    console.log(reason.message);
                })
                .finally(response=>{
                    this.isLoading = false;
                });
            
        },
        /*
        * if slug contain empty mean's it is in white list no need permission*/
        checkPermission(permission_slug){
            let hasPermission   =   false;
            let userPermissions = this.userPermissions;
            if( permission_slug == "")
                hasPermission = true;
            if( !hasPermission ){
                for( let userPermission in userPermissions ){
                    if( permission_slug == userPermissions[userPermission].slug )
                        hasPermission = true;
                }
            }
            return hasPermission;
        },
        showSlider(item){
            this.$parent.sideBarActiveElement = item.name;
        },
    }
});
