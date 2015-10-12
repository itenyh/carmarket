//
//  SBCommentReportSegView.h
//  carmarket
//
//  Created by itensb on 14-8-25.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SBCommentReportSegView;
@protocol SBCommentReportSegViewDelegate <NSObject>

- (void)SBCommentReportSegView:(SBCommentReportSegView *)view btn:(UIButton *)btn;

@end

@interface SBCommentReportSegView : UIView
{
    NSMutableArray *btns;
}

@property (nonatomic, assign) int selectedIndex;
@property (nonatomic, weak) id<SBCommentReportSegViewDelegate> delegate;

-(id)initWithFrame:(CGRect)frame datas:(NSArray *)datas;

@end
