//
//  SBDiscountCarTblCell.m
//  carmarket
//
//  Created by itensb on 14-11-6.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBDiscountCarTblCell.h"

@implementation SBDiscountCarTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        bottom = [[UIView alloc] initWithFrame:CGRectMake(21 * PJSAH, 0, [ITUIKitHelper getAppWidth] - 21 * PJSA, [SBDiscountCarTblCell getHeight:nil] - 18 * PJSAH)];
        bottom.backgroundColor = [UIColor whiteColor];
        [SBUIFactory decorateWithLine:bottom width:0.5 type:ITLineDecorateAll];
        [self.contentView addSubview:bottom];
        
        float inset = 10 * PJSAH;
        float imgPara = 1.39;
        float imgHeight = 1.0 / imgPara * (bottom.frame.size.width - inset * 2);

        imgView = [[UIImageView alloc] initWithFrame:CGRectMake(inset, inset, bottom.frame.size.width - inset * 2, imgHeight)];
        [bottom addSubview:imgView];
        
        float inset1 = inset + 3;
        title = [ITUIKitHelper createLabel:@"" size:CGSizeMake(imgView.frame.size.width - 3, -1) font:[UIFont systemFontOfSize:30 * PJSAH] color:[UIColor blackColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(inset1, [ITUIKitHelper yMarTopView:imgView margin:8]) superViewFrame:bottom.frame];
//        title.backgroundColor = TEST_BGCOLOR;
        [bottom addSubview:title];
        
        faburen = [ITUIKitHelper createLabel:@"" size:CGSizeMake(400 * PJSAH, -1) font:[UIFont systemFontOfSize:25 * PJSAH] color:[ITUIKitHelper color:@"969696"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(inset1, [ITUIKitHelper yMarTopView:title margin:10]) superViewFrame:self.frame];
        [bottom addSubview:faburen];
        
        time = [ITUIKitHelper createLabel:@"" size:CGSizeMake(400 * PJSAH, -1) font:[UIFont systemFontOfSize:25 * PJSAH] color:[ITUIKitHelper color:@"969696"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(inset1, [ITUIKitHelper yMarTopView:faburen margin:3]) superViewFrame:self.frame];
        [bottom addSubview:time];
        
        UIButton *zhifu = [SBUIFactory getColoredPanel:@"立即支付" size:CGSizeMake(bottom.frame.size.width - [ITUIKitHelper xMarLeftView:time margin:12 * PJSAH] - inset, bottom.frame.size.height - faburen.frame.origin.y - 5) color:nil font:[UIFont systemFontOfSize:16] type:4];
        zhifu.userInteractionEnabled = NO;
        [ITUIKitHelper pointSet:zhifu piont:CGPointMake([ITUIKitHelper xMarLeftView:time margin:12 * PJSAH], faburen.frame.origin.y)];
        [bottom addSubview:zhifu];
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
    
//    NSLog(@"info : %@", info);
    
    NSURL *imgUrl = [SBUtil getImgURLWith:info pre:@"imgDomainName" other:@"imgAddress"];
    [imgView sd_setImageWithURL:imgUrl placeholderImage:[SBUIFactory getPlaceHolderImg]];
    
    title.text = [info objectForKey:@"discountActivtTitle"];
    
    faburen.text = [info objectForKey:@"userLogName"];
    
    NSString *format = @"yyyy/MM/dd";
    NSString *sDate = [ITUtils date_fromInterval:[[info objectForKey:@"createTime"] doubleValue]/1000 format:format];
    NSString *eDate = [ITUtils date_fromInterval:[[info objectForKey:@"createTime"] doubleValue]/1000 format:format];
    time.text = [NSString stringWithFormat:@"%@-%@", sDate, eDate];
    
}

+ (float)getHeight:(NSDictionary *)info
{
    float inset = 10 * PJSAH;
    float imgPara = 1.39;
    float imgHeight = 1.0 / imgPara * ([ITUIKitHelper getAppWidth] - 21 * PJSA - inset * 2);
    
    return imgHeight + 85;
}


@end
