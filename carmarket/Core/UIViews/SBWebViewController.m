//
//  SBWebViewController.m
//  carmarket
//
//  Created by Apple on 14-9-22.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBWebViewController.h"
#import "MyURLCache.h"

@interface SBWebViewController () <UIWebViewDelegate>

@end

@implementation SBWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.cotentSize.width, self.cotentSize.height)];
    
    webView.delegate = self;
    
    [self addSubviewInContentView:webView];
    
    if (_url) [self loadWebPageWithString:_url];
    
    
}

- (void)loadWebPageWithString:(NSURL *)url
{
    if (url) {
        
//        NSLog(@"调用web url链接 : %@", url.absoluteString);
        
        [webView loadRequest:[NSURLRequest requestWithURL:url]];
        
        NSURLCache *shareCache = [NSURLCache sharedURLCache];
        if (!shareCache || ![shareCache isKindOfClass:[MyURLCache class]]) {
            
            NSArray *dicArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            NSString *basePath = [dicArray objectAtIndex:0];
            
            MyURLCache *shareCache = [[MyURLCache alloc] initWithMemoryCapacity:1024 * 1024 diskCapacity:0 diskPath:basePath];
            [NSURLCache setSharedURLCache:shareCache];
            
        }
        
        else {
            //            NSLog(@"有了一个");
        }
        
    }
    
}

#pragma - mark WebView 代理
- (void)webViewDidStartLoad:(UIWebView *)webView
{
//    [self showLoading];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
//    [self stopLoading];
    
    MyURLCache *sharedCache = (MyURLCache *)[NSURLCache sharedURLCache];
    if ([sharedCache isKindOfClass:[MyURLCache class]]) [sharedCache saveInfo];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self stopLoading];
    [self showErrorMessageOnCenter:LOADING_FAIL_INFO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    //    // Dispose of any resources that can be recreated.
    //    /* 内存警告时移除缓存 */
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

@end
