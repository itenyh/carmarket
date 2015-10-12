//
//  SBSecondCarComSayTblCell.m
//  carmarket
//
//  Created by Apple on 14-9-23.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBSecondCarComSayTblCell.h"

@implementation SBSecondCarComSayTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        UIView *lineView = [ITUIKitHelper createIconWithUIImage:[UIImage imageWithColor:[ITUIKitHelper color:@"d6d6d6"] size:CGSizeMake([ITUIKitHelper getAppWidth], 0.5)]];
        [ITUIKitHelper pointSet:lineView piont:CGPointMake(0, 0)];
        [self.contentView addSubview:lineView];
        
        UILabel *shuoming = [ITUIKitHelper createLabel:@"卖家自述" font:[UIFont systemFontOfSize:30 * PJSAH] color:[ITUIKitHelper color:@"181818"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(37 * PJSAH, [ITUIKitHelper yMarTopView:lineView margin:29 * PJSAH]) superViewFrame:self.frame];
        [self.contentView addSubview:shuoming];
        
        huodong = [ITUIKitHelper createLabel:@"" size:CGSizeMake([ITUIKitHelper getAppWidth] - 34 * PJSA, -1) font:[UIFont systemFontOfSize:25 * PJSAH] color:[ITUIKitHelper color:@"c4c4c4"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(34 * PJSAH, [ITUIKitHelper yMarTopView:shuoming margin:42 * PJSAH]) superViewFrame:self.frame];
        huodong.numberOfLines = 0;
        [self.contentView addSubview:huodong];
        
    }
    
    return self;
    
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
    
    NSDictionary *data = [info objectForKey:@"data"];
    
    NSString *huodongStr = [data objectForKey:@"description"];
    CGSize maxSize = CGSizeMake(huodong.frame.size.width, 999);
    CGSize labelSize = [huodongStr sizeWithFont:huodong.font
                              constrainedToSize: maxSize
                                  lineBreakMode: NSLineBreakByTruncatingTail];
    if(labelSize.width != 0) [ITUIKitHelper sizeSet:huodong size:labelSize];
    huodong.text = huodongStr;
    
}

+ (float)getHeight:(NSDictionary *)info
{
    NSDictionary *data = [info objectForKey:@"data"];
    
    NSString *huodongStr = [data objectForKey:@"description"];
    CGSize maxSize = CGSizeMake([ITUIKitHelper getAppWidth] - 34 * PJSA, 999);
    CGSize labelSize = [huodongStr sizeWithFont:[UIFont systemFontOfSize:25 * PJSAH]
                              constrainedToSize: maxSize
                                  lineBreakMode: NSLineBreakByTruncatingTail];
    
    return labelSize.height + 80;
}

@end
