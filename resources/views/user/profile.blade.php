@extends('layouts.home')

@section('content')
<profile-user inline-template>
    <div class="padding">
        <input type="hidden"  id="user_id" value="{{$user_id}}">
        <div  v-if="displayForm">
            <div>
                @include('user.form')
            </div>
        </div>
    </div>
</profile-user>

@endsection
