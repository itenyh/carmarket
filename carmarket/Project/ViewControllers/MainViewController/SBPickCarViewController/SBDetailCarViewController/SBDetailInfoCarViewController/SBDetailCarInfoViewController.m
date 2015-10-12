//
//  SBDetailCarInfoViewController.m
//  carmarket
//
//  Created by itensb on 14-8-11.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBDetailCarInfoViewController.h"
#import "SBNewPriceItemViewController.h"

#import "SBCategoryColView.h"
#import "BKUpdateTableView.h"

#import "SBNewPriceColCell.h"
#import "SBComMapColCell.h"
#import "SBArgDetailColCell.h"

#import "SBaseTableViewCell.h"

#import "SBPickCarVCInterface.h"

@interface SBDetailCarInfoViewController () <SBCategoryColViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    UICollectionView *colView;
    NSMutableArray *carDealerDatas;
}

@end

@implementation SBDetailCarInfoViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    carDealerDatas = [NSMutableArray array];
    
    NSDictionary *carStyleDict = [[SBRequestParamBus instance] getParamWith:self key:@"carStyleInfo"];
    self.title = [carStyleDict objectForKey:@"carName"];

    SBCategoryColView *categoryView = [SBCategoryColView new];
    categoryView.data = [NSArray arrayWithObjects:@"最新报价", @"参数配置", nil];
    categoryView.sbdelegate = self;
    [self addSubviewInContentView:categoryView];
    
    UICollectionViewFlowLayout *layout1 = [[UICollectionViewFlowLayout alloc] init];
    layout1.minimumLineSpacing = 0;
    layout1.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    colView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, [ITUIKitHelper yMarTopView:categoryView margin:0], [ITUIKitHelper getAppWidth], self.cotentSize.height - categoryView.frame.size.height)  collectionViewLayout:layout1];
    [colView registerClass:[SBNewPriceColCell class] forCellWithReuseIdentifier:@"newPriceCell"];
    [colView registerClass:[SBComMapColCell class] forCellWithReuseIdentifier:@"comMapCell"];
    [colView registerClass:[SBArgDetailColCell class] forCellWithReuseIdentifier:@"argDetailCell"];
    colView.backgroundColor = [UIColor clearColor];
    colView.dataSource = self;
    colView.delegate = self;
    colView.pagingEnabled = YES;
    colView.scrollEnabled = NO;
    [self addSubviewInContentView:colView];
    
    NSString *brandId = [[SBRequestParamBus instance] getParamWith:self key:@"brandId"];
    NSString *carModelId = [[SBRequestParamBus instance] getParamWith:self key:@"modelId"];
    NSString *carStyleId = [[SBRequestParamBus instance] getParamWith:self key:@"carStyle"];
   
    [SBPickCarVCInterface requestVenderCarStyle:brandId model:carModelId styleId:carStyleId SuccessBlock:^(id successValue) {
        
//        NSLog(@"successe : %@", successValue);
        carDealerDatas = successValue;
        [colView reloadData];
        
    } andFailBlock:^(id failValue) {
        
    }];

    
}

#pragma mark - UICollectionView Datasource
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    
    return 2;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row == 1) {
        
        NSString *cellId = @"argDetailCell";
        SBArgDetailColCell *cell = [cv dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
        [cell createView:self];
        return cell;
    }
    
//    else if (indexPath.row == 1) {
//        NSString *cellId = @"comMapCell";
//        SBComMapColCell *cell = [cv dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
//        return cell;
//    }
    
    else {
        
        NSString *cellId = @"newPriceCell";
        SBNewPriceColCell *cell = [cv dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
        [cell createView:UITableViewStylePlain bkTableStyle:BKUpdateTableViewTypeOnlyRefresh];
        [cell displayWithDatas:carDealerDatas];
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
- (void)sbCategoryColView:(SBCategoryColView *)view didSelectItemAtIndexPath:(NSIndexPath *)indexPath data:(id)data
{
    [colView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

#pragma mark - 代理方法
- (void)SBNewPriceItemTblCell_Button:(UIButton *)btn Cell:(SBaseTableViewCell *)cell
{
    NSString *phoneNum = [cell.info objectForKey:@"dealerPhone"];
    if (phoneNum) [ITUtils dialPhoneNumber:phoneNum];
}

- (void)SBNewPriceColCell_SBNewPriceItemTblCell:(SBaseTableViewCell *)cell
{
    NSDictionary *carStyleDict = [[SBRequestParamBus instance] getParamWith:self key:@"carStyleInfo"];
    NSDictionary *carModelDict = [[SBRequestParamBus instance] getParamWith:self key:@"carInfo"];
    
    SBNewPriceItemViewController *vc = [[SBNewPriceItemViewController alloc] initWithNavi:YES];
    [[SBRequestParamBus instance] setParamWith:vc key:@"dealerInfo" value:cell.info];
    [[SBRequestParamBus instance] setParamWith:vc key:@"carStyleInfo" value:carStyleDict];
    [[SBRequestParamBus instance] setParamWith:vc key:@"carModelInfo" value:carModelDict];
    
    [self push_rootNaviController:vc animated:YES];
}

#pragma - mark tableUpdate
- (void)SBUpdateTableColCell_Refresh:(BKUpdateTableView *)tbView
{
    NSString *brandId = [[SBRequestParamBus instance] getParamWith:self key:@"brandId"];
    NSString *carModelId = [[SBRequestParamBus instance] getParamWith:self key:@"modelId"];
    NSString *carStyleId = [[SBRequestParamBus instance] getParamWith:self key:@"carStyle"];
    
    [SBPickCarVCInterface requestVenderCarStyle:brandId model:carModelId styleId:carStyleId SuccessBlock:^(id successValue) {
        
//        NSLog(@"successe : %@", successValue);
        carDealerDatas = successValue;
        [colView reloadData];
        tbView.pullTableIsRefreshing = NO;
    } andFailBlock:^(id failValue) {
        tbView.pullTableIsRefreshing = NO;
    }];
    
}

- (void)SBUpdateTableColCell_LoadMore:(BKUpdateTableView *)tbView
{
    
}


@end
