export default {
    bag_status:[
        {
            id:0,
            name:"In Progress",
            value:'in_progress'
        },
        {
            id:1,
            name:"Completed",
            value:'completed'
        },
        {
            id:2,
            name:"Splitted",
            value:'splitted'
        },
        {
            id:3,
            name:"Admin Loss approval",
            value:'admin_loss_approval'
        },
        {
            id:4,
            name:"Merge",
            value:'merge'
        },
        {
            id:5,
            name:"Cancel",
            value:'cancel'
        },
    ],
    findBagType(value,field,type){
        let searchField = ( field == undefined )?"id":field;
        let searchType = ( type == undefined )?"bag_status":type;
        return this[searchType][this[searchType].findIndex(p => p[searchField] == value)];
    },
}
