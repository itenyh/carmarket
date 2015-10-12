//
//  SBDatePickerView.m
//  carmarket
//
//  Created by itensb on 14-8-19.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#define PICKER_HEIGHT 200

#import "SBDatePickerView.h"

@implementation SBDatePickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        originalRect = frame;
     
        self.backgroundColor = [ITUIKitHelper color:@"000000" alpha:0.5];
        
        UIButton *maskCloseBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [maskCloseBtn bk_addEventHandler:^(id sender) {[self hide:YES];} forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:maskCloseBtn];
        
        UIButton *close = [[UIButton alloc] initWithFrame:CGRectMake(0, self.frame.size.height - PICKER_HEIGHT - 30, self.frame.size.width, 30)];
        [close bk_addEventHandler:^(id sender) { [self hide:YES];if(clearB)clearB(self);} forControlEvents:UIControlEventTouchUpInside];
        [SBUIFactory decorateWithLine:close width:0.5 type:ITLineDecorateUpDown];
        [close setTitle:@"清除" forState:UIControlStateNormal];
        [close setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [close setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        close.backgroundColor = [UIColor whiteColor];
        [self addSubview:close];
        
        picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.frame.size.height - PICKER_HEIGHT, frame.size.width, PICKER_HEIGHT)];
        picker.datePickerMode = UIDatePickerModeDateAndTime;
        picker.minimumDate = [NSDate date];
        picker.backgroundColor = [UIColor whiteColor];
        [self addSubview:picker];
        
        [self hide:NO];
        
    }
    
    return self;
    
}

- (void)addClearHandler:(PickerClearB)block
{
    clearB = block;
}

- (void)addValueChangeHandler:(void (^)(id sender))handler 
{
    [picker bk_addEventHandler:handler forControlEvents:UIControlEventValueChanged];
}

- (void)show
{
    [UIView animateWithDuration:0.3 animations:^{[ITUIKitHelper pointSet:self piont:CGPointMake(originalRect.origin.x, originalRect.origin.y)];}];
}

- (void)hide:(BOOL)animate
{
    if (animate) [UIView animateWithDuration:0.3 animations:^{[ITUIKitHelper pointSet:self piont:CGPointMake(self.frame.origin.x, [ITUIKitHelper getAppHeight])];}];
    else [ITUIKitHelper pointSet:self piont:CGPointMake(self.frame.origin.x, [ITUIKitHelper getAppHeight])];
}

@end
