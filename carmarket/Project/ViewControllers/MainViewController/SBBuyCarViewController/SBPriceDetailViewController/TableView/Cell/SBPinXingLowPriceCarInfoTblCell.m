//
//  SBPinXingLowPriceCarInfoTblCell.m
//  carmarket
//
//  Created by itensb on 14-11-20.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBPinXingLowPriceCarInfoTblCell.h"

@implementation SBPinXingLowPriceCarInfoTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        yuanjia.hidden = YES;
        cuxiao.hidden = YES;
        
        delePrice.hidden = YES;
        lowprice.hidden = YES;
        cuxiaotime.hidden = YES;
        leftTime.hidden = YES;
        
        
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
    
    NSDictionary *data = [info objectForKey:@"data"];
    NSDictionary *oldData = [info objectForKey:@"oldData"];
    
    [imgView sd_setImageWithURL:[SBUtil getImgURLWith:oldData pre:@"imgDomainName" other:@"carImg"] placeholderImage:[SBUIFactory getPlaceHolderImg]];
    
    lowprice.hidden = YES;
//    delePrice.hidden = YES;
//    cuxiaotime.hidden = YES;
    
    NSString *huodongStr = [data objectForKey:@"detailContent"];
    CGSize maxSize = CGSizeMake(huodong.frame.size.width, 999);
    CGSize labelSize = [huodongStr sizeWithFont:huodong.font
                              constrainedToSize: maxSize
                                  lineBreakMode: NSLineBreakByTruncatingTail];
    if(labelSize.width != 0) [ITUIKitHelper sizeSet:huodong size:labelSize];
    huodong.text = huodongStr;
    
    
}

- (UIView *)createLineView
{
    UIView *lineView = [ITUIKitHelper createIconWithUIImage:[UIImage imageWithColor:[ITUIKitHelper color:@"d6d6d6"] size:CGSizeMake([ITUIKitHelper getAppWidth], 0.5)]];
    [ITUIKitHelper pointSet:lineView piont:CGPointMake(0, [ITUIKitHelper yMarTopView:price margin:13 * PJSAH])];
    [self.contentView addSubview:lineView];
    
    return lineView;
}

+ (float)getHeight:(NSDictionary *)info
{
    NSString *huodongStr = [info objectForKey:@"detailContent"];
    CGSize maxSize = CGSizeMake([ITUIKitHelper getAppWidth] - 34 * PJSA, 999);
    CGSize labelSize = [huodongStr sizeWithFont:[UIFont systemFontOfSize:25 * PJSAH]
                              constrainedToSize: maxSize
                                  lineBreakMode: NSLineBreakByTruncatingTail];
    float arg = 457 * PJSAH / (320 - 20 * PJSA);
    arg = arg * ([ITUIKitHelper getAppWidth] - 20 * PJSA);
    return labelSize.height + arg + 250;
}

@end
