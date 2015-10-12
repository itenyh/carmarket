//
//  SBLocPriceCarCell.m
//  carmarket
//
//  Created by itensb on 14-8-6.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBLowPriceCarCell.h"

@implementation SBLowPriceCarCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
  
        bottom = [[UIView alloc] initWithFrame:CGRectMake(21 * PJSAH, 0, ([ITUIKitHelper getAppWidth] - 21 * PJSA), 282 * PJSAH)];
        bottom.backgroundColor = [ITUIKitHelper color:255 blue:255 green:255 alpha:1];
        [self.contentView addSubview:bottom];
        
        // Initialization code
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake(21 * PJSAH, 21 * PJSAH, 235 * PJSAH, 156 * PJSAH)];
        [bottom addSubview:imgView];
        
        [self createTeleBtn];
//        [self createBottomBtn:@"询问底价" index:1];
        
        title = [ITUIKitHelper createLabel:@"" size:CGSizeMake(bottom.frame.size.width - [ITUIKitHelper xMarLeftView:imgView margin:5] - 10, -1) font:[UIFont boldSystemFontOfSize:30 * PJSAH] color:[ITUIKitHelper color:@"202020"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:imgView margin:5], 10) superViewFrame:bottom.frame];
//        title.backgroundColor = TEST_BGCOLOR;
        [bottom addSubview:title];
        
        price = [ITUIKitHelper createLabel:@"" size:CGSizeMake(30, -1) font:[UIFont boldSystemFontOfSize:28 * PJSAH] color:[ITUIKitHelper color:@"c30014"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(title.frame.origin.x, [ITUIKitHelper yMarTopView:title margin:41 * PJSAH]) superViewFrame:bottom.frame];
//        price.backgroundColor = TEST_BGCOLOR;
        [bottom addSubview:price];
        
        delePrice = [[StrikeThroughLabel alloc] initWithFrame:CGRectMake([ITUIKitHelper xMarLeftView:price margin:51 * PJSAH], price.frame.origin.y, 50, price.frame.size.height)];
//        delePrice.backgroundColor = TEST_BGCOLOR;
        delePrice.strikeThroughEnabled = YES;
        delePrice.font = [UIFont systemFontOfSize:28 * PJSAH];
        delePrice.textColor = [ITUIKitHelper color:@"cccccc"];
        [bottom addSubview:delePrice];
        
        [self createlowLabel];
        
        s4Icon = [[SBCarComTypeView alloc] initWithFrame:CGRectMake(title.frame.origin.x, [ITUIKitHelper yMarTopView:price margin:27 * PJSAH], 0, 0) type:1];
        [bottom addSubview:s4Icon];
//        s4Icon = [ITUIKitHelper createIconWithUIImage:[UIImage imageNamed:@"icon_gray4s"]];
//        [ITUIKitHelper pointSet:s4Icon piont:CGPointMake(title.frame.origin.x, [ITUIKitHelper yMarTopView:price margin:27 * PJSAH])];
        [bottom addSubview:s4Icon];
        
        s4title = [ITUIKitHelper createLabel:@"" size:CGSizeMake(177 * PJSAH, -1) font:[UIFont systemFontOfSize:25 * PJSAH] color:[ITUIKitHelper color:@"cccccc"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:s4Icon margin:19 * PJSAH], s4Icon.frame.origin.y) superViewFrame:bottom.frame];
//        s4title.backgroundColor = TEST_BGCOLOR;
        [bottom addSubview:s4title];
        
        localSell = [ITUIKitHelper createLabel:@"" size:CGSizeMake(116 * PJSAH, -1) font:[UIFont systemFontOfSize:25 * PJSAH] color:[ITUIKitHelper color:@"cccccc"] marginInsets:[ITUIKitHelper ITMarginInsetsMake:40 right:5] point:CGPointMake(-1, -1) superViewFrame:bottom.frame];
//        localSell.backgroundColor = TEST_BGCOLOR;
        [bottom addSubview:localSell];
        

    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
    
    [imgView sd_setImageWithURL:[SBUtil getLowPriceActivityImgURLWith:info] placeholderImage:[SBUIFactory getPlaceHolderImg]];
    title.text = [info objectForKey:@"carName"];
    price.text = [NSString stringWithFormat:@"%@万", [info objectForKey:@"newPrice"]];
    delePrice.text = [NSString stringWithFormat:@"%@万", [info objectForKey:@"oldPrice"]];
    lowprice.text = [NSString stringWithFormat:@"%@万", [info objectForKey:@"cutPriceRange"]];
    s4title.text = [info objectForKey:@"dealerName"];
    localSell.text = [info objectForKey:@"saleRegion"];
    [s4Icon setComTitle:[info objectForKey:@"dealerType"]];
    
    [price sizeWidthToFit];
    
    [teleBtn setTitle:[info objectForKey:@"dealerPhone"] forState:UIControlStateNormal];
    
    [ITUIKitHelper removeLineViews:bottom];
    [SBUIFactory decorateWithLine:bottom width:0.5 type:ITLineDecorateAll];
    
}

+ (float)getHeight:(NSDictionary *)info
{
    return 306 * PJSAH;
}

- (void)createBottomBtn:(NSString *)t index:(int)index
{
    UIButton *duibi = [[UIButton alloc] initWithFrame:CGRectMake(bottom.frame.size.width / 2.0 * index, bottom.frame.size.height - 78 * PJSAH, bottom.frame.size.width / 2.0, 78 * PJSAH)];
    [duibi setTitle:t forState:UIControlStateNormal];
    [duibi setBackgroundColor:[ITUIKitHelper color:246 blue:246 green:246 alpha:1]];
    duibi.tag = index;
    [duibi setTitleColor:[ITUIKitHelper color:@"202020"] forState:UIControlStateNormal];
    duibi.titleLabel.font = [UIFont systemFontOfSize:30 * PJSAH];
    [duibi setTitleEdgeInsets:UIEdgeInsetsMake(0, 15 + 20 * PJSAH, 0, 0)];
    [duibi bk_addEventHandler:^(id sender) {
        RUPWarning([[ITUtils viewControllerFor:self] performSelector:@selector(SBLowPriceCarCell_Button:Cell:) withObject:duibi withObject:self]);
    } forControlEvents:UIControlEventTouchUpInside];
    [bottom addSubview:duibi];
    
    UIView *icon = [ITUIKitHelper createIconWithUIImage:[UIImage imageNamed:@"icon_price"]];
    [ITUIKitHelper pointSet:icon piont:CGPointMake(80 * PJSAH, (duibi.frame.size.height - icon.frame.size.height) / 2.0)];
    [duibi addSubview:icon];
}

- (void)createTeleBtn
{
//    teleBtn = [[UIButton alloc] initWithFrame:CGRectMake(bottom.frame.size.width / 2.0 * 0, bottom.frame.size.height - 78 * PJSAH, bottom.frame.size.width / 2.0, 78 * PJSAH)];
    teleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, bottom.frame.size.height - 78 * PJSAH, bottom.frame.size.width , 78 * PJSAH)];
    [teleBtn setBackgroundColor:[ITUIKitHelper color:246 blue:246 green:246 alpha:1]];
    teleBtn.tag = 0;
//    [teleBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 60, 0, 0)];
    [teleBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    [teleBtn setTitleColor:[ITUIKitHelper color:@"202020"] forState:UIControlStateNormal];
    teleBtn.titleLabel.font = [UIFont systemFontOfSize:30 * PJSAH];
    [teleBtn bk_addEventHandler:^(id sender) {
        RUPWarning([[ITUtils viewControllerFor:self] performSelector:@selector(SBLowPriceCarCell_Button:Cell:) withObject:teleBtn withObject:self]);
    } forControlEvents:UIControlEventTouchUpInside];
    [bottom addSubview:teleBtn];
    
    UIView *icon = [ITUIKitHelper createIconWithUIImage:[UIImage imageNamed:@"icon_phone"]];
//    [ITUIKitHelper pointSet:icon piont:CGPointMake(80 * PJSAH, (teleBtn.frame.size.height - icon.frame.size.height) / 2.0)];
    [ITUIKitHelper pointSet:icon piont:CGPointMake((teleBtn.frame.size.width / 2) - 60, (teleBtn.frame.size.height - icon.frame.size.height) / 2.0)];
    [teleBtn addSubview:icon];
    
}


- (void)createlowLabel
{
    lowprice = [SBUIFactory getLowPriceView:120 * PJSAH point:CGPointMake([ITUIKitHelper xMarLeftView:delePrice margin:24 * PJSAH], delePrice.frame.origin.y) superView:bottom];
}

@end
