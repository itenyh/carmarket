//
//  SBGoOutPlanSwicherCell.m
//  carmarket
//
//  Created by itensb on 14-11-17.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBGoOutPlanSwicherCell.h"

@implementation SBGoOutPlanSwicherCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.contentView.backgroundColor = [ITUIKitHelper color:@"ffffff" alpha:1];

        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [ITUIKitHelper getAppWidth], 60)];
        [self.contentView addSubview:bgView];
        
        UIView *icon = [ITUIKitHelper createIconWithImage:@"ico_bar_checkin_pressed"];
        [ITUIKitHelper pointSet:icon piont:CGPointMake(10, (bgView.frame.size.height - icon.frame.size.height) / 2.0)];
        [bgView addSubview:icon];
        
        UILabel *l = [ITUIKitHelper createLabel:@"推送通知" size:CGSizeMake(200, bgView.frame.size.height) font:[UIFont systemFontOfSize:12] color:[ITUIKitHelper color:156 blue:164 green:161 alpha:1] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:icon margin:10], 0) superViewFrame:self.frame];
        [bgView addSubview:l];
        
        UIView *arrIcon = [ITUIKitHelper createIconWithUIImage:[UIImage imageNamed:@"icon_wangjimimaarray"]];
        [self addSubview:arrIcon];
        [ITUIKitHelper pointSet:arrIcon piont:CGPointMake([ITUIKitHelper getAppWidth] - 27 * PJSAH - arrIcon.frame.size.width, ([SBGoOutPlanSwicherCell getHeight:nil] - arrIcon.frame.size.height) / 2)];
        
        UIView *lineView = [ITUIKitHelper createIconWithUIImage:[UIImage imageWithColor:[ITUIKitHelper color:@"d6d6d6"] size:CGSizeMake([ITUIKitHelper getAppWidth] - 20, 0.5)]];
        [ITUIKitHelper pointSet:lineView piont:CGPointMake(10, 0)];
        [self.contentView addSubview:lineView];
        
        UIView *lineView1 = [ITUIKitHelper createIconWithUIImage:[UIImage imageWithColor:[ITUIKitHelper color:@"d6d6d6"] size:CGSizeMake([ITUIKitHelper getAppWidth] - 20, 0.5)]];
        [ITUIKitHelper pointSet:lineView1 piont:CGPointMake(10, [ITUIKitHelper yMarTopView:bgView margin:0])];
        [self.contentView addSubview:lineView1];
        
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
}

- (void)display:(NSString *)time isOn:(BOOL)is
{
    [sw setOn:is];
}

+ (float)getHeight:(NSDictionary *)info
{
    return 60;
}


@end
