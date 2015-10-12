//
//  SBDetailInfoOtherInfoTblCell.m
//  carmarket
//
//  Created by itensb on 14-11-19.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBDetailInfoOtherInfoTblCell.h"

@implementation SBDetailInfoOtherInfoTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
//        self.backgroundColor = [UIColor purpleColor];
        
        bottom = [[UIView alloc] initWithFrame:CGRectMake(21 * PJSAH, 10, ([ITUIKitHelper getAppWidth] - 21 * PJSA), 140)];
        //        bottom.backgroundColor = [ui];
        [SBUIFactory decorateWithLine:bottom width:0.5 type:ITLineDecorateAll];
        [self.contentView addSubview:bottom];
        
        UIImage *strechBgImg = [[UIImage imageNamed:@"header_line"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeTile];
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bottom.frame.size.width, 30)];
        [header setBackgroundColor:[UIColor colorWithPatternImage:strechBgImg]];
        [bottom addSubview:header];
        
        title = [ITUIKitHelper createLabel:@"其他信息" size:CGSizeMake(250, header.frame.size.height) font:[UIFont systemFontOfSize:16] color:[UIColor blackColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(5, 0) superViewFrame:bottom.frame];
        //        title.backgroundColor = TEST_BGCOLOR;
        [header addSubview:title];
        
        content = [ITUIKitHelper createLabel:@"" size:CGSizeMake(bottom.frame.size.width - 5 * 2, -1) font:[UIFont systemFontOfSize:25 * PJSAH] color:[ITUIKitHelper color:@"727272"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(5, [ITUIKitHelper yMarTopView:header margin:5]) superViewFrame:self.frame];
        content.numberOfLines = 0;
//        content.backgroundColor = TEST_BGCOLOR;
        [bottom addSubview:content];
        
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
    
    NSString *huodongStr = [info objectForKey:@"presentInfo"];
    if (huodongStr.length == 0) huodongStr = @"2014年10月29日 - 2014年11月27日， 北京合众明达 哈弗H2购车送大礼包，感兴趣的朋友可以到店咨询购买";
    CGSize maxSize = CGSizeMake(content.frame.size.width, 999);
    CGSize labelSize = [huodongStr sizeWithFont:content.font
                              constrainedToSize: maxSize
                                  lineBreakMode: NSLineBreakByTruncatingTail];
    if(labelSize.width != 0) [ITUIKitHelper sizeSet:content size:labelSize];
    content.text = huodongStr;
    
    [ITUIKitHelper removeLineViews:bottom];
    [ITUIKitHelper sizeSet:bottom size:CGSizeMake(-1, content.frame.size.height + 50)];
    [SBUIFactory decorateWithLine:bottom width:0.5 type:ITLineDecorateAll];
    
}

+ (float)getHeight:(NSDictionary *)info
{
    NSString *huodongStr = [info objectForKey:@"presentInfo"];
    if (huodongStr.length == 0) huodongStr = @"2014年10月29日 - 2014年11月27日， 北京合众明达 哈弗H2购车送大礼包，感兴趣的朋友可以到店咨询购买";
    CGSize maxSize = CGSizeMake([ITUIKitHelper getAppWidth] - 21 * PJSA - 5 * 2, 999);
    CGSize labelSize = [huodongStr sizeWithFont:[UIFont systemFontOfSize:25 * PJSAH]
                              constrainedToSize: maxSize
                                  lineBreakMode: NSLineBreakByTruncatingTail];
    
    return labelSize.height + 70;
}

@end
