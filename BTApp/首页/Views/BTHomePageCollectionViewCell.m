//
//  BTHomePageCollectionViewCell.m
//  BTApp
//
//  Created by MacMini on 16/3/23.
//  Copyright © 2016年 MacMini. All rights reserved.
//

#import "BTHomePageCollectionViewCell.h"
#import "BTEntryList.h"

@implementation BTHomePageCollectionViewCell

-(void)setEntryList:(BTEntryList *)entryList{
    
    _entryList = entryList;
    
    [_imageView fadeImageWithUrl:entryList.pic1];
    
}

@end
