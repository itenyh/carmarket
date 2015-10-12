//
//  SBDetailCarViewController.m
//  carmarket
//
//  Created by itensb on 14-8-6.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBDetailCarViewController.h"
#import "SBCategoryColView.h"
#import "BKUpdateTableView.h"

#import "SBDetailCarTypeColCell.h"
#import "SBUpdateSegViewCell.h"
#import "SBLowPriceColCell.h"

@interface SBDetailCarViewController () <SBCategoryColViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    UICollectionView *collectionView1;
}
@end

@implementation SBDetailCarViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    self.title = @"奥迪A8L";
    
    SBCategoryColView *categoryView = [SBCategoryColView new];
    categoryView.data = [NSArray arrayWithObjects:@"车款", @"降价", @"口碑", nil];
    categoryView.sbdelegate = self;
    [self addSubviewInContentView:categoryView];
    
    UICollectionViewFlowLayout *layout1 = [[UICollectionViewFlowLayout alloc] init];
    layout1.minimumLineSpacing = 0;
    layout1.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    collectionView1 = [[UICollectionView alloc] initWithFrame:CGRectMake(0, [ITUIKitHelper yMarTopView:categoryView margin:0], [ITUIKitHelper getAppWidth], self.cotentSize.height - categoryView.frame.size.height)  collectionViewLayout:layout1];
    collectionView1.backgroundColor = [UIColor clearColor];
    [collectionView1 registerClass:[SBDetailCarTypeColCell class] forCellWithReuseIdentifier:@"carTypeCell"];
    [collectionView1 registerClass:[SBUpdateSegViewCell class] forCellWithReuseIdentifier:@"updateTabSegCell"];
    [collectionView1 registerClass:[SBLowPriceColCell class] forCellWithReuseIdentifier:@"lowPriceCell"];
    collectionView1.dataSource = self;
    collectionView1.delegate = self;
    collectionView1.pagingEnabled = YES;
    collectionView1.scrollEnabled = NO;
    [self addSubviewInContentView:collectionView1];
    
}

#pragma mark - UICollectionView Datasource
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    
    return 3;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row == 2) {
        NSString *cellId = @"updateTabSegCell";
        SBUpdateSegViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
        [cell createView:UITableViewStylePlain];
        return cell;
    }
    
    else if (indexPath.row == 1) {
        NSString *cellId = @"lowPriceCell";
        SBLowPriceColCell *cell = [cv dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
        [cell createView:UITableViewStylePlain];
        return cell;
    }
    
    else {
        NSString *cellId = @"carTypeCell";
        SBDetailCarTypeColCell *cell = [cv dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
        [cell createView:UITableViewStylePlain];
        return cell;
    }
    
    
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark – UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize retval = CGSizeMake(collectionView.frame.size.width, collectionView.frame.size.height);
    return retval;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
    
}

#pragma mark - SBCategoryViewDelegate
- (void)sbCategoryColView:(SBCategoryColView *)view didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView1 scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:NO];
}

#pragma mark -车款的代理
- (void)SBLowPriceCarCell_phBtn:(SBLowPriceCarCell *)cell
{
    NSLog(@"%@", cell.info);
}

@end
