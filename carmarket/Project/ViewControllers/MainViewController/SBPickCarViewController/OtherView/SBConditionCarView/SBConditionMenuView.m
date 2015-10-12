//
//  SBConditionMenuView.m
//  carmarket
//
//  Created by itensb on 14-8-7.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#define TBLBOTTOM_INSET 50

#import "SBConditionMenuView.h"
#import "BKUpdateTableView.h"
#import "SBMenuBtn.h"

#import "SBConditionPickCarOneCTblCell.h"
#import "SBConditionPickCarMulTblCell.h"
#import "SBCondtionNormalTblCell.h"

#import "SBConditionDataSource.h"

@interface SBConditionMenuView () <BKUpdateTableViewDelegate, UITableViewDataSource, BKUpdateTableViewProcessingDelegate, SBConditionPickCarOneCTblCellDelegate, SBConditionPickCarMulTblCellDelegate>
{
    int menuBtnWidth;
    BKUpdateTableView *tbView;
    UIScrollView *scrollView;
    UIView *bottom;
    UIView *btnSegBg;
    
    CGRect originFrame;
    CGRect hideFrame;
    float menuHeight;
    
    NSMutableArray *menuBtns;
    NSMutableArray *datas;
    int selectedIndex;
    
    NSArray *menuDatas;
    
//    ----- 用于多选的临时存储 ------
    NSMutableArray *temp4One;
    NSMutableArray *temp4Mul;
}

@end

@implementation SBConditionMenuView
@synthesize params;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        temp4One = [NSMutableArray array];
        temp4Mul = [NSMutableArray array];
        
        params = [NSMutableDictionary dictionary];
        selectedIndex = 0;
        menuBtns = [NSMutableArray array];
        menuHeight = 71 * PJSAH;
        originFrame = frame;
        hideFrame = CGRectMake(0, 0, frame.size.width, menuHeight);
        self.frame = hideFrame;
        
        menuBtnWidth = self.frame.size.width / 5.0;
        
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, menuHeight)];
        scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrollView];
        
        menuDatas = [NSArray arrayWithObjects:@"价格", @"级别", @"国别", @"排量", @"更多", nil];
        for (int i = 0; i < 5; i++) [self createMenuBtn:i];
        
        bottom = [[UIView alloc] initWithFrame:CGRectMake(0, [ITUIKitHelper yMarTopView:scrollView margin:0], frame.size.width, frame.size.height - scrollView.frame.size.height)];
        bottom.backgroundColor = [ITUIKitHelper color:@"000000" alpha:0.5];
        bottom.hidden = YES;
        [self addSubview:bottom];
        UIButton *cancelBtn = [[UIButton alloc] initWithFrame:bottom.frame];
        [bottom addSubview:cancelBtn];
        [cancelBtn bk_addEventHandler:^(id sender) {[self hideTbl];[self tapMenu:[menuBtns objectAtIndex:selectedIndex]];} forControlEvents:UIControlEventTouchUpInside];
        
        tbView = [[BKUpdateTableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, bottom.frame.size.height - TBLBOTTOM_INSET) style:UITableViewStylePlain updateType:BKUpdateTableViewTypeNoUpdate];
        tbView.dataSource = self;
        tbView.processingDelegate = self;
        //        tbView.bounces = NO;
        tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [bottom addSubview:tbView];
        
        //        ------------ 搭配更多选项的btn -------------
        btnSegBg = [SBUIFactory getDaoHangBottomPanel:CGSizeMake(tbView.frame.size.width, 112 * PJSAH)];
        [ITUIKitHelper pointSet:btnSegBg piont:CGPointMake(0, tbView.frame.size.height - 112 * PJSAH)];
        [SBUIFactory decorateWithLine:btnSegBg width:0.5 type:ITLineDecorateUp];
        [bottom addSubview:btnSegBg];
        
        UIButton *sure = [SBUIFactory getColoredRedBtn:@"确定" size:CGSizeMake(btnSegBg.frame.size.width - 30 * PJSA, 55 * PJSAH)];
        sure.titleLabel.font = [UIFont systemFontOfSize:30 * PJSAH];
        [ITUIKitHelper pointSet:sure piont:CGPointMake((btnSegBg.frame.size.width - sure.frame.size.width) / 2, (btnSegBg.frame.size.height - sure.frame.size.height) / 2)];
        [sure addTarget:self action:@selector(mulSureClick:) forControlEvents:UIControlEventTouchUpInside];
        [btnSegBg addSubview:sure];
    }
    
    return self;
}

- (void)createMenuBtn:(int)index
{
    SBMenuBtn *sbtn = [[SBMenuBtn alloc] initWithFrame:CGRectMake(index * menuBtnWidth, 0, menuBtnWidth, scrollView.frame.size.height)];
    [SBUIFactory decorateWithLine:sbtn width:0.5 type:ITLineDecorateExceptRight];
    [sbtn setMenuTitle:[menuDatas objectAtIndex:index]];
    [scrollView addSubview:sbtn];
    [menuBtns addObject:sbtn];
    sbtn.tag = index;
    [sbtn addTarget:self action:@selector(tapMenu:)];
    
}

#pragma - mark 公共函数
- (void)showTbl {
    bottom.hidden = NO;
    self.frame = originFrame;
    btnSegBg.hidden = (selectedIndex == 4 ? NO : YES);
}

- (void)hideTbl
{
    bottom.hidden = YES;
    self.frame = hideFrame;
}

- (void)reloadTbViewWithSelectedIndex:(int)index
{
    selectedIndex = index;
    [tbView reloadData];
}

#pragma - mark TableView代理
- (CGFloat)BKUpdateTableView:(BKUpdateTableView *)updateTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (selectedIndex == 4) {
        NSDictionary *dic;
        
        if (indexPath.row == 0) dic = [SBConditionDataSource getBianSuXiangData];
        else if (indexPath.row == 1) dic = [SBConditionDataSource getJieGouData];
        else if (indexPath.row == 2) dic = [SBConditionDataSource getRanLiaoData];
        else {dic = [SBConditionDataSource getGengDuoData];return [SBConditionPickCarMulTblCell getHeight:dic];}
        
        return [SBConditionPickCarOneCTblCell getHeight:dic];
        
    }
    
    else return [SBCondtionNormalTblCell getHeight:nil];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (selectedIndex == 4) {
        
        NSDictionary *dic;
        
        if (indexPath.row == 3) {
            dic = [SBConditionDataSource getGengDuoData];
            SBConditionPickCarMulTblCell *cell = [[SBConditionPickCarMulTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
            [cell display:dic];
            cell.delegate = self;
            
            return cell;
        }
        
        if (indexPath.row == 0) dic = [SBConditionDataSource getBianSuXiangData];
        if (indexPath.row == 1) dic = [SBConditionDataSource getJieGouData];
        if (indexPath.row == 2) dic = [SBConditionDataSource getRanLiaoData];
        SBConditionPickCarOneCTblCell *cell = [[SBConditionPickCarOneCTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
        [cell display:dic];
        cell.delegate = self;
        
        return cell;
    }
    
    else {
        NSString *cid = @"d2";
        SBCondtionNormalTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
        if (!cell) cell = [[SBCondtionNormalTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
        NSArray *_datas;
        if (selectedIndex == 0) _datas = [[SBConditionDataSource getJiaGeFanWeiData] objectForKey:@"data"];
        else if (selectedIndex == 1) _datas = [[SBConditionDataSource getJiBieData] objectForKey:@"data"];
        else if (selectedIndex == 2) _datas = [[SBConditionDataSource getGuoBieData] objectForKey:@"data"];
        else if (selectedIndex == 3) _datas = [[SBConditionDataSource getPaiLiangData] objectForKey:@"data"];
        [cell display:[_datas objectAtIndex:indexPath.row]];
        return cell;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (selectedIndex == 4) return 4;
    else {
        if (selectedIndex == 0) return [SBConditionDataSource getJiaGeFanWeiArray].count / 2;
        else if (selectedIndex == 1) return [SBConditionDataSource getJiBieArray].count / 2;
        else if (selectedIndex == 2) return [SBConditionDataSource getGuoBieArray].count / 2;
        else if (selectedIndex == 3) return [SBConditionDataSource getPaiLiangArray].count / 2;
    }
    
    return 0;
}

- (void)BKUpdateTableViewDidSelectRowAtIndexPath:(BKUpdateTableView *)updateTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (selectedIndex == 4) return;
    
    NSMutableDictionary *selectedData;
    if (selectedIndex == 0) {selectedData = [[[SBConditionDataSource getJiaGeFanWeiData] objectForKey:@"data"] objectAtIndex:indexPath.row]; [SBConditionDataSource setSelectedState:selectedData targetDic:[SBConditionDataSource getJiaGeFanWeiData]];}
    if (selectedIndex == 1) {selectedData = [[[SBConditionDataSource getJiBieData] objectForKey:@"data"] objectAtIndex:indexPath.row]; [SBConditionDataSource setSelectedState:selectedData targetDic:[SBConditionDataSource getJiBieData]];}
    if (selectedIndex == 2) {selectedData = [[[SBConditionDataSource getGuoBieData] objectForKey:@"data"] objectAtIndex:indexPath.row]; [SBConditionDataSource setSelectedState:selectedData targetDic:[SBConditionDataSource getGuoBieData]];}
    if (selectedIndex == 3) {selectedData = [[[SBConditionDataSource getPaiLiangData] objectForKey:@"data"] objectAtIndex:indexPath.row]; [SBConditionDataSource setSelectedState:selectedData targetDic:[SBConditionDataSource getPaiLiangData]];}
    
    [self setConditionWithDic:selectedData];
    
    [self changeMenuBtnWithTitle:[selectedData objectForKey:@"title"] index:selectedIndex];
    
    [self tapMenu:[menuBtns objectAtIndex:selectedIndex]];
    
    RUPWarning([[ITUtils viewControllerFor:self] performSelector:@selector(SBConditionMenuView_Request:) withObject:params]);
    
}

#pragma - mark 点击数据代理
- (void)SBConditionPickCarOneCTblCell:(SBConditionPickCarOneCTblCell *)view panel:(SBConditionItemsPanel *)panel selectedDatas:(NSArray *)_datas
{
    NSMutableDictionary *param = [_datas objectAtIndex:0];
    [temp4One addObject:param];
}

- (void)SBConditionPickCarMulTblCell:(SBConditionPickCarMulTblCell *)view panel:(SBConditionItemsPanel *)panel selectedDatas:(NSArray *)_datas
{
    temp4Mul = (NSMutableArray *)_datas;
}

#pragma - mark 条件录入辅助函数
- (void)setConditionWithDic:(NSDictionary *)param
{
    //如果是不限
    if ([[param objectForKey:@"value"] isEqualToString:BUXIAN_VALUE]) [params removeObjectForKey:[param objectForKey:@"key"]];
    else [params setObject:[param objectForKey:@"value"] forKey:[param objectForKey:@"key"]];
}

- (void)setMulConditionWith:(NSArray *)infos
{
    NSMutableString *mulValue = [NSMutableString new];
    NSArray *allInfo = [[SBConditionDataSource getGengDuoData] objectForKey:@"data"];
    for (int i = 0; i < allInfo.count; i++) {
        NSString *singal = ([infos containsObject:[allInfo objectAtIndex:i]]?@"1":@"0");
        [mulValue appendString:singal];
    }
    
    [params setObject:mulValue forKey:GENGDUO_KEY];
    
}

- (void)mulSureClick:(UIButton *)btn
{
    for (NSMutableDictionary *dic in temp4One) {
        [SBConditionDataSource setSelectedState:dic];
        [self setConditionWithDic:dic];
    }
    [temp4One removeAllObjects];
    
   
    [SBConditionDataSource setMulSelectedState:temp4Mul];
    [self setMulConditionWith:temp4Mul];
    temp4Mul = [NSMutableArray array];
    
    [self tapMenu:[menuBtns objectAtIndex:selectedIndex]];
    RUPWarning([[ITUtils viewControllerFor:self] performSelector:@selector(SBConditionMenuView_Request:) withObject:params]);
}

#pragma - mark menuBtns相关
- (void)clearAllBtnStateExcept:(SBMenuBtn *)btn
{
    [menuBtns bk_each:^(SBMenuBtn *obj) {
        if (btn != obj) [obj setMenuBtnState:NO];
        else [obj setMenuBtnState:YES];
    }];
}

- (void)tapMenu:(UIButton *)b
{
    SBMenuBtn *sbtn = [menuBtns objectAtIndex:b.tag];
    
    if (sbtn.on) {
        [sbtn setMenuBtnState:NO];
        [self hideTbl];
    }
    
    else {
        [self clearAllBtnStateExcept:sbtn];
        [self reloadTbViewWithSelectedIndex:sbtn.tag];
        [self showTbl];
    }
    
}

- (void)changeMenuBtnWithTitle:(NSString *)title index:(int)index
{
    SBMenuBtn *btn = [menuBtns objectAtIndex:index];
    
    if ([title isEqualToString:@"不限"]) [btn setMenuTitleUnchangeSize:[menuDatas objectAtIndex:index]];
    else [btn setMenuTitleUnchangeSize:title];
}


@end
