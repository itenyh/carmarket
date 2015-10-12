//
//  SBCommentReportSegView.m
//  carmarket
//
//  Created by itensb on 14-8-25.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBCommentReportSegView.h"

@implementation SBCommentReportSegView
@synthesize selectedIndex;

-(id)initWithFrame:(CGRect)frame datas:(NSArray *)datas
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        btns = [NSMutableArray array];
        float btnWidth = frame.size.width / datas.count;
        float btnHeight = frame.size.height;
        
        for (int i = 0; i < 4; i++) {
            
            UIButton *b = [[UIButton alloc] initWithFrame:CGRectMake(i * btnWidth, 0, btnWidth, btnHeight)];
            b.titleLabel.font = [UIFont systemFontOfSize:30 * PJSAH];
            [b setTitle:[datas objectAtIndex:i] forState:UIControlStateNormal];
            b.tag = i;
            
            if (selectedIndex == b.tag) [self setBtnSelect:YES btn:b];
            else [self setBtnSelect:NO btn:b];
            
            [b bk_addEventHandler:^(id sender) {
                
                selectedIndex = b.tag;
                
                for (UIButton *bb in btns) [self setBtnSelect:NO btn:bb];
                
                [self setBtnSelect:YES btn:b];
                
                if (_delegate && [_delegate respondsToSelector:@selector(SBCommentReportSegView:btn:)]) {
                    [_delegate SBCommentReportSegView:self btn:b];
                }
                
            } forControlEvents:UIControlEventTouchUpInside];
            
            [btns addObject:b];
            [self addSubview:b];
            
            
        }
        
        
    }
    
    return self;
}

- (void)setBtnSelect:(BOOL)is btn:(UIButton *)btn
{
    if (is) {
        [btn setTitleColor:[ITUIKitHelper color:@"c30114"] forState:UIControlStateNormal];
        [btn setBackgroundColor:[ITUIKitHelper color:@"FCFCFC"]];
    }
    else {
        [btn setTitleColor:[ITUIKitHelper color:@"4f4f4f"] forState:UIControlStateNormal];
        [btn setBackgroundColor:[ITUIKitHelper color:@"EDEDED"]];
    }
}

@end
