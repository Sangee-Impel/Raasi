@extends('layouts.home')

@section('content')
<audit-block inline-template>
    <div class="container-fluid blue-color-theme">
        @include('audit.manage_audit')
    </div>
</audit-block>
@endsection
