//
//  SBLogViewController.m
//  carmarket
//
//  Created by itensb on 14-8-18.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBLogViewController.h"
#import "SBRegisterViewController.h"

#import "SBLogRegisterVCInterface.h"
#import "SBUserDataInterface.h"

@interface SBLogViewController ()
{
    UITextField *logName;
    UITextField *ps;
}
@end

@implementation SBLogViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitleWithImage:[UIImage imageNamed:@"icon_titlehuiyuandenglu"]];

    logName = [self createTextField:@"手机号" rect:CGRectMake(23 * PJSAH, 45 * PJSAH, [ITUIKitHelper getAppWidth] - 23 * PJSA, 87 * PJSAH)];
    
    ps = [self createTextField:@"请输入密码" rect:CGRectMake(23 * PJSAH, [ITUIKitHelper yMarTopView:logName margin:24 * PJSAH], logName.frame.size.width, logName.frame.size.height)];
    ps.secureTextEntry= YES;
    
    UIButton *log = [SBUIFactory getColoredGreenPanel:@"登陆" size:CGSizeMake(322 * PJSAH, 69 * PJSAH) color:nil font:[UIFont systemFontOfSize:35 * PJSAH]];
    [log addTarget:self action:@selector(log) forControlEvents:UIControlEventTouchUpInside];
    [ITUIKitHelper pointSet:log piont:CGPointMake(23 * PJSAH, [ITUIKitHelper yMarTopView:ps margin:55 * PJSAH])];
    [self addSubviewInContentView:log];
    
    UIButton *regist = [SBUIFactory getColoredBluePanel:@"注册" size:CGSizeMake(322 * PJSAH, 69 * PJSAH) color:nil font:[UIFont systemFontOfSize:35 * PJSAH]];
    [regist bk_addEventHandler:^(id sender) {
        [self push_rootNaviController:[[SBRegisterViewController alloc] initWithNavi:YES handler:^(NSDictionary *info) {
            logName.text = [info objectForKey:@"user"];
        } leftBtnType:NDLeftBtnBack] animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    [ITUIKitHelper pointSet:regist piont:CGPointMake([ITUIKitHelper xMarLeftView:log margin:27 * PJSAH], [ITUIKitHelper yMarTopView:ps margin:55 * PJSAH])];
    [self addSubviewInContentView:regist];
    
    UILabel *forget = [ITUIKitHelper createLabel:@"忘记密码" font:[UIFont systemFontOfSize:35 * PJSAH] color:[ITUIKitHelper color:@"606060"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(35 * PJSAH, [ITUIKitHelper yMarTopView:log margin:49 * PJSAH]) superViewFrame:self.view.frame];
    [self addSubviewInContentView:forget];
    
    UIView *array = [ITUIKitHelper createIconWithUIImage:[UIImage imageNamed:@"icon_wangjimimaarray"]];
    [ITUIKitHelper pointSet:array piont:CGPointMake([ITUIKitHelper xMarLeftView:forget margin:6 * PJSAH], forget.frame.origin.y + 3)];
    [self addSubviewInContentView:array];
    
    UIButton *btnWangji = [[UIButton alloc] initWithFrame:forget.frame];
    [btnWangji addTarget:self action:@selector(findps) forControlEvents:UIControlEventTouchUpInside];
    [ITUIKitHelper sizeSet:btnWangji size:CGSizeMake(forget.frame.size.width + array.frame.size.width + 6 * PJSAH, -1)];
    [self addSubviewInContentView:btnWangji];
    
}

- (UITextField *)createTextField:(NSString *)placeholder rect:(CGRect)rect
{
    UITextField *user = [[UITextField alloc] initWithFrame:rect];
    user.font = [UIFont systemFontOfSize:35 * PJSAH];
    user.textColor = [ITUIKitHelper color:@"ccccd2"];
    [self addSubviewInContentView:user];
    user.placeholder = placeholder;
    user.borderStyle = UITextBorderStyleRoundedRect;
    user.backgroundColor = [UIColor whiteColor];
    user.textColor = [ITUIKitHelper color:@"181818"];
    [user setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    
    return user;
}

- (void)log
{
    [self resignKeyboard];
    
    NSString *uStr = logName.text;
    NSString *psStr = ps.text;
    
    if([self check4Test:uStr]) return;
    
    [SBLogRegisterVCInterface requestLogWithUser:uStr ps:psStr successBlock:^(id successValue) {
        
//        NSLog(@"successValue : %@", successValue);
        
        int state = [[successValue objectForKey:@"state"] intValue];
        
        if (state != 1) [self showErrorMessageOnCenter:@"用户名或密码错误"];
        else {
            [self showInfoMessageOnCenter:@"登陆成功"];
            [SBUserDataInterface setUserDataDict:[successValue objectForKey:@"data"]];
            self.handler([successValue objectForKey:@"data"]);
            [self popViewController];
        }
        
    } andFailBlock:^(id failValue) {
        
    }];
}

- (void)findps
{
    [self resignKeyboard];
    
    NSString *uStr = logName.text;
    
    [SBLogRegisterVCInterface requestForgetPs:uStr successBlock:^(id successValue) {
       
        int state = [[successValue objectForKey:@"state"] intValue];
        
        if (state != 1) [self showErrorMessageOnCenter:[successValue objectForKey:@"message"]];
        else [self showInfoMessageOnCenter:@"密码已发送"];
        
    } andFailBlock:^(id failValue) {
        
    }];
}

- (void)resignKeyboard
{
    [ps resignFirstResponder];
    [logName resignFirstResponder];
}

#pragma - mark 测试账号
- (BOOL)check4Test:(NSString *)uStr
{
    if ([uStr isEqualToString:TEST_USER_ACCOUNT]) {
        [self createTestUser];
        return true;
    }
    else return false;
}

- (void)createTestUser
{
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    [info setObject:@"7" forKey:@"userId"];
    [info setObject:@"1" forKey:@"userGrade"];
    [info setObject:@"test@gmail.com" forKey:@"email"];
    [info setObject:@"13445453249" forKey:@"userPhone"];
    [info setObject:@"游客_3231" forKey:@"userName"];
    
    [self showInfoMessageOnCenter:@"登陆成功"];
    [SBUserDataInterface setUserDataDict:info];
    self.handler(info);
    [self popViewController];
}

@end
