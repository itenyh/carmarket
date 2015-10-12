//
//  BKUpdateTableView.m
//  BKWeiYun2
//
//  Created by itenyh on 13-6-15.
//  Copyright (c) 2013年 beikr. All rights reserved.
//

#import "BKUpdateTableView.h"

@implementation BKUpdateTableView
@synthesize pullTableIsLoadingMore, pullTableIsRefreshing, processingDelegate, pullUpdateDelegate, isSelectedKeeping, pageIndex;

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style updateType:(BKUpdateTableViewType)type tip:(NSString *)_tip
{
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        
        isSelectedKeeping = NO;
        pageIndex = 1;
        
        switch (type) {
            case BKUpdateTableViewTypePlain:
            {
                //如果主动调用了disableUpdate方法，那么即使刷新也不能恢复刷新功能
                disableManully = NO;
                
                /* Status Properties */
                pullTableIsRefreshing = NO;
                pullTableIsLoadingMore = NO;
                
                /* Refresh View */
                refreshView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, -self.bounds.size.height, self.bounds.size.width, self.bounds.size.height)];
                refreshView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
                refreshView.delegate = self;
                [self addSubview:refreshView];
                
                /* Load more view init */
                loadMoreView = [[LoadMoreTableFooterView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, self.bounds.size.height)];
                loadMoreView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
                loadMoreView.delegate = self;
                [self addSubview:loadMoreView];
            }
                break;
            case BKUpdateTableViewTypeNoUpdate:
            {
                
            }
                break;
            case BKUpdateTableViewTypeOnlyRefresh:
            {
                /* Status Properties */
                pullTableIsRefreshing = NO;
                pullTableIsLoadingMore = NO;
                
                /* Refresh View */
                refreshView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, -self.bounds.size.height, self.bounds.size.width, self.bounds.size.height)];
                refreshView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
                refreshView.delegate = self;
                [self addSubview:refreshView];
            }
                break;
            case BKUpdateTableViewTypeOnlyLoadMore:
            {
                /* Status Properties */
                pullTableIsRefreshing = NO;
                pullTableIsLoadingMore = NO;
                
                /* Load more view init */
                loadMoreView = [[LoadMoreTableFooterView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, self.bounds.size.height)];
                loadMoreView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
                loadMoreView.delegate = self;
                [self addSubview:loadMoreView];
            }
                break;
            default:
                break;
        }
        
        [self avoidGestureConflict];
        
        self.delegate = self;
        
        empMaskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        empMaskView.backgroundColor = [UIColor clearColor];
        empMaskView.tag = 1;
        UILabel *tip = [[UILabel alloc] initWithFrame:CGRectMake(0, (empMaskView.frame.size.height - 100) / 2.0, empMaskView.frame.size.width, 100)];
        if(_tip) tip.text = _tip;
        else tip.text = @"没有数据哦,请尝试刷新~";
        tip.textAlignment = NSTextAlignmentCenter;
        tip.textColor = [UIColor darkGrayColor];
        [empMaskView addSubview:tip];
        [self addSubview:empMaskView];
        
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style updateType:(BKUpdateTableViewType)type
{
    self = [self initWithFrame:frame style:style updateType:type tip:nil];
    
    if (self) {
        empMaskView.tag = 0;
        empMaskView.hidden = YES;
    }
    
    return self;
}


- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [self initWithFrame:frame style:style updateType:BKUpdateTableViewTypePlain];
    if (self) {}
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [self initWithFrame:frame style:UITableViewStylePlain];
    if (self) {}
    return self;
}

- (void)disableUpdate
{
    disableManully = YES;
    
    refreshView.delegate = nil;
    loadMoreView.delegate = nil;
    
    [refreshView removeFromSuperview];
    [loadMoreView removeFromSuperview];
}

- (void)disableLoadMore
{
    disableManully = YES;
    
    loadMoreView.delegate = nil;
    [loadMoreView removeFromSuperview];
}

- (void)tempDisableLoadMore
{
    loadMoreView.delegate = nil;
    [loadMoreView removeFromSuperview];
}

- (void)recoverLoadMore
{
    if (loadMoreView.delegate == nil) {
        loadMoreView.delegate = self;
        [self addSubview:loadMoreView];
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //只要滑动就重新定位loadMoreFrame的位置
    CGRect loadMoreFrame = loadMoreView.frame;
    loadMoreFrame.origin.y = self.contentSize.height;
    loadMoreView.frame = loadMoreFrame;
}

- (void)setProcessingDelegateAndDataSource:(id)dele
{
    self.dataSource = dele;
    self.processingDelegate = dele;
}

#pragma mark - Preserving the original behaviour
- (void)setDelegate:(id<UITableViewDelegate>)delegate
{
    //只允许在内部设置delegate
    if (self.delegate == nil) {
        [super setDelegate:delegate];
    }
}

- (void)changeDelegate:(id<UITableViewDelegate>)delegate
{
    [super setDelegate:delegate];
}

- (void)setPullTableIsRefreshing:(BOOL)isRefreshing
{
    if(!pullTableIsRefreshing && isRefreshing) {
        // If not allready refreshing start refreshing
        [refreshView startAnimatingWithScrollView:self];
        pullTableIsRefreshing = YES;
    } else if(pullTableIsRefreshing && !isRefreshing) {
        [refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
        pullTableIsRefreshing = NO;
    }
}

- (void)setPullTableIsLoadingMore:(BOOL)isLoadingMore
{
    if(!pullTableIsLoadingMore && isLoadingMore) {
        // If not allready loading more start refreshing
        [loadMoreView startAnimatingWithScrollView:self];
        pullTableIsLoadingMore = YES;
    } else if(pullTableIsLoadingMore && !isLoadingMore) {
        [loadMoreView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
        pullTableIsLoadingMore = NO;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    [self avoidGestureConflict];
    
    if(refreshView.delegate != nil){
        [refreshView egoRefreshScrollViewDidScroll:scrollView];
    }
    
    if(loadMoreView.delegate != nil){
        [loadMoreView egoRefreshScrollViewDidScroll:scrollView];
    }
    
    
    if (self.scrollDelegate != nil && [self.scrollDelegate respondsToSelector:@selector(BKUpdateTableViewDidScroll:)]) {
        [self.scrollDelegate BKUpdateTableViewDidScroll:self];
    }

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(loadMoreView.delegate != nil){
        [loadMoreView egoRefreshScrollViewDidEndDragging:scrollView];
    }
    
    if(refreshView.delegate != nil){
        [refreshView egoRefreshScrollViewDidEndDragging:scrollView];
    }

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if(refreshView.delegate != nil){
        [refreshView egoRefreshScrollViewWillBeginDragging:scrollView];
    }
    // Also forward the message to the real delegate
    //    if ([self.delegate
    //         respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
    //        [self.delegate scrollViewWillBeginDragging:scrollView];
    //    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.scrollDelegate != nil && [self.scrollDelegate respondsToSelector:@selector(BKUpdateTableViewDidEndDecelerating:)]) {
        [self.scrollDelegate BKUpdateTableViewDidEndDecelerating:self];
    }
}

#pragma mark - EGORefreshTableHeaderDelegate
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
    pullTableIsRefreshing = YES;
    [self performSelector:@selector(refresh) withObject:nil afterDelay:0.3];
}

- (void)refresh
{
    if (pullUpdateDelegate != nil && [pullUpdateDelegate respondsToSelector:@selector(pullBKUpdateTableViewDidTriggerRefresh:)]) {
        [pullUpdateDelegate pullBKUpdateTableViewDidTriggerRefresh:self];
        _pullLastRefreshDate = [NSDate date];
    }
    
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view {
    return self.pullLastRefreshDate;
}

#pragma mark - LoadMoreTableViewDelegate
- (void)loadMoreTableFooterDidTriggerLoadMore:(LoadMoreTableFooterView *)view
{
    pullTableIsLoadingMore = YES;
    [self performSelector:@selector(loadMore) withObject:nil afterDelay:0.3];
}

- (void)loadMore
{
    if (pullUpdateDelegate != nil && [pullUpdateDelegate respondsToSelector:@selector(pullBKUpdateTableViewDidTriggerLoadMore:)]) {
        [pullUpdateDelegate pullBKUpdateTableViewDidTriggerLoadMore:self];
        _pullLastRefreshDate = [NSDate date];
    }
}

#pragma mark - didSelectRowAtIndexPathDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:isSelectedKeeping];
    
    if (processingDelegate != nil && [processingDelegate respondsToSelector:@selector(BKUpdateTableViewDidSelectRowAtIndexPath:didSelectRowAtIndexPath:)]) {
        [processingDelegate BKUpdateTableViewDidSelectRowAtIndexPath:self didSelectRowAtIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (processingDelegate != nil && [processingDelegate respondsToSelector:@selector(BKUpdateTableView:heightForRowAtIndexPath:)]) {
        return [processingDelegate BKUpdateTableView:self heightForRowAtIndexPath:indexPath];
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (processingDelegate != nil && [processingDelegate respondsToSelector:@selector(BKUpdateTableView:heightForHeaderInSection:)]) {
        return [processingDelegate BKUpdateTableView:self heightForHeaderInSection:section];
    } else {
        return 0.1;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (processingDelegate != nil && [processingDelegate respondsToSelector:@selector(BKUpdateTableView:heightForFooterInSection:)]) {
        return [processingDelegate BKUpdateTableView:self heightForFooterInSection:section];
    } else {
        return 0.1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (processingDelegate != nil && [processingDelegate respondsToSelector:@selector(BKUpdateTableView:viewForHeaderInSection:)]) {
        return [processingDelegate BKUpdateTableView:self viewForHeaderInSection:section];
    } else {
        return nil;
    }
}

- (void)delayEndDragging
{
    [self scrollViewDidEndDragging:self willDecelerate:YES];
    self.tag = 0;
}

- (void)avoidGestureConflict
{
    if(self.frame.size.height <= 0) return;
    
    float scrollLen = self.contentOffset.y;
    float reallLen = self.contentSize.height - self.frame.size.height;
    NSString *scrollLenStr = [NSString stringWithFormat:@"%.0f", scrollLen];
    NSString *reallLenStr = [NSString stringWithFormat:@"%.0f", reallLen];

    if([scrollLenStr isEqualToString:reallLenStr]) {
        //滑到底部加载更多
        [self setContentOffset:CGPointMake(0, self.contentOffset.y - 0.5) animated:NO];
//        NSLog(@"滑到底部加载更多");
    }
    if (self.contentOffset.y == 0) {
        //滑到顶部更新
        [self setContentOffset:CGPointMake(0, 0.5) animated:NO];
//        NSLog(@"滑到顶部更新");
    }
    
}

#pragma - mark 公共函数
- (void)automateRefresh
{
    if (pullTableIsRefreshing) return;
    
    [refreshView refreshLastUpdatedDate];
    self.tag = 1;
    [self setContentOffset:CGPointMake(0, -100) animated:YES];
    [self performSelector:@selector(delayEndDragging) withObject:nil afterDelay:0.3];

}

- (void)reloadData
{
    [super reloadData];
    
    //    NSLog(@"contentSize : %f", self.contentSize.height);
    
    int cellNum = self.visibleCells.count;
//    for (UITableViewCell *cell in self.visibleCells) {
//        NSLog(@"%@", cell);
//    }
    
    if (cellNum <= 0 && empMaskView.tag == 1) empMaskView.hidden = NO;
    else empMaskView.hidden = YES;
    
    if (!disableManully) {
        
        //如果显示出来的所有cell总高度小于table高度，说明没有更对数据了
        if (self.contentSize.height < self.frame.size.height) [self tempDisableLoadMore];
        else [self recoverLoadMore];
        
    }
    
    // Give the footers a chance to fix it self.
    [loadMoreView egoRefreshScrollViewDidScroll:self];
    
}

@end
