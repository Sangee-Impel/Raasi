<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <title>Impel</title>
    @include('includes.head')
    @stack('scripts')
    <script>
        window.Spark = @json(array_merge(Spark::scriptVariables(), []));
    </script>
</head>

<body>
<div  id="spark-app" v-cloak>

    <div class="app" id="app">
        @include('includes.sidebar')
        <!-- content -->
        <div id="content" class="app-content box-shadow-z0" role="main">
            <input type="hidden" id="configuration" value="{{json_encode(Session::get('configuration'))}}">
            @include('includes.topbar')
            <div ui-view class="app-body" id="view">
                @yield('content')
                <vue-snotify></vue-snotify>
            </div>
            @include('includes.footerbar')
        </div>
        <!-- / -->


    </div>

</div>
@include('includes.footer')
</body>
</html>
