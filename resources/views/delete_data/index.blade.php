@extends('layouts.home')

@section('content')
<manage-delete-data inline-template>
    <div class="padding">
        @include('__global.loading')
        <div class="sub_content_custom_form">
            <div>Are you sure want to delete data</div>
            <button class="btn btn-fw success" v-show="!isFormLoading" @click="actionSendOtp">Send OTP</button>
        </div>
        <form-truncate inline-template ref="roleForm" class="sub_content" v-show="isFormLoading">
            <form class="sub_content_custom_form">
                <div class="">
                    <input type="number" placeholder="Please enter OTP here" v-model="form.otp" name="otp">
                </div>
                <button class="btn btn-fw success" type="button" @click="submit">Submit</button>
            </form>
        </form-truncate>
    </div>
</manage-delete-data>
@endsection