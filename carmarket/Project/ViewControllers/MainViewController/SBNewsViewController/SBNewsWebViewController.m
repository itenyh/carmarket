//
//  SBNewsWebViewController.m
//  carmarket
//
//  Created by itensb on 14-9-10.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBNewsWebViewController.h"
#import "SBUMSocialKit.h"

@interface SBNewsWebViewController () <UMSocialUIDelegate>

@end

@implementation SBNewsWebViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    [self createTextBtn:^(id sender) {
        
        [[SBUMSocialKit instance] start:self];
        
    } text:@"分享" isAdjusted:NO];
    
    [self setTitleWithImage:[UIImage imageNamed:@"icon_titlezixun"]];

    NSDictionary *newsInfo = [[SBRequestParamBus instance] getParamWith:self key:@"news"];
    if (newsInfo) [self loadWebPageWithString:[SBUtil getNewsURLWith:newsInfo]];
}

//实现回调方法（可选）：
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}


@end
