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
#import "SBCarStylePriceTblCell.h"
#import "SBUpdateSegViewCell.h"
#import "SBLowPriceColCell.h"
#import "SBCarVideoColCell.h"

#import "SBDetailCarInfoViewController.h"
#import "SBLowestPriceConsultViewCotroller.h"
#import "SBPriceConsultViewController.h"
#import "SBDetailCarOilInfoController.h"

#import "SBPickCarVCInterface.h"
#import "SBBuyCarVCInterface.h"

#import "SBPriceDetailViewController.h"
#import "SBCarArgViewController.h"

@interface SBDetailCarViewController () <SBCategoryColViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    UICollectionView *collectionView1;
    
    NSMutableDictionary *carModelDatas;
    NSMutableDictionary *lowPriceDatas;
    
}
@end

@implementation SBDetailCarViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    lowPriceDatas = [NSMutableDictionary dictionary];
    
    SBCategoryColView *categoryView = [SBCategoryColView new];
    categoryView.data = [NSArray arrayWithObjects:@"车款", @"降价", nil];
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
    [collectionView1 registerClass:[SBCarVideoColCell class] forCellWithReuseIdentifier:@"video"];
    collectionView1.dataSource = self;
    collectionView1.delegate = self;
    collectionView1.pagingEnabled = YES;
    collectionView1.scrollEnabled = NO;
    [self addSubviewInContentView:collectionView1];
    
    NSString *brandId = [[SBRequestParamBus instance] getParamWith:self key:@"brandId"];
    NSDictionary *carDict = [[SBRequestParamBus instance] getParamWith:self key:@"carInfo"];
    NSString *carId = [carDict objectForKey:@"carModelId"];
    
    carModelDatas = [NSMutableDictionary dictionaryWithObject:carDict forKey:@"carData"];
    [SBPickCarVCInterface requestCarModelWith:brandId model:carId SuccessBlock:^(id successValue) {

        [carModelDatas setObject:successValue forKey:@"carList"];
        [collectionView1 reloadData];
        
    } andFailBlock:^(id failValue) {
        
    }];
    
    self.title = ([carDict objectForKey:@"showName"] == nil ? [carDict objectForKey:@"modelName"] : [carDict objectForKey:@"showName"]);
    
}

#pragma mark - UICollectionView Datasource
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    
    return 4;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row == 0) {
        NSString *cellId = @"carTypeCell";
        SBDetailCarTypeColCell *cell = [cv dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
        [cell createView:UITableViewStylePlain bkTableStyle:BKUpdateTableViewTypeNoUpdate];
        [cell display:[NSMutableDictionary dictionaryWithDictionary:carModelDatas]];
        return cell;
    }
    
    else if (indexPath.row == 1) {
        NSString *cellId = @"lowPriceCell";
        SBLowPriceColCell *cell = [cv dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
        [cell createView:UITableViewStylePlain bkTableStyle:BKUpdateTableViewTypePlain topInset:10];
        [cell display:[NSMutableDictionary dictionaryWithDictionary:lowPriceDatas]];
        return cell;
    }
    
    else if (indexPath.row == 2) {
        NSString *cellId = @"updateTabSegCell";
        SBUpdateSegViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
        [cell createView:UITableViewStylePlain];
        return cell;
    }
    
    else  {
        NSString *cellId = @"video";
        SBCarVideoColCell *cell = [cv dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
        [cell createView:UITableViewStylePlain];
        return cell;
    }
    
    
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {}

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
- (void)sbCategoryColView:(SBCategoryColView *)view didSelectItemAtIndexPath:(NSIndexPath *)indexPath data:(NSDictionary *)data
{
    //降价
    if (indexPath.row == 1) {
        
        [SBBuyCarVCInterface requestLowPriceActivities:[self getLowPriceParam] pageSize:DEFAULT_PAGESIZE pageIndex:1 isCache:NO successBlock:^(id successValue) {
           
            if([successValue isKindOfClass:[NSArray class]])
                if(((NSArray *)successValue).count == 0){[self showErrorMessageOnCenter:NO_DATA_INFO];}
            lowPriceDatas = [NSMutableDictionary dictionaryWithObject:successValue forKey:@"data"];
            [lowPriceDatas setObject:[NSNumber numberWithInt:1] forKey:@"curPage"];
            [collectionView1 reloadData];

            
        } andFailBlock:^(id failValue) {
            
        }];
        
    }
    
    [collectionView1 scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:NO];
}

#pragma mark -车款的代理
- (void)SBLowPriceColCell_Cell:(SBaseTableViewCell *)cell
{
    SBPriceDetailViewController *priceCon = [[SBPriceDetailViewController alloc] initWithNavi:YES];
    [[SBRequestParamBus instance] setParamWith:priceCon key:@"info" value:cell.info];
    [self push_rootNaviController:priceCon animated:YES];
    
}

- (void)SBDetailCarTypeColCell_Cell:(SBaseTableViewCell *)cell
{
    
    NSString *brandId = [[SBRequestParamBus instance] getParamWith:self key:@"brandId"];
    NSDictionary *carDict = [[SBRequestParamBus instance] getParamWith:self key:@"carInfo"];
    NSString *modelId = [carDict objectForKey:@"carModelId"];
    NSString *carStyle = [cell.info objectForKey:@"carStyleId"];
    
    SBDetailCarInfoViewController *vc = [[SBDetailCarInfoViewController alloc] initWithNavi:YES];
    [[SBRequestParamBus instance] setParamWith:vc key:@"brandId" value:brandId];
    [[SBRequestParamBus instance] setParamWith:vc key:@"modelId" value:modelId];
    [[SBRequestParamBus instance] setParamWith:vc key:@"carStyle" value:carStyle];
    [[SBRequestParamBus instance] setParamWith:vc key:@"carStyleInfo" value:cell.info];
    [[SBRequestParamBus instance] setParamWith:vc key:@"carInfo" value:carDict];
    [self push_rootNaviController:vc animated:YES];
    
//    SBCarArgViewController *vc1 = [[SBCarArgViewController alloc] initWithNavi:YES];
//    [[SBRequestParamBus instance] setParamWith:vc1 key:@"brandId" value:brandId];
//    [[SBRequestParamBus instance] setParamWith:vc1 key:@"modelId" value:modelId];
//    [[SBRequestParamBus instance] setParamWith:vc1 key:@"carStyle" value:carStyle];
//    [self push_rootNaviController:vc1 animated:YES];
    

}

//降价条目下
- (void)SBCarStylePriceTblCell_Button:(UIButton *)btn Cell:(SBaseTableViewCell *)cell
{
    if (btn.tag == 0) {
        [ITUtils dialPhoneNumber:btn.titleLabel.text];
    }
    
    else if (btn.tag == 1) {
//        [self push_rootNaviController:[[SBLowestPriceConsultViewCotroller alloc] initWithNavi:YES] animated:YES];
    }
    
    else {
        [self push_rootNaviController:[[SBLowestPriceConsultViewCotroller alloc] initWithNavi:YES] animated:YES];
    }
}

- (void)SBDetailCarInfoTblCell_moreBtn:(SBaseTableViewCell *)cell
{
    NSString *brandId = [[SBRequestParamBus instance] getParamWith:self key:@"brandId"];
    NSDictionary *carDict = [[SBRequestParamBus instance] getParamWith:self key:@"carInfo"];
    NSString *carId = [carDict objectForKey:@"carModelId"];
    
    SBDetailCarOilInfoController *oilCon = [[SBDetailCarOilInfoController alloc] initWithNavi:YES];
    [[SBRequestParamBus instance] setParamWith:oilCon key:@"brandId" value:brandId];
    [[SBRequestParamBus instance] setParamWith:oilCon key:@"carId" value:carId];
    [self push_rootNaviController:oilCon animated:YES];
}

- (void)SBLowPriceCarCell_Button:(UIButton *)btn Cell:(SBaseTableViewCell *)cell
{
    if (btn.tag == 0) {
        [ITUtils dialPhoneNumber:btn.titleLabel.text];
    }
    
    else if (btn.tag == 1) {
        [self push_rootNaviController:[[SBPriceConsultViewController alloc] initWithNavi:YES] animated:YES];
    }
}

#pragma - mark tableUpdate
- (void)SBUpdateTableColCell_Refresh:(BKUpdateTableView *)tbView
{
    [SBBuyCarVCInterface requestLowPriceActivities:[self getLowPriceParam] pageSize:20 pageIndex:1 isCache:NO successBlock:^(id successValue) {
        
        if([successValue isKindOfClass:[NSArray class]])
            if(((NSArray *)successValue).count == 0){[self showErrorMessageOnCenter:NO_DATA_INFO];}
        lowPriceDatas = [NSMutableDictionary dictionaryWithObject:successValue forKey:@"data"];
        [lowPriceDatas setObject:[NSNumber numberWithInt:1] forKey:@"curPage"];
        [collectionView1 reloadData];
        
        tbView.pullTableIsRefreshing = NO;
        
    } andFailBlock:^(id failValue) {
        
        tbView.pullTableIsRefreshing = NO;
        
    }];
}

- (void)SBUpdateTableColCell_LoadMore:(BKUpdateTableView *)tbView
{
    int curPage = [[lowPriceDatas objectForKey:@"curPage"] integerValue];
    int requestPage = curPage + 1;
    
    [SBBuyCarVCInterface requestLowPriceActivities:[self getLowPriceParam] pageSize:DEFAULT_PAGESIZE pageIndex:requestPage isCache:NO successBlock:^(id successValue) {
        
        if([successValue isKindOfClass:[NSArray class]])
            
            if(((NSArray *)successValue).count != 0) {
                
                NSMutableArray *datas = [lowPriceDatas objectForKey:@"data"];
                [datas addObjectsFromArray:successValue];
                [lowPriceDatas setObject:[NSNumber numberWithInt:requestPage] forKey:@"curPage"];
            }
        
        [collectionView1 reloadData];
        
        tbView.pullTableIsLoadingMore = NO;
        
    } andFailBlock:^(id failValue) {
        
        tbView.pullTableIsLoadingMore = NO;
        
    }];
}

#pragma - mark 辅助函数
- (NSDictionary *)getLowPriceParam
{
    NSDictionary *carDict = [[SBRequestParamBus instance] getParamWith:self key:@"carInfo"];
    NSString *carId = [carDict objectForKey:@"carModelId"];
    NSDictionary *param = [NSDictionary dictionaryWithObject:carId forKey:@"carModelId"];
    return param;
}

@end
