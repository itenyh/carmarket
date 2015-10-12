//
//  SBCarsViewController.m
//  carmarket
//
//  Created by itensb on 14-11-3.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBCarsViewController.h"
#import "SBPickCarVCInterface.h"
#import "SBaseTableViewCell.h"
#import "SBDetailCarViewController.h"

@interface SBCarsViewController () <BKUpdateTableViewDelegate, BKUpdateTableViewProcessingDelegate, BKUpdateTableViewScrollDelegate>

@end

@implementation SBCarsViewController
@synthesize pcView;

- (id)initWithNavi:(BOOL)navi leftBtnType:(NDLeftBtnType)type
{
    self = [super initWithNavi:navi leftBtnType:type];
    
    if (self) {
    
        self.view.frame = CGRectMake(0, 0, [ITUIKitHelper getAppWidth], [ITUIKitHelper getAppHeight]);
        
    }
    
    
    return self;
}

//- (id)initWithNavi:(BOOL)navi
//{
//    self = [super initWithNavi:navi];
//    
//    if (self) {
//        
//        self.view.frame = CGRectMake(0, 0, [ITUIKitHelper getAppWidth], 0);
//        
//        pcView = [[SBPickCarView alloc] initWithFrame:CGRectMake(0, 0, [ITUIKitHelper getAppWidth], 0)];
//        pcView.tbView.pullUpdateDelegate = self;
//        pcView.tbView.scrollDelegate = self;
//        [pcView setTargetVC:self];
//        [self addSubviewInContentView:pcView];
//        
//        [SBPickCarVCInterface requestAllBrandCarSuccessBlock:^(id successValue) {
//            [pcView setBrandListData:successValue];
//        } andFailBlock:^(id failValue) {}];
//        
//        [SBPickCarVCInterface requestHotBrandCarSuccessBlock:^(id successValue) {
//            if (successValue) [pcView setHotBrandData:[NSDictionary dictionaryWithObject:successValue forKey:@"data"]];
//        } andFailBlock:^(id failValue) {}];
//        
//    }
//    
//    return self;
//}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"车型库";
    
    pcView = [[SBPickCarView alloc] initWithFrame:CGRectMake(0, 0, [ITUIKitHelper getAppWidth], self.cotentSize.height)];
    pcView.tbView.pullUpdateDelegate = self;
    pcView.tbView.scrollDelegate = self;
    [pcView setTargetVC:self];
    [self addSubviewInContentView:pcView];
    
    [SBPickCarVCInterface requestAllBrandCarSuccessBlock:^(id successValue) {
        [pcView setBrandListData:successValue];
    } andFailBlock:^(id failValue) {}];
    
    [SBPickCarVCInterface requestHotBrandCarSuccessBlock:^(id successValue) {
        if (successValue) [pcView setHotBrandData:[NSDictionary dictionaryWithObject:successValue forKey:@"data"]];
    } andFailBlock:^(id failValue) {}];
    
}

#pragma - mark 其他代理
- (void)SBPickCarTableView_Cell:(SBaseTableViewCell *)cell
{
    [pcView.brandListView clear];
    [pcView.brandListView show];
    
    NSNumber *brandIdNum = [cell.info objectForKey:@"brandId"];
    NSString *brandId = [brandIdNum isKindOfClass:[NSNumber class]] ? [brandIdNum stringValue] : (NSString *)brandIdNum;
    pcView.brandListView.brandId = brandId;
    
    [SBPickCarVCInterface requestBrandCarModelWithBrandId:brandId SuccessBlock:^(id successValue) {
        
        if ([brandId isEqualToString:pcView.brandListView.brandId]) {
            pcView.brandListView.brandId = brandId;
            [pcView.brandListView reloadWithDatas:successValue];
            [self showNO_DATA_INFO];
        }
        
    } andFailBlock:^(id failValue) {}];

}

- (void)SBHotBrandCell_Btn:(UIButton *)btn Data:(NSDictionary *)data
{
    [pcView.brandListView clear];
    [pcView.brandListView show];
    
    NSNumber *brandIdNum = [data objectForKey:@"brandId"];
    NSString *brandId = [brandIdNum isKindOfClass:[NSNumber class]] ? [brandIdNum stringValue] : (NSString *)brandIdNum;
    pcView.brandListView.brandId = brandId;
    
    [SBPickCarVCInterface requestBrandCarModelWithBrandId:brandId SuccessBlock:^(id successValue) {
        
        if ([brandId isEqualToString:pcView.brandListView.brandId]) {
            pcView.brandListView.brandId = brandId;
            [pcView.brandListView reloadWithDatas:successValue];
            [self showNO_DATA_INFO];
        }
        
    } andFailBlock:^(id failValue) {}];
    
    
}

- (void)SBSingleBrandlListView_Cell:(SBaseTableViewCell *)cell
{
    if (_delegate && [_delegate respondsToSelector:@selector(sBCarsViewControllerCarStyleClick:cell:)]) {
        [_delegate sBCarsViewControllerCarStyleClick:self cell:cell];
    }
}

- (void)SBPickCarTableView_SectionIndex:(NSString *)sectionTitle
{
    if (_delegate && [_delegate respondsToSelector:@selector(sBCarsViewControllerTableIndex:sectionTitle:)]) {
        [_delegate sBCarsViewControllerTableIndex:self sectionTitle:sectionTitle];
    }
    else {
        [self showTblIndexMessageOnCenter:sectionTitle];
    }
    
}

#pragma - mark SBPickCarTableView Delegate
- (void)BKUpdateTableViewDidScroll:(BKUpdateTableView *)updateTableView
{
    [pcView.brandListView hide:YES];
}

- (void)pullBKUpdateTableViewDidTriggerLoadMore:(BKUpdateTableView *)updateTableView
{
    
}

- (void)pullBKUpdateTableViewDidTriggerRefresh:(BKUpdateTableView *)updateTableView
{
    
    [SBPickCarVCInterface requestAllBrandCarSuccessBlock:^(id successValue) {
        
        pcView.tbView.data = successValue;
        
        [SBPickCarVCInterface requestHotBrandCarSuccessBlock:^(id successValue) {
            if (successValue) pcView.tbView.hotdata = [NSDictionary dictionaryWithObject:successValue forKey:@"data"];
            
            updateTableView.pullTableIsRefreshing = NO;
            
        } andFailBlock:^(id failValue) {
            
            updateTableView.pullTableIsRefreshing = NO;
            
        }];
        
        
    } andFailBlock:^(id failValue) {
        
        updateTableView.pullTableIsRefreshing = NO;
        
    }];
    
}

- (void)showNO_DATA_INFO
{
    UIViewController *vc = self.parentViewController;
    if ([vc isKindOfClass:[SBBaseViewController class]]) {
        SBBaseViewController *vc1 = (SBBaseViewController *)vc;
        if (pcView.brandListView.datas.allKeys.count == 0) [vc1 showErrorMessageOnCenter:@"暂无该车型数据"];
    }
    else {
        if (pcView.brandListView.datas.allKeys.count == 0) [self showErrorMessageOnCenter:@"暂无该车型数据"];
    }
}

- (BOOL)shouldAutorotate
{
    return NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
