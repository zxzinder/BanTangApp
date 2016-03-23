//
//  BTHomeMidView.m
//  BTApp
//
//  Created by MacMini on 16/3/23.
//  Copyright © 2016年 MacMini. All rights reserved.
//

#import "BTHomeMidView.h"
#import "BTHomePageCollectionViewCell.h"

static NSString *const reuseID = @"colcell";

@interface BTHomeMidView()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation BTHomeMidView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setEntryListArr:(NSArray *)entryListArr{
    
    _entryListArr = entryListArr;
    [self.collectionView reloadData];
    
}
#pragma mark UICollectionViewDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.entryListArr.count;
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BTHomePageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
    
    cell.entryList = self.entryListArr[indexPath.item];
    
    return cell;
    
}

@end
