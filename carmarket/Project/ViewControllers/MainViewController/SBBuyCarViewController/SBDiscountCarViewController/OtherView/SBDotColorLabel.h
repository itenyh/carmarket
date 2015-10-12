//
//  SBDotColorLabel.h
//  carmarket
//
//  Created by itensb on 14-11-6.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBDotColorLabel : UIView
{
    UILabel *l;
}

- (void)setContent:(NSString *)content;
+ (SBDotColorLabel *)dotColorLable:(NSString *)title point:(CGPoint)point;

@end
