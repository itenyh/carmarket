//
//  SBSecondHandCarInfoTblCell.m
//  carmarket
//
//  Created by itensb on 14-8-29.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBSecondHandCarInfoTblCell.h"

@implementation SBSecondHandCarInfoTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        bottom = [[UIView alloc] initWithFrame:CGRectMake(21 * PJSAH, 0, [ITUIKitHelper getAppWidth] - 21 * PJSA, [SBSecondHandCarInfoTblCell getHeight:nil] - 18 * PJSAH)];
        bottom.backgroundColor = [UIColor whiteColor];
        [SBUIFactory decorateWithLine:bottom width:0.5 type:ITLineDecorateAll];
        [self.contentView addSubview:bottom];
        
        // Initialization code
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10 * PJSAH, 21 * PJSAH, 236 * PJSAH, 157 * PJSAH)];
        [bottom addSubview:imgView];
        
        title = [ITUIKitHelper createLabel:@"" size:CGSizeMake(bottom.frame.size.width - [ITUIKitHelper xMarLeftView:imgView margin:5] - 10, -1) font:[UIFont boldSystemFontOfSize:30 * PJSAH] color:[ITUIKitHelper color:@"131313"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:imgView margin:12 * PJSAH], 37 * PJSAH) superViewFrame:bottom.frame];
//        title.backgroundColor = TEST_BGCOLOR;
        [bottom addSubview:title];
        
        distance = [ITUIKitHelper createLabel:@"" size:CGSizeMake(195 * PJSAH, -1) font:[UIFont systemFontOfSize:25 * PJSAH] color:[ITUIKitHelper color:@"cccccc"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:imgView margin:12 * PJSAH], [ITUIKitHelper yMarTopView:title margin:28 * PJSAH]) superViewFrame:bottom.frame];
//        distance.backgroundColor = TEST_BGCOLOR;
        [bottom addSubview:distance];
        
        price = [ITUIKitHelper createLabel:@"" size:CGSizeMake(80, -1) font:[UIFont boldSystemFontOfSize:28 * PJSAH] color:[ITUIKitHelper color:@"c30014"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(bottom.frame.size.width - 80 - 10, [ITUIKitHelper yMarTopView:title margin:41 * PJSAH] - 9) superViewFrame:bottom.frame];
//        price.backgroundColor = TEST_BGCOLOR;
        price.textAlignment = NSTextAlignmentRight;
        [bottom addSubview:price];
        
        faburen = [ITUIKitHelper createLabel:@"" size:CGSizeMake(100 * PJSAH, -1) font:[UIFont systemFontOfSize:25 * PJSAH] color:[ITUIKitHelper color:@"cccccc"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:imgView margin:12 * PJSAH], [ITUIKitHelper yMarTopView:distance margin:20 * PJSAH]) superViewFrame:bottom.frame];
//        faburen.backgroundColor = TEST_BGCOLOR;
        [bottom addSubview:faburen];
        
        time = [ITUIKitHelper createLabel:@"" size:CGSizeMake(280 * PJSAH, -1) font:[UIFont systemFontOfSize:25 * PJSAH] color:[ITUIKitHelper color:@"cccccc"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:faburen margin:12 * PJSAH], [ITUIKitHelper yMarTopView:distance margin:20 * PJSAH]) superViewFrame:bottom.frame];
//        time.backgroundColor = TEST_BGCOLOR;
        [bottom addSubview:time];
        
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
    
    [imgView sd_setImageWithURL:[SBUtil getImgURLWith:info pre:@"imgDomainName" other:@"imgBody"] placeholderImage:[SBUIFactory getPlaceHolderImg]];
    
    title.text = [info objectForKey:@"carName"];
    
    NSString *priceStr = [NSString stringWithFormat:@"%@", [info objectForKey:@"price"]];
    price.text = [NSString stringWithFormat:@"￥%@万", priceStr];
    
    NSString *distanceStr = [NSString stringWithFormat:@"%@", [info objectForKey:@"mileage"]];
    distance.text = [NSString stringWithFormat:@"%@万公里", distanceStr];
    
    faburen.text = [info objectForKey:@"createName"];
    
    double createTime = [[info objectForKey:@"createTime"] doubleValue];
    createTime = createTime / 1000;
    NSString *ct = [ITUtils date_fromInterval:createTime format:@"yyyy年MM月dd日"];
    time.text = ct;
//    distance.text = [info objectForKey:@"mileage"];
//    time.text = [info objectForKey:@"createTime"];
//    title.text = [info objectForKey:@"carName"];
//    price.text = [NSString stringWithFormat:@"%@万", [info objectForKey:@"newPrice"]];
//    s4title.text = [info objectForKey:@"dealerName"];
//    localSell.text = [info objectForKey:@"saleRegion"];
//    
//    [price sizeWidthToFit];
//    
//    [teleBtn setTitle:[info objectForKey:@"dealerPhone"] forState:UIControlStateNormal];
//    
//    [ITUIKitHelper removeLineViews:bottom];
//    [SBUIFactory decorateWithLine:bottom width:0.5 type:ITLineDecorateAll];
    
}

+ (float)getHeight:(NSDictionary *)info
{
    return 204 * PJSAH + 18 * PJSAH;
}


@end
