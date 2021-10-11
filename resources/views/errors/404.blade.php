<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    @include('includes.head')
</head>

<body class="four-zero-four">
<!--<div class="four-zero-four-container">
    <div class="error-code">404</div>
    <div class="error-message">This page doesn't exist</div>
    <div class="button-place">
        <a href="/dashboard" class="btn btn-default btn-lg waves-effect">GO TO HOMEPAGE</a>
    </div>
</div>-->
<div class="app-body amber bg-auto w-full">
    <div class="text-center pos-rlt p-y-md">
        <h1 class="text-shadow m-0 text-white text-4x">
            <span class="text-2x font-bold block m-t-lg">404</span>
        </h1>
        <h2 class="h1 m-y-lg text-black">OOPS!</h2>
        <p class="h5 m-y-lg text-u-c font-bold text-black">Sorry! the page you are looking for doesn't exist.</p>
        <a href="/dashboard" class="md-btn amber-700 md-raised p-x-md">
            <span class="text-white">Go to the home page</span>
        </a>
    </div>
</div>
@include('includes.footer')
</body>

</html>