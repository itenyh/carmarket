//
//  SBCarNameTblCell.m
//  carmarket
//
//  Created by itensb on 14-8-8.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBCarNameTblCell.h"

@implementation SBCarNameTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        UIView *bottom = [[UIView alloc] initWithFrame:CGRectMake(10, 10, [ITUIKitHelper getAppWidth] - 2 * 10, [SBCarNameTblCell getHeight:nil] - 2 * 10)];
        bottom.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bottom];
        
        // Initialization code
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake(17 * PJSAH, 17 * PJSAH, 166 * PJSAH, 105 * PJSAH)];
        [bottom addSubview:imgView];
        
        lab = [ITUIKitHelper createLabel:@"" size:CGSizeMake(263 * PJSAH, -1) font:[UIFont boldSystemFontOfSize:35 * PJSAH] color:[ITUIKitHelper color:@"1c1c1c"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:imgView margin:5], 25 * PJSAH) superViewFrame:self.contentView.frame];
        [bottom addSubview:lab];
        
        UIView *lineView = [ITUIKitHelper createIconWithUIImage:[UIImage imageWithColor:[ITUIKitHelper color:@"d6d6d6"] size:CGSizeMake(263 * PJSAH, 0.5)]];
        [ITUIKitHelper pointSet:lineView piont:CGPointMake(lab.frame.origin.x, [ITUIKitHelper yMarTopView:lab margin:5])];
        [bottom addSubview:lineView];
        
        price = [ITUIKitHelper createLabel:@"" size:CGSizeMake(263 * PJSAH, -1) font:[UIFont boldSystemFontOfSize:25 * PJSAH] color:[ITUIKitHelper color:@"c30114"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(lab.frame.origin.x, [ITUIKitHelper yMarTopView:lineView margin:5]) superViewFrame:self.contentView.frame];
        [bottom addSubview:price];
        
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
    
     [imgView sd_setImageWithURL:[NSURL URLWithString:@"http://c.hiphotos.baidu.com/image/pic/item/a686c9177f3e6709131191ff39c79f3df8dc5599.jpg"] placeholderImage:[SBUIFactory getPlaceHolderImg]];
    lab.text = @"宝马X5（进口）";
    price.text = @"100万";
    
}

+ (float)getHeight:(NSDictionary *)info
{
    return 90;
}


@end
