
/*
 |--------------------------------------------------------------------------
 | Laravel Spark Components
 |--------------------------------------------------------------------------
 |
 | Here we will load the Spark components which makes up the core client
 | application. This is also a convenient spot for you to load all of
 | your components that you write while building your applications.
 */

require('./../spark-components/bootstrap');

require('./sidebar/sidebar');
require('./__globals/filters');


require('./home/home');
require('./dashboard/dashboard');
require('./transaction/transaction');
require('./transaction/manage-transaction');
require('./transaction/form-transaction');


/*roles*/
require('./roles/manage-roles');
require('./roles/form-roles');

/*user*/
require('./user/manage-user');
require('./user/profile-user');
require('./user/form-user');

/*unit*/
require('./unit/manage-unit');
require('./unit/form-unit');

/*department*/
require('./department/manage-department');
require('./department/form-department');

/*process*/
require('./process/manage-process');
require('./process/form-process');

/*process*/
require('./employee/manage-employee');
require('./employee/form-employee');
/*product-category*/
require('./product_category/manage-product-category');
require('./product_category/form-product-category');

/*product*/
require('./product/manage-product');
require('./product/form-product');

/*uom*/
require('./uom/manage-uom');
require('./uom/form-uom');

/*bag*/
require('./bag/manage-bag');
require('./bag/form-bag');

/*bag*/
require('./other_accessories/manage-other-accessories');
require('./other_accessories/form-other-accessories');

require('./transaction_history/manage-transaction-history');
require('./transaction_history/manage-tally-report');

require('./configuration/manage-configuration');

require('./loss_approval/manage-loss-approval');

require('./opening_report/manage-opening-report');

require('./fctransaction_report/manage-fctransaction-report');
require('./merge_report/manage-merge-report');
require('./split_report/manage-split-report');

require('./scrap_report/manage-scrap-report');
require('./channam_report/manage-channam-report');

require('./loss_report/manage-loss-report');
require('./pending_report/manage-pending-report');
require('./emploss_report/manage-emploss-report');
require('./castinginword_report/manage-castinginword-report');
require('./accessoriesinword_report/manage-accessoriesinword-report');
require('./closing_report/manage-closing-report');
require('./eod_report/manage-eod-report');

/*casting*/
require('./casting/manage-casting');
require('./casting/form-casting');

require('./delete-data/manage-delete-data');
require('./delete-data/form-truncate');

