//
//  SBLowPriceView.h
//  carmarket
//
//  Created by itensb on 14-9-2.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBLowPriceView : UIView
{
    UILabel *l;
    UIView *bottom;
}

- (void)setPrice:(NSString *)price;

@end
