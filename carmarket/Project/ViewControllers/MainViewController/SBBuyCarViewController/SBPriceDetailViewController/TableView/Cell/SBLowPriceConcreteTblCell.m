//
//  SBLowPriceConcreteTblCell.m
//  carmarket
//
//  Created by Apple on 14-8-17.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBLowPriceConcreteTblCell.h"

@implementation SBLowPriceConcreteTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        bottom = [[UIView alloc] initWithFrame:CGRectMake(10, 0, [ITUIKitHelper getAppWidth] - 2 * 10, [SBLowPriceConcreteTblCell getHeight:nil])];
        [SBUIFactory decorateWithLine:bottom width:0.5 type:ITLineDecorateAll];
        [self.contentView addSubview:bottom];
        
        title = [ITUIKitHelper createLabel:@"" size:CGSizeMake(250, -1) font:[UIFont boldSystemFontOfSize:12] color:[UIColor blackColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(10, 10) superViewFrame:bottom.frame];
//        title.backgroundColor = TEST_BGCOLOR;
        [bottom addSubview:title];
        
        price = [ITUIKitHelper createLabel:@"" size:CGSizeMake(65, -1) font:[UIFont systemFontOfSize:30 * PJSAH] color:[ITUIKitHelper color:@"c30014"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(title.frame.origin.x, [ITUIKitHelper yMarTopView:title margin:13]) superViewFrame:bottom.frame];
//        price.backgroundColor = TEST_BGCOLOR;
        [bottom addSubview:price];
        
        delePrice = [[StrikeThroughLabel alloc] initWithFrame:CGRectMake([ITUIKitHelper xMarLeftView:price margin:5], price.frame.origin.y, 65, price.frame.size.height)];
//        delePrice.backgroundColor = TEST_BGCOLOR;
        delePrice.strikeThroughEnabled = YES;
        delePrice.font = [UIFont systemFontOfSize:30 * PJSAH];
        delePrice.textColor = [UIColor lightGrayColor];
        [bottom addSubview:delePrice];
        
        lowprice = [[SBLowPriceView alloc] initWithFrame:CGRectMake([ITUIKitHelper xMarLeftView:delePrice margin:5], delePrice.frame.origin.y + 2, 100, 0)];
        [bottom addSubview:lowprice];
        
        UIButton *askPrice = [SBUIFactory getColoredPanel:@"询问底价" size:CGSizeMake(45,18) color:nil font:[UIFont systemFontOfSize:9] type:2];
        [ITUIKitHelper pointSet:askPrice piont:CGPointMake(bottom.frame.size.width - 45 - 5, lowprice.frame.origin.y - 2)];
//        [bottom addSubview:askPrice];
        [askPrice bk_addEventHandler:^(id sender) {
            RUPWarning([[ITUtils viewControllerFor:self] performSelector:@selector(SBLowPriceConcreteTblCell_askPrice:) withObject:self]);
        } forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (void)display:(NSDictionary *)info show:(BOOL)is
{
    [self display:info];
    
    if (is) bottom.hidden = NO;
    else bottom.hidden = YES;
    
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
    
    title.text = [info objectForKey:@"carName"];
    price.text = [NSString stringWithFormat:@"%@万", [info objectForKey:@"newPrice"]];
    delePrice.text = [NSString stringWithFormat:@"%@万", [info objectForKey:@"oldPrice"]];
    [lowprice setPrice:[NSString stringWithFormat:@"%@万", [info objectForKey:@"cutPriceRange"]]];
}

+ (float)getHeight:(NSDictionary *)info
{
    return 60;
}


@end
