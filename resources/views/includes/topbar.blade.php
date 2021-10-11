<div class="app-header white box-shadow navbar-md">
    <div class="navbar navbar-toggleable-sm flex-row align-items-center">
        <!-- Open side - Naviation on mobile -->
        <a data-toggle="modal" data-target="#aside" class="hidden-lg-up mr-3">
            <i class="material-icons">&#xe5d2;</i>
        </a>
        <!-- / -->

        <!-- Page title - Bind to $state's title -->
        <div class="mb-0 h5 no-wrap" ng-bind="$state.current.data.title" id="pageTitle"></div>

        <!-- navbar collapse -->
        <div class="collapse navbar-collapse" id="collapse">
            <!-- link and dropdown -->
            <!--<ul class="nav navbar-nav mr-auto">
                <li class="nav-item dropdown">
                    <a class="nav-link" href data-toggle="dropdown">
                        <i class="fa fa-fw fa-plus text-muted"></i>
                        <span>New</span>
                    </a>

                </li>
            </ul>-->

            <!--<div ui-include="'../views/blocks/navbar.form.html'"></div>-->
            <!-- / -->
        </div>
        <!-- / navbar collapse -->

        <!-- navbar right -->
        <ul class="nav navbar-nav ml-auto flex-row">
            <li class="nav-item dropdown">
                <div class="ui compact menu">
                    <div class="ui  simple icon dropdown item">
                        @{{ user.name }}
                        <i class="dropdown icon"></i>
                        <div class="menu">
                            <div class="item">
                                <a href="/profile">
                                    Profile
                                </a>
                            </div>
                            <div class="item">
                                <a href="/logout">
                                    Logout
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <!--<a class="nav-link p-0 clear" href="#" data-toggle="dropdown">
                  <span class="avatar w-32">
                    d
                    <i class="on b-white bottom"></i>
                  </span>
                </a>-->
                <!--<div ui-include="'../views/blocks/dropdown.user.html'"></div>-->
            </li>
        </ul>
        <!-- / navbar right -->
    </div>
</div>