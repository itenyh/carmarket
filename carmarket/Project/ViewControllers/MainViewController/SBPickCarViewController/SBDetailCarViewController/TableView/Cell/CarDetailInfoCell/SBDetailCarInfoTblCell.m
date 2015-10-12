//
//  SBDetailCarInfoTblCell.m
//  carmarket
//
//  Created by itensb on 14-8-6.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBDetailCarInfoTblCell.h"

@implementation SBDetailCarInfoTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        // Initialization code
        imgBtn = [[UIButton alloc] initWithFrame:CGRectMake(29 * PJSAH, 19 * PJSAH, 353 * PJSAH, 243 * PJSAH)];
        [self.contentView addSubview:imgBtn];
        
        title = [ITUIKitHelper createLabel:@"" size:CGSizeMake(290 * PJSAH, -1) font:[UIFont systemFontOfSize:35 * PJSAH] color:[ITUIKitHelper color:@"181818"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:imgBtn margin:19 * PJSAH], 34 * PJSAH) superViewFrame:self.frame];
        title.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:title];
        
        paiLiang = [ITUIKitHelper createLabel:@"" size:CGSizeMake(290 * PJSAH, -1) font:[UIFont systemFontOfSize:25 * PJSAH] color:[ITUIKitHelper color:@"4f4f4f"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(title.frame.origin.x, [ITUIKitHelper yMarTopView:title margin:34 * PJSAH]) superViewFrame:self.frame];
        [self.contentView addSubview:paiLiang];
        
        jiBie = [ITUIKitHelper createLabel:@"" size:CGSizeMake(290 * PJSAH, -1) font:[UIFont systemFontOfSize:25 * PJSAH] color:paiLiang.textColor marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(title.frame.origin.x, [ITUIKitHelper yMarTopView:paiLiang margin:30 * PJSAH]) superViewFrame:self.frame];
        [self.contentView addSubview:jiBie];
        
        youHao = [ITUIKitHelper createLabel:@"" size:CGSizeMake(215 * PJSAH, -1) font:[UIFont systemFontOfSize:25 * PJSAH] color:paiLiang.textColor marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(title.frame.origin.x, [ITUIKitHelper yMarTopView:jiBie margin:30 * PJSAH]) superViewFrame:self.frame];
        [self.contentView addSubview:youHao];
        
        UIButton *moreBtn = [ITUIKitHelper createButtonWithUIImage:[UIImage imageNamed:@"btn_more"] highlightImg:nil isBackgroundImg:YES];
        [moreBtn bk_addEventHandler:^(id sender) {
            RUPWarning([[ITUtils viewControllerFor:self] performSelector:@selector(SBDetailCarInfoTblCell_moreBtn:) withObject:self]);
        } forControlEvents:UIControlEventTouchUpInside];
        [ITUIKitHelper pointSet:moreBtn piont:CGPointMake([ITUIKitHelper getAppWidth] - 15 - 20, youHao.frame.origin.y)];
        
        [self.contentView addSubview:moreBtn];
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
    
    [imgBtn sd_setImageWithURL:[SBUtil getImgURLWith:info pre:@"imgDomainName" other:@"picture"] forState:UIControlStateNormal placeholderImage:[SBUIFactory getPlaceHolderImg]];
    
    title.text = [info objectForKey:@"showName"];
    
//    NSArray *paiLiangData = [NSArray arrayWithObjects:@"1.5", @"1.6", nil];
//    NSMutableString *paiLiangStr = [NSMutableString stringWithString:@"排量："];
//    for (int i = 0; i < paiLiangData.count; i++) {
//        NSString *temp = [paiLiangData objectAtIndex:i];
//        if (i == 0) [paiLiangStr appendFormat:@"%@L", temp];
//        else [paiLiangStr appendFormat:@"、%@L", temp];
//    } 
    
    paiLiang.text = [NSString stringWithFormat:@"排量：%@", ([info objectForKey:@"displacement"] == nil ? @"" : [info objectForKey:@"displacement"])];
    jiBie.text = [NSString stringWithFormat:@"级别：%@", ([info objectForKey:@"carLevel"] == nil ? @"" : [info objectForKey:@"carLevel"])];
    youHao.text = [NSString stringWithFormat:@"油耗：%@", ([info objectForKey:@"summaryFuel"] == nil ? @"" : [info objectForKey:@"summaryFuel"])];
    
}

+ (float)getHeight:(NSDictionary *)info
{
    return 287 * PJSAH;
}


@end
