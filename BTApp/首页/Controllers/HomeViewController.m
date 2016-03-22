//
//  HomeViewController.m
//  BTApp
//
//  Created by MacMini on 16/3/22.
//  Copyright © 2016年 MacMini. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeHeaderView.h"
#import "BTHomePageManager.h"
#import "BTHomePageData.h"

@interface HomeViewController ()

@property (nonatomic,strong)HomeHeaderView *homeHeaderView;
@property (nonatomic,strong)BTHomePageData *homePageData;
/** 当前页码 */
@property (nonatomic, assign) NSInteger page;
/** 表格列表数据源 */
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getData{
    self.page = 0;
    
    [BTHomePageManager getHomePageDataWithPage:self.page successHandler:^(BTHomePageData *pageData) {
  
       
            [self.dataArray removeAllObjects];
            self.homePageData = pageData;
            self.homeHeaderView.ads = pageData.banner;
           // self.headerView.entryListArray = pageData.entryList;
        
        
//        if (pageData.topic.count == 0)  return;
//        
//        self.finishedLoadedData = pageData.topic.count < 10;
//        [self.dataArray addObjectsFromArray:pageData.topic];
//        [self.tableView setHidden:NO];
//        [self.tableView reloadData];
//        self.page++;
    } failureHandler:^(NSError *error) {
      //  [self hideLoading];
    }];
    
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
