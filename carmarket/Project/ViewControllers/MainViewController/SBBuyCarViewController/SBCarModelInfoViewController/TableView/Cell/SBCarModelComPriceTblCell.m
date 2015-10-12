//
//  SBCarModelComPriceTblCell.m
//  carmarket
//
//  Created by itensb on 14-9-4.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBCarModelComPriceTblCell.h"

@implementation SBCarModelComPriceTblCell
@synthesize dianhua;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        UIView *s4Icon = [ITUIKitHelper createIconWithUIImage:[UIImage imageNamed:@"icon_gray4s"]];
        [ITUIKitHelper pointSet:s4Icon piont:CGPointMake(55 * PJSAH, 29 * PJSAH)];
        [self.contentView addSubview:s4Icon];
        
        s4Title = [ITUIKitHelper createLabel:@"" size:CGSizeMake(190 * PJSAH, -1) font:[UIFont systemFontOfSize:30 * PJSAH] color:[ITUIKitHelper color:@"7c7c7c"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:s4Icon margin:14 * PJSAH], s4Icon.frame.origin.y) superViewFrame:self.frame];
//        s4Title.backgroundColor = TEST_BGCOLOR;
        [self.contentView addSubview:s4Title];
        
        price = [ITUIKitHelper createLabel:@"" size:CGSizeMake(70, -1) font:[UIFont systemFontOfSize:30 * PJSAH] color:[ITUIKitHelper color:@"c30014"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:s4Title margin:26 * PJSAH], 30 * PJSAH) superViewFrame:self.frame];
//        price.backgroundColor = TEST_BGCOLOR;
        [self.contentView addSubview:price];
        
        UIView *phone = [ITUIKitHelper createIconWithUIImage:[UIImage imageNamed:@"icon_bluephone"]];[self.contentView addSubview:phone];
        [ITUIKitHelper pointSet:phone piont:CGPointMake(60 * PJSAH, [ITUIKitHelper yMarTopView:s4Icon margin:33 * PJSAH])];
        dianhua = [ITUIKitHelper createLabel:@"400-123-8888" size:CGSizeMake(250 * PJSAH, -1) font:[UIFont systemFontOfSize:30 * PJSAH] color:[ITUIKitHelper color:75 blue:210 green:137 alpha:1] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:phone margin:20 * PJSAH], [ITUIKitHelper yMarTopView:s4Title margin:28 * PJSAH]) superViewFrame:self.frame];
//        dianhua.backgroundColor = TEST_BGCOLOR;
        [self.contentView addSubview:dianhua];
        UIButton *dianhuatn = [[UIButton alloc] initWithFrame:CGRectMake(phone.frame.origin.x, phone.frame.origin.y, phone.frame.size.width + dianhua.frame.size.width + 43 * PJSAH, phone.frame.size.height)];
        [self.contentView addSubview:dianhuatn];
        
        UIButton *yufu = [SBUIFactory getColoredRedPanel:@"预付定金" size:CGSizeMake(164 * PJSAH, 54 * PJSAH) color:nil font:[UIFont systemFontOfSize:28 * PJSAH]];[ITUIKitHelper pointSet:yufu piont:CGPointMake(500 * PJSAH, 20 * PJSAH)];
        yufu.tag = 0;//[self.contentView addSubview:yufu];
        [yufu bk_addEventHandler:^(id sender) {
            RUPWarning([[ITUtils viewControllerFor:self] performSelector:@selector(SBCarModelComPriceTblCell_askPrice:Btn:) withObject:self withObject:yufu]);
        } forControlEvents:UIControlEventTouchUpInside];
        UIButton *lianxi = [SBUIFactory getColoredBluePanel:@"联系商家" size:yufu.frame.size color:nil font:[UIFont systemFontOfSize:28 * PJSAH]];[self.contentView addSubview:lianxi];[ITUIKitHelper pointSet:lianxi piont:CGPointMake(500 * PJSAH, [ITUIKitHelper yMarTopView:yufu margin:13 * PJSAH])];
        lianxi.tag = 1;
        [lianxi bk_addEventHandler:^(id sender) {
            RUPWarning([[ITUtils viewControllerFor:self] performSelector:@selector(SBCarModelComPriceTblCell_askPrice:Btn:) withObject:self withObject:lianxi]);
        } forControlEvents:UIControlEventTouchUpInside];
        
        UIView *lineView = [ITUIKitHelper createIconWithUIImage:[UIImage imageWithColor:[ITUIKitHelper color:@"d6d6d6"] size:CGSizeMake([ITUIKitHelper getAppWidth], 0.5)]];
        [ITUIKitHelper pointSet:lineView piont:CGPointMake(0, 0)];
        [self.contentView addSubview:lineView];
        
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
    
    s4Title.text = @"重庆胜博汽车";
    price.text = @"3.98万";
    
}

+ (float)getHeight:(NSDictionary *)info
{
    return 159 * PJSAH;
}

@end
