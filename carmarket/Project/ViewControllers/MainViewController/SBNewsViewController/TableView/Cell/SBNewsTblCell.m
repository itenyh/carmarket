//
//  SBNewsTblCell.m
//  carmarket
//
//  Created by itensb on 14-8-13.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#define imgWidth 134 - 5

#import "SBNewsTblCell.h"

@implementation SBNewsTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        newsImgView = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, imgWidth, 200.0 / 300.0 * imgWidth)];
//        NSLog(@"%f", 320.0f / 200.0f * [SBNewsTblCell getHeight:nil] - 5 * 2);
        newsImgView.userInteractionEnabled = NO;
        [self.contentView addSubview:newsImgView];
        
        title = [ITUIKitHelper createLabel:@"" size:CGSizeMake([ITUIKitHelper getAppWidth] - 10 * 2 - newsImgView.frame.size.width - 10, -1) font:[UIFont boldSystemFontOfSize:35 * PJSAH] color:[UIColor blackColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:newsImgView margin:28 * PJSAH], 21 * PJSAH) superViewFrame:self.frame];
        title.numberOfLines = 2;
//        title.backgroundColor = TEST_BGCOLOR;
        [self.contentView addSubview:title];
        
        content = [ITUIKitHelper createLabel:@"" size:CGSizeMake(200, -1) font:[UIFont systemFontOfSize:14] color:[UIColor grayColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:newsImgView margin:5], [ITUIKitHelper yMarTopView:title margin:10]) superViewFrame:self.frame];
        content.numberOfLines = 0;
//        [self.contentView addSubview:content];
        
        UIFont *timeFont = [UIFont systemFontOfSize:30 * PJSAH];
        time = [ITUIKitHelper createLabel:@"" size:CGSizeMake(90, -1) font:timeFont color:[UIColor grayColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:newsImgView margin:28 * PJSAH], [SBNewsTblCell getHeight:nil] - timeFont.lineHeight - 5) superViewFrame:self.frame];
//        time.backgroundColor = TEST_BGCOLOR;
        [self.contentView addSubview:time];
        
        UIView *lineView = [ITUIKitHelper createIconWithUIImage:[UIImage imageWithColor:[ITUIKitHelper color:@"d6d6d6"] size:CGSizeMake([ITUIKitHelper getAppWidth], 0.5)]];
        [ITUIKitHelper pointSet:lineView piont:CGPointMake(0, [SBNewsTblCell getHeight:nil] - 0.5)];
        [self.contentView addSubview:lineView];
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
    
    [newsImgView sd_setBackgroundImageWithURL:[SBUtil getNewsImgURLWith:info] forState:UIControlStateNormal placeholderImage:[SBUIFactory getPlaceHolderImg]];
    
    NSString *huodongStr = [info objectForKey:@"title"];
    CGSize maxSize = CGSizeMake(title.frame.size.width, 999);
    CGSize labelSize = [huodongStr sizeWithFont:title.font
                              constrainedToSize: maxSize
                                  lineBreakMode: NSLineBreakByTruncatingTail];
    if(labelSize.width != 0) {
        if (labelSize.height > title.font.lineHeight * 2) labelSize.height = title.font.lineHeight * 2;
        [ITUIKitHelper sizeSet:title size:CGSizeMake(title.frame.size.width, labelSize.height)];
    }
    title.text = [info objectForKey:@"title"];
//    NSLog(@"title : %@, height : %f", huodongStr, title.frame.size.height);
    
    NSString *timeStr = [info objectForKey:@"createTime"];
    double actionStartTime = [timeStr doubleValue];
    time.text = [ITUtils time_interval2date:actionStartTime / 1000 time_format:@"yyyy-MM-dd"];
    
   
//    NSString *cellString = @"家用也疯狂 试道奇酷威3.6L四驱旗舰版 家用也疯狂 试道奇酷威3.6L四驱旗舰版 家用也疯狂 试道奇酷威3.6L四驱旗舰版 家用也疯狂 试道奇酷威3.6L四驱旗舰版";
//    CGSize maxSize = CGSizeMake(200, [SBNewsTblCell getHeight:nil] - 40);
//    CGSize labelSize = [cellString sizeWithFont:content.font
//                              constrainedToSize: maxSize
//                                  lineBreakMode: NSLineBreakByTruncatingTail];
//    content.text = cellString;
//    [ITUIKitHelper sizeSet:content size:labelSize];
    
}

+ (float)getHeight:(NSDictionary *)info
{
    return 200.0 / 300.0 * imgWidth + 2 * 5;
}


@end
