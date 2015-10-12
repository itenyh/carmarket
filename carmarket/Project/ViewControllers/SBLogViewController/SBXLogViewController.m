//
//  SBXLogViewController.m
//  carmarket
//
//  Created by itensb on 14-10-11.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBXLogViewController.h"
#import "SBRegisterViewController.h"
#import "SBLogRegisterVCInterface.h"
#import "SBUserDataInterface.h"

@interface SBXLogViewController ()

@end

@implementation SBXLogViewController
@synthesize log, regist, ps, logName;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitleWithImage:[UIImage imageNamed:@"icon_titlehuiyuandenglu"]];
    
    UIImage *strechBgImg = [[UIImage imageNamed:@"bg_greenbottom"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeTile];
    [log setBackgroundImage:strechBgImg forState:UIControlStateNormal];
    [log addTarget:self action:@selector(logIn) forControlEvents:UIControlEventTouchUpInside];
    
    strechBgImg = [[UIImage imageNamed:@"bg_bluebottom"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeTile];
    [regist setBackgroundImage:strechBgImg forState:UIControlStateNormal];
    [regist bk_addEventHandler:^(id sender) {
        [self push_rootNaviController:[[SBRegisterViewController alloc] initWithNavi:YES handler:^(NSDictionary *info) {
            logName.text = [info objectForKey:@"user"];
        } leftBtnType:NDLeftBtnBack] animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [_foget addTarget:self action:@selector(findps) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)logIn
{
    [self resignKeyboard];
    
    NSString *uStr = logName.text;
    NSString *psStr = ps.text;
    
    if([self check4Test:uStr]) return;
    
    [SBLogRegisterVCInterface requestLogWithUser:uStr ps:psStr successBlock:^(id successValue) {

        int state = [[successValue objectForKey:@"state"] intValue];
        
        if (state != 1) [self showErrorMessageOnCenter:@"用户名或密码错误"];
        else {
            [self showInfoMessageOnCenter:@"登陆成功"];
            [SBUserDataInterface setUserDataDict:[successValue objectForKey:@"data"]];
            if(self.handler) self.handler([successValue objectForKey:@"data"]);
            [self performSelector:@selector(popViewController) withObject:nil afterDelay:0.3];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
