@extends('layouts.home')

@section('content')
    <spark-settings :user="user" :teams="teams" inline-template>
        <div class="spark-screen container">
            <div class="row">
                <!-- Tab cards -->
                <div class="col-md-12">
                    <div class="tab-content">
                        <!-- Profile -->
                        <div role="tabcard" class="tab-pane active" id="profile">
                            @include('spark::settings.profile')
                        </div>

                        <!-- Teams -->
                        @if (Spark::usesTeams())
                        <div role="tabcard" class="tab-pane" id="{{Spark::teamsPrefix()}}">
                            @include('spark::settings.teams')
                        </div>
                        @endif


                    </div>
                </div>
            </div>
        </div>
    </spark-settings>
@endsection
