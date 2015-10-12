    //
//  SBActivityTblCell.m
//  carmarket
//
//  Created by itensb on 14-8-18.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBActivityTblCell.h"

@implementation SBActivityTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        UIView *time = [ITUIKitHelper createIconWithUIImage:[UIImage imageNamed:@"bg_huodongtime"]];
        [ITUIKitHelper pointSet:time piont:CGPointMake(57 * PJSAH, 18 * PJSAH)];
        [self.contentView addSubview:time];
        
        title = [ITUIKitHelper createLabel:@"" size:CGSizeMake(170, -1) font:[UIFont boldSystemFontOfSize:35 * PJSAH] color:[UIColor blackColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:time margin:43 * PJSAH], 23 * PJSAH) superViewFrame:self.contentView.frame];
//        title.backgroundColor = TEST_BGCOLOR;
        [self.contentView addSubview:title];
        
        content = [ITUIKitHelper createLabel:@"" size:CGSizeMake(200, -1) font:[UIFont systemFontOfSize:25 * PJSAH] color:[ITUIKitHelper color:@"6d6d6d"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:time margin:43 * PJSAH], [ITUIKitHelper yMarTopView:title margin:20 * PJSAH]) superViewFrame:self.contentView.frame];
//        content.backgroundColor = TEST_BGCOLOR;
        content.numberOfLines = 2;
        [self.contentView addSubview:content];
        
        canyu = [SBUIFactory getColoredRedPanel:@"已参与" size:CGSizeMake(54 * PJSAH, 21 * PJSAH) color:nil font:[UIFont systemFontOfSize:15 * PJSAH]];
        [ITUIKitHelper pointSet:canyu piont:CGPointMake([ITUIKitHelper xMarLeftView:title margin:7], title.frame.origin.y + 10)];
        [self.contentView addSubview:canyu];
        
        yue = [ITUIKitHelper createLabel:@"" size:CGSizeMake(time.frame.size.width, -1) font:[UIFont systemFontOfSize:20 * PJSAH] color:[ITUIKitHelper color:@"ffffff"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(0, 2) superViewFrame:self.contentView.frame];
        yue.textAlignment = NSTextAlignmentCenter;
        [time addSubview:yue];
        
        ri = [ITUIKitHelper createLabel:@"" size:CGSizeMake(time.frame.size.width, -1) font:[UIFont boldSystemFontOfSize:50 * PJSAH] color:[ITUIKitHelper color:@"4b89d2"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(0, 15) superViewFrame:self.contentView.frame];
        ri.textAlignment = NSTextAlignmentCenter;
        [time addSubview:ri];
        
        nian = [ITUIKitHelper createLabel:@"" size:CGSizeMake(time.frame.size.width, -1) font:[UIFont systemFontOfSize:20 * PJSAH] color:[ITUIKitHelper color:@"828282"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(0, 44) superViewFrame:self.contentView.frame];
        nian.textAlignment = NSTextAlignmentCenter;
        [time addSubview:nian];
        
        UIView *lineView = [ITUIKitHelper createIconWithUIImage:[UIImage imageWithColor:[ITUIKitHelper color:@"d6d6d6"] size:CGSizeMake([ITUIKitHelper getAppWidth], 0.5)]];
        [ITUIKitHelper pointSet:lineView piont:CGPointMake(0, [SBActivityTblCell getHeight:nil] - 0.5)];
        [self addSubview:lineView];
        
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
    
    
//    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUnicode);
//    NSData *data = [[info objectForKey:@"actionTitle"] dataUsingEncoding:NSUTF8StringEncoding];
//    NSString *retStr = [[NSString alloc] initWithData:data encoding:enc];
//    NSLog(@"%@",retStr);

    
    title.text = [info objectForKey:@"actionTitle"];
    
    NSString *nameStr = [info objectForKey:@"actionContext"];
    CGSize maxSize = CGSizeMake(content.frame.size.width, content.font.lineHeight * 2);
    CGSize labelSize = [nameStr sizeWithFont:content.font
                           constrainedToSize:maxSize
                               lineBreakMode:NSLineBreakByTruncatingTail];
    content.text = nameStr;
    [ITUIKitHelper sizeSet:content size:CGSizeMake(content.frame.size.width, labelSize.height)];
    

    double actionStartTime = [[info objectForKey:@"actionStartTime"] doubleValue];
    actionStartTime = actionStartTime / 1000;
    
    NSString *y = [ITUtils date_fromInterval:actionStartTime format:@"MM"];
    NSString *r = [ITUtils date_fromInterval:actionStartTime format:@"dd"];
    NSString *n = [ITUtils date_fromInterval:actionStartTime format:@"yyyy"];
    
    yue.text = [NSString stringWithFormat:@"%@ 月",y];
    ri.text = r;
    nian.text = n;
    
    id isenter = [info objectForKey:@"isenter"];
    if (isenter && [isenter integerValue] == 1) canyu.hidden = NO;
    else canyu.hidden = YES;
    
}

+ (float)getHeight:(NSDictionary *)info
{
    return 18 * PJSA + [UIImage imageNamed:@"bg_huodongtime"].size.height;
}

@end
