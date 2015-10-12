//
//  SBCarComTypeView.h
//  carmarket
//
//  Created by itensb on 14-11-7.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBCarComTypeView : UIView
{
    UIButton *icon;
    int type;
}

- (id)initWithFrame:(CGRect)frame type:(int)_type;
- (void)setComTitle:(NSString *)title;

@end
