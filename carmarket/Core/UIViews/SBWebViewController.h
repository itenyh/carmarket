//
//  SBWebViewController.h
//  carmarket
//
//  Created by Apple on 14-9-22.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBBaseViewController.h"

@interface SBWebViewController : SBBaseViewController
{
    UIWebView *webView;
}

@property (nonatomic, strong) NSURL *url;

- (void)loadWebPageWithString:(NSURL *)url;

@end
