//
//  SBSecondCarMorePicTblCell.m
//  carmarket
//
//  Created by Apple on 14-9-23.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#define IMG_HEIGHT 457 * PJSAH / 2.0
#define IMG_WIDTH ([ITUIKitHelper getAppWidth] - 20 * PJSA) / 2 - 20 * PJSAH

#import "SBSecondCarMorePicTblCell.h"

@implementation SBSecondCarMorePicTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        qitatupian = [ITUIKitHelper createLabel:@"其他图片:" font:[UIFont systemFontOfSize:30 * PJSAH] color:[ITUIKitHelper color:@"727272"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(34 * PJSAH, 10) superViewFrame:self.frame];
        qitatupian.hidden = YES;
        [self.contentView addSubview:qitatupian];
        
    }
    
    return self;
    
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
    
    NSDictionary *data = [info objectForKey:@"data"];
    
    NSString *picPre = [data objectForKey:@"imgDomainName"];
    NSString *picStrs = [data objectForKey:@"picturesAddress"];
    if (picStrs) {
        NSArray *pics = [picStrs componentsSeparatedByString:@","];
        for (int i = 0; i < pics.count; i++) {
            NSString *other = [pics objectAtIndex:i];
            NSString *urlStr = [NSString stringWithFormat:@"%@/%@", picPre, other];
            NSURL *url = [NSURL URLWithString:urlStr];
            
            int row = i / 2;
            int col = i % 2;
            
            if (url) {
                UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20 * PJSAH + col * (20 * PJSAH + IMG_WIDTH) + 3, [ITUIKitHelper yMarTopView:qitatupian margin:27 * PJSAH] + row * (IMG_HEIGHT + 10), IMG_WIDTH, IMG_HEIGHT)];
                [imgView sd_setImageWithURL:url placeholderImage:[SBUIFactory getPlaceHolderImg]];
                [self.contentView addSubview:imgView];
            }
            
            
        }
        
        qitatupian.hidden = NO;
    }
    
    else qitatupian.hidden = YES;
    
}

+ (float)getHeight:(NSDictionary *)info
{
    NSDictionary *data = [info objectForKey:@"data"];
    NSString *picStrs = [data objectForKey:@"picturesAddress"];
    if (picStrs) {
        NSArray *pics = [picStrs componentsSeparatedByString:@","];
        int count = pics.count;
        int rowNum = (count - 1) / 2 + 1;
        return (rowNum * IMG_HEIGHT + rowNum * 10) + 40;
    }
    else return 0;
    
}


@end
