//
//  SBDiscountDetailTblCell.m
//  carmarket
//
//  Created by itensb on 14-11-6.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBDiscountDetailTblCell.h"
#import "SBDotColorLabel.h"

@implementation SBDiscountDetailTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        float imgPara = 1.39;
        float imgHeight = 1.0 / imgPara * [ITUIKitHelper getAppWidth];
        
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [ITUIKitHelper getAppWidth], imgHeight)];
        [self.contentView addSubview:imgView];

        float inset = 13;
        title = [ITUIKitHelper createLabel:@"" size:CGSizeMake(imgView.frame.size.width - 2 * inset, -1) font:[UIFont boldSystemFontOfSize:35 * PJSAH] color:[UIColor blackColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(inset, [ITUIKitHelper yMarTopView:imgView margin:8]) superViewFrame:self.frame];
        //        title.backgroundColor = TEST_BGCOLOR;
        [self.contentView addSubview:title];
        
        huodong = [ITUIKitHelper createLabel:@"" size:CGSizeMake(imgView.frame.size.width - 2 * inset, -1) font:[UIFont systemFontOfSize:28 * PJSAH] color:[ITUIKitHelper color:103 blue:103 green:103 alpha:1] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(inset, [ITUIKitHelper yMarTopView:title margin:6]) superViewFrame:self.frame];
        huodong.numberOfLines = 0;
        [self.contentView addSubview:huodong];
        
        UIImage *dotImg = [UIImage imageNamed:@"bg_dotline"];
        fenge = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [ITUIKitHelper getAppWidth], dotImg.size.height)];
        fenge.image = dotImg;
        [self.contentView addSubview:fenge];
        
    }
    
    return self;
    
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
    
    NSURL *imgUrl = [SBUtil getImgURLWith:info pre:@"imgDomainName" other:@"imgAddress"];
    [imgView sd_setImageWithURL:imgUrl placeholderImage:[SBUIFactory getPlaceHolderImg]];
    
    title.text = [info objectForKey:@"discountActivtTitle"];
    
    NSString *huodongStr = @"2014双十一又！来！了！斜眼一扫视，各种厂商优惠琳琅满目，各方神圣上场大显身手。车展价？团购价？令人应接不暇，那么问题来了...到底哪家汽车厂商的优惠力度最大!";
    CGSize maxSize = CGSizeMake(huodong.frame.size.width, 999);
    CGSize labelSize = [huodongStr sizeWithFont:huodong.font
                              constrainedToSize: maxSize
                                  lineBreakMode: NSLineBreakByTruncatingTail];
    if(labelSize.width != 0) [ITUIKitHelper sizeSet:huodong size:labelSize];
    huodong.text = huodongStr;
    
    [ITUIKitHelper pointSet:fenge piont:CGPointMake(0, [ITUIKitHelper yMarTopView:huodong margin:12])];
    
    int num = 0;
    BOOL changeline = NO;
    float widthInset = 150;
    float heightInset = 9;
    UIView *formerView = fenge;
    
    NSString *carNum = [info objectForKey:@"carNum"];
    if (carNum) {
        SBDotColorLabel *cl = [SBDotColorLabel dotColorLable:[NSString stringWithFormat:@"总车数为%d", [carNum integerValue]] point:CGPointMake((num % 2) * widthInset + 13, [ITUIKitHelper yMarTopView:formerView margin:heightInset])];
        [self.contentView addSubview:cl];
        if (changeline) {changeline = NO; formerView = cl;}
        else changeline = YES;
        num++;
    }
    
    NSString *deposit = [info objectForKey:@"deposit"];
    if (deposit) {
        SBDotColorLabel *cl = [SBDotColorLabel dotColorLable:[NSString stringWithFormat:@"预付定金%d元", [deposit integerValue]] point:CGPointMake((num % 2) * widthInset + 13, [ITUIKitHelper yMarTopView:formerView margin:heightInset])];
        [self.contentView addSubview:cl];
        if (changeline) {changeline = NO; formerView = cl;}
        else changeline = YES;
        num++;
    }
    
    NSString *discount = [info objectForKey:@"discount"];
    if (discount) {
        SBDotColorLabel *cl = [SBDotColorLabel dotColorLable:[NSString stringWithFormat:@"定金抵扣优惠%d元", [discount integerValue]] point:CGPointMake((num % 2) * widthInset + 13, [ITUIKitHelper yMarTopView:formerView margin:heightInset])];
        [self.contentView addSubview:cl];
        if (changeline) {changeline = NO; formerView = cl;}
        else changeline = YES;
        num++;
    }
    
    NSString *carVendorPrice = [info objectForKey:@"carVendorPrice"];
    if (carVendorPrice) {
        SBDotColorLabel *cl = [SBDotColorLabel dotColorLable:[NSString stringWithFormat:@"单车售价%.1f万", [carVendorPrice floatValue] / 10000] point:CGPointMake((num % 2) * widthInset + 13, [ITUIKitHelper yMarTopView:formerView margin:heightInset])];
        [self.contentView addSubview:cl];
        if (changeline) {changeline = NO; formerView = cl;}
        else changeline = YES;
        num++;
    }

    
}

+ (float)getHeight:(NSDictionary *)info
{
    float imgPara = 1.39;
    float imgHeight = 1.0 / imgPara * [ITUIKitHelper getAppWidth];
    
    NSString *huodongStr = @"2014双十一又！来！了！斜眼一扫视，各种厂商优惠琳琅满目，各方神圣上场大显身手。车展价？团购价？令人应接不暇，那么问题来了...到底哪家汽车厂商的优惠力度最大!";
    CGSize maxSize = CGSizeMake([ITUIKitHelper getAppWidth] - 26, 999);
    CGSize labelSize = [huodongStr sizeWithFont:[UIFont systemFontOfSize:28 * PJSAH]
                              constrainedToSize: maxSize
                                  lineBreakMode: NSLineBreakByTruncatingTail];
    
    return labelSize.height + imgHeight + 200;
   
    
}

@end
