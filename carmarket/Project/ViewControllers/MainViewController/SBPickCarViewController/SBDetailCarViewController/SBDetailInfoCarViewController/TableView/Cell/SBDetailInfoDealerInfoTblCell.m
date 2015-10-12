//
//  SBDetailInfoDealerInfoTblCell.m
//  carmarket
//
//  Created by itensb on 14-11-10.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBDetailInfoDealerInfoTblCell.h"


@implementation SBDetailInfoDealerInfoTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        UIView *bottom = [[UIView alloc] initWithFrame:CGRectMake(21 * PJSAH, 10, ([ITUIKitHelper getAppWidth] - 21 * PJSA), [SBDetailInfoDealerInfoTblCell getHeight:nil] - 10)];
        //        bottom.backgroundColor = [ui];
        [SBUIFactory decorateWithLine:bottom width:0.5 type:ITLineDecorateAll];
        [self.contentView addSubview:bottom];
        
        UIImage *strechBgImg = [[UIImage imageNamed:@"header_line"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeTile];
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bottom.frame.size.width, 30)];
        [header setBackgroundColor:[UIColor colorWithPatternImage:strechBgImg]];
        [bottom addSubview:header];
        
        comIcon = [[SBCarComTypeView alloc] initWithFrame:CGRectMake(5, 0, 0, 0) type:0];
        [ITUIKitHelper pointSet:comIcon piont:CGPointMake(-1, (header.frame.size.height - comIcon.frame.size.height) / 2.0)];
        [header addSubview:comIcon];
        [comIcon setComTitle:@"4S"];
        
        title = [ITUIKitHelper createLabel:@"" size:CGSizeMake(200, header.frame.size.height) font:[UIFont boldSystemFontOfSize:16] color:[UIColor blackColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:comIcon margin:5], 0) superViewFrame:bottom.frame];
//        title.backgroundColor = TEST_BGCOLOR;
        [header addSubview:title];
        
        web = [UIButton new];
        web.frame = CGRectMake(header.frame.size.width - 55 - 5, 0, 55, header.frame.size.height);
        [web setTitle:@"进入官网" forState:UIControlStateNormal];
        [web setTitleColor:[ITUIKitHelper color:@"4b89d2"] forState:UIControlStateNormal];
        [web setTitleColor:[ITUIKitHelper color:@"4b89d2" alpha:0.8] forState:UIControlStateHighlighted];
        web.titleLabel.font = [UIFont systemFontOfSize:25 * PJSAH];
        [web bk_addEventHandler:^(id sender) {
                RUPWarning([[ITUtils viewControllerFor:self] performSelector:@selector(SBDetailInfoDealerInfoTblCell:weburl:) withObject:self withObject:weburl]);
        } forControlEvents:UIControlEventTouchUpInside];
        [header addSubview:web];
        
        name = [ITUIKitHelper createLabel:@"" size:CGSizeMake(bottom.frame.size.width - 5 * 2, -1) font:[UIFont systemFontOfSize:30 * PJSAH] color:[ITUIKitHelper color:@"727272"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(5, [ITUIKitHelper yMarTopView:header margin:5]) superViewFrame:self.frame];
        [bottom addSubview:name];
        
        phone = [ITUIKitHelper createLabel:@"" size:CGSizeMake(bottom.frame.size.width / 2.0 - 5 * 2, -1) font:[UIFont systemFontOfSize:30 * PJSAH] color:[ITUIKitHelper color:@"727272"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(5, [ITUIKitHelper yMarTopView:name margin:5]) superViewFrame:self.frame];
//        phone.backgroundColor = TEST_BGCOLOR;
        [bottom addSubview:phone];
        
        qq = [ITUIKitHelper createLabel:@"" size:CGSizeMake((bottom.frame.size.width - 5 * 2 ) / 2.0, -1) font:[UIFont systemFontOfSize:30 * PJSAH] color:[ITUIKitHelper color:@"727272"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(5, [ITUIKitHelper yMarTopView:phone margin:5]) superViewFrame:self.frame];
//        qq.backgroundColor = TEST_BGCOLOR;
        [bottom addSubview:qq];
        
        weixin = [ITUIKitHelper createLabel:@"" size:CGSizeMake((bottom.frame.size.width - 5 * 2 ) / 2.0, -1) font:[UIFont systemFontOfSize:30 * PJSAH] color:[ITUIKitHelper color:@"727272"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:qq margin:0], qq.frame.origin.y) superViewFrame:self.frame];
//        weixin.backgroundColor = TEST_BGCOLOR;
        [bottom addSubview:weixin];
        
        add = [ITUIKitHelper createLabel:@"" size:CGSizeMake(bottom.frame.size.width - 5 * 2, [UIFont systemFontOfSize:28 * PJSAH].lineHeight * 2) font:[UIFont systemFontOfSize:28 * PJSAH] color:[ITUIKitHelper color:@"727272"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(5, [ITUIKitHelper yMarTopView:weixin margin:5]) superViewFrame:self.frame];
        add.numberOfLines = 2;
//        add.backgroundColor = TEST_BGCOLOR;
        [bottom addSubview:add];
        
        float btnHeight = 26;
        UIButton *phoneBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, bottom.frame.size.height - btnHeight, bottom.frame.size.width / 2.0, btnHeight)];
        phoneBtn.tag = 0;
        [phoneBtn bk_addEventHandler:^(id sender) {
            RUPWarning([[ITUtils viewControllerFor:self] performSelector:@selector(SBDetailInfoDealerInfoTblCell_Button:Cell:) withObject:phoneBtn withObject:self]);
        } forControlEvents:UIControlEventTouchUpInside];
        [phoneBtn setImage:[UIImage imageNamed:@"icon_merchant_phone"] forState:UIControlStateNormal];
        [SBUIFactory decorateWithLine:phoneBtn width:0.5 type:ITLineDecorateRight];
        [SBUIFactory decorateWithLine:phoneBtn width:0.5 type:ITLineDecorateUp];
        [bottom addSubview:phoneBtn];
        
        UIButton *LocBtn = [[UIButton alloc] initWithFrame:CGRectMake([ITUIKitHelper xMarLeftView:phoneBtn margin:0], bottom.frame.size.height - btnHeight, bottom.frame.size.width / 2.0, btnHeight)];
        LocBtn.tag = 1;
        [LocBtn bk_addEventHandler:^(id sender) {
            RUPWarning([[ITUtils viewControllerFor:self] performSelector:@selector(SBDetailInfoDealerInfoTblCell_Button:Cell:) withObject:LocBtn withObject:self]);
        } forControlEvents:UIControlEventTouchUpInside];
        [LocBtn setImage:[UIImage imageNamed:@"icon_merchant_location"] forState:UIControlStateNormal];
        [SBUIFactory decorateWithLine:LocBtn width:0.5 type:ITLineDecorateUp];
        [bottom addSubview:LocBtn];
        
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
    
    title.text = [info objectForKey:@"dealerName"];
    
    name.text = [info objectForKey:@"dealerFullName"];
    
    phone.text = [info objectForKey:@"dealerPhone"];
    
    NSString *qqStr = [info objectForKey:@"qq"];
    qqStr = (qqStr == nil || qqStr.length == 0) ? @"QQ : -----" : [NSString stringWithFormat:@"QQ : %@", qqStr];
    qq.text = qqStr;
    NSString *weixinStr = [info objectForKey:@"weixin"];
    weixinStr = (weixinStr == nil || weixinStr.length == 0) ? @"微信 : -----" : [NSString stringWithFormat:@"微信 : %@", weixinStr];
    weixin.text = weixinStr;
    
    [comIcon setComTitle:[info objectForKey:@"dealerType"]];
    
    weburl = [info objectForKey:@"dealerWebUrl"];
    if (weburl && weburl.length > 0) web.hidden = NO;
    else web.hidden = YES;
    
    NSString *addStr = [info objectForKey:@"dealerAddress"];
    add.text = addStr;
    
}

+ (float)getHeight:(NSDictionary *)info
{
    return 170;
}

@end
