//
//  SBFastNaviHistoryTblCell.m
//  carmarket
//
//  Created by itensb on 14-11-14.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBFastNaviHistoryTblCell.h"

@implementation SBFastNaviHistoryTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        UIView *bottom = [[UIView alloc] initWithFrame:CGRectMake(21 * PJSAH, 15, [ITUIKitHelper getAppWidth] - 21 * PJSA, [SBFastNaviHistoryTblCell getHeight:nil] - 15)];
        bottom.backgroundColor = [ITUIKitHelper color:@"ffffff" alpha:0.8];
        [SBUIFactory decorateWithLine:bottom width:1 type:ITLineDecorateAll];
        [self.contentView addSubview:bottom];
        
        UIView *icon = [ITUIKitHelper createIconWithImage:@"icon_history"];
        [ITUIKitHelper pointSet:icon piont:CGPointMake(5, (bottom.frame.size.height - icon.frame.size.height) / 2.0)];
        [bottom addSubview:icon];
        
        ll = [ITUIKitHelper createLabel:@"" size:CGSizeMake(bottom.frame.size.width - icon.frame.size.width - 20, -1) font:[UIFont systemFontOfSize:40 * PJSAH] color:[UIColor blackColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:icon margin:0], 5) superViewFrame:self.contentView.frame];
        ll.adjustsFontSizeToFitWidth = YES;
        [bottom addSubview:ll];
        
        sub = [ITUIKitHelper createLabel:@"" size:CGSizeMake(bottom.frame.size.width - icon.frame.size.width - 1, bottom.frame.size.height - [ITUIKitHelper yMarTopView:ll margin:0]) font:[UIFont systemFontOfSize:31 * PJSAH] color:[UIColor lightGrayColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:icon margin:1], [ITUIKitHelper yMarTopView:ll margin:0]) superViewFrame:self.contentView.frame];
        sub.adjustsFontSizeToFitWidth = YES;
        [bottom addSubview:sub];
        
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
    
    ll.text = [info objectForKey:@"name"];
    sub.text = [info objectForKey:@"add"];
    if(sub.text.length == 0) sub.text = @"无详细地址数据";
}


+ (float)getHeight:(NSDictionary *)info
{
    return 70;
}


@end
