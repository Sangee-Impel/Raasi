@extends('layouts.login')

@section('content')
<div class="p-a-md box-color r box-shadow-z1 text-color m-a">
    <div class="m-b text-sm text-center">
        <img src="{{asset('images/impel_1.png')}}" alt="Company Logo" style="width: 80%">
    </div>
    @include('spark::shared.errors')
    <form role="form" name="form" id="sign_in" class="ui big form  fix-sui" method="POST" action="/custom-login">
        {{ csrf_field() }}
        <div class="field">
            <label>Email</label>
            <input type="email" class="md-input" name="email"  value="{{ old('email') }}"  autofocus required>
        </div>
        <div class="field">
            <label>Password</label>
            <input type="password" class="md-input" name="password" required>
        </div>
        <!--<div class="md-form-group float-label">
            <input type="password" class="md-input" name="password" required>
            <label>Password</label>
        </div>-->
        <button type="submit" class="btn primary btn-block p-x-md">Sign in</button>
        <!--<div class="col-xs-8 align-left">
            <a href="{{ url('/password/reset') }}">Forgot Password?</a>
        </div>-->
    </form>
    <!--<div class="p-v-lg text-center">
        <div class="m-b"><a ui-sref="access.forgot-password" href="{{ url('/password/reset') }}" class="text-primary _600">Forgot password?</a></div>
    </div>-->
</div>
@endsection
