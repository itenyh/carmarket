//
//  SBConditionBtn.h
//  carmarket
//
//  Created by Apple on 14-8-23.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SBConditionBtn;
typedef void (^SBConditionBtnClick)(SBConditionBtn *btn);

@interface SBConditionBtn : UIView
{
    SBConditionBtnClick block;
}

@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) NSDictionary *info;

+ (float)getHeight;
- (void)setTitle:(NSString *)title;
- (void)setWidth:(float)width;
- (void)setSelected:(BOOL)is;

- (id)initWithFrame:(CGRect)frame block:(SBConditionBtnClick)_block;

@end
