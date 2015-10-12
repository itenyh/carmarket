//
//  SBCategoryColView.m
//  carmarket
//
//  Created by itensb on 14-8-5.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBCategoryColView.h"

@interface SBCategoryColView () <UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation SBCategoryColView
@synthesize sbdelegate, data, selectedIndex, selectedInfo;

- (id)init
{
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self = [self initWithFrame:CGRectMake(0, 0, [ITUIKitHelper getAppWidth], 40) collectionViewLayout:layout];
    
    if (self) {
        
        data = [NSArray array];
        selectedInfo = [NSDictionary dictionary];
        
        self.showsHorizontalScrollIndicator = NO;
        selectedIndex = 0;
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"categoryCell"];
        self.dataSource = self;
        self.delegate = self;
        
        UIView *lineView = [ITUIKitHelper createIconWithUIImage:[UIImage imageWithColor:[ITUIKitHelper color:@"d6d6d6"] size:CGSizeMake([ITUIKitHelper getAppWidth] + 999, 1)]];
        [ITUIKitHelper pointSet:lineView piont:CGPointMake(- 100, self.frame.size.height - 1)];
        [self addSubview:lineView];
    }
    
    return self;
}

- (void)setData:(NSArray *)_data
{
    data = _data;
    [self reloadData];
}

- (void)selectIndex:(int)index
{
    selectedIndex = index;
    [self reloadData];
}

- (NSDictionary *)selectedInfo
{
    return [data objectAtIndex:selectedIndex];
}

#pragma mark - UICollectionView Datasource
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    
    return data.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellId = @"categoryCell";
    
    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
 
    NSString *title = [self getTitleByData:[data objectAtIndex:indexPath.row]];
    
    UIButton *btn = [ITUIKitHelper createButtonWithUIImage:[UIImage imageNamed:@"bg_menuselect"] highlightImg:nil marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(0, 0) isBackgroundImg:YES superViewFrame:self.frame];
    [ITUIKitHelper sizeSet:btn size:CGSizeMake([self getBgWidth:title], -1)];
    [btn setTitle:title forState:UIControlStateNormal];
    [cell.contentView addSubview:btn];
    btn.userInteractionEnabled = NO;
    
    if (selectedIndex != indexPath.row) {
        
        [btn setBackgroundImage:nil forState:UIControlStateNormal];
        [btn setTitleColor:[ITUIKitHelper color:@"181818"] forState:UIControlStateNormal];
        
    }
    
    return cell;
    
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (selectedIndex == indexPath.row) return; //禁止重复点击
    
    selectedIndex = indexPath.row;
    
    [self reloadData];
    
    if (sbdelegate && [sbdelegate respondsToSelector:@selector(sbCategoryColView:didSelectItemAtIndexPath:data:)]) {
        [sbdelegate sbCategoryColView:self didSelectItemAtIndexPath:indexPath data:[data objectAtIndex:indexPath.row]];
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}

#pragma mark – UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize retval;
    
    if (data.count > 0) {
        
        UIImage *bg = [UIImage imageNamed:@"bg_menuselect"];
        NSString *title = [self getTitleByData:[data objectAtIndex:indexPath.row]];
        retval = CGSizeMake([self getBgWidth:title], bg.size.height);
    }
    
    else {
        retval = CGSizeMake(0, 0);
    }
    
    return retval;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 10, 0, 10);
    
}

#pragma - mar 辅助函数
- (float)getBgWidth:(NSString *)title
{
    UILabel *l = [ITUIKitHelper createLabel:title font:[UIFont systemFontOfSize:30 * PJSAH] color:[UIColor redColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointZero superViewFrame:self.frame];
    return l.frame.size.width + 30;
}

- (NSString *)getTitleByData:(id)_data
{
    if (![_data isKindOfClass:[NSDictionary class]]) return ((NSString *)_data);
    else {
        return [_data objectForKey:@"typeName"];
    }
    
}

@end
