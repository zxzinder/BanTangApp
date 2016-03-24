//
//  BTHomeTableViewCell.m
//  BTApp
//
//  Created by MacMini on 16/3/24.
//  Copyright © 2016年 MacMini. All rights reserved.
//

#import "BTHomeTableViewCell.h"
#import "BTHomeTopic.h"

@implementation BTHomeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)configureCellWithTopic:(BTHomeTopic *)topic{
    
    [_iconImageView fadeImageWithUrl:topic.pic];
    _titleLabel.text = topic.title;
    [_likeBtn setTitle:topic.likes forState:UIControlStateNormal];
}

@end
