//
//  SBUserMenuPanelTblCell.m
//  carmarket
//
//  Created by itensb on 14-8-15.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#define LINE_NUM 3
#define ALL_NUM 4

#import "SBUserMenuPanelTblCell.h"
#import "UIImage+ITColorImage.h"

@implementation SBUserMenuPanelTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        g_index = 0;
    
        [self createBtn:@"活动" image:[UIImage imageNamed:@"btn_myhuodong"] color:[ITUIKitHelper color:@"5cc300"]];
        [self createBtn:@"违章查询" image:[UIImage imageNamed:@"btn_mylishi"] color:[ITUIKitHelper color:@"00adfa"]];
        [self createBtn:@"出行规划" image:[UIImage imageNamed:@"btn_myqiandao"] color:[ITUIKitHelper color:@"c30114"]];
        [self createBtn:@"快捷导航" image:[UIImage imageNamed:@"btn_mydaohang"] color:[ITUIKitHelper color:@"ff652f"]];
//        [self createBtn:@"购车计算器" image:[UIImage imageNamed:@"btn_myjisuanqi"] color:[ITUIKitHelper color:@"4b89d2"]];
//        [self createBtn:@"收藏" image:[UIImage imageNamed:@"btn_myshoucang"] color:[ITUIKitHelper color:@"ffb32f"]];
//        [self createBtn:@"车型对比" image:[UIImage imageNamed:@"btn_mycaogao"] color:[ITUIKitHelper color:@"4b89d2"]];
        
        
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
}


+ (float)getHeight:(NSDictionary *)info
{
    return (ALL_NUM / LINE_NUM + 1) * 230 * PJSAH;
}

- (void)createBtn:(NSString *)title image:(UIImage *)img color:(UIColor *)color
{
    int i = g_index % LINE_NUM;
    int j = g_index / LINE_NUM;
    
    UIButton *b = [[UIButton alloc] initWithFrame:CGRectMake(i * [ITUIKitHelper getAppWidth] / 3, j * 230 * PJSAH, [ITUIKitHelper getAppWidth] / LINE_NUM, 230 * PJSAH)];
    b.tag = g_index;
    [b bk_addEventHandler:^(id sender) {
        RUPWarning([[ITUtils viewControllerFor:self] performSelector:@selector(SBUserMenuPanelTblCell_Button:) withObject:b]);
    } forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:b];
    
    UIButton *iconb = [ITUIKitHelper createButtonWithUIImage:img highlightImg:nil point:CGPointMake((b.frame.size.width - img.size.width) / 2.0, 26 * PJSAH) isBackgroundImg:YES];
    [iconb setTitle:title forState:UIControlStateNormal];
    [iconb setTitleColor:color forState:UIControlStateNormal];
    iconb.titleLabel.font = [UIFont systemFontOfSize:25 * PJSAH];
    [iconb setTitleEdgeInsets:UIEdgeInsetsMake(80 + 22 * PJSAH, 0, 0, 0)];
    iconb.userInteractionEnabled = NO;
    
    [b addSubview:iconb];
    
    g_index++;
    
}

@end
