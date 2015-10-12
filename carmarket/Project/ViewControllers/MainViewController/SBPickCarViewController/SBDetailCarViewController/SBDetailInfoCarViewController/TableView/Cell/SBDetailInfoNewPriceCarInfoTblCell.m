//
//  SBDetailInfoNewPriceCarInfoTblCell.m
//  carmarket
//
//  Created by itensb on 14-11-10.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBDetailInfoNewPriceCarInfoTblCell.h"

@implementation SBDetailInfoNewPriceCarInfoTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        UIView *bottom = [[UIView alloc] initWithFrame:CGRectMake(21 * PJSAH, 10, ([ITUIKitHelper getAppWidth] - 21 * PJSA), 90)];
//        bottom.backgroundColor = [ui];
        [SBUIFactory decorateWithLine:bottom width:0.5 type:ITLineDecorateAll];
        [self.contentView addSubview:bottom];
        
        img = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 110, bottom.frame.size.height - 2 * 5)];
        [bottom addSubview:img];
        
        title = [ITUIKitHelper createLabel:@"" size:CGSizeMake(175, -1) font:[UIFont boldSystemFontOfSize:16] color:[ITUIKitHelper color:@"181818"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:img margin:7], 30 * PJSAH) superViewFrame:self.frame];
//        title.backgroundColor = TEST_BGCOLOR;
        [bottom addSubview:title];
        
        UILabel *p1 = [ITUIKitHelper createLabel:@"经销商报价: " font:[UIFont systemFontOfSize:12] color:[UIColor lightGrayColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(title.frame.origin.x, [ITUIKitHelper yMarTopView:title margin:17]) superViewFrame:bottom.frame];
        [bottom addSubview:p1];
        
        p1t = [ITUIKitHelper createLabel:@"" size:CGSizeMake(80, -1) font:[UIFont systemFontOfSize:28 * PJSAH] color:[ITUIKitHelper color:@"c30114"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:p1 margin:1], p1.frame.origin.y) superViewFrame:bottom.frame];
//        p1t.backgroundColor = TEST_BGCOLOR;
        [bottom addSubview:p1t];
        
        UILabel *p2 = [ITUIKitHelper createLabel:@"预估总价: " font:[UIFont systemFontOfSize:12] color:[UIColor lightGrayColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(title.frame.origin.x, [ITUIKitHelper yMarTopView:p1 margin:3]) superViewFrame:bottom.frame];
        [bottom addSubview:p2];
        
        p2t = [ITUIKitHelper createLabel:@"" size:CGSizeMake(80, -1) font:[UIFont systemFontOfSize:28 * PJSAH] color:[ITUIKitHelper color:@"181818"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:p2 margin:1], p2.frame.origin.y) superViewFrame:bottom.frame];
//        p2t.backgroundColor = TEST_BGCOLOR;
        [bottom addSubview:p2t];
        
        
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
    
    title.text = [info objectForKey:@"carName"];
    p1t.text = [NSString stringWithFormat:@"%@万", [info objectForKey:@"dealerMinPrice"]];
    p2t.text = [info objectForKey:@"factoryPrice"];
    
    NSDictionary *modelDict = [info objectForKey:@"carModelInfo"];
    [img sd_setImageWithURL:[SBUtil getImgURLWith:modelDict pre:@"imgDomainName" other:@"picture"] placeholderImage:[SBUIFactory getPlaceHolderImg]];

}

+ (float)getHeight:(NSDictionary *)info
{
    return 100;
}


@end
