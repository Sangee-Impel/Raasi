@extends('layouts.home')

@section('content')
<home :user="user" inline-template>
    <div class="container-fluid">
        <!--<div class="block-header">
            <h2>DASHBOARD</h2>
        </div>-->
        <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <div class="card">
                    <div class="header">
                        <div class="row clearfix">
                            <div class="col-xs-12 col-sm-6 ">
                                <h2>DASHBOARD</h2>
                            </div>
                        </div>
                    </div>
                    <div class="body">
                        <div class="ui container">
                          
                        </div>
                    </div>
                </div>
            </div>
        </div>


    </div>
</home>
@endsection
