//
//  SBSingleBrandlListView.m
//  carmarket
//
//  Created by itensb on 14-8-5.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#define SECTION_HEIGHT 30
#define SECTION_KEY @"brandName"

#import "SBSingleBrandlListView.h"
#import "BKUpdateTableView.h"
#import "SBCarNameTblCell.h"

@interface SBSingleBrandlListView () <BKUpdateTableViewDelegate, UITableViewDataSource, BKUpdateTableViewProcessingDelegate ,UIGestureRecognizerDelegate>
{
    BKUpdateTableView *tbView;
    float originalX;
    BOOL isShow;
    
    NSMutableArray *allSections;
    
}
@end

@implementation SBSingleBrandlListView
@synthesize datas, targetVC;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        isShow = YES;
        originalX = frame.origin.x;
        self.backgroundColor = [ITUIKitHelper color:@"f5f5f5"];
        datas = [NSMutableDictionary dictionary];
        allSections = [NSMutableArray array];
        
        tbView = [[BKUpdateTableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:UITableViewStyleGrouped updateType:BKUpdateTableViewTypeNoUpdate];
        tbView.dataSource = self;
        tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tbView.processingDelegate = self;
//        tbView.backgroundColor = [UIColor purpleColor];
        [self addSubview:tbView];

        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
        swipeRight.delegate = self;
        [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
        [self addGestureRecognizer:swipeRight];
        
        [SBUIFactory decorateWithLine:self width:0.8 type:ITLineDecorateLeft];
        
    }
    
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    [ITUIKitHelper sizeSet:tbView size:CGSizeMake(-1, frame.size.height)];
}

#pragma - mark 数据处理函数
- (void)reloadWithDatas:(NSArray *)_datas
{
    [datas removeAllObjects];
    [allSections removeAllObjects];
    
    for (NSDictionary *dic in _datas) {
        
        NSString *sectionStr = [dic objectForKey:SECTION_KEY];
        
        NSMutableArray *section = [datas objectForKey:sectionStr];
        if (section) [section addObject:dic];
        else {
            section = [NSMutableArray arrayWithObject:dic];
            [datas setObject:section forKey:sectionStr];
        }
        
    }
    
    allSections = [NSMutableArray arrayWithArray:[datas allKeys]];
    
    [tbView reloadData];
}

//- (void)setDatas:(NSArray *)_datas
//{
//    [datas removeAllObjects];
//    [allSections removeAllObjects];
//    
//    for (NSDictionary *dic in _datas) {
//        
//        NSString *sectionStr = [dic objectForKey:SECTION_KEY];
//        
//        NSMutableArray *section = [datas objectForKey:sectionStr];
//        if (section) [section addObject:dic];
//        else {
//            section = [NSMutableArray arrayWithObject:dic];
//            [datas setObject:section forKey:sectionStr];
//        }
//        
//    }
//    
//    allSections = [NSMutableArray arrayWithArray:[datas allKeys]];
//    
//    [tbView reloadData];
//    
//}

- (void)clear
{
    [datas removeAllObjects];
    [allSections removeAllObjects];
    [tbView reloadData];
}

#pragma - mark UI显示函数
- (void)swipeRight:(UISwipeGestureRecognizer *)reco
{
    tbView.scrollEnabled = NO;
    [self hide:YES];
}

- (void)show
{
    tbView.scrollEnabled = YES;
    
    if (isShow) return;
    
    isShow = YES;
    [UIView animateWithDuration:0.3 animations:^{
        [ITUIKitHelper pointSet:self piont:CGPointMake(originalX, -1)];
    }];
}

- (void)hide:(BOOL)animated
{
    if (!isShow) return;
    
    isShow = NO;
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{
            [ITUIKitHelper pointSet:self piont:CGPointMake([ITUIKitHelper getAppWidth], -1)];
        }];
    }
    
    else {
        [ITUIKitHelper pointSet:self piont:CGPointMake([ITUIKitHelper getAppWidth], -1)];
    }
}

#pragma - mark TableView代理
- (CGFloat)BKUpdateTableView:(BKUpdateTableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)BKUpdateTableView:(BKUpdateTableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return SECTION_HEIGHT;
}

- (UIView *)BKUpdateTableView:(BKUpdateTableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [ITUIKitHelper getAppWidth], SECTION_HEIGHT)];
    view.backgroundColor = [UIColor clearColor];
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(42 * PJSAH, 0, [ITUIKitHelper getAppWidth] - 20, SECTION_HEIGHT)];
    l.font = [UIFont boldSystemFontOfSize:40 * PJSAH];
    l.text = [allSections objectAtIndex:section];
    l.textColor = [ITUIKitHelper color:@"1c1c1c"];
    l.backgroundColor = [UIColor clearColor];
    [view addSubview:l];
    
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return allSections.count; //出了字母，加入热门品牌、车型收藏
//    return 2;
}

- (CGFloat)BKUpdateTableView:(BKUpdateTableView *)updateTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [SBCarNameTblCell getHeight:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cid = @"id1";
    
    SBCarNameTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
    if (!cell) cell = [[SBCarNameTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid type:0];
    NSArray *sectionDatas = [datas objectForKey:[allSections objectAtIndex:indexPath.section]];
    [cell display:[sectionDatas objectAtIndex:indexPath.row]];
//    [cell display:nil];
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = [datas objectForKey:[allSections objectAtIndex:section]];
    return array.count;
//    return 6;
}


- (void)BKUpdateTableViewDidSelectRowAtIndexPath:(BKUpdateTableView *)updateTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (targetVC) RUPWarning([targetVC performSelector:@selector(SBSingleBrandlListView_Cell:) withObject:[updateTableView cellForRowAtIndexPath:indexPath]]);
    else RUPWarning([[ITUtils viewControllerFor:self] performSelector:@selector(SBSingleBrandlListView_Cell:) withObject:[updateTableView cellForRowAtIndexPath:indexPath]]);
}



@end
