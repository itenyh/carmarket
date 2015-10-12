//
//  SBDatePickerView.h
//  carmarket
//
//  Created by itensb on 14-8-19.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  SBDatePickerView;
typedef void (^PickerClearB)(SBDatePickerView *picker);

@interface SBDatePickerView : UIView
{
    CGRect originalRect;
    UIDatePicker *picker;
    PickerClearB clearB;
}

- (void)show;
- (void)hide:(BOOL)animate;
- (void)addValueChangeHandler:(void (^)(id sender))handler;
- (void)addClearHandler:(PickerClearB)block;

@end
