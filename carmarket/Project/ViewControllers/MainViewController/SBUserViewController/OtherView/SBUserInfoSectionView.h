//
//  SBUserInfoSectionView.h
//  carmarket
//
//  Created by itensb on 14-8-15.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+LBBlurredImage.h"
#import "GBPathImageView.h"

@interface SBUserInfoSectionView : UIView
{
    GBPathImageView *head;
    UIButton *log;
    UILabel *name;
}

+ (float)getHeight:(NSDictionary *)info;
- (void)setLogState:(BOOL)logging;
- (void)displayWithInfo:(NSDictionary *)info;

@end
