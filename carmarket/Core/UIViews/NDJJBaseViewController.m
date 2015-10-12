//
//  NDJJBaseViewController.m
//  CoacoapodsDemo
//
//  Created by itensb on 14-7-24.
//  Copyright (c) 2014年 itenyhCom. All rights reserved.
//

#define bgColor2 [ITUIKitHelper color:@"f6f16f"];

#import "NDJJBaseViewController.h"
#import "UIImage+ITColorImage.h"
#import "BKAlertView.h"

@implementation NDJJBaseViewController
@synthesize hasNavi, cotentSize ,navigationBar, titleLabel, contentView, isPopable;

- (id)initWithNavi:(BOOL)navi leftBtnType:(NDLeftBtnType)type
{
    self = [self initWithNavi:navi];
    
    if (self) {
        
        leftType = type;
        
    }
    
    return self;
}

- (id)initWithNavi:(BOOL)navi
{
    self = [super init];
    
    if (self) {
        
        isPopable = YES;
        leftType = NDLeftBtnBack;
        hasNavi = navi;
        float iosVer = [self getIosVer];
        
        navBarBtns = [NSMutableArray array];
        
        if (iosVer < 7.0) {
            navigationBarHeight = 44;
            statusBarHeight = 20; //透明请置为0
            if (hasNavi) {contentViewHeight = [self getAppHeight] - 20 - navigationBarHeight;}
            else {contentViewHeight = [self getAppHeight] - 20;}
        }
        
        else {
            navigationBarHeight = 64;
            statusBarHeight = 0; //透明请置为0
            if (hasNavi) {contentViewHeight = [self getAppHeight] - navigationBarHeight;}
            else {contentViewHeight = [self getAppHeight] - 20;}
        }
        
        if (!hasNavi) navigationBarHeight = 0;
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = bgColor2;
    
    navigationBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [self getAppWidth], navigationBarHeight)];
    navigationBar.backgroundColor = [UIColor redColor];
    [self.view addSubview:navigationBar];
    
    if(!contentView) {
        contentView = [UIView new];[self.view addSubview:contentView];
        contentView.frame = CGRectMake(0, [self getAppHeight] - contentViewHeight - statusBarHeight, [self getAppWidth], contentViewHeight);    
    }
    
    else {
        contentView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view removeConstraints:self.view.constraints];
        
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:[self getAppHeight] - contentViewHeight - statusBarHeight];
        [self.view addConstraint:constraint];
        
        constraint = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f
                                                   constant:[self getAppWidth]];
        [contentView addConstraint:constraint];
        
        constraint = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f
                                                   constant:contentViewHeight];
        [contentView addConstraint:constraint];
    }

    contentView.backgroundColor = [UIColor grayColor];
    
    leftBtn = [ITUIKitHelper createButtonWithUIImage:[UIImage imageNamed:@"UI7NavigationBarBackButton"] highlightImg:nil point:CGPointMake(0, 0) isBackgroundImg:YES];
    [leftBtn addTarget:self action:@selector(navBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    if(leftType == NDLeftBtnNone) leftBtn.hidden = YES;
    [ITUIKitHelper sizeSet:leftBtn size:CGSizeMake(navigationBar.frame.size.height, leftBtn.frame.size.width + 20)];
    [ITUIKitHelper pointSet:leftBtn piont:CGPointMake(0, (navigationBar.frame.size.height - leftBtn.frame.size.height))];
    leftBtn.backgroundColor = [UIColor clearColor];
    [navigationBar addSubview:leftBtn];
    
    float titleLabelWidth = 150;
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width - titleLabelWidth) / 2.0, navigationBar.frame.size.height - 44, titleLabelWidth, 44)];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.minimumScaleFactor = 0.9;
    titleLabel.font = [UIFont fontWithName:@"Heiti SC" size:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [navigationBar addSubview:titleLabel];
    
}

- (void)insertSubview:(UIView *)view belowContentSubview:(UIView *)subView
{
    [contentView insertSubview:view belowSubview:subView];
}

- (void)addSubviewInContentView:(UIView *)view
{
    [contentView addSubview:view];
}

- (void)navBtnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    if (btn == leftBtn)
    {
        switch (leftType) {
            case NDLeftBtnBack:
                [self popViewController];
                break;
            case NDLeftBtnClose:
                [self dismissViewControllerAnimated:YES completion:nil];
                break;
            default:
                break;
        }
        
    }
}

- (NDJJBaseViewController *)popViewController
{
   return (NDJJBaseViewController *)[self.navigationController popViewControllerAnimated:YES];
}

- (void)setNavigationBarHidden:(BOOL)is
{
    if (is) {
        navigationBar.hidden = YES;
    }
}

#pragma - mark 重写方法
- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    
    titleLabel.text = title;
}

#pragma - mark 导航栏辅助函数
- (UIButton *)createFavBtn
{
    //    favBtn = [ITUIHelper createButtonWithImage:@"btn_topfav" highlightImg:nil marginInsets:[ITUIHelper ITMarginInsetsMake:30 / 2 right:86 / 2] point:CGPointZero isBackgroundImg:YES superViewFrame:navigationBar.frame];
    //    favBtn.tag = 0;
    //    [navigationBar addSubview:favBtn];
    //    [navBarBtns addObject:favBtn];
    //    [favBtn addTarget:self action:@selector(favClick:) forControlEvents:UIControlEventTouchUpInside];
    //    return favBtn;
    
    return nil;
}

- (UIButton *)createTextBtn:(NSString *)text
{
    //    UIButton *textBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, navigationBar.frame.size.height - [ITUIHelper getHeightWithFont:[UIFont systemFontOfSize:14]] - 15, 0, 0)];
    //    textBtn.backgroundColor = [UIColor clearColor];
    //    textBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    //    [textBtn setTitle:text forState:UIControlStateNormal];
    //    [textBtn sizeToFit];
    //    textBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    //    [ITUIHelper pointSet:textBtn piont:CGPointMake(navigationBar.frame.size.width - textBtn.frame.size.width - 8, -1)];
    //    [navBarBtns addObject:textBtn];
    //    [navigationBar addSubview:textBtn];
    //    [textBtn addTarget:self action:@selector(textClick:) forControlEvents:UIControlEventTouchUpInside];
    //
    //    return textBtn;
    
    return nil;
}

#pragma - mark 辅助函数
- (void)clearNavBar
{
    for (UIView *view in navBarBtns) {
        [view removeFromSuperview];
    }
}

- (float)getIosVer
{
    float _iosVer = [[[UIDevice currentDevice] systemVersion] floatValue];
    return _iosVer;
}

- (float)getAppWidth
{
    CGRect appFrame = [[UIScreen mainScreen] bounds];
    float appWidth = appFrame.size.width;
    return appWidth;
}

- (float)getAppHeight
{
    CGRect appFrame = [[UIScreen mainScreen] bounds];
    float appHeight = appFrame.size.height;
    return appHeight;
}

#pragma - mark 公共函数
- (CGSize)cotentSize
{
    return contentView.frame.size;
}

- (void)setLeftBackBar:(BOOL)is
{
    leftBtn.hidden = is;
}

- (void)setTitle:(NSString *)title navStyle:(NDNavStyle)style text:(NSString *)text
{
    
}

- (void)showErrorMessageOnCenter:(NSString *)msg
{
    [BKAlertView showErrorMsg:msg inview:self.view offsetY:([self getAppHeight] - TankHeight) / 2];
}

- (void)showInfoMessageOnCenter:(NSString *)msg
{
    [BKAlertView showInfoMsg:msg inview:self.view offsetY:([self getAppHeight] - TankHeight) / 2];
}

- (void)showTblIndexMessageOnCenter:(NSString *)msg
{
    [BKAlertView showTblIndexMsg:msg inview:self.view offsetY:([self getAppHeight] - TankHeight) / 2 + 40];
}

- (void)showLoading
{
    if (!loadingview) {
        loadingview = [[MBProgressHUD alloc] initWithView:self.view];
        loadingview.labelText = @"加载中";
        loadingview.animationType = MBProgressHUDAnimationFade;
        loadingview.mode = MBProgressHUDModeIndeterminate;
        loadingview.removeFromSuperViewOnHide = YES;
        [self.view addSubview:loadingview];
        [loadingview show:YES];
    }
    
}

-(void)stopLoading
{
    if(loadingview){
        [loadingview hide:YES];
        [loadingview removeFromSuperViewOnHide];
        loadingview = nil;
    }
}

#pragma - mark clickEvent
//- (void)menuClick:(id)sender
//{
//    UIViewController *controller = [self viewControllerForSelf];
//    if ([controller respondsToSelector:@selector(NDJJBaseView_NDNavStyleMenu:)]) {
//        [controller performSelector:@selector(NDJJBaseView_NDNavStyleMenu:) withObject:sender];
//    }
//}

@end
