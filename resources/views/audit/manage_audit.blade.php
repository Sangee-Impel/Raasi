<manage-audit inline-template :customer_id="customer_id">
    <div>
    @include('__global.loading')
    <div class="ui centered grid" v-if="displayForm == false">
        <div class="sixteen wide column">
            @include('__global.loading')
            <div class="card container-card">
                <div class="header">
                    <div class="ui centered grid">
                        <div class="twelve wide column">
                            <div class="ui grid">
                                <div class="six wide column">
                                    <h2 class="pt-3">Audit trail</h2>
                                </div>
                                <div class="ten wide column ">
                                    @include('__global.search_bar')
                                    <button class="ui button icon huge  float-right" v-bind:class="vueTableParams.trash | trashClass"  @click="actionTrash">@{{vueTableParams.trash | trashText}}</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="body">
                    <div class="ui centered grid">
                        <div class="sixteen wide column vue-table-grid">
                            <vue-table ref="vuetable"
                                       api-url="{{ URL::route('audit.index') }}"
                                       :fields="fields"
                                       pagination-path=""
                                       :http-fetch="vueTableFetch"
                                       @vuetable:pagination-data="onPaginationData"
                                       :append-params="vueTableParams"
                            >
                                <template slot="actions" scope="props">
                                    <div class="custom-actions">
                                        <button class="ui large icon button theme-color"v-if="vueTableParams.trash != 1"
                                                @click="onAction('edit-item', props.rowData, props.rowIndex, props)">
                                            <i class="eye icon"></i>
                                        </button>
                                    </div>
                                </template>
                            </vue-table>
                            <div class="vuetable-pagination ui basic segment grid">
                                <vuetable-pagination-info ref="paginationInfo"></vuetable-pagination-info>
                                <vuetable-pagination
                                    ref="pagination"
                                    @vuetable-pagination:change-page="onChangePage"
                                ></vuetable-pagination>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
</manage-audit>
