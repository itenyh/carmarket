//
//  NDJJBaseViewController.h
//  CoacoapodsDemo
//
//  Created by itensb on 14-7-24.
//  Copyright (c) 2014年 itenyhCom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITUIKitHelper.h"
#import "MBProgressHUD.h"

#undef	ON_CLICK
#define ON_CLICK( __sytle) \
- (void)NDJJBaseView_##__sytle:(id)obj

typedef enum{
    NDLeftBtnNone = 0,
    NDLeftBtnBack,
    NDLeftBtnClose
    
} NDLeftBtnType;

typedef enum{
    NDNavStylePlain = 0,
    NDNavStyleMenu,
    NDNavStyleFavMenu,
    NDNavStyleShareBeixuan,
    NDNavStyleText,
    NDNavStyleDetail,
    
    NDNavStyleFav
    
} NDNavStyle;

@interface NDJJBaseViewController : UIViewController <MBProgressHUDDelegate>
{
    UIButton *leftBtn;
    UILabel *titleLabel;
    float navigationBarHeight;
    float statusBarHeight;
    float contentViewHeight;
    
    int numOfRighBtn;
    
    NSMutableArray *navBarBtns;
    
    MBProgressHUD *loadingview;
    
    BOOL leftType;
}

@property (nonatomic, assign) BOOL hasNavi;
@property (nonatomic, assign) CGSize cotentSize;
@property (nonatomic, readonly, strong) UIView *navigationBar;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UIView *contentView;
@property (nonatomic, assign) BOOL isPopable;

- (id)initWithNavi:(BOOL)navi leftBtnType:(NDLeftBtnType)type;
- (id)initWithNavi:(BOOL)navi;

- (void)addSubviewInContentView:(UIView *)view;
- (void)insertSubview:(UIView *)view belowContentSubview:(UIView *)subView;

- (void)setNavigationBarHidden:(BOOL)is;

- (void)setTitle:(NSString *)title navStyle:(NDNavStyle)style text:(NSString *)text;
- (void)setLeftBackBar:(BOOL)is;

- (void)showLoading;
- (void)stopLoading;
- (void)showErrorMessageOnCenter:(NSString *)msg;
- (void)showInfoMessageOnCenter:(NSString *)msg;
- (void)showTblIndexMessageOnCenter:(NSString *)msg;

- (NDJJBaseViewController *)popViewController;

@end
