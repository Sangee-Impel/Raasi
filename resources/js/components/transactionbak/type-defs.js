export default {
    transaction_status:[

        {
            id:0,
            name:"Completed",
            value:'completed'
        },
        {
            id:1,
            name:"Admin Loss Approval",
            value:'admin_loss_approval'
        },
        {
            id:2,
            name:"Cancel",
            value:'cancel'
        },
    ],
    transaction_item_status:[
        {
            id:0,
            name:"Completed",
            value:'completed'
        },
        {
            id:1,
            name:"Admin Loss Approval",
            value:'admin_loss_approval'
        },
        {
            id:2,
            name:"Cancel",
            value:'cancel'
        },
    ],
    transaction_type:[
        {
            id:0,
            name:"Bag",
            value:'bag'
        },
        {
            id:1,
            name:"Other Accessories",
            value:'other_accessories'
        },
    ],

    transaction_item_loss_type:[
        {
            id:0,
            name:"Loss",
            value:'loss'
        },
        {
            id:1,
            name:"Scrap",
            value:'scrap'
        },
        {
            id:2,
            name:"Channam",
            value:'channam'
        },
    ],
    transaction_item_loss_status:[
        {
            id:0,
            name:"Approval",
            value:'approval'
        },
        {
            id:1,
            name:"Waiting Admin Approval",
            value:'waiting_admin_approval'
        },

    ],
    split_bag_type:[
        {
            id:0,
            name:"Transfer",
            value:'transfer'
        },
        {
            id:1,
            name:"Receive",
            value:'receive'
        },
    ],
    transaction_mode : [
        {
            id:0,
            name:"Default Mode",
            value:'default_mode'
        },
        {
            id:1,
            name:"Split Mode",
            value:'split_mode'
        },
        {
            id:2,
            name:"Merge Mode",
            value:'merge_mode'
        },
    ],
    split_bag_status:[
        {
            id:0,
            name:"Split Mode Off",
            value:'split_mode_off'
        },
        {
            id:1,
            name:"Split Mode On",
            value:'split_mode_on'
        },
    ],
    loss_reason_type:[
        {
            id:0,
            name:"Reduce wt acc to the order",
            value:'reduce_wt_acc_to_the_order'
        },
        {
            id:1,
            name:"Employee mistake",
            value:'employee_mistake'
        },
        {
            id:2,
            name:"Lot box mismatch",
            value:'lot_box_mismatch'
        },
        {
            id:3,
            name:"Others",
            value:'others'
        },

    ],
    split_iteration : {
        iteration_first : "-1",
        iteration_second : "-2",
    },
    split_string : "-",
    findTransactionType(value,field,type){
        let searchField = ( field == undefined )?"id":field;
        let searchType = ( type == undefined )?"transaction_type":type;
        return this[searchType][this[searchType].findIndex(p => p[searchField] == value)];
    },
}
