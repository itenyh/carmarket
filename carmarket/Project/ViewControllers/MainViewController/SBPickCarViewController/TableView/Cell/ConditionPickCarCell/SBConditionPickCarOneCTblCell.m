//
//  SBConditionPickCarOneCTblCell.m
//  carmarket
//
//  Created by Apple on 14-8-23.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBConditionPickCarOneCTblCell.h"

@implementation SBConditionPickCarOneCTblCell
@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [ITUIKitHelper color:252 blue:252 green:252 alpha:1];
        
        l = [ITUIKitHelper createLabel:@"" size:CGSizeMake(70, - 1) font:[UIFont boldSystemFontOfSize:30 * PJSAH] color:[ITUIKitHelper color:@"9a9a9a"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(49 * PJSAH, 34 * PJSAH) superViewFrame:self.frame];
        [self.contentView addSubview:l];
        
        panel = [[SBConditionItemsPanel alloc] initWithFrame:CGRectMake(222 * PJSAH, 23 * PJSAH, 460 * PJSAH + 8, 0)];
        panel.zuoyou = 35 * PJSAH;
        panel.shangxia = 18 * PJSAH;
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
    
    panel.datas = [info objectForKey:@"data"];
    for (int i = 0; i < panel.datas.count; i++) {
        NSDictionary *dic = [panel.datas objectAtIndex:i];
        if ([[dic objectForKey:@"selected"] isEqualToString:@"1"]) {[panel selectIndex:i]; break;}
    }
    
    NSString *title = [info objectForKey:@"title"];
    if (title) l.text = [NSString stringWithFormat:@"%@：", title];

    [ITUIKitHelper pointSet:lineView piont:CGPointMake(-1, panel.frame.size.height + 23 * PJSA - 0.5)];
    
}

+ (float)getHeight:(NSDictionary *)info
{
    float height = [SBConditionItemsPanel getHeight:[info objectForKey:@"data"] width:460 * PJSAH + 8 zuoyou:35 * PJSAH shangxia:18 * PJSAH] + 23 * PJSA;
    return height;
}

- (void)SBConditionItemsPanel:(SBConditionItemsPanel *)_panel selectedDatas:(NSArray *)datas
{
    [delegate SBConditionPickCarOneCTblCell:self panel:_panel selectedDatas:datas];
}

@end
