//
//  SBCarCommentReportSegTblCell.m
//  carmarket
//
//  Created by Apple on 14-8-24.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBCarCommentGoodOrBadTblCell.h"

@implementation SBCarCommentGoodOrBadTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        // Initialization code

        
        UIView *xiao = [ITUIKitHelper createIconWithUIImage:[UIImage imageNamed:@"icon_facexiao"]];
        [ITUIKitHelper pointSet:xiao piont:CGPointMake(34 * PJSAH, 47 * PJSAH)];
        [self.contentView addSubview:xiao];
        
        ku = [ITUIKitHelper createIconWithUIImage:[UIImage imageNamed:@"icon_faceku"]];
        [ITUIKitHelper pointSet:ku piont:CGPointMake(34 * PJSAH, 0)];
        [self.contentView addSubview:ku];
        
        l1 = [ITUIKitHelper createLabel:@"" size:CGSizeMake(555 * PJSAH, -1) font:[UIFont boldSystemFontOfSize:30 * PJSAH] color:[ITUIKitHelper color:@"808080"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:xiao margin:46 * PJSAH], 37 * PJSAH) superViewFrame:self.frame];
        l1.numberOfLines = 0;
        l1.backgroundColor = [ITUIKitHelper color:249 blue:237 green:237 alpha:1];
        [self.contentView addSubview:l1];
        
        l2 = [ITUIKitHelper createLabel:@"" size:CGSizeMake(555 * PJSAH, -1) font:[UIFont boldSystemFontOfSize:30 * PJSAH] color:[ITUIKitHelper color:@"808080"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:xiao margin:46 * PJSAH], 0) superViewFrame:self.frame];
        l2.numberOfLines = 0;
        l2.backgroundColor = [ITUIKitHelper color:241 blue:246 green:251 alpha:1];
        [self.contentView addSubview:l2];
        
        
    }
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
    
    [ITUIKitHelper setLabelWithConstrainedStringSize:l1 text:@"如果与前方车辆距离过近，或存在静止的障碍物，系统将向驾驶员发出视觉警告；当探测到碰撞风险时，可协助驾驶员进行制动；如果驾驶员未能作出反应，系统将介入自动降低车速。这一系统可将碰撞危险降到最低，最大程度地保证了驾驶者的安全" maxHeight:-1];
    
    [ITUIKitHelper setLabelWithConstrainedStringSize:l2 text:@"如果与前方车辆距离过近，或存在静止的障碍物，系统将向驾驶员发出视觉警告；当探测到碰撞风险时，可协助驾驶员进行制动；如果驾驶员未能作出反应，系统将介入自动降低车速。这一系统可将碰撞危险降到最低，最大程度地保证了驾驶者的安全" maxHeight:-1];
    
    [ITUIKitHelper pointSet:l2 piont:CGPointMake(-1, [ITUIKitHelper yMarTopView:l1 margin:24 * PJSAH])];
    
    [ITUIKitHelper pointSet:ku piont:CGPointMake(-1, l2.frame.origin.y + 5)];
    
}

+ (float)getHeight:(NSDictionary *)info
{
    UILabel *l = [ITUIKitHelper createLabel:@"" size:CGSizeMake(555 * PJSAH, -1) font:[UIFont boldSystemFontOfSize:30 * PJSAH] color:[ITUIKitHelper color:@"808080"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(0, 0) superViewFrame:CGRectZero];
    
    float height = [ITUIKitHelper setLabelWithConstrainedStringSize:l text:@"如果与前方车辆距离过近，或存在静止的障碍物，系统将向驾驶员发出视觉警告；当探测到碰撞风险时，可协助驾驶员进行制动；如果驾驶员未能作出反应，系统将介入自动降低车速。这一系统可将碰撞危险降到最低，最大程度地保证了驾驶者的安全" maxHeight:-1].height;
    
    height += [ITUIKitHelper setLabelWithConstrainedStringSize:l text:@"如果与前方车辆距离过近，或存在静止的障碍物，系统将向驾驶员发出视觉警告；当探测到碰撞风险时，可协助驾驶员进行制动；如果驾驶员未能作出反应，系统将介入自动降低车速。这一系统可将碰撞危险降到最低，最大程度地保证了驾驶者的安全" maxHeight:-1].height;
    
    return height + 28 +37 * PJSAH;
}

@end
