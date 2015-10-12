//
//  SBMenuBtn.h
//  carmarket
//
//  Created by itensb on 14-8-22.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBMenuBtn : UIView
{
    UIView *array;
    UILabel *title;
    UIButton *b;
    
    UIView *atPanel;
}

@property (nonatomic, assign) BOOL on;
@property (nonatomic, readonly) UILabel *title;
@property (nonatomic, readonly) UIButton *b;

- (void)setMenuTitle:(NSString *)_title;
- (void)addTarget:(id)target action:(SEL)action;
- (void)setMenuBtnState:(BOOL)on;
- (void)setMenuTitleUnchangeSize:(NSString *)_title;

@end
