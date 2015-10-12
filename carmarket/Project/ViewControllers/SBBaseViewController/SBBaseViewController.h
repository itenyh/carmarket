//
//  SBBaseViewController.h
//  carmarket
//
//  Created by itensb on 14-8-4.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "NDJJBaseViewController.h"

typedef void (^InfoHandler)(NSDictionary *info);

typedef enum{
    
    SBNavPlainType = 0,
    SBNavSearchBarType,
    SBNavTabConType,
    SBNavCustomType
    
} SBNavBarType;

@interface SBBaseViewController : NDJJBaseViewController
{
//    UIButton *searchBtn;
    
    SBNavBarType naviType;
    
}

@property (nonatomic, strong) InfoHandler handler;
@property (nonatomic, strong) NSString *passedTitle;

- (void)push_rootNaviController:(UIViewController *)viewController animated:(BOOL)animated;
- (void)present_rootNaviController:(UIViewController *)viewController animated:(BOOL)animated;

- (UIButton *)createEditCreateBtn:(void (^)(id sender))_handler;
- (UIButton *)createSearchBtn:(void (^)(id sender))handler;
- (UIButton *)createAddBtn:(void (^)(id sender))handler;
- (UIButton *)createSettingBtn:(void (^)(id sender))handler;
- (UIButton *)createActivityCreateBtn:(void (^)(id sender))handler;
- (UIButton *)createNaviCreateBtn:(void (^)(id sender))_handler;
- (UIButton *)createTextBtn:(void (^)(id sender))_handler text:(NSString *)text isAdjusted:(BOOL)is;
- (UIButton *)createExchangeCreateBtn:(void (^)(id sender))_handler;
- (UIButton *)createNewVersionCreateBtn:(void (^)(id sender))_handler;

- (void)setTitleWithImage:(UIImage *)img;

- (id)initWithNavi:(BOOL)navi handler:(InfoHandler)_handler leftBtnType:(NDLeftBtnType)type;
- (id)initWithNavi:(BOOL)navi leftBtnType:(NDLeftBtnType)type naviType:(SBNavBarType)navitype;
- (id)initWithNavi:(BOOL)navi naviType:(SBNavBarType)navitype;

- (void)clearViewController;

@end
