//
//  SBTaBarController.m
//  carmarket
//
//  Created by itensb on 14-8-4.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#define AllBTN_NUM 5.0
#define LEFT_INSET 20


#import "SBTabBarController.h"
#import "SBNewsViewController.h"
#import "SBBuyCarViewController.h"
#import "SBPickCarViewController.h"
#import "SBUserViewController.h"
#import "SBDiscussViewController.h"

#import "ITUIKitHelper.h"

#import "SBPriceDetailViewController.h"
#import "SBLogViewController.h"

@interface SBTabBarController ()
{
    UIButton *news_btn;
    UIButton *dis_btn;
    UIButton *buy_btn;
    UIButton *pick_btn;
    UIButton *user_btn;
    
    UIView *tabBgView;
    
}

@end

@implementation SBTabBarController
@synthesize tbController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    tbController = [UITabBarController new];
    tbController.tabBar.hidden = YES;
    [ITUIKitHelper pointSet:tbController.view piont:CGPointMake(-1, tbController.view.frame.origin.y - 20)];
    [self addSubviewInContentView:tbController.view];
    
    SBNewsViewController *newsViewController = [[SBNewsViewController alloc] initWithNavi:YES leftBtnType:NDLeftBtnNone];
//    SBLogViewController *newsViewController = [[SBLogViewController alloc] initWithNavi:YES leftBtnType:NDLeftBtnNone];
    SBDiscussViewController *discussViewController = [[SBDiscussViewController alloc] initWithNavi:YES leftBtnType:NDLeftBtnNone];
    discussViewController.url = [NSURL URLWithString:API_DIS_ADD];
    SBBuyCarViewController *buyViewController = [[SBBuyCarViewController alloc] initWithNavi:YES leftBtnType:NDLeftBtnNone];
//    SBCarModelInfoViewController *buyViewController = [[SBCarModelInfoViewController alloc] initWithNavi:YES leftBtnType:NDLeftBtnNone];
    SBPickCarViewController *pickViewController = [[SBPickCarViewController alloc] initWithNavi:YES leftBtnType:NDLeftBtnNone];
    SBUserViewController *userViewController = [[SBUserViewController alloc] initWithNavi:YES leftBtnType:NDLeftBtnNone];
    tbController.viewControllers = @[newsViewController, discussViewController, buyViewController, pickViewController, userViewController];
    
    tabBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [ITUIKitHelper getAppWidth], TABBAR_HEIGHT)];
    [ITUIKitHelper pointSet:tabBgView piont:CGPointMake(-1, self.cotentSize.height - tabBgView.frame.size.height)];
    tabBgView.backgroundColor = [ITUIKitHelper color:@"f9f9f9"];
    [self addSubviewInContentView:tabBgView];
    UIView *lineView = [ITUIKitHelper createIconWithUIImage:[UIImage imageWithColor:[ITUIKitHelper color:@"d6d6d6"] size:CGSizeMake([ITUIKitHelper getAppWidth], 0.7)]];
    [tabBgView addSubview:lineView];
    
    news_btn = [self createTabBtn:[UIImage imageNamed:@"icon_news"] select:[UIImage imageNamed:@"icon_news_01"] index:0 title:@"资讯"];
    dis_btn = [self createTabBtn:[UIImage imageNamed:@"icon_dis"] select:[UIImage imageNamed:@"icon_dis_01"] index:1 title:@"论坛"];
    buy_btn = [self createTabBtn:[UIImage imageNamed:@"icon_buycar"] select:[UIImage imageNamed:@"icon_buycar_01"] index:2 title:@"买车"];
    pick_btn = [self createTabBtn:[UIImage imageNamed:@"icon_choosecar"] select:[UIImage imageNamed:@"icon_choosecar_01"] index:3 title:@"选车"];
    user_btn = [self createTabBtn:[UIImage imageNamed:@"icon_my"] select:[UIImage imageNamed:@"icon_my_01"] index:4 title:@"我的"];
    
    [tabBgView addSubview:news_btn];
    [tabBgView addSubview:dis_btn];
    [tabBgView addSubview:buy_btn];
    [tabBgView addSubview:pick_btn];
    [tabBgView addSubview:user_btn];
    
    [self setTabBarItemSelected:0];
}

- (void)setTabBarItemSelected:(int)index
{
    [news_btn setSelected:NO];
    [dis_btn setSelected:NO];
    [buy_btn setSelected:NO];
    [pick_btn setSelected:NO];
    [user_btn setSelected:NO];
    
    switch (index) {
        case 0:
            [news_btn setSelected:YES];
            break;
        case 1:
            [dis_btn setSelected:YES];
            break;
        case 2:
            [buy_btn setSelected:YES];
            break;
        case 3:
            [pick_btn setSelected:YES];
            break;
        case 4:
            [user_btn setSelected:YES];
            break;
        default:
            break;
    }
    
    [tbController setSelectedIndex:index];
}

- (void)tabbarItemClick:(UIButton *)sender
{
    [self setTabBarItemSelected:(int)sender.tag];
}

- (UIButton *)createTabBtn:(UIImage *)nomal select:(UIImage *)select index:(int)index title:(NSString *)title
{
    float XBtn = LEFT_INSET + index * (self.view.frame.size.width - 2 * LEFT_INSET) / AllBTN_NUM + ((self.view.frame.size.width - 2 * LEFT_INSET) / AllBTN_NUM - nomal.size.width) / 2.0;
//    (TABBAR_HEIGHT - nomal.size.height) / 2.0
    UIButton *btn = [ITUIKitHelper createButtonWithUIImage:nomal highlightImg:nil point:CGPointMake(XBtn, 7) isBackgroundImg:YES];
//    [ITUIKitHelper sizeSet:btn size:CGSizeMake(-1, nomal.size.height)];
    [btn setBackgroundImage:select forState:UIControlStateSelected];
//    [btn setBackgroundColor:TEST_BGCOLOR];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[ITUIKitHelper color:@"757575"] forState:UIControlStateNormal];
    [btn setTitleColor:[ITUIKitHelper color:@"c30114"] forState:UIControlStateSelected];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(45, 0, 0, 0)];
    btn.titleLabel.font = [UIFont systemFontOfSize:23 * PJSAH];
    btn.userInteractionEnabled = NO;
    btn.tag = index;
    
    //扩大点击面积
    UIButton *realBtn = [[UIButton alloc] initWithFrame:CGRectMake(btn.frame.origin.x - 10, btn.frame.origin.y, btn.frame.size.width + 20, btn.frame.size.height + 20)];
    realBtn.tag = index;
    [tabBgView addSubview:realBtn];
//    realBtn.backgroundColor = TEST_BGCOLOR;
    [realBtn addTarget:self action:@selector(tabbarItemClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

@end
