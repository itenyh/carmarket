//
//  SBRegisterViewController.m
//  carmarket
//
//  Created by Apple on 14-9-11.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBRegisterViewController.h"
#import "SBLogRegisterVCInterface.h"
#import "SBShengMingWebViewController.h"

@interface SBRegisterViewController ()
{
    UITextField *user;
}
@end

@implementation SBRegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"注册";
    
    user = [self createTextField:@"手机号" rect:CGRectMake(23 * PJSAH, 45 * PJSAH, [ITUIKitHelper getAppWidth] - 23 * PJSA, 87 * PJSAH)];
    
    UIButton *regist = [SBUIFactory getColoredBluePanel:@"注册" size:CGSizeMake(user.frame.size.width, 69 * PJSAH) color:nil font:[UIFont systemFontOfSize:35 * PJSAH]];
    [regist addTarget:self action:@selector(regist) forControlEvents:UIControlEventTouchUpInside];
    [ITUIKitHelper pointSet:regist piont:CGPointMake(user.frame.origin.x, [ITUIKitHelper yMarTopView:user margin:55 * PJSAH])];
    [self addSubviewInContentView:regist];
    
    UILabel *l = [ITUIKitHelper createLabel:@"点击注册表示同意" font:[UIFont systemFontOfSize:10] color:[UIColor blackColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(13, [ITUIKitHelper yMarTopView:regist margin:20]) superViewFrame:self.view.frame];
    [self addSubviewInContentView:l];
    
    UIButton *shengming = [UIButton new];
    shengming.frame = CGRectMake([ITUIKitHelper xMarLeftView:l margin:0], 134.5, 68, l.font.lineHeight);
    shengming.titleLabel.textAlignment = NSTextAlignmentLeft;
    [shengming setTitle:@"网络服务协议" forState:UIControlStateNormal];
    [shengming setTitleColor:[ITUIKitHelper color:@"4b89d2"] forState:UIControlStateNormal];
    [shengming setTitleColor:[ITUIKitHelper color:@"4b89d2" alpha:0.8] forState:UIControlStateHighlighted];
    shengming.titleLabel.font = l.font;
    [shengming bk_addEventHandler:^(id sender) {
        [self push_rootNaviController:[[SBShengMingWebViewController alloc] initWithNavi:YES] animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    [self addSubviewInContentView:shengming];
    
    
    
}

- (UITextField *)createTextField:(NSString *)placeholder rect:(CGRect)rect
{
    UITextField *tf = [[UITextField alloc] initWithFrame:rect];
    tf.font = [UIFont systemFontOfSize:35 * PJSAH];
    tf.textColor = [ITUIKitHelper color:@"ccccd2"];
    [self addSubviewInContentView:tf];  
    tf.placeholder = placeholder;
    tf.borderStyle = UITextBorderStyleRoundedRect;
    tf.backgroundColor = [UIColor whiteColor];
    tf.textColor = [ITUIKitHelper color:@"181818"];
    
    return tf;
}

- (void)regist
{
    NSString *phone = user.text;
    
    [SBLogRegisterVCInterface requestRegisterWith:phone successBlock:^(id successValue) {
       
        int state = [[successValue objectForKey:@"state"] intValue];
        
        if (state != 1) [self showErrorMessageOnCenter:[successValue objectForKey:@"message"]];
        
        else {
            [self showInfoMessageOnCenter:@"注册成功，密码已经发送到手机"];
            self.handler([NSDictionary dictionaryWithObject:phone forKey:@"user"]);
            [self performSelector:@selector(popViewController) withObject:nil afterDelay:1.5];
        }
        
        [user resignFirstResponder];
        
        
    } andFailBlock:^(id failValue) {
        
        [user resignFirstResponder];
        
    }];
}


@end
