//
//  BTTabBarController.m
//  BTApp
//
//  Created by MacMini on 16/3/22.
//  Copyright © 2016年 MacMini. All rights reserved.
//

#import "BTTabBarController.h"
#import "BTNavigationController.h"
#import "HomeViewController.h"

#define BUTTON_LABEL_TAG 111
#define BUTTON_IMAGE_TAG 222

NSString *titles[] = {@"首页", @"社区",@"发表", @"分类", @"我"};


@interface BTTabBarController()<UIViewControllerTransitioningDelegate>
{
 NSMutableArray *buttons;
    BTNavigationController *homeBoardNavi;
}
@end

@implementation BTTabBarController
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        buttons = [[NSMutableArray alloc] initWithCapacity:5];
    }
    return self;
}
-(void)viewDidLoad{
    
    [super viewDidLoad];
    [self addViewControllers];
    for (NSInteger i = 0; i < 5; i++) {
        UIButton *btn = [self createBtnForImage:[self normalImageForIndex:i] tag:i];
        [buttons addObject:btn];
        [self.tabBar addSubview:btn];
        CGFloat width = self.tabBar.bounds.size.width / 5;
        btn.frame = CGRectMake(i * width, 0, width, self.tabBar.bounds.size.height);
//        NSInteger index = [[DataManager objectForRead:@"redDotIndex"]integerValue];
//        if (i == 2 && index != 1) {
//            redDot = [[UIView alloc] initWithFrame:CGRectMake(width / 2 + 11, 3, 7, 7)];
//            redDot.backgroundColor = [UIColor colorWithRed:0.910 green:0.353 blue:0.353 alpha:1.000];
//            redDot.layer.cornerRadius = 3.5;
//            redDot.layer.masksToBounds = YES;
//            [btn addSubview:redDot];
//        }
    }
    self.selectedIndex = 0;
    [self highlightButtonWithIndex:0];
    
}
- (void)addViewControllers
{
    UIStoryboard *homeBoardStoryboard = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
    UIStoryboard *transferStoryboard = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
    UIStoryboard *cardStoryboard = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
    UIStoryboard *meStoryboard = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
     UIStoryboard *me2Storyboard = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
     homeBoardNavi = homeBoardStoryboard.instantiateInitialViewController;
    BTNavigationController *transferNavi = transferStoryboard.instantiateInitialViewController;
    BTNavigationController *cardNavi = cardStoryboard.instantiateInitialViewController;
    BTNavigationController *meNavi = meStoryboard.instantiateInitialViewController;
    BTNavigationController *me2Navi = me2Storyboard.instantiateInitialViewController;

    self.viewControllers = @[homeBoardNavi,transferNavi,cardNavi,meNavi,me2Navi];
    
}
#pragma mark Buttons
- (void)highlightButtonWithIndex:(NSInteger)index
{
    UIButton *button = buttons[index];
    UIImageView *imageView = (UIImageView *)[button viewWithTag:BUTTON_IMAGE_TAG];
    imageView.image = [self highlightImageForIndex:button.tag];
}

- (void)normalizeButtonWithIndex:(NSInteger)index
{
    UIButton *button = buttons[index];
    UIImageView *imageView = (UIImageView *)[button viewWithTag:BUTTON_IMAGE_TAG];
    imageView.image = [self normalImageForIndex:button.tag];
}
- (UIButton *)createBtnForImage:(UIImage *)image tag:(NSInteger)tag
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = tag;
    btn.backgroundColor = [UIColor whiteColor];
    [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
  
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = [UIColor clearColor];
    imageView.tag = BUTTON_IMAGE_TAG;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.image = image;
  
    [btn addSubview:imageView];
    [self SetConstraintsForImageView:imageView onButton:btn];
    
    return btn;
}

- (void)SetConstraintsForImageView:(UIImageView *)imageView onButton:(UIButton *)button
{
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:25];
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:25];
    [imageView addConstraints:@[heightConstraint, widthConstraint]];
   
    NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:button attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
    NSLayoutConstraint *centerConstraint = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:button attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    [button addConstraints:@[centerYConstraint, centerConstraint]];
}

- (UIImage *)normalImageForIndex:(NSInteger)index
{
    NSArray *names = @[@"tab_首页", @"tab_社区",@"tab_publish_add", @"tab_分类", @"tab_我的"];
    return [UIImage imageNamed:names[index]];
}

- (UIImage *)highlightImageForIndex:(NSInteger)index
{
    NSArray *names = @[@"tab_首页_pressed", @"tab_社区_pressed",@"tab_publish_add_pressed", @"tab_分类_pressed", @"tab_我的_pressed"];
    return [UIImage imageNamed:names[index]];
}


#pragma mark PressSelector
- (void)buttonPressed:(UIButton *)button
{
    [self normalizeButtonWithIndex:self.selectedIndex];
    self.selectedIndex = button.tag;
    [self highlightButtonWithIndex:button.tag];
//    NSInteger index = [[DataManager objectForRead:@"redDotIndex"]integerValue];
//    if (button.tag == 2 && index != 1) {
//        UIButton *but = buttons[button.tag];
//        for(int i = 0;i<[but.subviews count];i++){
//            if ([but.subviews objectAtIndex:i] == redDot) {
//                [[but.subviews objectAtIndex:i] removeFromSuperview];
//            }
//        }
//        [DataManager saveObject:@"1" forKey:@"redDotIndex"];
//    }
}

@end
