//
//  SBNewsViewController.m
//  carmarket
//
//  Created by itensb on 14-8-4.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBNewsViewController.h"
#import "BKUpdateTableView.h"
#import "SBCategoryColView.h"
#import "SBUpdateTableColCell.h"

@interface SBNewsViewController () <UICollectionViewDataSource, UICollectionViewDelegate, SBCategoryColViewDelegate>
{
    UICollectionView *collectionView1;
    SBCategoryColView *categoryView;
}
@end

@implementation SBNewsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"资讯";

    categoryView = [SBCategoryColView new];
    categoryView.sbdelegate = self;
    [self addSubviewInContentView:categoryView];

    UICollectionViewFlowLayout *layout1 = [[UICollectionViewFlowLayout alloc] init];
    layout1.minimumLineSpacing = 0;
    layout1.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    collectionView1 = [[UICollectionView alloc] initWithFrame:CGRectMake(0, [ITUIKitHelper yMarTopView:categoryView margin:0], [ITUIKitHelper getAppWidth], self.cotentSize.height - TABBAR_HEIGHT - categoryView.frame.size.height)  collectionViewLayout:layout1];
    collectionView1.backgroundColor = [UIColor blueColor];
    [collectionView1 registerClass:[SBUpdateTableColCell class] forCellWithReuseIdentifier:@"updateTabColCell"];
    collectionView1.dataSource = self;
    collectionView1.delegate = self;
    collectionView1.pagingEnabled = YES;
    [self addSubviewInContentView:collectionView1];
    
}

#pragma mark - UICollectionView Datasource
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    
    return 10;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellId = @"updateTabColCell";
    
    
    SBUpdateTableColCell *cell = [cv dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }

    UILabel *textLabel = [ITUIKitHelper createLabel:[NSString stringWithFormat:@"%d", (int)indexPath.row] font:[UIFont systemFontOfSize:20] color:[UIColor whiteColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(0, 0) superViewFrame:self.view.frame];
//    cell.text = [NSString stringWithFormat:@"%@", indexPath];
    [cell.contentView addSubview:textLabel];
    cell.backgroundColor = [UIColor purpleColor];
    
    return cell;
    
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}

#pragma mark – UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize retval = CGSizeMake(collectionView.frame.size.width, collectionView.frame.size.height);
    return retval;
}

// 3
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {

    return UIEdgeInsetsMake(0, 0, 0, 0);
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSIndexPath *path = [[collectionView1 indexPathsForVisibleItems] objectAtIndex:0];
    [categoryView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally  animated:YES];
    
}

#pragma mark - SBCategoryViewDelegate
- (void)sbCategoryColView:(SBCategoryColView *)view didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView1 scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:YES];
}

@end
