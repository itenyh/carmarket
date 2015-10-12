//
//  SBGoActivityTblCell.m
//  carmarket
//
//  Created by Apple on 14-9-25.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBGoActivityTblCell.h"

@implementation SBGoActivityTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {

//        self.backgroundColor = [UIColor purpleColor];
        
        title = [ITUIKitHelper createLabel:@"" size:CGSizeMake([ITUIKitHelper getAppWidth] - 128 * PJSA, -1) font:[UIFont boldSystemFontOfSize:40 * PJSAH] color:[ITUIKitHelper color:@"181818"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(128 * PJSAH, 80 * PJSAH) superViewFrame:self.frame];
        title.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:title];
        
        content = [ITUIKitHelper createLabel:@"" size:CGSizeMake([ITUIKitHelper getAppWidth] - 62 * PJSA, 0) font:[UIFont boldSystemFontOfSize:30 * PJSAH] color:[ITUIKitHelper color:@"181818"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(62 * PJSAH, [ITUIKitHelper yMarTopView:title margin:76 * PJSAH]) superViewFrame:self.frame];
        content.numberOfLines = 0;
        [self.contentView addSubview:content];
        
        
        lianxiren = [self create_Label];
        lianxidianhua = [self create_Label];
        zongrenshu = [self create_Label];
        feiyong = [self create_Label];
        jiezhishijian = [self create_Label];
        kaishishijian = [self create_Label];
        jieshushijian = [self create_Label];
        huodongdidian = [self create_Label];
        jihedidian = [self create_Label];
        
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
    
    title.text = [info objectForKey:@"actionTitle"];
    
    NSString *contentStr = [info objectForKey:@"actionContext"];
    CGSize maxSize = CGSizeMake(content.frame.size.width, 999);
    CGSize labelSize = [contentStr sizeWithFont:content.font
                              constrainedToSize: maxSize
                                  lineBreakMode: NSLineBreakByTruncatingTail];
    content.text = contentStr;
    if (labelSize.width > 0) [ITUIKitHelper sizeSet:content size:labelSize];
    
    [self resetLabel:lianxiren text:@"联系人" content:[info objectForKey:@"contactPerson"] y:[ITUIKitHelper yMarTopView:content margin:50]];
    [self resetLabel:lianxidianhua text:@"联系电话" content:[info objectForKey:@"personPhone"] y:[ITUIKitHelper yMarTopView:lianxiren margin:10]];
    [self resetLabel:zongrenshu text:@"总人数" content:[info objectForKey:@"actionMaxUser"] y:[ITUIKitHelper yMarTopView:lianxidianhua margin:10]];
    [self resetLabel:feiyong text:@"费用/元" content:[info objectForKey:@"personMoney"] y:[ITUIKitHelper yMarTopView:zongrenshu margin:10]];
    [self resetLabel:jiezhishijian text:@"报名截止时间" content:[self get_time:[info objectForKey:@"actionBaotime"]] y:[ITUIKitHelper yMarTopView:feiyong margin:10]];
    [self resetLabel:kaishishijian text:@"活动开始时间" content:[self get_time:[info objectForKey:@"actionStartTime"]] y:[ITUIKitHelper yMarTopView:jiezhishijian margin:10]];
    [self resetLabel:jieshushijian text:@"活动结束时间" content:[self get_time:[info objectForKey:@"actionEndTime"]] y:[ITUIKitHelper yMarTopView:kaishishijian margin:10]];
    [self resetLabel:huodongdidian text:@"活动地点" content:[info objectForKey:@"actionSite"] y:[ITUIKitHelper yMarTopView:jieshushijian margin:10]];
    [self resetLabel:jihedidian text:@"集合地点" content:[info objectForKey:@"actionGatherSite"] y:[ITUIKitHelper yMarTopView:huodongdidian margin:10]];

    
}

- (void)resetLabel:(UILabel *)l text:(NSString *)text content:(NSString *)_content y:(float)y
{
    l.text = [NSString stringWithFormat:@"%@：%@", text, _content != nil ? _content : @""];
    [ITUIKitHelper pointSet:l piont:CGPointMake(-1, y)];
}

- (UILabel *)create_Label
{
    UILabel *l = [ITUIKitHelper createLabel:@"" size:CGSizeMake([ITUIKitHelper getAppWidth] - content.frame.origin.x * 2, -1) font:[UIFont boldSystemFontOfSize:30 * PJSAH] color:[ITUIKitHelper color:@"181818"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(content.frame.origin.x, 0) superViewFrame:self.frame];
    [self.contentView addSubview:l];
    return l;
}

- (NSString *)get_time:(id)_time
{
    double time = [_time doubleValue];
    time = time / 1000;

    NSString *n = [ITUtils date_fromInterval:time format:@"yyyy年MM月dd日 HH:mm"];
    
    return n;
}

+ (float)getHeight:(NSDictionary *)info
{
    NSString *contentStr = [info objectForKey:@"actionContext"];
    CGSize maxSize = CGSizeMake([ITUIKitHelper getAppWidth] - 62 * PJSA, 999);
    CGSize labelSize = [contentStr sizeWithFont:[UIFont boldSystemFontOfSize:30 * PJSAH]
                              constrainedToSize: maxSize
                                  lineBreakMode: NSLineBreakByTruncatingTail];
    
//    NSLog(@"labelSize : %@", NSStringFromCGSize(labelSize));
    
    return labelSize.height + 300 + 100;
}

@end
