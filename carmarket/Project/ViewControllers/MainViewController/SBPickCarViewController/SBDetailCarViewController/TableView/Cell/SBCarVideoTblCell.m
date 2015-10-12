//
//  SBCarViewTblCell.m
//  carmarket
//
//  Created by itensb on 14-8-25.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBCarVideoTblCell.h"

@implementation SBCarVideoTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        imgView = [[UIButton alloc] initWithFrame:CGRectMake(22 * PJSAH, 17 * PJSAH, 202 * PJSAH, 157 * PJSAH)];
        [self.contentView addSubview:imgView];
        
        title = [ITUIKitHelper createLabel:@"" size:CGSizeMake(430 * PJSAH, -1) font:[UIFont boldSystemFontOfSize:35 * PJSAH] color:[ITUIKitHelper color:@"373737"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:imgView margin:23 * PJSAH], 27 * PJSAH - 10) superViewFrame:self.frame];
        title.backgroundColor = TEST_BGCOLOR;
        title.numberOfLines = 2;
        [self.contentView addSubview:title];
        
        length = [ITUIKitHelper createLabel:@"" size:CGSizeMake(130 * PJSAH, -1) font:[UIFont systemFontOfSize:25 * PJSAH] color:[ITUIKitHelper color:@"727272"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:imgView margin:11 * PJSAH], 145 * PJSAH) superViewFrame:self.frame];
        length.backgroundColor = TEST_BGCOLOR;
        [self.contentView addSubview:length];
        
        times = [ITUIKitHelper createLabel:@"" size:CGSizeMake(130 * PJSAH, -1) font:[UIFont systemFontOfSize:25 * PJSAH] color:[ITUIKitHelper color:@"727272"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:length margin:11 * PJSAH], 145 * PJSAH) superViewFrame:self.frame];
        times.backgroundColor = TEST_BGCOLOR;
        [self.contentView addSubview:times];
        
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
    
    [imgView sd_setImageWithURL:[NSURL URLWithString:TEST_IMGURL] forState:UIControlStateNormal placeholderImage:[SBUIFactory getPlaceHolderImg]];
    
    [ITUIKitHelper setLabelWithConstrainedStringSize:title text:@"2014奥迪 非常牛步 的 阿拉拉拉了 AD 老地方30 啊啊啊" maxHeight:-1];
    
    length.text = @"06:35";
    times.text = @"2342345";
}

+ (float)getHeight:(NSDictionary *)info
{
    return 203 * PJSAH;
}


@end
