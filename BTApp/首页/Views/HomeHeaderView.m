//
//  HomeHeaderView.m
//  BTApp
//
//  Created by MacMini on 16/3/22.
//  Copyright © 2016年 MacMini. All rights reserved.
//

#import "HomeHeaderView.h"
#import "BTHomeBanner.h"
#import <SDWebImage/UIImageView+WebCache.h>

typedef NS_ENUM(NSUInteger, BBCustomBusAdViewScrollDirection) {
    BBCustomBusAdViewLeft,  //界面朝左划
    BBCustomBusAdViewRight
};

@interface HomeHeaderView()
{
    NSMutableArray *buttons;
    NSInteger index;
    NSTimer *timer;
}

@end

@implementation HomeHeaderView

- (void)awakeFromNib
{
    buttons = [NSMutableArray array];
 }
-(void)dealloc{
    
    [self endAutoScroll];
    
}

- (void)setAds:(NSArray *)ads
{
   
    if (_ads != ads) {
        _ads = ads;
      
        for (UIImageView *imageView in buttons) {
            [imageView removeFromSuperview];
        }
        
        [buttons removeAllObjects];
        for (NSInteger i = 0; i < _ads.count; i++) {
            BTHomeBanner *ad = _ads[i];
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
            btn.imageView.contentMode = UIViewContentModeScaleAspectFill;
            btn.tag = i;
//            [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [btn sd_setImageWithURL:[NSURL URLWithString:ad.photo] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@""]];
            [btn sd_setImageWithURL:[NSURL URLWithString:ad.photo] forState:UIControlStateHighlighted placeholderImage:[UIImage imageNamed:@""]];
            [_scrollView addSubview:btn];
            [buttons addObject:btn];
        }
       
        _scrollView.contentSize = CGSizeMake(self.frame.size.width * _ads.count, self.frame.size.height);
        _scrollView.contentOffset = CGPointZero;
        _pageControl.numberOfPages = _ads.count;
        _pageControl.currentPage = 0;
        //_pageControlWidthConstraint.constant = [_pageControl sizeForNumberOfPages:_ads.count].width;
    }
}

#pragma mark scroll
-(void)startAudoScroll{
    
    if (!timer && _ads.count) {
        timer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(scroll) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    }
    
}

-(void)endAutoScroll{
    
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    
}

- (void)scroll
{
    index = (index + 1)%_ads.count;
    _pageControl.currentPage = index;
    if ([_ads count]> 0) {
 
        if (_scrollView.contentOffset.x >= _scrollView.contentSize.width - _scrollView.bounds.size.width) {
            [self adjustViewsForInfiniteScrollAtDirection:BBCustomBusAdViewLeft];
        }
        [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x + _scrollView.frame.size.width, 0) animated:YES];
    }
}
#pragma mark Helper
- (void)adjustViewsForInfiniteScrollAtDirection:(BBCustomBusAdViewScrollDirection)direction
{
    if (direction == BBCustomBusAdViewLeft) {
        for (UIView *view in _scrollView.subviews) {
            if (view.frame.origin.x < _scrollView.frame.size.width) {
                CGRect frame = view.frame;
                frame.origin.x = view.frame.origin.x + _scrollView.contentSize.width;
                view.frame = frame;
            }
            CGRect frame = view.frame;
            frame.origin.x = view.frame.origin.x - _scrollView.frame.size.width;
            view.frame = frame;
        }
        _scrollView.contentOffset = CGPointMake(_scrollView.contentOffset.x - _scrollView.frame.size.width, 0);
    } else if (direction == BBCustomBusAdViewRight) {
        for (UIView *view in _scrollView.subviews) {
            if (view.frame.origin.x >= _scrollView.contentSize.width - _scrollView.frame.size.width) {
                CGRect frame = view.frame;
                frame.origin.x = view.frame.origin.x - _scrollView.contentSize.width;
                view.frame = frame;
            }
            CGRect frame = view.frame;
            frame.origin.x = view.frame.origin.x + _scrollView.frame.size.width;
            view.frame = frame;
        }
        _scrollView.contentOffset = CGPointMake(_scrollView.contentOffset.x + _scrollView.frame.size.width, 0);
    }
}
@end
