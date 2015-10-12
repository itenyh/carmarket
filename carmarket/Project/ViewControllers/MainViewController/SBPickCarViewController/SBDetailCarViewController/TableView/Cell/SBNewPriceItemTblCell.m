//
//  SBNewPriceItemTblCell.m
//  carmarket
//
//  Created by itensb on 14-8-11.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBNewPriceItemTblCell.h"

@implementation SBNewPriceItemTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        bottom = [[UIView alloc] initWithFrame:CGRectMake(10, 10, [ITUIKitHelper getAppWidth] - 2 * 10, [SBNewPriceItemTblCell getHeight:nil] - 2 * 10)];
        bottom.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bottom];
        
        comIcon = [[SBCarComTypeView alloc] initWithFrame:CGRectMake(5, 12, 0, 0) type:0];
        [bottom addSubview:comIcon];
        
        title = [ITUIKitHelper createLabel:@"" size:CGSizeMake(200, -1) font:[UIFont boldSystemFontOfSize:16] color:[UIColor blackColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:comIcon margin:5], 10) superViewFrame:bottom.frame];
//        title.backgroundColor = TEST_BGCOLOR;
        [bottom addSubview:title];
        
        add = [ITUIKitHelper createLabel:@"" size:CGSizeMake(200, -1) font:[UIFont systemFontOfSize:12] color:[UIColor lightGrayColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(title.frame.origin.x + 2, [ITUIKitHelper yMarTopView:title margin:10]) superViewFrame:bottom.frame];
        add.numberOfLines = 2;
//        add.backgroundColor = TEST_BGCOLOR;
        [bottom addSubview:add];
        
        price = [ITUIKitHelper createLabel:@"" size:CGSizeMake(80, -1) font:[UIFont boldSystemFontOfSize:28 * PJSAH] color:[ITUIKitHelper color:@"c30114"] marginInsets:[ITUIKitHelper ITMarginInsetsMake:-1 right:10] point:CGPointMake(0, 12) superViewFrame:bottom.frame];
//        price.backgroundColor = TEST_BGCOLOR;
        price.textAlignment = NSTextAlignmentRight;
        [bottom addSubview:price];
        
        [self createTeleBtn];
//        [self createBottomBtn:@"询问底价" index:1];
        
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
    
    title.text = [info objectForKey:@"dealerName"];
    
    [ITUIKitHelper sizeLabelWithText:[info objectForKey:@"dealerAddress"] label:add];

    price.text = [NSString stringWithFormat:@"%@万", [SBUtil getOneWeiFloatStr:[info objectForKey:@"carVendorPrice"]]];
    
    [comIcon setComTitle:[info objectForKey:@"dealerType"]];
    
    [ITUIKitHelper removeLineViews:bottom];
    [SBUIFactory decorateWithLine:bottom width:0.5 type:ITLineDecorateAll];

}

+ (float)getHeight:(NSDictionary *)info
{
    return 130;
}

- (void)createBottomBtn:(NSString *)t index:(int)index
{
    UIButton *duibi = [[UIButton alloc] initWithFrame:CGRectMake(bottom.frame.size.width / 2.0 * index, bottom.frame.size.height - 20, bottom.frame.size.width / 2.0, 20)];
    [duibi setTitle:t forState:UIControlStateNormal];
//    [duibi setBackgroundColor:[UIColor orangeColor]];
    duibi.tag = index;
    [duibi bk_addEventHandler:^(id sender) {
        RUPWarning([[ITUtils viewControllerFor:self] performSelector:@selector(SBNewPriceItemTblCell_Button:Cell:) withObject:duibi withObject:self]);
    } forControlEvents:UIControlEventTouchUpInside];
    [bottom addSubview:duibi];
}

- (void)createTeleBtn
{

    teleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, bottom.frame.size.height - 68 * PJSAH, bottom.frame.size.width, 68 * PJSAH)];
//    [teleBtn setBackgroundColor:[UIColor orangeColor]];
    teleBtn.tag = 0;
    [teleBtn setTitleColor:[ITUIKitHelper color:@"434343"] forState:UIControlStateNormal];
    teleBtn.titleLabel.font = [UIFont systemFontOfSize:32 * PJSAH];
    [teleBtn setBackgroundColor:[ITUIKitHelper color:245 blue:245 green:245 alpha:1]];
    [teleBtn setTitle:@"立即拨打电话" forState:UIControlStateNormal];
    [teleBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 25, 0, 0)];
    [teleBtn bk_addEventHandler:^(id sender) {
        RUPWarning([[ITUtils viewControllerFor:self] performSelector:@selector(SBNewPriceItemTblCell_Button:Cell:) withObject:teleBtn withObject:self]);
    } forControlEvents:UIControlEventTouchUpInside];
    [SBUIFactory decorateWithLine:teleBtn width:0.5 type:ITLineDecorateUp];
    [bottom addSubview:teleBtn];
    
    UIView *phoneView = [ITUIKitHelper createIconWithUIImage:[UIImage imageNamed:@"icon_bluephone"]];
    [ITUIKitHelper pointSet:phoneView piont:CGPointMake((teleBtn.frame.size.width / 2 - 50), (teleBtn.frame.size.height - phoneView.frame.size.height) / 2.0)];
    [teleBtn addSubview:phoneView];
                                                        
}

@end
