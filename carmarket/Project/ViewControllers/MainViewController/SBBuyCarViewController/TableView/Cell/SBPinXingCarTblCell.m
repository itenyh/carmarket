//
//  SBPinXingCarTblCell.m
//  carmarket
//
//  Created by itensb on 14-11-19.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBPinXingCarTblCell.h"

@implementation SBPinXingCarTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        delePrice.hidden = YES;
        lowprice.hidden = YES;
        
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
    
    [imgView sd_setImageWithURL: [SBUtil getImgURLWith:info pre:@"imgDomainName" other:@"carImg"] placeholderImage:[SBUIFactory getPlaceHolderImg]];
    price.text = [NSString stringWithFormat:@"%@万", [info objectForKey:@"price"]];
    
}

- (void)createlowLabel
{
    
}

@end
