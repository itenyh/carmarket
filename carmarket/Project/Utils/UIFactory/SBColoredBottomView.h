//
//  SBColoredBottomView.h
//  carmarket
//
//  Created by itensb on 14-9-3.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBColoredBottomView : UIView
{
    UIButton *btn;
    UIView *btnSegBg;
    
    NSString *oldTitle;
}

@property (nonatomic, strong) UIButton *btn;

- (void)setTitle:(NSString *)title;
- (void)setTitle:(NSString *)title handler:(void (^)(id sender))handler;
- (id)initWithType:(int)colorType view:(UIView *)superView;

@end
