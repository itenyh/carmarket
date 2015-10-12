//
//  BKUpdateTableView.h
//  BKWeiYun2
//
//  Created by itenyh on 13-6-15.
//  Copyright (c) 2013年 beikr. All rights reserved.
//

#import "EGORefreshTableHeaderView.h"
#import "LoadMoreTableFooterView.h"

@class BKUpdateTableView;
@protocol BKUpdateTableViewDelegate <NSObject>
@optional
- (void)pullBKUpdateTableViewDidTriggerRefresh:(BKUpdateTableView*)updateTableView;
- (void)pullBKUpdateTableViewDidTriggerLoadMore:(BKUpdateTableView*)updateTableView;
@end

@protocol BKUpdateTableViewProcessingDelegate <NSObject>
@optional
- (void)BKUpdateTableViewDidSelectRowAtIndexPath:(BKUpdateTableView*)updateTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)BKUpdateTableView:(BKUpdateTableView *)updateTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)BKUpdateTableView:(BKUpdateTableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (CGFloat)BKUpdateTableView:(BKUpdateTableView *)tableView heightForFooterInSection:(NSInteger)section;
- (UIView *)BKUpdateTableView:(BKUpdateTableView *)tableView viewForHeaderInSection:(NSInteger)section;
@end

@protocol BKUpdateTableViewScrollDelegate <NSObject>
@optional
- (void)BKUpdateTableViewDidScroll:(BKUpdateTableView*)updateTableView;
- (void)BKUpdateTableViewDidEndDecelerating:(BKUpdateTableView*)updateTableView;
@end

typedef enum{
    BKUpdateTableViewTypePlain = (1UL << 1),
    BKUpdateTableViewTypeNoUpdate = (1UL << 2),
    BKUpdateTableViewTypeOnlyRefresh = (1UL << 3),
    BKUpdateTableViewTypeOnlyLoadMore = (1UL << 4)
    
} BKUpdateTableViewType;

@interface BKUpdateTableView : UITableView <EGORefreshTableHeaderDelegate, LoadMoreTableFooterDelegate, UITableViewDelegate, UIGestureRecognizerDelegate>
{
    EGORefreshTableHeaderView *refreshView;
    LoadMoreTableFooterView *loadMoreView;
    
    // Status
    BOOL pullTableIsRefreshing;
    BOOL pullTableIsLoadingMore;

    BOOL disableManully;
    
    UIView *empMaskView;

}

@property (nonatomic, strong) NSDate *pullLastRefreshDate;
@property (nonatomic, weak) id<BKUpdateTableViewDelegate> pullUpdateDelegate;
@property (nonatomic, weak) id<BKUpdateTableViewProcessingDelegate> processingDelegate;
@property (nonatomic, weak) id<BKUpdateTableViewScrollDelegate> scrollDelegate;

@property (nonatomic, assign) BOOL pullTableIsRefreshing;
@property (nonatomic, assign) BOOL pullTableIsLoadingMore;

@property (nonatomic, assign) BOOL isSelectedKeeping;
@property (nonatomic, assign) int pageIndex;

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style updateType:(BKUpdateTableViewType)type;
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style updateType:(BKUpdateTableViewType)type tip:(NSString *)_tip;

- (void)reloadData;
- (void)automateRefresh;
- (void)disableLoadMore;
- (void)changeDelegate:(id<UITableViewDelegate>)delegate;
- (void)disableUpdate;
- (void)setProcessingDelegateAndDataSource:(id)dele;

@end
