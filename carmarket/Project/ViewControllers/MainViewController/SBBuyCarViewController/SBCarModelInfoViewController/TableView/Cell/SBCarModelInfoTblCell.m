//
//  SBCarModelInfoTblCell.m
//  carmarket
//
//  Created by itensb on 14-9-4.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBCarModelInfoTblCell.h"

@implementation SBCarModelInfoTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        UIView *bottom = [[UIView alloc] initWithFrame:CGRectMake(33 * PJSAH, 50 * PJSAH, [ITUIKitHelper getAppWidth] - 33 * PJSA, 293 * PJSAH)];
        [SBUIFactory decorateWithLine:bottom width:0.5 type:ITLineDecorateAll];
        [self.contentView addSubview:bottom];
        
        img = [[UIImageView alloc] initWithFrame:CGRectMake(28 * PJSAH, (bottom.frame.size.height - 195 * PJSAH) / 2.0, 283 * PJSAH, 195 * PJSAH)];
        [SBUIFactory decorateWithLine:img width:0.5 type:ITLineDecorateAll];
        [bottom addSubview:img];
        
        title = [ITUIKitHelper createLabel:@"" size:CGSizeMake(290 * PJSAH, -1) font:[UIFont systemFontOfSize:35 * PJSAH] color:[ITUIKitHelper color:@"181818"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:img margin:19 * PJSAH], 51 * PJSAH) superViewFrame:self.frame];
        title.textAlignment = NSTextAlignmentCenter;
//        title.backgroundColor = TEST_BGCOLOR;
        [bottom addSubview:title];
        
        paiLiang = [ITUIKitHelper createLabel:@"" size:CGSizeMake(290 * PJSAH, -1) font:[UIFont systemFontOfSize:25 * PJSAH] color:[ITUIKitHelper color:@"4f4f4f"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(title.frame.origin.x, [ITUIKitHelper yMarTopView:title margin:15 * PJSAH]) superViewFrame:self.frame];
        [bottom addSubview:paiLiang];
        
        jiBie = [ITUIKitHelper createLabel:@"" size:CGSizeMake(290 * PJSAH, -1) font:[UIFont systemFontOfSize:25 * PJSAH] color:paiLiang.textColor marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(title.frame.origin.x, [ITUIKitHelper yMarTopView:paiLiang margin:10 * PJSAH]) superViewFrame:self.frame];
        [bottom addSubview:jiBie];
        
        youHao = [ITUIKitHelper createLabel:@"" size:CGSizeMake(215 * PJSAH, -1) font:[UIFont systemFontOfSize:25 * PJSAH] color:paiLiang.textColor marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(title.frame.origin.x, [ITUIKitHelper yMarTopView:jiBie margin:10 * PJSAH]) superViewFrame:self.frame];
        [bottom addSubview:youHao];
        
        UILabel *xiangxi = [ITUIKitHelper createLabel:@"详细信息" size:CGSizeMake(215 * PJSAH, -1) font:[UIFont systemFontOfSize:20 * PJSAH] color:[ITUIKitHelper color:@"4b89d2"] marginInsets:[ITUIKitHelper ITMarginInsetsMake:50 * PJSAH right:-1] point:CGPointMake([ITUIKitHelper xMarLeftView:img margin:210 * PJSAH] + 5, [ITUIKitHelper yMarTopView:jiBie margin:10 * PJSAH]) superViewFrame:bottom.frame];
//        [bottom addSubview:xiangxi];
        UIView *arr = [ITUIKitHelper createIconWithUIImage:[UIImage imageNamed:@"icon_bluearray"]];[bottom addSubview:arr];
        [ITUIKitHelper pointSet:arr piont:CGPointMake([ITUIKitHelper xMarLeftView:xiangxi margin:14 * PJSAH], 220 * PJSAH)];
        UIButton *xiangxiBtn = [[UIButton alloc] initWithFrame:CGRectMake(xiangxi.frame.origin.x, xiangxi.frame.origin.y, xiangxi.frame.size.width + arr.frame.size.width + 14 * PJSAH, xiangxi.frame.size.height)];
        [bottom addSubview:xiangxiBtn];
        
        UILabel *sjbj = [ITUIKitHelper createLabel:@"商家报价" font:[UIFont systemFontOfSize:35 * PJSAH] color:[ITUIKitHelper color:@"181818"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(0, [ITUIKitHelper yMarTopView:bottom margin:35 * PJSAH]) superViewFrame:self.frame];
        [ITUIKitHelper pointSet:sjbj piont:CGPointMake(([ITUIKitHelper getAppWidth] - sjbj.frame.size.width) / 2.0, -1)];
        [self.contentView addSubview:sjbj];
        
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
    
    [img sd_setImageWithURL:[NSURL URLWithString:TEST_IMGURL] placeholderImage:[SBUIFactory getPlaceHolderImg]];
    
    title.text = [info objectForKey:@"showName"];
    paiLiang.text = [NSString stringWithFormat:@"排量：%@", @"1.5L"];
    jiBie.text = [NSString stringWithFormat:@"级别：%@", @"SUV"];
    youHao.text = [NSString stringWithFormat:@"油耗：%@", @"7.6L-8.8L"];
}

+ (float)getHeight:(NSDictionary *)info
{
    return 451 * PJSAH;
}


@end
