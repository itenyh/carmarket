//
//  SBNewsViewController.m
//  carmarket
//
//  Created by itensb on 14-8-4.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBNewsViewController.h"
#import "SBCategoryColView.h"
#import "SBUpdateTableColCell.h"

#import "SBHeadNewsColCell.h"
#import "SBPinCeColCell.h"

#import "SBBaseCollectionView.h"

#import "SBNewsVCInterface.h"
#import "SBaseTableViewCell.h"

#import "SBNewsWebViewController.h"

@interface SBNewsViewController () <UICollectionViewDataSource, UICollectionViewDelegate, SBCategoryColViewDelegate>
{
    SBBaseCollectionView *collectionView1;
    SBCategoryColView *categoryView;
    
    NSMutableDictionary *infos;
    
}

@end

@implementation SBNewsViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //应对无任何数据的情况
    if(categoryView.data.count == 0) {
        
        [self showLoading];
        
        [SBNewsVCInterface requestNewsTypeWithsuccessBlock:^(id successValue) {
            
            [self stopLoading];
            
            categoryView.data = successValue;
            
            [self requestNewsWithTbView:nil];
            
        } andFailBlock:^(id failValue) {
            
            [self stopLoading];
            
        }];
        
    }
    
    [self correctAdBug];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setTitleWithImage:[UIImage imageNamed:@"icon_titlezixun"]];

    infos = [NSMutableDictionary dictionary];
    
    categoryView = [SBCategoryColView new];
    categoryView.sbdelegate = self;
    [self addSubviewInContentView:categoryView];

    UICollectionViewFlowLayout *layout1 = [[UICollectionViewFlowLayout alloc] init];
    layout1.minimumLineSpacing = 0;
    layout1.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    collectionView1 = [[SBBaseCollectionView alloc] initWithFrame:CGRectMake(0, [ITUIKitHelper yMarTopView:categoryView margin:0], [ITUIKitHelper getAppWidth], self.cotentSize.height - TABBAR_HEIGHT - categoryView.frame.size.height)  collectionViewLayout:layout1];
    collectionView1.backgroundColor = [UIColor clearColor];
    [collectionView1 registerClass:[SBHeadNewsColCell class] forCellWithReuseIdentifier:@"SBHeadNewsColCell"];
    [collectionView1 registerClass:[SBPinCeColCell class] forCellWithReuseIdentifier:@"SBPinCeColCell"];
    collectionView1.dataSource = self;
    collectionView1.delegate = self;
    collectionView1.pagingEnabled = YES;
    collectionView1.showsHorizontalScrollIndicator = NO;
    [self addSubviewInContentView:collectionView1];
    
    [SBNewsVCInterface requestNewsTypeWithsuccessBlock:^(id successValue) {

        categoryView.data = successValue;

        [self requestNewsWithTbView:nil];

    } andFailBlock:^(id failValue) {
        
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(correctAdBug) name:NOTI_ENTER_FORGROUND object:nil];
    
    
}

- (NSString *)getTitleByData:(id)_data
{
    if (![_data isKindOfClass:[NSDictionary class]]) return ((NSString *)_data);
    else {
        return [_data objectForKey:@"typeName"];
    }
    
}

#pragma mark - UICollectionView Datasource
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    
    return categoryView.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray *_data = [[infos objectForKey:[NSString stringWithFormat:@"%d", indexPath.row]] objectForKey:@"data"];
    
    if (indexPath.row == 0) {
        
        NSString *cellId = @"SBHeadNewsColCell";
        
        SBHeadNewsColCell *cell = [cv dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
        [cell createView:UITableViewStylePlain];
        [cell displayWithDatas:_data];
        
        return cell;
        
    }
    
    else {
        
        NSString *cellId = @"SBPinCeColCell";
        
        SBPinCeColCell *cell = [cv dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
        [cell createView:UITableViewStylePlain];
        [cell displayWithDatas:_data];
        
        return cell;
        
    }
    
    
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
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {return UIEdgeInsetsMake(0, 0, 0, 0);}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSIndexPath *path = [collectionView1 indexPathForItemAtPoint:collectionView1.contentOffset];
    [categoryView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    [categoryView selectIndex:path.row];
    
//    [self performSelector:@selector(delayRefreshCurColCell:) withObject:path afterDelay:0.3];
    if (![infos objectForKey:[NSString stringWithFormat:@"%d", path.row]]) [self requestNewsWithTbView:[self get_tbViewWithIndex:path]];
    
    [self correctAdBug];
}

#pragma mark - SBCategoryViewDelegate
- (void)sbCategoryColView:(SBCategoryColView *)view didSelectItemAtIndexPath:(NSIndexPath *)indexPath data:(NSDictionary *)data
{
    [collectionView1 scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
//    [self performSelector:@selector(delayRefreshCurColCell:) withObject:indexPath afterDelay:0.3];
    if (![infos objectForKey:[NSString stringWithFormat:@"%d", indexPath.row]]) [self requestNewsWithTbView:[self get_tbViewWithIndex:indexPath]];
    
    [self correctAdBug];
    
}

//- (void)delayRefreshCurColCell:(NSIndexPath *)indexPath
//{
//    SBUpdateTableColCell *cell = (SBUpdateTableColCell *)[collectionView1 cellForItemAtIndexPath:indexPath];
//    if (![infos objectForKey:[NSString stringWithFormat:@"%d", indexPath.row]]) [cell autoRefeshTable];
//    else if (indexPath.row == 0) [self correctAdBug]; //此专门为解决广告控件的错位问题
//}

#pragma - mark 其他代理
- (void)SBHeadNewsColCell_Cell:(SBaseTableViewCell *)cell
{
    SBNewsWebViewController *wvc = [[SBNewsWebViewController alloc] initWithNavi:YES];
    [[SBRequestParamBus instance] setParamWith:wvc key:@"news" value:cell.info];
    [self push_rootNaviController:wvc animated:YES];
}

- (void)SBHeadNewsAdTblCell_ADData:(NSDictionary *)data
{
    SBNewsWebViewController *wvc = [[SBNewsWebViewController alloc] initWithNavi:YES];
    [[SBRequestParamBus instance] setParamWith:wvc key:@"news" value:data];
    [self push_rootNaviController:wvc animated:YES];
}

#pragma  - mark table刷新
- (void)SBUpdateTableColCell_Refresh:(BKUpdateTableView *)tbView
{
    [self requestNewsWithTbView:tbView];
}

- (void)SBUpdateTableColCell_LoadMore:(BKUpdateTableView *)tbView
{
    [self requestMoreNews:tbView];
}

- (void)requestNewsWithTbView:(BKUpdateTableView *)tbView
{
    [self requestNewsWithTypeId:[self getTypeId] colIndex:categoryView.selectedIndex tbView:tbView];
}

- (void)requestNewsWithTypeId:(NSString *)typeId colIndex:(int)index tbView:(BKUpdateTableView *)tbView
{
    
    [SBNewsVCInterface requestNewsWithTypeId:typeId pageNum:1 pageIndex:-1 successBlock:^(id successValue) {
        
        
        NSMutableArray *dataList = [successValue objectForKey:@"datalist"];
        NSMutableDictionary *_info = [NSMutableDictionary dictionaryWithObjectsAndKeys:dataList, @"data", nil];
        [infos setObject:_info forKey:[NSString stringWithFormat:@"%d", index]];
        
        if(tbView) tbView.pullTableIsRefreshing = NO;
        
        [collectionView1 reloadData];
        
        if (!dataList || dataList.count == 0) [self showErrorMessageOnCenter:@"暂无数据"];
        
        tbView.pageIndex = 1;
        
        [self performSelector:@selector(correctAdBug) withObject:nil afterDelay:0.5];
        
    } andFailBlock:^(id failValue) {
        
        if(tbView) tbView.pullTableIsRefreshing = NO;
        
    }];
}

- (void)requestMoreNews:(BKUpdateTableView *)tbView
{
    
    [SBNewsVCInterface requestNewsWithTypeId:[self getTypeId] pageNum:++tbView.pageIndex pageIndex:0 successBlock:^(id successValue) {
        
        NSMutableDictionary *curDic = [infos objectForKey:[NSString stringWithFormat:@"%d", categoryView.selectedIndex]];
        NSArray *dataList = [successValue objectForKey:@"datalist"];
        NSMutableArray *oldData = [curDic objectForKey:@"data"];
        [oldData addObjectsFromArray:dataList];
        
        tbView.pullTableIsLoadingMore = NO;
        
        [collectionView1 reloadData];
        
    } andFailBlock:^(id failValue) {
        
        tbView.pullTableIsLoadingMore = NO;
        
    }];
}

- (NSString *)getTypeId
{
    return [categoryView.selectedInfo objectForKey:@"typeId"];
}

- (void)correctAdBug
{
//    NSLog(@"correctAdBug");
    [collectionView1 reloadData];
}

- (BKUpdateTableView *)get_tbViewWithIndex:(NSIndexPath *)i
{
    SBUpdateTableColCell *cell = (SBUpdateTableColCell *)[collectionView1 cellForItemAtIndexPath:i];
    return [cell get_tbView];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
