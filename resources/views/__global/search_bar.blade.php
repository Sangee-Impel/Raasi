<div class="row pull-right">
    <div class="form-group">
        <div class="input-group m-b">
          <span class="input-group-btn">
            <button class="btn white" type="button" @click=clearDataTable()> <i class="fa fa-eraser"></i></button>
          </span>
            <input type="text" placeholder="Search..." class="form-control" v-model="vueTableParams.filter" @keyup="onFilter">
            <span class="input-group-btn" @click="showAdvanceFilterBlock()"  v-if="(is_advance_search)">
            <button class="btn white" type="button"  > <i class="fa fa-sort-desc"></i></button>
          </span>
        </div>
    </div>
</div>
