@extends('layouts.login')

<!-- Main Content -->
@section('content')
<div class="card">
    <div class="header">{{__('Resets Password')}}</div>
    <div class="body">
        @if (session('status'))
        <div class="alert alert-success">
            {{ session('status') }}
        </div>
        @endif
        <form id="forgot_password"  role="form" method="POST" action="{{ url('/password/email') }}">
            <div class="msg">
                Enter your email address, We'll send you an email with an
                link to reset your password.
            </div>
            {!! csrf_field() !!}
            <div class="input-group">
                <span class="input-group-addon">
                    <i class="material-icons">email</i>
                </span>
                <div class="form-line">
                    <input type="email" class="form-control" name="email" placeholder="Username" value="{{ old('email') }}"  autofocus>
                </div>
                @if ($errors->has('email'))
                <span class="invalid-feedback">
                    {{ $errors->first('email') }}
                </span>
                @endif
            </div>
            <button class="btn btn-block btn-lg bg-pink waves-effect" type="submit">RESET PASSWORD</button>
            <div class="clearfix"></div>
            <div class="row m-t-20 m-b--5 align-center">
                <div class="col-xs-8 align-left">
                    <a href="/login">Sign In!</a>
                </div>

            </div>
        </form>
    </div>
</div>

@endsection
