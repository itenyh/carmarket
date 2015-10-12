//
//  SBLowPriceBottomMenu.m
//  carmarket
//
//  Created by itensb on 14-8-18.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#define SBLowPriceBottomMenu_HEIGHT 88 * PJSAH

#import "SBLowPriceBottomMenu.h"
#import "UIImage+ITColorImage.h"

@implementation SBLowPriceBottomMenu

- (id)initWithFrame:(CGRect)frame type:(int)type title:(NSString *)title
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        UIButton *panel = [SBUIFactory getColoredBluePanel:@"" size:CGSizeMake([ITUIKitHelper getAppWidth] - 12 * PJSA, SBLowPriceBottomMenu_HEIGHT) color:nil font:nil];
        [ITUIKitHelper pointSet:panel piont:CGPointMake(12 * PJSAH, 12 * PJSAH)];
        [self addSubview:panel];
        
        if (type == 0) {
            UIButton *b1 = [self createBtn:@"参数配置" x:0 index:0];
            [panel addSubview:b1];
            
            UIButton *b2 = [self createBtn:@"电话咨询" x:[ITUIKitHelper xMarLeftView:b1 margin:0] index:1];
            [b2 setTitleEdgeInsets:UIEdgeInsetsMake(0, 19, 0, 0)];
            UIView *phone = [ITUIKitHelper createIconWithUIImage:[UIImage imageNamed:@"icon_whitephone"]];
            [ITUIKitHelper pointSet:phone piont:CGPointMake(14, 9)];
            [b2 addSubview:phone];
            [panel addSubview:b2];
            
//            UIButton *b3 = [self createBtn:@"询问最低价" x:[ITUIKitHelper xMarLeftView:b2 margin:0] index:2];
//            [panel addSubview:b3];
//
//            [ITUIKitHelper decorateWithLine:b1 color:[UIColor grayColor] lineWidth:0.3 type:ITLineDecorateRight];
//            [ITUIKitHelper decorateWithLine:b2 color:[UIColor grayColor] lineWidth:0.3 type:ITLineDecorateRight];
        }
        
        else if (type == 2) {
            
            UIButton *b2 = [self createBtnOne:title index:1];
            [panel addSubview:b2];
            
        }
        
        else if (type == 3) {
            [panel removeFromSuperview];
            panel = [SBUIFactory getColoredPanel:@"" size:CGSizeMake([ITUIKitHelper getAppWidth] - 12 * PJSA, SBLowPriceBottomMenu_HEIGHT) color:nil font:nil type:4];
            [ITUIKitHelper pointSet:panel piont:CGPointMake(12 * PJSAH, 12 * PJSAH)];
            [self addSubview:panel];
            
            UIButton *b2 = [self createBtnOne:title index:1];
            [panel addSubview:b2];
            
        }
        
        else {
            
            UIButton *b2 = [self createBtnOne:title index:1];
            [b2 setTitleEdgeInsets:UIEdgeInsetsMake(0, 19, 0, 0)];
            UIView *phone = [ITUIKitHelper createIconWithUIImage:[UIImage imageNamed:@"icon_whitephone"]];
            [ITUIKitHelper pointSet:phone piont:CGPointMake(103, 9)];
            [b2 addSubview:phone];
            [panel addSubview:b2];
            
        }
        
        [SBUIFactory decorateWithLine:self width:0.5 type:ITLineDecorateUp];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self = [self initWithFrame:frame type:0 title:@""];
        
    }
    
    return self;
}

- (UIButton *)createBtnOne:(NSString *)title index:(int)index
{
    UIButton *b1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ([ITUIKitHelper getAppWidth] - 12 * PJSA), SBLowPriceBottomMenu_HEIGHT)];
    [b1 setTitle:title forState:UIControlStateNormal];
    b1.tag = index;
    [b1 setBackgroundImage:[UIImage imageWithColor:[ITUIKitHelper color:@"ffffff" alpha:0.05]] forState:UIControlStateNormal];
    b1.titleLabel.font = [UIFont systemFontOfSize:30 * PJSAH];
    [b1 bk_addEventHandler:^(id sender) {
        RUPWarning([[ITUtils viewControllerFor:self] performSelector:@selector(SBLowPriceBottomMenu_Button:) withObject:b1]);
    } forControlEvents:UIControlEventTouchUpInside];
    return b1;
}

- (UIButton *)createBtn:(NSString *)title x:(float)x index:(int)index
{
    UIButton *b1 = [[UIButton alloc] initWithFrame:CGRectMake(x, 0, ([ITUIKitHelper getAppWidth] - 12 * PJSA) / 2.0, SBLowPriceBottomMenu_HEIGHT)];
    [b1 setTitle:title forState:UIControlStateNormal];
    b1.tag = index;
    [b1 setBackgroundImage:[UIImage imageWithColor:[ITUIKitHelper color:@"ffffff" alpha:0.05]] forState:UIControlStateNormal];
    b1.titleLabel.font = [UIFont systemFontOfSize:30 * PJSAH];
    [b1 bk_addEventHandler:^(id sender) {
        RUPWarning([[ITUtils viewControllerFor:self] performSelector:@selector(SBLowPriceBottomMenu_Button:) withObject:b1]);
    } forControlEvents:UIControlEventTouchUpInside];
    return b1;
}


@end
