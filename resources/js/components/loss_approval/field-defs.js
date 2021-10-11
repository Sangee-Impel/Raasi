export default [
    {
        name: '__sequence',
        title: '#',
        titleClass: 'center aligned',
        dataClass: 'center aligned'
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
    },{
        name: 'style_sku',
        title:'Style Name',
        sortField: 'style_sku',
        titleClass: 'center aligned',
        dataClass: 'left aligned'
    },
    {
        name: 'user_name',
        title:'User Name',
        sortField: 'user_name',
        titleClass: 'center aligned',
        dataClass: 'left aligned'
    },
    {
        name: 'weight',
        title:'Loss Weight',
        sortField: 'weight',
        titleClass: 'center aligned',
        dataClass: 'left aligned'
    },
    {
        name: 'admin_approval_loss_weight',
        title:'Admin Approved Weight',
        sortField: 'admin_approval_loss_weight',
        titleClass: 'center aligned',
        dataClass: 'left aligned'
    },
    {
        name: 'status',
        title:'Status',
        sortField: 'status',
        titleClass: 'center aligned',
        dataClass: 'left aligned',
        callback:'changeBagStatus'
    },
    {
        name: '__slot:actions',
        title: 'Action',
        titleClass: 'center aligned',
        dataClass: 'center aligned',

    }
]

