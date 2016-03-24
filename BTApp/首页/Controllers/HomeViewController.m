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
#import "BTHomeTableViewCell.h"
#import "UINavigationBar+Awesome.h"

#define NAVBAR_CHANGE_POINT 50
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)BTHomePageData *homePageData;
/** 当前页码 */
@property (nonatomic, assign) NSInteger page;
/** 表格列表数据源 */
@property (nonatomic, strong) NSMutableArray *dataArray;

@property(nonatomic,strong) NSMutableArray *headInfos;

@property (nonatomic, assign) BOOL finishedLoadedData;
/** navigationBar的alpha值 */
@property (nonatomic, assign) CGFloat navigationBarAlpha;
@end

@implementation HomeViewController
-(void)awakeFromNib{
    
    //banner:   BTTopicListVC,BTWebViewVC
    //collection: BTSubjectVC
    //tableview: BTProductListVC
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
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[BTGobalRedColor
                                                                    colorWithAlphaComponent:self.navigationBarAlpha]];
    
    if (self.navigationBarAlpha==0) {
        [self.navigationItem.titleView setHidden:YES];
        [self.navigationItem.leftBarButtonItem.customView setHidden:YES];
        [self.navigationItem.rightBarButtonItem.customView setHidden:YES];
    }
    
    [self.navigationItem.titleView setAlpha:self.navigationBarAlpha];
    [self.navigationItem.leftBarButtonItem.customView setAlpha:self.navigationBarAlpha];
    [self.navigationItem.rightBarButtonItem.customView setAlpha:self.navigationBarAlpha];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    [_headerView endAutoScroll];

}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupViews];
    [self getData];
    // Do any additional setup after loading the view.
}
-(void)setupViews{
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nar_logo"]];
    self.navigationItem.leftBarButtonItem =  [UIBarButtonItem rx_barBtnItemWithNmlImg:@"home_search_icon"
                                                                               hltImg:@"home_search_icon"
                                                                               target:self
                                                                               action:@selector(searchBtnClick)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem rx_barBtnItemWithNmlImg:@"sign_bar_icon"
                                                                               hltImg:@"sign_bar_icon"
                                                                               target:self
                                                                               action:@selector(signBtnClick)];
    [self.navigationItem.titleView setAlpha:0.0];
    [self.navigationItem.leftBarButtonItem.customView setAlpha:0.0];
    [self.navigationItem.rightBarButtonItem.customView setAlpha:0.0];
     self.automaticallyAdjustsScrollViewInsets = NO;
   
    
}
- (void)searchBtnClick
{
    NSLog(@"searchBtnClick");
}

- (void)signBtnClick
{
    NSLog(@"signBtnClick");
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
        
        
        if (pageData.topic.count == 0)  return;
        
        self.finishedLoadedData = pageData.topic.count < 10;
        [self.dataArray addObjectsFromArray:pageData.topic];
        [self.tableView setHidden:NO];
        [self.tableView reloadData];
        self.page++;
    } failureHandler:^(NSError *error) {
      //  [self hideLoading];
    }];
    
}

#pragma mark UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BTHomeTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"contentCell" forIndexPath:indexPath];
    [cell configureCellWithTopic:self.dataArray[indexPath.row]];
    return cell;
    
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 100开始显示
    // 180显示完全
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat alpha = 0;
    
    if (offsetY > NAVBAR_CHANGE_POINT) {
        alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
    }
    
    if (alpha>0) {
        [self.navigationItem.titleView setHidden:NO];
        [self.navigationItem.leftBarButtonItem.customView setHidden:NO];
        [self.navigationItem.rightBarButtonItem.customView setHidden:NO];
    }
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[BTGobalRedColor colorWithAlphaComponent:alpha]];
    [self.navigationItem.titleView setAlpha:alpha];
    [self.navigationItem.leftBarButtonItem.customView setAlpha:alpha];
    [self.navigationItem.rightBarButtonItem.customView setAlpha:alpha];
    self.navigationBarAlpha = alpha;
}

@end
