//
//  SBShengMingWebViewController.m
//  carmarket
//
//  Created by Apple on 14-9-22.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBShengMingWebViewController.h"

@interface SBShengMingWebViewController ()

@end

@implementation SBShengMingWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"网络服务协议";
    
    [self loadWebPageWithString:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", API_DOMAIN, @"protocol.html"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
