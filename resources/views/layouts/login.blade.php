<!DOCTYPE html>
<html lang="en">
<head>
    @include('includes.head')
    @stack('scripts')
    <script>
        window.Spark = @json(array_merge(Spark::scriptVariables(), []));
    </script>
</head>
<body >
<div  id="spark-app" v-cloak>
    <div class="app" id="app">
        <div class="center-block w-xxl w-auto-xs p-y-md">
            @yield('content')
        </div>
    </div>
</div>


@include('includes.footer')

</body>

</html>
