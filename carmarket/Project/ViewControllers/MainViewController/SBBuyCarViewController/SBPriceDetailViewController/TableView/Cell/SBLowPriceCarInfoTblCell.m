//
//  SBLowPriceCarInfoTblCell.m
//  carmarket
//
//  Created by Apple on 14-8-17.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBLowPriceCarInfoTblCell.h"

@implementation SBLowPriceCarInfoTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        title = [ITUIKitHelper createLabel:@"" size:CGSizeMake([ITUIKitHelper getAppWidth] - 35 * PJSA, -1) font:[UIFont boldSystemFontOfSize:35 * PJSAH] color:[ITUIKitHelper color:@"0c0c0c"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(35 * PJSAH, 50 * PJSAH) superViewFrame:self.frame];
        [self.contentView addSubview:title];
        
        s4Icon = [[SBCarComTypeView alloc] initWithFrame:CGRectMake(34 * PJSAH, [ITUIKitHelper yMarTopView:title margin:55 * PJSAH], 0, 0) type:0];
        [self.contentView addSubview:s4Icon];
        
        s4title = [ITUIKitHelper createLabel:@"" size:CGSizeMake([ITUIKitHelper getAppWidth] - 35 * PJSA, -1) font:[UIFont systemFontOfSize:30 * PJSAH] color:[ITUIKitHelper color:@"727272"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:s4Icon margin:23 * PJSAH], s4Icon.frame.origin.y - 1.5) superViewFrame:self.frame];
        [self.contentView addSubview:s4title];
        
        float arg = 457 * PJSAH / (320 - 20 * PJSA);
        UIView *whiteBorder = [[UIView alloc] initWithFrame:CGRectMake(20 * PJSAH, [ITUIKitHelper yMarTopView:s4title margin:27 * PJSAH], ([ITUIKitHelper getAppWidth] - 20 * PJSA), arg * ([ITUIKitHelper getAppWidth] - 20 * PJSA))];
        [self.contentView addSubview:whiteBorder];
        [SBUIFactory decorateWithLine:whiteBorder width:0.5 type:ITLineDecorateAll];
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake(6 * PJSAH, 6 * PJSAH, whiteBorder.frame.size.width - 6 * PJSA, whiteBorder.frame.size.height - 6 * PJSA)];
        [imgView sd_setImageWithURL:[NSURL URLWithString:TEST_IMGURL] placeholderImage:[SBUIFactory getPlaceHolderImg]];
        [whiteBorder addSubview:imgView];
        
        xianjia = [self createTitleLab:@"现价:" point:CGPointMake(35 * PJSAH, [ITUIKitHelper yMarTopView:whiteBorder margin:43 * PJSAH])];
        yuanjia = [self createTitleLab:@"原价:" point:CGPointMake(35 * PJSAH, [ITUIKitHelper yMarTopView:xianjia margin:24 * PJSAH])];
        cuxiao = [self createTitleLab:@"促销时间:" point:CGPointMake(35 * PJSAH, [ITUIKitHelper yMarTopView:yuanjia margin:22 * PJSAH])];
        
        price = [ITUIKitHelper createLabel:@"" size:CGSizeMake(30, -1) font:[UIFont boldSystemFontOfSize:35 * PJSAH] color:[ITUIKitHelper color:@"c30014"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:xianjia margin:5], xianjia.frame.origin.y - 1.5) superViewFrame:self.frame];
        [self.contentView addSubview:price];
        
        delePrice = [[StrikeThroughLabel alloc] initWithFrame:CGRectMake([ITUIKitHelper xMarLeftView:yuanjia margin:5], yuanjia.frame.origin.y - 1, 0,  [UIFont systemFontOfSize:30 * PJSAH].lineHeight)];
        delePrice.strikeThroughEnabled = YES;
        delePrice.font = [UIFont systemFontOfSize:30 * PJSAH];
        delePrice.textColor = [ITUIKitHelper color:@"969696"];
        [self.contentView addSubview:delePrice];

        lowprice = [[SBLowPriceView alloc] initWithFrame:CGRectMake([ITUIKitHelper xMarLeftView:delePrice margin:5], delePrice.frame.origin.y + 2, 100, 0)];
        [self.contentView addSubview:lowprice];
        
        cuxiaotime = [ITUIKitHelper createLabel:@"" size:CGSizeMake(340 * PJSAH, -1) font:[UIFont systemFontOfSize:30 * PJSAH] color:[ITUIKitHelper color:@"969696"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:cuxiao margin:5], cuxiao.frame.origin.y + 1) superViewFrame:self.frame];
        [self.contentView addSubview:cuxiaotime];
        
        leftTime = [[SBLeftTimeView alloc] initWithFrame:CGRectMake([ITUIKitHelper getAppWidth] - 45 * PJSAH - 10, [ITUIKitHelper yMarTopView:whiteBorder margin:190 * PJSAH], 0, 0)];
        [self.contentView addSubview:leftTime];
        
        UIView *lineView = [self createLineView];
        
        UILabel *shuoming = [ITUIKitHelper createLabel:@"活动说明" font:[UIFont systemFontOfSize:30 * PJSAH] color:[ITUIKitHelper color:@"181818"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(37 * PJSAH, [ITUIKitHelper yMarTopView:lineView margin:29 * PJSAH]) superViewFrame:self.frame];
        [self.contentView addSubview:shuoming];
        
        huodong = [ITUIKitHelper createLabel:@"" size:CGSizeMake([ITUIKitHelper getAppWidth] - 34 * PJSA, -1) font:[UIFont systemFontOfSize:25 * PJSAH] color:[ITUIKitHelper color:@"727272"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(34 * PJSAH, [ITUIKitHelper yMarTopView:shuoming margin:25 * PJSAH]) superViewFrame:self.frame];
        huodong.numberOfLines = 0;
        [self.contentView addSubview:huodong];
        
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
    
//    title.text = [info objectForKey:@"carName"];
    
    NSDictionary *data = [info objectForKey:@"data"];
    NSDictionary *oldData = [info objectForKey:@"oldData"];
    
    if ([oldData objectForKey:@"ImgAddress"]) [imgView sd_setImageWithURL:[SBUtil getImgURLWith:oldData pre:@"imgDomainName" other:@"ImgAddress"] placeholderImage:[SBUIFactory getPlaceHolderImg]];
    
    else [imgView sd_setImageWithURL:[SBUtil getImgURLWith:oldData pre:@"imgDomainName" other:@"imgBody"] placeholderImage:[SBUIFactory getPlaceHolderImg]];
    
    [s4Icon setComTitle:[oldData objectForKey:@"dealerType"]];
    
    title.text = [oldData objectForKey:@"carName"];
    
    NSString *s4TitleStr = [oldData objectForKey:@"dealerName"];
    if (s4TitleStr) s4title.text = s4TitleStr;
    else {
        s4TitleStr = [oldData objectForKey:@"createName"];
        if (s4TitleStr) s4title.text = s4TitleStr;
    }

    NSString *newPriceStr = [oldData objectForKey:@"newPrice"];
    NSString *newPriceStr1 = [oldData objectForKey:@"price"];
    if (newPriceStr) price.text = [NSString stringWithFormat:@"%@万", newPriceStr];
    else if (newPriceStr1) price.text = [NSString stringWithFormat:@"%@万", newPriceStr1];
    [price sizeWidthToFit];
    
    NSString *oldPriceStr = [oldData objectForKey:@"oldPrice"];
    if(oldPriceStr) delePrice.text = [NSString stringWithFormat:@"%@万", oldPriceStr];
    [delePrice sizeWidthToFit];
    
    NSString *lowpriceStr = [oldData objectForKey:@"cutPriceRange"];
    if(lowpriceStr) {lowprice.hidden = NO;[lowprice setPrice:[NSString stringWithFormat:@"%@万", lowpriceStr]];} else lowprice.hidden = YES;
    [ITUIKitHelper pointSet:lowprice piont:CGPointMake([ITUIKitHelper xMarLeftView:delePrice margin:24 * PJSAH], -1)];
    
    NSString *format = @"yyyy/MM/dd";
    NSString *sDate = [ITUtils date_fromInterval:[[data objectForKey:@"cutPricebegTime"] doubleValue]/1000 format:format];
    NSString *eDate = [ITUtils date_fromInterval:[[data objectForKey:@"cutPriceendTime"] doubleValue]/1000 format:format];
    cuxiaotime.text = [NSString stringWithFormat:@"%@-%@", sDate, eDate];
    
    double leftTimeD = [[data objectForKey:@"cutPriceendTime"] doubleValue]/1000 - [[NSDate date] timeIntervalSince1970];
    int leftDay = leftTimeD / 60 / 60 / 24;
    if (leftDay >= 0) [leftTime setTime:[NSString stringWithFormat:@"%d", leftDay]];
    else [leftTime setTime:@"0"];
    
    NSString *huodongStr = [data objectForKey:@"cutPriceExplain"];
    CGSize maxSize = CGSizeMake(huodong.frame.size.width, 999);
    CGSize labelSize = [huodongStr sizeWithFont:huodong.font
                          constrainedToSize: maxSize
                              lineBreakMode: NSLineBreakByTruncatingTail];
    if(labelSize.width != 0) [ITUIKitHelper sizeSet:huodong size:labelSize];
    huodong.text = huodongStr;
    
}

+ (float)getHeight:(NSDictionary *)info
{
    NSString *huodongStr = [info objectForKey:@"cutPriceExplain"];
    CGSize maxSize = CGSizeMake([ITUIKitHelper getAppWidth] - 34 * PJSA, 999);
    CGSize labelSize = [huodongStr sizeWithFont:[UIFont systemFontOfSize:25 * PJSAH]
                              constrainedToSize: maxSize
                                  lineBreakMode: NSLineBreakByTruncatingTail];
    float arg = 457 * PJSAH / (320 - 20 * PJSA);
    arg = arg * ([ITUIKitHelper getAppWidth] - 20 * PJSA);
    return labelSize.height + arg + 250;
}

- (UILabel *)createTitleLab:(NSString *)_title point:(CGPoint)point
{
    UILabel *l = [ITUIKitHelper createLabel:_title font:[UIFont systemFontOfSize:30 * PJSAH] color:[ITUIKitHelper color:@"727272"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:point superViewFrame:self.frame];
    [self.contentView addSubview:l];
    
    return l;
}

- (UIView *)createLineView
{
    UIView *lineView = [ITUIKitHelper createIconWithUIImage:[UIImage imageWithColor:[ITUIKitHelper color:@"d6d6d6"] size:CGSizeMake([ITUIKitHelper getAppWidth], 0.5)]];
    [ITUIKitHelper pointSet:lineView piont:CGPointMake(0, [ITUIKitHelper yMarTopView:leftTime margin:13 * PJSAH])];
    [self.contentView addSubview:lineView];
    
    return lineView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
