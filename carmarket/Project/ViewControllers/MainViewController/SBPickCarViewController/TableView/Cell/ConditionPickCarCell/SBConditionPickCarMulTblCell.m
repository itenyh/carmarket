//
//  SBConditionPickCarMulTblCell.m
//  carmarket
//
//  Created by Apple on 14-8-23.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBConditionPickCarMulTblCell.h"

@implementation SBConditionPickCarMulTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [ITUIKitHelper color:252 blue:252 green:252 alpha:1];
        
        left = [ITUIKitHelper createLabel:@"选择配置(可多选)：已选"  font:[UIFont boldSystemFontOfSize:30 * PJSAH] color:[ITUIKitHelper color:@"9a9a9a"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(25 * PJSAH, 34 * PJSAH) superViewFrame:self.frame];
        [self.contentView addSubview:left];
        
        right = [ITUIKitHelper createLabel:@"项"  font:[UIFont boldSystemFontOfSize:30 * PJSAH] color:[ITUIKitHelper color:@"9a9a9a"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(0, left.frame.origin.y) superViewFrame:self.frame];
        [self.contentView addSubview:right];
        
        number = [ITUIKitHelper createLabel:@""  font:[UIFont boldSystemFontOfSize:30 * PJSAH] color:[ITUIKitHelper color:@"c30114"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:left margin:1], left.frame.origin.y) superViewFrame:self.frame];
        [self.contentView addSubview:number];
        
        UIView *icon = [ITUIKitHelper createIconWithUIImage:[UIImage imageNamed:@"icon_laji"]];
        [ITUIKitHelper pointSet:icon piont:CGPointMake(506 * PJSAH, 32 * PJSAH)];
        [self.contentView addSubview:icon];
        UILabel *laji = [ITUIKitHelper createLabel:@"清空配置"  font:[UIFont boldSystemFontOfSize:30 * PJSAH] color:[ITUIKitHelper color:@"9a9a9a"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper  xMarLeftView:icon margin:2], left.frame.origin.y) superViewFrame:self.frame];
        [self.contentView addSubview:laji];
        UIButton *lajiBtn = [[UIButton alloc] initWithFrame:CGRectMake(icon.frame.origin.x, icon.frame.origin.y, icon.frame.size.width + laji.frame.size.width + 2, laji.frame.size.height)];
        [lajiBtn bk_addEventHandler:^(id sender) {
            [panel clearAll];
        } forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:lajiBtn];
        
        panel = [[SBConditionItemsPanel alloc] initWithFrame:CGRectMake(25 * PJSAH, 91 * PJSAH, ([ITUIKitHelper getAppWidth] - 25 * PJSA), 0)];
        panel.zuoyou = 35 * PJSAH;
        panel.shangxia = 18 * PJSAH;
        panel.multiSelect = YES;
        panel.delegate = self;
        [self.contentView addSubview:panel];
        
        lineView = [SBUIFactory getSeperateLineView:0];
        [self.contentView addSubview:lineView];
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
    
    number.text = [NSString stringWithFormat:@"%d", panel.selecedSet.count];
    [number sizeWidthToFit];
    [ITUIKitHelper pointSet:right piont:CGPointMake([ITUIKitHelper xMarLeftView:number margin:1], -1)];
    
    panel.datas = [info objectForKey:@"data"];
    for (int i = 0; i < panel.datas.count; i++) {
        NSDictionary *dic = [panel.datas objectAtIndex:i];
        if ([[dic objectForKey:@"selected"] isEqualToString:@"1"]) {[panel selectIndex:i];}
    }
//    NSLog(@"lineView height : %f", panel.frame.size.height + 40);
    
    [ITUIKitHelper pointSet:lineView piont:CGPointMake(-1, panel.frame.size.height + 50 - 0.5)];
    
    
}

+ (float)getHeight:(NSDictionary *)info
{
    float height = [SBConditionItemsPanel getHeight:[info objectForKey:@"data"] width:([ITUIKitHelper getAppWidth] - 25 * PJSA) zuoyou:35 * PJSAH shangxia:18 * PJSAH] + 40 + 50;
//    NSLog(@"height : %f", height);
    return height;
}

- (void)SBConditionItemsPanel:(SBConditionItemsPanel *)_panel selectedDatas:(NSArray *)datas
{
    [_delegate SBConditionPickCarMulTblCell:self panel:_panel selectedDatas:datas];
}

@end
