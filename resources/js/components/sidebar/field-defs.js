export default [
    {
        title: "Dashboard",
        icon: 'dashboard',
        href: "/dashboard",
        permission_slug: "",
        has_permission: true,
        dataClass: '',
        childrens: []
    },

    {
        title: 'Lot',
        icon: 'work',
        permission_slug: "index.bag",
        has_permission: false,
        dataClass: '',
        href: "/bag",
        childrens: []
    },
    {
        title: 'Transactions',
        icon: 'payments',
        permission_slug: "store.transaction",
        has_permission: false,
        dataClass: '',
        href: "/transactions",
        childrens: []
    },
    {
        title: 'Transactions History',
        icon: 'history',
        permission_slug: "index.transactionreport",
        has_permission: false,
        dataClass: '',
        href: "/transactions-history",
        childrens: []
    },
    {
        title: 'Loss Approval',
        icon: 'history',
        permission_slug: "index.lossapproval",
        has_permission: false,
        dataClass: '',
        href: "/loss-approval",
        childrens: []
    },
    {
        title: 'Tally Report',
        icon: 'history',
        permission_slug: "index.tallyreport",
        has_permission: false,
        dataClass: '',
        href: "/tally-report",
        childrens: []
    },
    {
        title: "Setup",
        icon: 'settings',
        href: "#",
        permission_slug: "",
        has_permission: false,
        dataClass: '',
        childrens: [
            {
                title: 'Units',
                permission_slug: "index.unit",
                has_permission: false,
                dataClass: '',
                href: "/unit"
            }, {
                title: 'Departments',
                permission_slug: "index.department",
                has_permission: false,
                dataClass: '',
                href: "/department"
            },
            {
                title: 'Process',
                permission_slug: "index.process",
                has_permission: false,
                dataClass: '',
                href: "/process"
            },{
                title: 'Employee',
                permission_slug: "index.employee",
                has_permission: false,
                dataClass: '',
                href: "/employee"
            },
            {
                title: 'Product Category',
                permission_slug: "index.productcategory",
                has_permission: false,
                dataClass: '',
                href: "/product-category"
            },
            {
                title: 'Product',
                permission_slug: "index.product",
                has_permission: false,
                dataClass: '',
                href: "/product"
            },
            {
                title: 'Uom',
                permission_slug: "index.uom",
                has_permission: false,
                dataClass: '',
                href: "/uom"
            },

            {
                title: 'Other Accessories',
                icon: 'dashboard',
                permission_slug: "index.otheraccessories",
                has_permission: false,
                dataClass: '',
                href: "/other-accessories",
                childrens: []
            },
            {
                title: 'Roles',
                permission_slug: "index.role",
                has_permission: false,
                dataClass: '',
                href: "/roles"
            },
            {
                title: 'Users',
                permission_slug: "index.user",
                has_permission: false,
                dataClass: '',
                href: "/user"
            },
            {
                title: 'Configuration',
                permission_slug: "index.configuration",
                has_permission: false,
                dataClass: '',
                href: "/configuration"
            },



        ]
    },

];

