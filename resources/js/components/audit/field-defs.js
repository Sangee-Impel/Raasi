export default [
    {
        name: '__sequence',
        title: '#',
        titleClass: 'center aligned',
        dataClass: 'center aligned'
    },
    {
        name: 'auditable_type',
        title:'Model',
        sortField: 'auditable_type',
        titleClass: 'center aligned',
        dataClass: 'left aligned'
    },
    {
        name: 'event',
        title:'Event',
        sortField: 'event',
        titleClass: 'center aligned',
        dataClass: 'left aligned'
    },
    {
        name: 'old_values',
        title:'Old Values',
        sortField: 'old_values',
        titleClass: 'center aligned',
        dataClass: 'left aligned',
        callback : 'convertObject'
    },
    {
        name: 'new_values',
        title:'New Values',
        sortField: 'new_values',
        titleClass: 'center aligned',
        dataClass: 'left aligned',
        callback : 'convertObject'
    },
    {
        name: 'created_at',
        title:'Created at',
        sortField: 'created_at',
        titleClass: 'center aligned',
        dataClass: 'left aligned',
        callback:'changeDateFormat',
        width   : '15%'
    },
]

