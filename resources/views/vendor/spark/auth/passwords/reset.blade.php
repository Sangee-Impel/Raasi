@extends('layouts.login')

@section('content')

<div class="p-a-md box-color r box-shadow-z1 text-color m-a">
    <div class="row">
        <div class="col-sm-12 col-md-12 col-lg-12">
            <div class="box">
                <div class="box-header">
                    <div class="row">
                        <div class="col-lg-12">
                            <h2 class="pt-1">{{__('Resets Password')}}</h2>
                        </div>
                    </div>
                </div>
            </div>
            <div class="box-body">
                <div class="row">
                    <div class="col-lg-12">
                        <form role="form"class="ui form fix-sui" method="POST" action="{{ url('/reset/passwords') }}">
                            {!! csrf_field() !!}
                            <input type="hidden" name="token" value="{{ $token }}">
                            <div class="field">
                                <label>Email </label>
                                <input type="email" class="form-control {{ $errors->has('email') ? ' is-invalid' : '' }}" name="email" placeholder="Email Id" value="{{ $email ?? old('email') }}" readonly autofocus>
                                @if ($errors->has('email'))
                                <span class="alert-danger invalid-feedback">
                                    {{ $errors->first('email') }}
                                </span>
                                @endif
                            </div>
                            <div class="field {{ $errors->has('password') ? ' is-invalid' : '' }}">
                                <label>Password</label>
                                <input type="password" class="form-control" name="password" minlength="4" placeholder="Password" >
                                @if ($errors->has('password'))
                                    <span class="alert-danger invalid-feedback">
                                        {{ $errors->first('password') }}
                                    </span>
                                @endif
                            </div>
                            <div class="field {{ $errors->has('password_confirmation') ? ' is-invalid' : '' }}">
                                <label>Password Confirmation</label>
                                <input type="password" class="form-control" name="password_confirmation" minlength="4" placeholder="Confirm Password" >
                                @if ($errors->has('password_confirmation'))
                                    <span class="alert-danger invalid-feedback">
                                        {{ $errors->first('password_confirmation') }}
                                    </span>
                                @endif
                            </div>
                            <button class="btn primary btn-block p-x-md" type="submit">RESET PASSWORD</button>

                            <!--<div class="input-group">
                <span class="input-group-addon">
                    <i class="material-icons">person</i>
                </span>
                                <div class="form-line">
                                    <input type="email" class="form-control {{ $errors->has('email') ? ' is-invalid' : '' }}" name="email" placeholder="Email Id" value="{{ $email ?? old('email') }}"  autofocus>
                                </div>
                                @if ($errors->has('email'))
                <span class="invalid-feedback">
                    {{ $errors->first('email') }}
                </span>
                                @endif
                            </div>
                            <div class="input-group {{ $errors->has('password') ? ' is-invalid' : '' }}">
                <span class="input-group-addon">
                    <i class="material-icons">lock</i>
                </span>
                                <div class="form-line">
                                    <input type="password" class="form-control" name="password" minlength="4" placeholder="Password" >
                                </div>
                                @if ($errors->has('password'))
                <span class="invalid-feedback">
                    {{ $errors->first('password') }}
                </span>
                                @endif
                            </div>
                            <div class="input-group {{ $errors->has('password_confirmation') ? ' is-invalid' : '' }}">
                <span class="input-group-addon">
                    <i class="material-icons">lock</i>
                </span>
                                <div class="form-line">
                                    <input type="password" class="form-control" name="password_confirmation" minlength="4" placeholder="Confirm Password" >
                                </div>
                                @if ($errors->has('password_confirmation'))
                <span class="invalid-feedback">
                    {{ $errors->first('password_confirmation') }}
                </span>
                                @endif
                            </div>-->

                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
