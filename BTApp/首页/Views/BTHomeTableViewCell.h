//
//  BTHomeTableViewCell.h
//  BTApp
//
//  Created by MacMini on 16/3/24.
//  Copyright © 2016年 MacMini. All rights reserved.
//

#import <UIKit/UIKit.h>


@class BTHomeTopic;

@interface BTHomeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIButton *likeBtn;

-(void)configureCellWithTopic:(BTHomeTopic *)topic;

@end
