//
//  SBConditionCarView.m
//  carmarket
//
//  Created by itensb on 14-8-6.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBConditionCarView.h"
#import "BKUpdateTableView.h"
#import "SBConditionMenuView.h"
#import "SBCarNameTblCell.h"

@interface SBConditionCarView () <BKUpdateTableViewDelegate, UITableViewDataSource, BKUpdateTableViewProcessingDelegate>
{
    int menuBtnWidth;
    SBConditionMenuView *conditionMenuView;
    BKUpdateTableView *tbView;
    
    NSDictionary *info;
    NSMutableArray *datas;
    
    UILabel *datasLab;
}

@end

@implementation SBConditionCarView
@synthesize pageIndex;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        pageIndex = 1;
        info = [NSDictionary dictionary];
        datas = [NSMutableArray array];
        
        conditionMenuView = [[SBConditionMenuView alloc] initWithFrame:self.frame];

        UIView *infoPanelView = [[UIView alloc] initWithFrame:CGRectMake(0, [ITUIKitHelper yMarTopView:conditionMenuView margin:0], frame.size.width, 65 * PJSAH)];
        infoPanelView.backgroundColor = [UIColor clearColor];
        [self addSubview:infoPanelView];
        
        datasLab = [ITUIKitHelper createLabel:@"" size:CGSizeMake(0, infoPanelView.frame.size.height) font:[UIFont systemFontOfSize:25 * PJSAH] color:[ITUIKitHelper color:@"757575"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(34 * PJSAH, 0) superViewFrame:self.frame];
        datasLab.text = [NSString stringWithFormat:@"共%d车型，%d车款", 0, 0];
        [datasLab sizeWidthToFit];
        [infoPanelView addSubview:datasLab];
        
        UILabel *sortLab = [ITUIKitHelper createLabel:@"*按关注度排序" font:[UIFont systemFontOfSize:25 * PJSAH] color:[ITUIKitHelper color:@"757575"] marginInsets:[ITUIKitHelper ITMarginInsetsMake:-1 right:29 * PJSAH] point:CGPointMake(-1, 0) superViewFrame:infoPanelView.frame];
        [ITUIKitHelper sizeSet:sortLab size:CGSizeMake(-1, infoPanelView.frame.size.height)];
        [infoPanelView addSubview:sortLab];
        
        tbView = [[BKUpdateTableView alloc] initWithFrame:CGRectMake(0, [ITUIKitHelper yMarTopView:infoPanelView margin:0], frame.size.width, frame.size.height - conditionMenuView.frame.size.height - infoPanelView.frame.size.height) style:UITableViewStylePlain updateType:BKUpdateTableViewTypeOnlyLoadMore];
        tbView.pullUpdateDelegate = self;
        tbView.dataSource = self;
        tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tbView.backgroundColor = [UIColor clearColor];
        tbView.processingDelegate = self;
        [self addSubview:tbView];
        
        [self addSubview:conditionMenuView];
        
    }
    
    return self;
}

- (void)reloadMoreDatas:(id)_datas
{
    if (![_datas isKindOfClass:[NSDictionary class]]) return;
    
    info = _datas;
    
    NSArray *_data = [info objectForKey:@"list"];
    if (_data) {[datas addObjectsFromArray:_data]; pageIndex++;}
    
    [tbView reloadData];
}

- (void)reloadDatas:(id)_datas
{
    if (![_datas isKindOfClass:[NSDictionary class]]) return;
    
    pageIndex = 2;
    info = _datas;
    
    NSArray *_data = [info objectForKey:@"list"];
    if (_data) datas = [NSMutableArray arrayWithArray:_data];
    
    datasLab.text = [NSString stringWithFormat:@"共%@车型，%@车款", [info objectForKey:@"carModelCount"], [info objectForKey:@"carCount"]];
    [datasLab sizeWidthToFit];
    
    [tbView reloadData];
}

- (NSMutableDictionary *)getNowParam
{
    return conditionMenuView.params;
}

#pragma - mark TableView代理
- (CGFloat)BKUpdateTableView:(BKUpdateTableView *)updateTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [SBCarNameTblCell getHeight:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cid = @"d1";
    SBCarNameTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
    if (!cell) cell = [[SBCarNameTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid type:1];
    [cell display:[datas objectAtIndex:indexPath.row] imageDomainName:[info objectForKey:@"imgDomainName"]];
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return datas.count;
}

- (void)pullBKUpdateTableViewDidTriggerLoadMore:(BKUpdateTableView *)updateTableView
{
    RUPWarning([[ITUtils viewControllerFor:self] performSelector:@selector(SBConditionCarView_TableLoadMore:) withObject:updateTableView]);
}

- (void)BKUpdateTableViewDidSelectRowAtIndexPath:(BKUpdateTableView *)updateTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RUPWarning([[ITUtils viewControllerFor:self] performSelector:@selector(SBConditionCarView_Cell:) withObject:[updateTableView cellForRowAtIndexPath:indexPath]]);
}


@end
