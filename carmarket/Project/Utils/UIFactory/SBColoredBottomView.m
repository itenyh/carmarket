//
//  SBColoredBottomView.m
//  carmarket
//
//  Created by itensb on 14-9-3.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBColoredBottomView.h"

@implementation SBColoredBottomView
@synthesize btn;

- (id)initWithType:(int)colorType view:(UIView *)superView
{
    self = [super init];
    float selfHeight = 112 * PJSAH;
    
    if (self) {
        
        self.frame = CGRectMake(0, superView.frame.size.height - selfHeight, [ITUIKitHelper getAppWidth], selfHeight);
        
        btnSegBg = [SBUIFactory getDaoHangBottomPanel:CGSizeMake([ITUIKitHelper getAppWidth], selfHeight)];
        [SBUIFactory decorateWithLine:btnSegBg width:0.5 type:ITLineDecorateUp];
        [self addSubview:btnSegBg];
        
        btn = [SBUIFactory getColoredPanel:@"" size:CGSizeMake([ITUIKitHelper getAppWidth] - 110 * PJSA, 72 * PJSAH) color:nil font:[UIFont systemFontOfSize:37 * PJSAH] type:colorType];
        [ITUIKitHelper pointSet:btn piont:CGPointMake(([ITUIKitHelper getAppWidth] - btn.frame.size.width) / 2, (btnSegBg.frame.size.height - btn.frame.size.height) / 2)];
        [btnSegBg addSubview:btn];
        
    }
    
    return self;
}

- (void)setTitle:(NSString *)title
{
    [btn setTitle:title forState:UIControlStateNormal];
}

- (void)setTitle:(NSString *)title handler:(void (^)(id sender))handler
{
    oldTitle = title;
    
    if (title) [btn setTitle:title forState:UIControlStateNormal];
    if (handler) [btn bk_addEventHandler:handler forControlEvents:UIControlEventTouchUpInside];
}

@end
