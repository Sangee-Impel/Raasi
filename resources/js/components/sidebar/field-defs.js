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
        title: 'Casting',
        icon: 'casting',
        permission_slug: "index.casting",
        has_permission: false,
        dataClass: '',
        href: "/casting",
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
        title: 'Delete Data',
        icon: 'delete',
        permission_slug: "index.deletedata",
        has_permission: false,
        dataClass: '',
        href: "/delete-data",
        childrens: []
    },

    {
        title: "Reports",
        icon: 'reports',
        href: "#",
        permission_slug: "",
        has_permission: false,
        dataClass: '',
        childrens: [
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
                title: 'Opening Report',
                permission_slug: "index.openingreport",
                has_permission: false,
                dataClass: '',
                href: "/opening-report"
            },
            {
                title: 'Fc Transaction Report',
                permission_slug: "index.fctransactionreport",
                has_permission: false,
                dataClass: '',
                href: "/fctransaction-report"
            },
            {
                title: 'Casting Inword Report',
                permission_slug: "index.castinginwordreport",
                has_permission: false,
                dataClass: '',
                href: "/castinginword-report"
            },
            {
                title: 'Accessories Inword Report',
                permission_slug: "index.accessoriesinwordreport",
                has_permission: false,
                dataClass: '',
                href: "/accessoriesinword-report"
            },
            {
                title: 'Merge Report',
                permission_slug: "index.mergereport",
                has_permission: false,
                dataClass: '',
                href: "/merge-report"
            },
            {
                title: 'Split Report',
                permission_slug: "index.splitreport",
                has_permission: false,
                dataClass: '',
                href: "/split-report"
            },
            {
                title: 'Scrap Report',
                permission_slug: "index.scrapreport",
                has_permission: false,
                dataClass: '',
                href: "/scrap-report"
            },
            {
                title: 'Channam Report',
                permission_slug: "index.channamreport",
                has_permission: false,
                dataClass: '',
                href: "/channam-report"
            },
            {
                title: 'Loss Report',
                permission_slug: "index.lossreport",
                has_permission: false,
                dataClass: '',
                href: "/loss-report"
            },
            {
                title: 'Pending Lot Report',
                permission_slug: "index.pendingreport",
                has_permission: false,
                dataClass: '',
                href: "/pending-report"
            },
            {
                title: 'Employee Loss Report',
                permission_slug: "index.emplossreport",
                has_permission: false,
                dataClass: '',
                href: "/emploss-report"
            },
            {
                title: 'Closing Loss Report',
                permission_slug: "index.closingreport",
                has_permission: false,
                dataClass: '',
                href: "/closing-report"
            },
            {
                title: 'EOD Report',
                permission_slug: "index.eodreport",
                has_permission: false,
                dataClass: '',
                href: "/eod-report"
            }
        ]
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
            }, {
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

