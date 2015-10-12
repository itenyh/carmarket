//
//  SBBaseViewController.m
//  carmarket
//
//  Created by itensb on 14-8-4.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#define NAVI_RIGHTBTN_Y 25 * PJSAH
#define ITEM_STRECH_FRAME 30

#import "SBBaseViewController.h"
#import "SBAppDelegate.h"

@implementation SBBaseViewController
@synthesize handler;

- (id)initWithNavi:(BOOL)navi handler:(InfoHandler)_handler leftBtnType:(NDLeftBtnType)type
{
    self = [super initWithNavi:navi leftBtnType:type];
    
    if (self) {
        
        handler = _handler;
        
    }
    
    return self;
}

- (id)initWithNavi:(BOOL)navi leftBtnType:(NDLeftBtnType)type naviType:(SBNavBarType)navitype
{
    self = [super initWithNavi:navi leftBtnType:type];
    
    if (self) naviType = navitype;

    return self;
}

- (id)initWithNavi:(BOOL)navi naviType:(SBNavBarType)navitype
{
    self = [super initWithNavi:navi leftBtnType:NDLeftBtnBack];
    
    if (self) naviType = navitype;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationBar.backgroundColor = [ITUIKitHelper color:@"c40014"];
    
    if(_passedTitle) self.title = _passedTitle;
    
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:50 * PJSAH];
    
    [leftBtn removeFromSuperview];
    
    if (leftType == NDLeftBtnBack) {
        leftBtn = [ITUIKitHelper createButtonWithUIImage:[UIImage imageNamed:@"btn_naviback"] highlightImg:nil marginInsets:[ITUIKitHelper ITMarginInsetsMake:30 * PJSAH right:-1] point:CGPointMake(45 * PJSAH, -1) isBackgroundImg:NO superViewFrame:self.navigationBar.frame];
        RUPWarning([leftBtn addTarget:self action:@selector(navBtnClick:) forControlEvents:UIControlEventTouchUpInside]);
    }
    
    else if (leftType == NDLeftBtnClose) {
        leftBtn = [ITUIKitHelper createButtonWithUIImage:[UIImage imageNamed:@"btn_navicancel"] highlightImg:nil marginInsets:[ITUIKitHelper ITMarginInsetsMake:30 * PJSAH right:-1] point:CGPointMake(45 * PJSAH, -1) isBackgroundImg:NO superViewFrame:self.navigationBar.frame];
        RUPWarning([leftBtn addTarget:self action:@selector(navBtnClick:) forControlEvents:UIControlEventTouchUpInside]);
    }
    
    else if(leftType == NDLeftBtnNone) leftBtn.hidden = YES; [ITUIKitHelper stretchViewFrame:ITEM_STRECH_FRAME view:leftBtn];
    [self.navigationBar addSubview:leftBtn];
    
    self.contentView.backgroundColor = DEFAULT_BG_COLOR;
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (naviType == SBNavCustomType) [titleLabel removeFromSuperview];
    
}

- (SBAppDelegate *)getAppDelegate
{
    return [UIApplication sharedApplication].delegate;
}

- (void)push_rootNaviController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[self getAppDelegate].rootNavi pushViewController:viewController animated:animated];
}

- (void)present_rootNaviController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[self getAppDelegate].rootNavi presentViewController:viewController animated:animated completion:nil];
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion
{
    [self clearViewController];
    [super dismissViewControllerAnimated:flag completion:completion];
}

- (SBBaseViewController *)popViewController
{
    [self clearViewController];
    return (SBBaseViewController *)[super popViewController];
}

- (void)clearViewController
{
    [[SBRequestParamBus instance] removeParam4Obj:self];
    MLNavigationController *navi = (MLNavigationController *)self.navigationController;
    navi.panGestureLock = NO;
}

#pragma - mark 导航栏辅助函数
- (void)setTitleWithImage:(UIImage *)img
{
    titleLabel.hidden = YES;
    
    UIView *view = [ITUIKitHelper createIconWithUIImage:img];
    [self.navigationBar addSubview:view];
    [ITUIKitHelper pointSet:view piont:CGPointMake(([ITUIKitHelper getAppWidth] - view.frame.size.width) / 2.0, self.navigationBar.frame.size.height - view.frame.size.height - 10)];
}

- (UIButton *)createSearchBtn:(void (^)(id sender))_handler
{
    numOfRighBtn++;
    
    UIButton *searchBtn = [ITUIKitHelper createButtonWithUIImage:[UIImage imageNamed:@"btn_navisearch"] highlightImg:nil marginInsets:[ITUIKitHelper ITMarginInsetsMake:NAVI_RIGHTBTN_Y right:33 * PJSAH] point:CGPointZero isBackgroundImg:YES superViewFrame:self.navigationBar.frame];
    [searchBtn bk_addEventHandler:_handler forControlEvents:UIControlEventTouchUpInside];
    [self.navigationBar addSubview:searchBtn];
    [navBarBtns addObject:searchBtn];
    return searchBtn;
}

- (UIButton *)createAddBtn:(void (^)(id sender))_handler
{
    UIButton *addBtn = [ITUIKitHelper createButtonWithImage:@"icon_dianhua" highlightImg:nil marginInsets:[ITUIKitHelper ITMarginInsetsMake:30 / 2 right:86 / 2] point:CGPointZero isBackgroundImg:YES superViewFrame:self.navigationBar.frame];
    [addBtn bk_addEventHandler:_handler forControlEvents:UIControlEventTouchUpInside];
    [self.navigationBar addSubview:addBtn];
    [navBarBtns addObject:addBtn];
    return addBtn;
}

- (UIButton *)createSettingBtn:(void (^)(id sender))_handler
{
    numOfRighBtn++;
    
    UIButton *searchBtn = [ITUIKitHelper createButtonWithUIImage:[UIImage imageNamed:@"btn_navisetting"] highlightImg:nil marginInsets:[ITUIKitHelper ITMarginInsetsMake:NAVI_RIGHTBTN_Y right:33 * PJSAH] point:CGPointZero isBackgroundImg:YES superViewFrame:self.navigationBar.frame];
    [searchBtn bk_addEventHandler:_handler forControlEvents:UIControlEventTouchUpInside];
    [self.navigationBar addSubview:searchBtn];
    [navBarBtns addObject:searchBtn];
    return searchBtn;
}

- (UIButton *)createActivityCreateBtn:(void (^)(id sender))_handler
{
    numOfRighBtn++;
    
    UIButton *searchBtn = [ITUIKitHelper createButtonWithUIImage:[UIImage imageNamed:@"btn_huodongnavi"] highlightImg:nil marginInsets:[ITUIKitHelper ITMarginInsetsMake:NAVI_RIGHTBTN_Y - 3 right:33 * PJSAH] point:CGPointZero isBackgroundImg:NO superViewFrame:self.navigationBar.frame];
    [searchBtn bk_addEventHandler:_handler forControlEvents:UIControlEventTouchUpInside];
    [self.navigationBar addSubview:searchBtn];
    [navBarBtns addObject:searchBtn];[ITUIKitHelper stretchViewFrame:ITEM_STRECH_FRAME view:searchBtn];
    return searchBtn;
}

- (UIButton *)createNaviCreateBtn:(void (^)(id sender))_handler
{
    numOfRighBtn++;
    
    UIButton *searchBtn = [ITUIKitHelper createButtonWithUIImage:[UIImage imageNamed:@"btn_navinavi"] highlightImg:nil marginInsets:[ITUIKitHelper ITMarginInsetsMake:NAVI_RIGHTBTN_Y - 3 right:33 * PJSAH] point:CGPointZero isBackgroundImg:NO superViewFrame:self.navigationBar.frame];
    [searchBtn bk_addEventHandler:_handler forControlEvents:UIControlEventTouchUpInside];
    [self.navigationBar addSubview:searchBtn];
    [navBarBtns addObject:searchBtn];[ITUIKitHelper stretchViewFrame:ITEM_STRECH_FRAME view:searchBtn];
    return searchBtn;
}

- (UIButton *)createExchangeCreateBtn:(void (^)(id sender))_handler
{
    numOfRighBtn++;
    
    UIButton *searchBtn = [ITUIKitHelper createButtonWithUIImage:[UIImage imageNamed:@"icon_exchange"] highlightImg:nil marginInsets:[ITUIKitHelper ITMarginInsetsMake:NAVI_RIGHTBTN_Y - 3 right:33 * PJSAH] point:CGPointZero isBackgroundImg:NO superViewFrame:self.navigationBar.frame];
    [searchBtn bk_addEventHandler:_handler forControlEvents:UIControlEventTouchUpInside];
    [self.navigationBar addSubview:searchBtn];
    [navBarBtns addObject:searchBtn];[ITUIKitHelper stretchViewFrame:ITEM_STRECH_FRAME view:searchBtn];
    return searchBtn;
}

- (UIButton *)createNewVersionCreateBtn:(void (^)(id sender))_handler
{
    numOfRighBtn++;
    
    UIButton *b = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    b.titleLabel.font = [UIFont boldSystemFontOfSize:10];
    [b setTitle:@"新版本" forState:UIControlStateNormal];
    [b setBackgroundColor:[ITUIKitHelper color:@"#FF4040"]];
    b.layer.cornerRadius = 10;
    b.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [ITUIKitHelper locateWithMargin:[ITUIKitHelper ITMarginInsetsMake:NAVI_RIGHTBTN_Y right:33 * PJSAH] point:CGPointZero view:b superView:self.navigationBar.frame];
    
    [b bk_addEventHandler:_handler forControlEvents:UIControlEventTouchUpInside];
    [self.navigationBar addSubview:b];
    [navBarBtns addObject:b];
    return b;
}

- (UIButton *)createTextBtn:(void (^)(id sender))_handler text:(NSString *)text isAdjusted:(BOOL)is
{
    numOfRighBtn++;
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    btn.tag = 0;
    [ITUIKitHelper locateWithMargin:[ITUIKitHelper ITMarginInsetsMake:NAVI_RIGHTBTN_Y right:20] point:CGPointZero view:btn superView:self.navigationBar.frame];
    [btn bk_addEventHandler:^(id sender) {
        btn.tag = (btn.tag == 0 ? 1 : 0);
        if (is) {
            if (btn.tag == 1) [btn setTitleColor:[ITUIKitHelper color:@"ffffff" alpha:0.5] forState:UIControlStateNormal];
            else [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        _handler(sender);
    }  forControlEvents:UIControlEventTouchUpInside];
    [self.navigationBar addSubview:btn];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[ITUIKitHelper color:@"ffffff" alpha:0.5] forState:UIControlStateHighlighted];
    [navBarBtns addObject:btn];[ITUIKitHelper stretchViewFrame:ITEM_STRECH_FRAME view:btn];
    return btn;
}

@end
