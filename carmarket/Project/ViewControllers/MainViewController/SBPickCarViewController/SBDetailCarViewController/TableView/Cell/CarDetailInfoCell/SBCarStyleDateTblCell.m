//
//  SBCarStyleDateTblCell.m
//  carmarket
//
//  Created by itensb on 14-8-6.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBCarStyleDateTblCell.h"

@implementation SBCarStyleDateTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        selectedIndex = 0;
        
        btns = [NSMutableArray array];
        
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, [SBCarStyleDateTblCell getHeight:nil])];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.bounces = NO;
        [self.contentView addSubview:scrollView];
        
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    
    [super display:info];
    
    NSArray *datas = [info objectForKey:@"data"];
    
    [scrollView.subviews bk_each:^(id obj) {[obj removeFromSuperview];}];
    [btns removeAllObjects];
    
    datas = [datas sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj2 compare:obj1];
    }];
    
    for (int i = 0; i < datas.count; i++) {
    
        UIButton *b = [[UIButton alloc] initWithFrame:CGRectMake(23 * PJSAH + i * 80, 0, 80, [SBCarStyleDateTblCell getHeight:nil])];
        b.titleLabel.font = [UIFont systemFontOfSize:30 * PJSAH];
        [b setTitle:[datas objectAtIndex:i] forState:UIControlStateNormal];
        b.tag = i;
        
        if (selectedIndex == b.tag) [self setBtnSelect:YES btn:b];
        else [self setBtnSelect:NO btn:b];
        
        [b bk_addEventHandler:^(id sender) {
            
            selectedIndex = b.tag;
            
            for (UIButton *bb in btns) [self setBtnSelect:NO btn:bb];
            
            [self setBtnSelect:YES btn:b];
            
            if (_delegate && [_delegate respondsToSelector:@selector(SBCarStyleDateTblCellBtnClick:)]) {
                [_delegate SBCarStyleDateTblCellBtnClick:b];
            }
            
        } forControlEvents:UIControlEventTouchUpInside];
        
        [SBUIFactory decorateWithLine:b width:0.5 type:ITLineDecorateExceptDown];
        
        [btns addObject:b];
        [scrollView addSubview:b];
        
        
    }
    
    [scrollView setContentSize:CGSizeMake(datas.count * 80, scrollView.frame.size.height)];
    
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

+ (float)getHeight:(NSDictionary *)info
{
    return 50;
}

@end
