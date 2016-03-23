//
//  HomeHeaderView.h
//  BTApp
//
//  Created by MacMini on 16/3/22.
//  Copyright © 2016年 MacMini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeHeaderView : UIView

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;

@property (nonatomic, strong) NSArray *ads;


-(void)startAudoScroll;

-(void)endAutoScroll;

@end
