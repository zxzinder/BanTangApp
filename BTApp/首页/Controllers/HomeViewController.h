//
//  HomeViewController.h
//  BTApp
//
//  Created by MacMini on 16/3/22.
//  Copyright © 2016年 MacMini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeHeaderView.h"
#import "BTHomeMidView.h"

@interface HomeViewController : UIViewController

@property (weak, nonatomic) IBOutlet HomeHeaderView *headerView;
@property (weak, nonatomic) IBOutlet BTHomeMidView *midView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
