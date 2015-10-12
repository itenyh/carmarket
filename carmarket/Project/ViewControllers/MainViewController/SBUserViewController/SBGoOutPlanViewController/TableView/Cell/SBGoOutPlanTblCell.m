//
//  SBGoOutPlanTblCell.m
//  carmarket
//
//  Created by itensb on 14-11-13.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBGoOutPlanTblCell.h"

@implementation SBGoOutPlanTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        UIImage *strechBgImg = [[UIImage imageNamed:@"bg_plantag"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeTile];
        bottom = [[UIImageView alloc] initWithFrame:CGRectMake(21 * PJSAH, 0, [ITUIKitHelper getAppWidth] - 21 * PJSA, 80)];
//        bottom.backgroundColor = [ITUIKitHelper color:140 blue:229 green:194 alpha:1];
//        bottom.layer.cornerRadius = 10;//设置那个圆角的有多圆
//        bottom.layer.borderWidth = 0;//设置边框的宽度，当然可以不要
//        bottom.layer.masksToBounds = YES;
        bottom.image = strechBgImg;
        [self.contentView addSubview:bottom];
        
        float itemHeight = 40;
        float itemWidth = 20;
        UIButton *lb = [[UIButton alloc] initWithFrame:CGRectMake(8, 0, itemWidth, itemHeight)];
        [lb setImage:[UIImage imageNamed:@"left_arrow"] forState:UIControlStateNormal];
        [bottom addSubview:lb];
        
        ll = [ITUIKitHelper createLabel:@"" size:CGSizeMake(bottom.frame.size.width - itemWidth - 10, itemHeight) font:[UIFont systemFontOfSize:40 * PJSAH] color:[ITUIKitHelper color:@"000000"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:lb margin:0], 0) superViewFrame:self.contentView.frame];
        ll.textAlignment = NSTextAlignmentLeft;
//        ll.adjustsFontSizeToFitWidth = YES;
        [bottom addSubview:ll];
        
        rl = [ITUIKitHelper createLabel:@"" size:CGSizeMake(bottom.frame.size.width - itemWidth - 10, itemHeight) font:[UIFont systemFontOfSize:40 * PJSAH] color:[ITUIKitHelper color:@"000000"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(0, [ITUIKitHelper yMarTopView:ll margin:0]) superViewFrame:self.contentView.frame];
        rl.textAlignment = NSTextAlignmentRight;
//        rl.adjustsFontSizeToFitWidth = YES;
        [bottom addSubview:rl];
        
        UIButton *rb = [[UIButton alloc] initWithFrame:CGRectMake([ITUIKitHelper xMarLeftView:rl margin:0], rl.frame.origin.y, itemWidth, itemHeight)];
        [rb setImage:[UIImage imageNamed:@"right_arrow"] forState:UIControlStateNormal];
        [bottom addSubview:rb];
        
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];

    ll.text = [[info objectForKey:@"sInfo"] objectForKey:@"name"];
    rl.text = [[info objectForKey:@"eInfo"] objectForKey:@"name"];

    UIImage *bgImg = [info objectForKey:@"map"];
    if(bgImg) bottom.image = bgImg;
}


+ (float)getHeight:(NSDictionary *)info
{
    return 85;
}


@end
