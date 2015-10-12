//
//  SBLeftTimeView.h
//  carmarket
//
//  Created by itensb on 14-9-2.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBLeftTimeView : UIView
{
    UILabel *l;
    UIView *low_icon;
}

- (void)setTime:(NSString *)time;

@end
