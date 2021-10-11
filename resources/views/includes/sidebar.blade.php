<sidebar inline-template>
    <!-- aside -->
    <div id="aside" class="app-aside modal fade folded md nav-expand">
        <div class="left navside dark dk " data-layout="column">
            <div class="navbar navbar-md no-radius">
                <!-- brand -->
                <a class="navbar-brand text-center">
                    <img src="{{asset('images/impel.png')}}" alt="." class="center">
                    <!--<span class="hidden-folded inline">Impel</span>-->
                </a>
                <!-- / brand -->
            </div>
            <div flex class="hide-scroll">
                <nav class="scroll nav-active-primary text-md">
                    <ul class="nav" ui-nav>
                        <li v-for="(item, index) in fields" v-if="item.has_permission" class="p-1" v-bind:class="item.dataClass"  >
                            <a :href="item.href">
                                <span class="nav-caret" v-if="item.childrens.length > 0">
                                    <i class="fa fa-caret-down"></i>
                                </span>
                                <span class="nav-icon">
                                    <i class="material-icons">@{{item.icon}}</i>
                                </span>
                                <span class="nav-text">@{{item.title}}</span>
                            </a>
                            <ul class="nav-sub" v-if="item.childrens.length > 0" >
                                <li v-for="(child, childIndex) in item.childrens" v-if="child.has_permission" class="p-1" v-bind:class="child.dataClass">
                                    <a :href="child.href" >
                                        <span class="nav-text">@{{child.title}}</span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="/logout">
                                <span class="nav-icon">
                                    <i class="material-icons">input</i>
                                </span>
                                <span class="nav-text">Logout</span>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
    <!-- / aside -->
</sidebar>
