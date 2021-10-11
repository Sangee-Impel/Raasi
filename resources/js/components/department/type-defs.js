export default {
    is_last:[
        {
            id:0,
            value:false,
            name:"not_is_last"
        },
        {
            id:1,
            value:true,
            name:"is_last"
        },
    ],
    findDepartmentType(value,field,type){
        let searchField = ( field == undefined )?"id":field;
        let searchType = ( type == undefined )?"is_last":type;
        return this[searchType][this[searchType].findIndex(p => p[searchField] == value)];
    },
}
