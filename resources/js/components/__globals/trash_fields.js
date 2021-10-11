export default {
    trashOff : 0,
    trashOn  : 1,
    trash : [
        {
            text:'Trash',
            cssClass:'blue trash-theme-color',
            value: 0
        },
        {
            text:'Trash Off',
            cssClass: 'red',
            value: 1
        }
    ],



    findByValue(value){
        return this.trash[this.trash.findIndex(p => p.value == value)];
    },


}
