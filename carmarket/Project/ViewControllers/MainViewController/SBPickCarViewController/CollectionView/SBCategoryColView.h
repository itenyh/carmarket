//
//  SBCategoryColView.h
//  carmarket
//
//  Created by itensb on 14-8-5.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SBCategoryColView;
@protocol SBCategoryColViewDelegate <NSObject>
@optional
- (void)sbCategoryColView:(SBCategoryColView *)view didSelectItemAtIndexPath:(NSIndexPath *)indexPath data:(id)data;

@end

@interface SBCategoryColView : UICollectionView

@property (nonatomic, weak) id<SBCategoryColViewDelegate> sbdelegate;
@property (nonatomic, copy) NSArray *data;
@property (nonatomic, assign) int selectedIndex;

@property (nonatomic, strong) NSDictionary *selectedInfo;

- (void)selectIndex:(int)index;

@end
