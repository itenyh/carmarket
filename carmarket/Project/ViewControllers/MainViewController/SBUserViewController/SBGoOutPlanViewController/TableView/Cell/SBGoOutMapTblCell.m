//
//  SBGoOutMapTblCell.m
//  carmarket
//
//  Created by itensb on 14-11-14.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBGoOutMapTblCell.h"
#import "SBTrafficStateView.h"

@implementation SBGoOutMapTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
//        SBTrafficStateView *tsv = [[SBTrafficStateView alloc] init];
//        [ITUIKitHelper pointSet:tsv piont:CGPointMake(mapView.frame.size.width - tsv.frame.size.width - 5, mapView.frame.size.height - tsv.frame.size.height - 5)];
//        [[ITMapper instance].mapView addSubview:tsv];
        
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
}

- (void)displayWithView:(UIView *)view
{
    [self.contentView addSubview:view];

}

+ (float)getHeight:(NSDictionary *)info
{
    return 100;
}


@end
