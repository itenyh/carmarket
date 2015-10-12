//
//  SBSecondCarCarInfoTblCell.m
//  carmarket
//
//  Created by Apple on 14-9-23.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBSecondCarCarInfoTblCell.h"

@implementation SBSecondCarCarInfoTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        title = [ITUIKitHelper createLabel:@"" size:CGSizeMake([ITUIKitHelper getAppWidth] - 35 * PJSA, -1) font:[UIFont boldSystemFontOfSize:35 * PJSAH] color:[ITUIKitHelper color:@"0c0c0c"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(35 * PJSAH, 50 * PJSAH) superViewFrame:self.frame];
        [self.contentView addSubview:title];
        
        kanchedidian = [ITUIKitHelper createLabel:@"看车地点:" font:[UIFont systemFontOfSize:30 * PJSAH] color:[ITUIKitHelper color:@"727272"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(34 * PJSAH, [ITUIKitHelper yMarTopView:title margin:55 * PJSAH]) superViewFrame:self.frame];
        [self.contentView addSubview:kanchedidian];
        
        s4title = [ITUIKitHelper createLabel:@"" size:CGSizeMake([ITUIKitHelper getAppWidth] - 35 * PJSA, -1) font:[UIFont systemFontOfSize:30 * PJSAH] color:[ITUIKitHelper color:@"727272"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:kanchedidian margin:23 * PJSAH], kanchedidian.frame.origin.y) superViewFrame:self.frame];
        [self.contentView addSubview:s4title];
        
        float arg = 457 * PJSAH / (320 - 20 * PJSA);
        UIView *whiteBorder = [[UIView alloc] initWithFrame:CGRectMake(20 * PJSAH, [ITUIKitHelper yMarTopView:s4title margin:27 * PJSAH], ([ITUIKitHelper getAppWidth] - 20 * PJSA), arg * ([ITUIKitHelper getAppWidth] - 20 * PJSA))];
        [self.contentView addSubview:whiteBorder];
        [SBUIFactory decorateWithLine:whiteBorder width:0.5 type:ITLineDecorateAll];
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake(6 * PJSAH, 6 * PJSAH, whiteBorder.frame.size.width - 6 * PJSA, whiteBorder.frame.size.height - 6 * PJSA)];
//        [imgView sd_setImageWithURL:[NSURL URLWithString:TEST_IMGURL] placeholderImage:[SBUIFactory getPlaceHolderImg]];
        [whiteBorder addSubview:imgView];
        
    }
    
    return self;
    
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
    
    NSDictionary *data = [info objectForKey:@"data"];
    NSDictionary *oldData = [info objectForKey:@"oldData"];

    if ([oldData objectForKey:@"ImgAddress"]) [imgView sd_setImageWithURL:[SBUtil getImgURLWith:oldData pre:@"imgDomainName" other:@"ImgAddress"] placeholderImage:[SBUIFactory getPlaceHolderImg]];
    
    else [imgView sd_setImageWithURL:[SBUtil getImgURLWith:oldData pre:@"imgDomainName" other:@"imgBody"] placeholderImage:[SBUIFactory getPlaceHolderImg]];
    
    title.text = [oldData objectForKey:@"carName"];
    s4title.text = [data objectForKey:@"seeCarAddr"];

}

+ (float)getHeight:(NSDictionary *)info
{
    float arg = 457 * PJSAH / (320 - 20 * PJSA);
    arg = arg * ([ITUIKitHelper getAppWidth] - 20 * PJSA);
    return arg + 100;
}

@end
