//
//  SBYuFuViewController.m
//  carmarket
//
//  Created by itensb on 14-9-4.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBYuFuViewController.h"

@implementation SBYuFuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitleWithImage:[UIImage imageNamed:@"icon_titleyufudingjin"]];
    
    UIView *pricebg = [ITUIKitHelper createIconWithUIImage:[UIImage imageNamed:@"bg_yufuprice"]];[self addSubviewInContentView:pricebg];
    [ITUIKitHelper pointSet:pricebg piont:CGPointMake(([ITUIKitHelper getAppWidth] - pricebg.frame.size.width) / 2.0, 0)];
    
    UILabel *fukuanjine = [ITUIKitHelper createLabel:@"付款金额：" font:[UIFont boldSystemFontOfSize:35 * PJSAH] color:[ITUIKitHelper color:@"393939"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(63 * PJSAH, 59 * PJSAH) superViewFrame:self.view.frame];
    [pricebg addSubview:fukuanjine];
    
    price = [ITUIKitHelper createLabel:@"￥5000.00" size:CGSizeMake(100, -1) font:[UIFont boldSystemFontOfSize:35 * PJSAH] color:[ITUIKitHelper color:@"c30114"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:fukuanjine margin:5 * PJSAH], 59 * PJSAH) superViewFrame:self.view.frame];
    [pricebg addSubview:price];
    
    UILabel *shoukuan = [ITUIKitHelper createLabel:@"付款方式：" font:[UIFont systemFontOfSize:20 * PJSAH] color:[ITUIKitHelper color:@"4b89d2"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(57 * PJSAH, 242 * PJSAH) superViewFrame:self.view.frame];
    [self addSubviewInContentView:shoukuan];
    
    UIView *lineView = [ITUIKitHelper createIconWithUIImage:[UIImage imageWithColor:[ITUIKitHelper color:@"d6d6d6"] size:CGSizeMake([ITUIKitHelper getAppWidth] - shoukuan.frame.origin.x * 2, 0.5)]];
    [ITUIKitHelper pointSet:lineView piont:CGPointMake(shoukuan.frame.origin.x, [ITUIKitHelper yMarTopView:shoukuan margin:23 * PJSAH])];
    [self addSubviewInContentView:lineView];
    
    UIButton *weixin = [ITUIKitHelper createButtonWithUIImage:[UIImage imageNamed:@"btn_yufuweixin"] highlightImg:nil isBackgroundImg:YES];[self addSubviewInContentView:weixin];
    [ITUIKitHelper pointSet:weixin piont:CGPointMake(84 * PJSAH, [ITUIKitHelper yMarTopView:lineView margin:42 * PJSAH])];
    
    UIButton *yinlian = [ITUIKitHelper createButtonWithUIImage:[UIImage imageNamed:@"btn_yufuyinlian"] highlightImg:nil isBackgroundImg:YES];[self addSubviewInContentView:yinlian];
    [ITUIKitHelper pointSet:yinlian piont:CGPointMake([ITUIKitHelper xMarLeftView:weixin margin:100 * PJSAH], [ITUIKitHelper yMarTopView:lineView margin:42 * PJSAH] + 2)];
    
    UIButton *zhifubao = [ITUIKitHelper createButtonWithUIImage:[UIImage imageNamed:@"btn_yufuzhifubao"] highlightImg:nil isBackgroundImg:YES];[self addSubviewInContentView:zhifubao];
    [ITUIKitHelper pointSet:zhifubao piont:CGPointMake([ITUIKitHelper xMarLeftView:yinlian margin:92 * PJSAH], [ITUIKitHelper yMarTopView:lineView margin:42 * PJSAH] + 9)];
    
    UILabel *wenxin = [ITUIKitHelper createLabel:@"温馨提示：" font:[UIFont systemFontOfSize:25 * PJSAH] color:[ITUIKitHelper color:@"807f7f"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(57 * PJSAH, [ITUIKitHelper yMarTopView:lineView margin:220 * PJSAH]) superViewFrame:self.view.frame];
    [self addSubviewInContentView:wenxin];
    
    UILabel *wenxinContent = [ITUIKitHelper createLabel:@"    温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示" size:CGSizeMake([ITUIKitHelper getAppWidth] - 81 * PJSA, -1) font:[UIFont systemFontOfSize:25 * PJSAH] color:[ITUIKitHelper color:@"807f7f"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(81 * PJSAH, [ITUIKitHelper yMarTopView:wenxin margin:24 * PJSAH]) superViewFrame:self.view.frame];
    wenxinContent.numberOfLines = 2;
    [wenxinContent sizeToFit];
    [self addSubviewInContentView:wenxinContent];
}

@end
