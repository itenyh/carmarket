//
//  SBLowPriceStrechBtnTblCell.m
//  carmarket
//
//  Created by itensb on 14-8-18.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBLowPriceStrechBtnTblCell.h"

@implementation SBLowPriceStrechBtnTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        strechBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, [ITUIKitHelper getAppWidth], [SBLowPriceStrechBtnTblCell getHeight:nil])];
        strechBtn.backgroundColor = [UIColor orangeColor];
        [self addSubview:strechBtn];
        [strechBtn bk_addEventHandler:^(id sender) {
            RUPWarning([[ITUtils viewControllerFor:self] performSelector:@selector(SBLowPriceStrechBtnTblCell_strechBtn:) withObject:self]);
        } forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
}

+ (float)getHeight:(NSDictionary *)info
{
    return 20;
}


@end
