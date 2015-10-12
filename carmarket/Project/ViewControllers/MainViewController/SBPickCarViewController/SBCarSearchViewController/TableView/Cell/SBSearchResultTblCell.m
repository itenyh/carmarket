//
//  SBSearchResultTblCell.m
//  carmarket
//
//  Created by itensb on 14-8-22.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBSearchResultTblCell.h"

@implementation SBSearchResultTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        UIView *lineView = [ITUIKitHelper createIconWithUIImage:[UIImage imageWithColor:[ITUIKitHelper color:@"d6d6d6"] size:CGSizeMake([ITUIKitHelper getAppWidth] - 10, 0.5)]];
        [ITUIKitHelper pointSet:lineView piont:CGPointMake(10, [SBSearchResultTblCell getHeight:nil] - 0.5)];
        [self.contentView addSubview:lineView];

        
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
    
    self.textLabel.text = [info objectForKey:@"name"];
    self.textLabel.font = [UIFont boldSystemFontOfSize:40 * PJSAH];
}

+ (float)getHeight:(NSDictionary *)info
{
    return [UIFont boldSystemFontOfSize:40 * PJSAH].lineHeight + 20;
}

@end
