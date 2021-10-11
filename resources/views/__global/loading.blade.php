
<!-- Page Loader -->
<!--<div class="page-loader-wrapper" v-show="isLoading">
    <div class="loader">
        <div class="preloader">
            <div class="spinner-layer pl-red">
                <div class="circle-clipper left">
                    <div class="circle"></div>
                </div>
                <div class="circle-clipper right">
                    <div class="circle"></div>
                </div>
            </div>
        </div>
        <p>Please wait...</p>
    </div>
</div>-->
<div class="overlay" v-show="isLoading">
    <div class="loading">
        <i class="fa fa-refresh fa-6 fa-spin"></i> <span> Loading ... </span>
    </div>
</div>
<!-- #END# Page Loader -->