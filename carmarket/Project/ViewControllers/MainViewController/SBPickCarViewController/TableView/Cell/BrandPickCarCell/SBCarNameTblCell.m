//
//  SBCarNameTblCell.m
//  carmarket
//
//  Created by itensb on 14-8-8.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBCarNameTblCell.h"

@implementation SBCarNameTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(int)_type
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        type = _type;
        
        float bottomWidth = (type == 0 ? 552 * PJSAH - 2 * 10 : [ITUIKitHelper getAppWidth] - 2 * 22 * PJSAH);
        float rightInset = (type == 0 ? 5 : 61 * PJSAH);
        
        UIView *bottom = [[UIView alloc] initWithFrame:CGRectMake(10, 10, bottomWidth, [SBCarNameTblCell getHeight:nil] - 2 * 10)];
        bottom.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bottom];
        
        [SBUIFactory decorateWithLine:bottom width:0.5 type:ITLineDecorateAll];
        
        // Initialization code
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake(17 * PJSAH, (bottom.frame.size.height - 93 * PJSAH) / 2, 180 * PJSAH, 93 * PJSAH)];
        [bottom addSubview:imgView];
        
        lab = [ITUIKitHelper createLabel:@"" size:CGSizeMake(263 * PJSAH, -1) font:[UIFont boldSystemFontOfSize:35 * PJSAH] color:[ITUIKitHelper color:@"1c1c1c"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:imgView margin:rightInset], 25 * PJSAH) superViewFrame:self.contentView.frame];
        [bottom addSubview:lab];
        
        UIView *lineView = [ITUIKitHelper createIconWithUIImage:[UIImage imageWithColor:[ITUIKitHelper color:@"d6d6d6"] size:CGSizeMake(263 * PJSAH, 0.5)]];
        [ITUIKitHelper pointSet:lineView piont:CGPointMake(lab.frame.origin.x, [ITUIKitHelper yMarTopView:lab margin:5])];
        [bottom addSubview:lineView];
        
        price = [ITUIKitHelper createLabel:@"" size:CGSizeMake(263 * PJSAH, -1) font:[UIFont boldSystemFontOfSize:25 * PJSAH] color:[ITUIKitHelper color:@"c30114"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(lab.frame.origin.x, [ITUIKitHelper yMarTopView:lineView margin:5]) superViewFrame:self.contentView.frame];
        [bottom addSubview:price];
        
        if (type == 1) {
            UIView *arrIcon = [ITUIKitHelper createIconWithUIImage:[UIImage imageNamed:@"icon_xuanchearray"]];
            [bottom addSubview:arrIcon];
            [ITUIKitHelper pointSet:arrIcon piont:CGPointMake(bottom.frame.size.width - 27 * PJSAH - arrIcon.frame.size.width, (bottom.frame.size.height - arrIcon.frame.size.height) / 2)];
        }
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
    
    [imgView sd_setImageWithURL:[SBUtil getImgURLWith:info pre:@"imgDomainName" other:@"picture"] placeholderImage:[SBUIFactory getPlaceHolderImg]];
    lab.text = [info objectForKey:@"showName"];
    price.text = [info objectForKey:@"priceRange"];
    
}

- (void)display:(NSDictionary *)info imageDomainName:(NSString *)domain
{
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:info];
    [tempDic setObject:domain forKey:@"imgDomainName"];
    
    [super display:tempDic];
    
    [imgView sd_setImageWithURL:[SBUtil getImgURLWith:tempDic pre:@"imgDomainName" other:@"picture"] placeholderImage:[SBUIFactory getPlaceHolderImg]];
    lab.text = [tempDic objectForKey:@"modelName"];
    price.text = [tempDic objectForKey:@"dealerPrice"];
    
}

+ (float)getHeight:(NSDictionary *)info
{
    return 90;
}


@end
