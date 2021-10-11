export default [
    {
        name: '__sequence',
        title: '#',
        titleClass: 'center aligned',
        dataClass: 'center aligned'
    },
    {
        name: 'parent_bag_number',
        title:'Parent Lot Number',
        sortField: 'parent_bag_number',
        titleClass: 'center aligned',
        dataClass: 'left aligned'
    },
    {
        name: 'bag_number',
        title:'Lot Number',
        sortField: 'bag_number',
        titleClass: 'center aligned',
        dataClass: 'left aligned'
    },
    {
        name: 'order_number',
        title:'Order Number',
        sortField: 'order_number',
        titleClass: 'center aligned',
        dataClass: 'left aligned'
    },
    {
        name: 'department_name',
        title:'Department Number',
        sortField: 'department_name',
        titleClass: 'center aligned',
        dataClass: 'left aligned'
    },
    {
        name: 'employee_name',
        title:'Employee Number',
        sortField: 'employee_name',
        titleClass: 'center aligned',
        dataClass: 'left aligned'
    },
    {
        name: 'status',
        title:'Lot Status',
        sortField: 'status',
        titleClass: 'center aligned',
        dataClass: 'left aligned',
        callback:'changeBagStatus'
    },
    {
        name: 'instructions',
        title:'Instructions ',
        sortField: 'instructions',
        titleClass: 'center aligned',
        dataClass: 'left aligned'
    },

    {
        name: '__slot:actions',
        title: 'Action',
        titleClass: 'center aligned',
        dataClass: 'center aligned',

    }
]

