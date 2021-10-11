export default [
    {
        name: '__sequence',
        title: '#',  
        titleClass: 'center aligned',
        dataClass: 'center aligned'
    },
    { 
        name: 'name',
        title:'Project Name',
        sortField: 'project.name',
        titleClass: 'center aligned',
        dataClass: ' left aligned '
    },
    {
        name: 'description',
        title:'Project Description',
        sortField: 'project.description',
        titleClass: 'center aligned',
        dataClass: 'center aligned'
    },
    {
        name: '__slot:actions',
        title: 'Action',
        titleClass: 'center aligned',
        dataClass: 'center aligned',

    }
]

