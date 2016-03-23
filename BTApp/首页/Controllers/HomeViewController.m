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
#import "BTHomeBanner.h"

@interface HomeViewController ()

@property (nonatomic,strong)BTHomePageData *homePageData;
/** 当前页码 */
@property (nonatomic, assign) NSInteger page;
/** 表格列表数据源 */
@property (nonatomic, strong) NSMutableArray *dataArray;

@property(nonatomic,strong) NSMutableArray *headInfos;
@end

@implementation HomeViewController
-(void)awakeFromNib{
    
    _headInfos = [NSMutableArray array];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    if (_headInfos.count > 1) {
        [_headerView startAudoScroll];
    }
    if (!(_headInfos.count>0)) {
        [self getData];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    [_headerView endAutoScroll];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self getData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getData{
    self.page = 0;
    __weak HomeViewController *weakSelf = self;

    [BTHomePageManager getHomePageDataWithPage:self.page successHandler:^(BTHomePageData *pageData) {
  
            [self.dataArray removeAllObjects];
            self.homePageData = pageData;
        for (NSDictionary *dict in pageData.banner) {
            BTHomeBanner *banner = [BTHomeBanner mj_objectWithKeyValues:dict];
            [weakSelf.headInfos addObject:banner];
        }
        if (weakSelf.headInfos.count > 1) {
            weakSelf.headerView.ads = weakSelf.headInfos;
           weakSelf.midView.entryListArr = pageData.entryList;
            [weakSelf.headerView startAudoScroll];
        }
        
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
