<?php

return [
    'upload_path' => 'public/attachments',
    'customer_file_path' => 'public/customer_attachments/',
    'delay' => now()->addSeconds(1),
    "trash_on"  =>  1,
    "trash_off" =>  0,
    "success"   =>  1,
    "failure"   =>  0,
    "primary"   =>  0,
    "non-primary"=>1,
    "create"   =>1,
    "update"   =>0,
    "toggle_active" =>[
        "active" => 0,
        "in_active" =>1,
    ],
    "default_email" =>  "@impel.com",
    "transaction_type"=>[
        [
            "id" => 0,
            "name"=>"Completed",
            "value"=>'completed'
        ],
        [
            "id" => 1,
            "name"=>"Admin Loss Approval",
            "value"=>'admin_loss_approval'
        ],
    ],
    "transaction"=>[
        [
            "id" => 0,
            "name"=>"Completed",
            "value"=>'completed'
        ],
        [
            "id" => 1,
            "name"=>"Admin Loss Approval",
            "value"=>'admin_loss_approval'
        ],
    ],
    "transaction_item_loss_type"=>[
        [
            "id" => 0,
            "name"=>"Loss",
            "value"=>'loss'
        ],
        [
            "id" => 1,
            "name"=>"Scrap",
            "value"=>'scrap'
        ],
        [
            "id" => 2,
            "name"=>"Channam",
            "value"=>'channam'
        ]
    ],
    "transaction_item_loss_status"=>[
        [
            "id" => 0,
            "name"=>"Approved",
            "value"=>'approved'
        ],
        [
            "id" => 1,
            "name"=>"Waiting Admin Approval",
            "value"=>'waiting_admin_approval'
        ]
    ],
    "loss_reason_type"=>[
        [
            "id" => 0,
            "name"=>"Reduce wt acc to the order",
            "value"=>'reduce_wt_acc_to_the_order'
        ],
        [
            "id" => 1,
            "name"=>"Employee mistake",
            "value"=>'employee_mistake'
        ],
        [
            "id" => 2,
            "name"=>"Lot box mismatch",
            "value"=>'lot_box_mismatch'
        ],
        [
            "id" => 3,
            "name"=>"Others",
            "value"=>'others'
        ]
    ],

    "is_EOD_reporting_true" => 1,
    "is_EOD_reporting_false" => 0,
    "department"    =>  [
        "final_process_status"=>[
            "is_not_final"  =>  0,
            "is_final"      =>  1
        ]
    ],
    "transaction_mode" => [
        [
            "id"    =>  0,
            "name"  =>  "Default Mode",
            "value" =>  'default_mode'
        ],
        [
            "id"    =>  1,
            "name"  =>  "Split Mode",
            "value" =>  'split_mode'
        ],
        [
            "id"    =>  2,
            "name"  =>  "Merge Mode",
            "value" =>  'merge_mode'
        ],
    ],
    "bag"   =>  [
        "status"    =>  [
            [
                "id" => 0,
                "name"=>"In Progress",
                "value"=>'in_progress'
            ],
            [
                "id" => 1,
                "name"=>"Completed",
                "value"=>'completed'
            ],
            [
                "id" => 2,
                "name"=>"Splitted",
                "value"=>'splitted'
            ],
            [
                "id" => 3,
                "name"=>"Admin Loss approval",
                "value"=>'admin_loss_approval'
            ],
            [
                "id" => 4,
                "name"=>"Merge",
                "value"=>'merge'
            ],
            [
                "id" => 5,
                "name"=>"Cancel",
                "value"=>'cancel'
            ],
        ],
        "split"     =>  [
            "status" => [
                [
                    "id" => 0,
                    "name"=>"Split Mode Off",
                    "value"=>'split_mode_off'
                ],
                [
                    "id" => 1,
                    "name"=>"Split Mode Off",
                    "value"=>'split_mode_on'
                ],
            ],
            "iteration_first" => "-1",
            "iteration_second" => "-2",
        ],
        "split_bag_status" => [

        ]
    ],
    "configration"=>[
        "config_key" =>[
            "precision",
            "bag_starting_department"
        ]
    ],
    "bag_split_string"=>"-",
    "transaction_item_type" => [
        [
            "id"    =>  0,
            "name"  =>  "Bag",
            "value" =>  'bag'
        ],
        [
            "id"    =>  1,
            "name"  =>  "Other Accessories",
            "value" =>  'other_accessories'
        ],
    ]
];


