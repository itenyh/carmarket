//
//  SBCarCommentPlainTextTblCell.m
//  carmarket
//
//  Created by itensb on 14-8-25.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBCarCommentPlainTextTblCell.h"

@implementation SBCarCommentPlainTextTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        // Initialization code

        l1 = [ITUIKitHelper createLabel:@"" size:CGSizeMake(([ITUIKitHelper getAppWidth] - 34 * PJSAH * 2), -1) font:[UIFont boldSystemFontOfSize:30 * PJSAH] color:[ITUIKitHelper color:@"808080"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(34 * PJSAH, 38 * PJSAH) superViewFrame:self.frame];
        l1.numberOfLines = 0;
        l1.backgroundColor = TEST_BGCOLOR;
        [self.contentView addSubview:l1];
        
        
    }
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
    
    [ITUIKitHelper setLabelWithConstrainedStringSize:l1 text:@"如果与前方车辆距离过近，或存在静止的障碍物，系统将向驾驶员发出视觉警告；当探测到碰撞风险时，可协助驾驶员进行制动；如果驾驶员未能作出反应，系统将介入自动降低车速。这一系统可将碰撞危险降到最低，最大程度地保证了驾驶者的安全" maxHeight:-1];
    
}

+ (float)getHeight:(NSDictionary *)info
{
    UILabel *l = [ITUIKitHelper createLabel:@"" size:CGSizeMake(555 * PJSAH, -1) font:[UIFont boldSystemFontOfSize:30 * PJSAH] color:[ITUIKitHelper color:@"808080"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(0, 38 * PJSAH) superViewFrame:CGRectZero]; //rame = (0 16.8889; 246.667 15.9067)
    
    [ITUIKitHelper setLabelWithConstrainedStringSize:l text:@"如果与前方车辆距离过近，或存在静止的障碍物，系统将向驾驶员发出视觉警告；当探测到碰撞风险时，可协助驾驶员进行制动；如果驾驶员未能作出反应，系统将介入自动降低车速。这一系统可将碰撞危险降到最低，最大程度地保证了驾驶者的安全" maxHeight:-1]; //16.8889; 240 111.347

    float height = [ITUIKitHelper yMarTopView:l margin:0]; //128
    
    return height;
}


@end
