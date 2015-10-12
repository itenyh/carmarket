//
//  SBNewPriceStaTblCell.m
//  carmarket
//
//  Created by itensb on 14-8-11.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBNewPriceStaTblCell.h"
#import "SBStaPanelView.h"

@implementation SBNewPriceStaTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        SBStaPanelView *staPanelView = [[SBStaPanelView alloc] initWithFrame:CGRectMake(0, 0, [ITUIKitHelper getAppWidth], [SBNewPriceStaTblCell getHeight:nil])];
        [self.contentView addSubview:staPanelView];
        
        
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
}

+ (float)getHeight:(NSDictionary *)info
{
    return 150;
}


@end
