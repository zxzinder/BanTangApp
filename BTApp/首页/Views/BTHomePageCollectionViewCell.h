//
//  BTHomePageCollectionViewCell.h
//  BTApp
//
//  Created by MacMini on 16/3/23.
//  Copyright © 2016年 MacMini. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BTEntryList;

@interface BTHomePageCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) BTEntryList *entryList;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@end
