@extends('layouts.home')

@section('content')
<manage-delete-data inline-template>
    <div class="padding">
        @include('__global.loading')
        <form-truncate inline-template ref="roleForm" class="sub_content">
            <form>
                <div>Are you sure want to delete data</div>
                <button class="btn btn-fw success " type="button" @click="submit">Submit</button>
            </form>
        </form-truncate>
    </div>
</manage-delete-data>
@endsection