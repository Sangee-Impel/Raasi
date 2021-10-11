export default [
    {
        name: '__sequence',
        title: '#',
        titleClass: 'center aligned',
        dataClass: 'center aligned'
    },
    {
        name: 'transaction_date',
        title:'Transaction Date',
        sortField: 'transaction_date',
        titleClass: 'center aligned',
        dataClass: 'left aligned',
        callback:'changeDateFormat'
    },
    {
        name: 'bag_number',
        title:'Bag Number',
        sortField: 'bag_number',
        titleClass: 'center aligned',
        dataClass: 'left aligned'
    },
    {
        name: 'from_department_name',
        title:'From Department Name',
        sortField: 'from_department_name',
        titleClass: 'center aligned',
        dataClass: 'left aligned'
    },
    {
        name: 'from_employee_name',
        title:'From Employee Name',
        sortField: 'from_employee_name',
        titleClass: 'center aligned',
        dataClass: 'left aligned'
    },

    {
        name: 'to_department_name',
        title:'To Department Name',
        sortField: 'to_department_name',
        titleClass: 'center aligned',
        dataClass: 'left aligned'
    },
    {
        name: 'to_employee_name',
        title:'To Employee Name',
        sortField: 'to_employee_name',
        titleClass: 'center aligned',
        dataClass: 'left aligned'
    },
    {
        name: 'description',
        title:'Description',
        sortField: 'description',
        titleClass: 'center aligned',
        dataClass: 'left aligned'
    },
    {
        name: 'status',
        title:'Status',
        sortField: 'status',
        titleClass: 'center aligned',
        dataClass: 'left aligned',
        callback:'changeTransactionStatus'
    },
    {
        name: '__slot:actions',
        title: 'Action',
        titleClass: 'center aligned',
        dataClass: 'center aligned',
    }
]

