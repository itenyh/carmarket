//
//  SBBuyCarMenuView.m
//  carmarket
//
//  Created by itensb on 14-8-14.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#define MENU_HEIGHT 78 * PJSAH

#import "SBBuyCarMenuView.h"

@implementation SBBuyCarMenuView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        allPriceItem = [NSMutableArray arrayWithObjects:@"降幅最高", @"价格最低", @"价格最高", nil];
        
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [ITUIKitHelper getAppWidth], MENU_HEIGHT)];
        [scrollView setContentSize:CGSizeMake(frame.size.width, MENU_HEIGHT)];
        scrollView.bounces = NO;
        [self addSubview:scrollView];
        
        [ITUIKitHelper sizeSet:self size:scrollView.frame.size];
        
        carStyle = [self createMenuBtn:@"全部车型" index:0 handler:nil];
        place = [self createMenuBtn:@"地点" index:1 handler:nil];
        price = [self createMenuBtn:@"降幅最高" index:2 handler:^(id sender) {
            
            [price setMenuBtnState:YES];
            [ITUIKitHelper sizeSet:self size:CGSizeMake(-1, [ITUIKitHelper getAppHeight])];
            self.backgroundColor = [ITUIKitHelper color:@"000000" alpha:0.5];
            if (!removeBtn) {
                removeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, [ITUIKitHelper getAppWidth], [ITUIKitHelper getAppHeight])];
            }
            [self addSubview:removeBtn];
            [removeBtn bk_addEventHandler:^(id sender) {
                [self toNomalState];
            } forControlEvents:UIControlEventTouchUpInside];
            
            [self createPriceSelectView];
            [self addSubview:priceSelectView];
            
        }];
        
        [SBUIFactory decorateWithLine:self width:0.5 type:ITLineDecorateUpDown];
        
    }
    
    return self;
}

- (SBMenuBtn *)createMenuBtn:(NSString *)title index:(int)i handler:(void (^)(id sender))handler
{
    float btnWidth = self.frame.size.width / 3.0;
    
    SBMenuBtn *btn = [[SBMenuBtn alloc] initWithFrame:CGRectMake(i * btnWidth, 0, btnWidth, MENU_HEIGHT)];
    [btn setMenuTitle:title];

    [btn.b bk_addEventHandler:^(id sender) {
        
       if(handler) handler(sender);
        
    } forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:btn];
    
    return btn;
}

- (void)toNomalState
{
    [price setMenuBtnState:NO];
    [removeBtn removeFromSuperview];
    [ITUIKitHelper sizeSet:self size:scrollView.frame.size];
    self.backgroundColor = [UIColor clearColor];
    [priceSelectView removeFromSuperview];
}

- (void)createPriceSelectView
{
    float btnWidth = [ITUIKitHelper getAppWidth] / 3.0;
    
    if (priceSelectView == nil) {
         priceSelectView = [[UIView alloc] initWithFrame:CGRectMake(2 * btnWidth, MENU_HEIGHT, btnWidth, MENU_HEIGHT * 2)];
    }
    
    [priceSelectView.subviews bk_each:^(id obj) {[obj removeFromSuperview];}];
    
    int index = 0;
    for (int i = 0; i < allPriceItem.count; i++) {
        if (![[allPriceItem objectAtIndex:i] isEqualToString:price.title.text]) {
            UIButton *b1 = [[UIButton alloc] initWithFrame:CGRectMake(0, MENU_HEIGHT * index++, btnWidth, MENU_HEIGHT)];
            [b1 setTitle:[allPriceItem objectAtIndex:i] forState:UIControlStateNormal];
            [b1 setBackgroundColor:carStyle.backgroundColor];
            [b1 setTitleColor:carStyle.title.textColor forState:UIControlStateNormal];
            b1.titleLabel.font = carStyle.title.font;
            [priceSelectView addSubview:b1];
            [b1 bk_addEventHandler:^(id sender) {
                [price setMenuTitle:b1.titleLabel.text];
                [self toNomalState];
            } forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    
}

@end
