//
//  SBUMSocialKit.m
//  carmarket
//
//  Created by YangHan on 15/1/16.
//  Copyright (c) 2015年 chinaCQ. All rights reserved.
//

#define ICON_SIZE 50

#import "SBUMSocialKit.h"
#import "UMSocialWechatHandler.h"
#import "UtilsMacro.h"

@implementation SBUMSocialKit
@synthesize controller;

SYNTHESIZE_SINGLETON_FOR_CLASS_WITHOUTINIT(SBUMSocialKit);

+ (SBUMSocialKit *)instance
{
    
    @synchronized(self)
    {
        if (sharedSBUMSocialKit == nil)
        {
            sharedSBUMSocialKit = [SBUMSocialKit new];
        }
    }
    
    return sharedSBUMSocialKit;
    
}

- (void)register_SBUMSocialKit
{
    [UMSocialData setAppKey:YOUMENG_APPKEY];
    [UMSocialWechatHandler setWXAppId:@"wx6219f128f0d38168" appSecret:@"154663c127f4ddc6696717ac21dd00d1" url:@""];
}

//dic {url:source, icon:image}
- (void)start:(SBBaseViewController *)_controller
{
    sharedSBUMSocialKit.controller = _controller;
    [self sharePanel];
}

- (void)sharePanel
{
    UIView *view = sharedSBUMSocialKit.controller.view;
    UIView *mask = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
    mask.backgroundColor = [ITUIKitHelper color:@"000000" alpha:0.5];
    [view addSubview:mask];
    
    //关闭按钮
    UIButton *close = [[UIButton alloc] initWithFrame:mask.frame];
    [mask addSubview:close];
    [close bk_addEventHandler:^(id sender) {
        [mask removeFromSuperview];
    } forControlEvents:UIControlEventTouchUpInside];
    
    float panel_width = 300;
    float panel_height = 150;
    UIView *panel = [[UIView alloc] initWithFrame:CGRectMake(([ITUIKitHelper getAppWidth] - panel_width) / 2.0, ([ITUIKitHelper getAppHeight] - panel_height) / 2.0, panel_width, panel_height)];
    panel.layer.cornerRadius = 2;
    panel.backgroundColor = [UIColor whiteColor];
    [mask addSubview:panel];
    
    UILabel *label = [ITUIKitHelper createLabel:@"分享到" size:CGSizeMake(panel.frame.size.width
, 40) font:[UIFont boldSystemFontOfSize:16] color:[UIColor blackColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(0, 0) superViewFrame:panel.frame];
    label.textAlignment = NSTextAlignmentCenter;
    [panel addSubview:label];
    
    [ITUIKitHelper decorateWithLine:label color:[UIColor lightGrayColor] lineWidth:0.2 type:ITLineDecorateDown];
    
    float inset = 20;
    [self share_btn_create:CGPointMake(inset, (panel.frame.size.height + label.frame.size.height - ICON_SIZE) / 2.0) img:@"UMS_wechat_session_icon" panel:panel index:1];
    [self share_btn_create:CGPointMake(inset * 2 + ICON_SIZE, (panel.frame.size.height + label.frame.size.height - ICON_SIZE) / 2.0) img:@"UMS_wechat_timeline_icon" panel:panel index:2];
    [self share_btn_create:CGPointMake(inset * 3 + ICON_SIZE * 2, (panel.frame.size.height + label.frame.size.height - ICON_SIZE) / 2.0) img:@"UMS_wechat_favorite_icon" panel:panel index:3];
    [self share_btn_create:CGPointMake(inset * 4 + ICON_SIZE * 3, (panel.frame.size.height + label.frame.size.height - ICON_SIZE) / 2.0) img:@"UMS_sina_icon" panel:panel index:4];
    
}

#pragma - mark 分享函数
- (void)share_to_wechat_friend
{
    NSDictionary *newsInfo = [[SBRequestParamBus instance] getParamWith:controller key:@"news"];
    
    //在分享代码前设置微信分享应用类型，用户点击消息将跳转到应用，或者到下载页面
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;
    //分享图文样式到微信朋友圈显示字数比较少，只显示分享标题
    [UMSocialData defaultData].extConfig.title = @"";
    //设置微信好友或者朋友圈的分享url,下面是微信好友，微信朋友圈对应wechatTimelineData
    [UMSocialData defaultData].extConfig.wechatSessionData.url = [[SBUtil getNewsURLWith:newsInfo] absoluteString];
    
    UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:
                                        [newsInfo objectForKey:@"titleImg"]];
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:[newsInfo objectForKey:@"title"] image:nil location:nil urlResource:urlResource presentedController:controller completion:^(UMSocialResponseEntity *shareResponse){
        if (shareResponse.responseCode == UMSResponseCodeSuccess) {
//            NSLog(@"分享成功！");
        }
    }];
}

- (void)share_to_wechat_circel
{
    NSDictionary *newsInfo = [[SBRequestParamBus instance] getParamWith:controller key:@"news"];
    
    //在分享代码前设置微信分享应用类型，用户点击消息将跳转到应用，或者到下载页面
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;
    //分享图文样式到微信朋友圈显示字数比较少，只显示分享标题
    [UMSocialData defaultData].extConfig.title = [newsInfo objectForKey:@"title"];
    //设置微信好友或者朋友圈的分享url,下面是微信好友，微信朋友圈对应wechatTimelineData
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = [[SBUtil getNewsURLWith:newsInfo] absoluteString];
    
    UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:
                                        [newsInfo objectForKey:@"titleImg"]];
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:@"" image:nil location:nil urlResource:urlResource presentedController:controller completion:^(UMSocialResponseEntity *shareResponse){
        if (shareResponse.responseCode == UMSResponseCodeSuccess) {
//            NSLog(@"分享成功！");
        }
    }];
}

- (void)share_to_wechat_fav
{
    NSDictionary *newsInfo = [[SBRequestParamBus instance] getParamWith:controller key:@"news"];
    
    //在分享代码前设置微信分享应用类型，用户点击消息将跳转到应用，或者到下载页面
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;
    //分享图文样式到微信朋友圈显示字数比较少，只显示分享标题
    [UMSocialData defaultData].extConfig.title = [newsInfo objectForKey:@"title"];
    //设置微信好友或者朋友圈的分享url,下面是微信好友，微信朋友圈对应wechatTimelineData
    [UMSocialData defaultData].extConfig.wechatFavoriteData.url = [[SBUtil getNewsURLWith:newsInfo] absoluteString];
    
    UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:
                                        [newsInfo objectForKey:@"titleImg"]];
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatFavorite] content:@"" image:nil location:nil urlResource:urlResource presentedController:controller completion:^(UMSocialResponseEntity *shareResponse){
        if (shareResponse.responseCode == UMSResponseCodeSuccess) {
//            NSLog(@"分享成功！");
        }
    }];
}

- (void)share_to_weibo
{
    NSDictionary *newsInfo = [[SBRequestParamBus instance] getParamWith:controller key:@"news"];
    
    NSString *share_text = [NSString stringWithFormat:@"%@  %@", [newsInfo objectForKey:@"title"], [[SBUtil getNewsURLWith:newsInfo] absoluteString]];
    [[UMSocialControllerService defaultControllerService] setShareText:share_text shareImage:[UIImageView sd] socialUIDelegate:nil];        //设置分享内容和回调对象
    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(sharedSBUMSocialKit.controller,[UMSocialControllerService defaultControllerService],YES);
}

#pragma - mark 辅助函数
- (void)share_btn_create:(CGPoint)point img:(NSString *)img panel:(UIView *)panel index:(int)index
{
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"UMSocialSDKResourcesNew" ofType:@"bundle"]];
    NSString *imageName = [bundle pathForResource:[NSString stringWithFormat:@"SnsPlatform/%@", img] ofType:@"png"];
    UIImage *btn_img = [[UIImage alloc] initWithContentsOfFile:imageName];
    UIButton *weixin_py = [ITUIKitHelper createButtonWithUIImage:btn_img highlightImg:nil point:CGPointZero isBackgroundImg:YES];
    [ITUIKitHelper sizeSet:weixin_py size:CGSizeMake(ICON_SIZE, ICON_SIZE)];
    [ITUIKitHelper pointSet:weixin_py piont:point];
    [panel addSubview:weixin_py];
    weixin_py.tag = index;
    [weixin_py addTarget:self action:@selector(share_icon_click:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma - mark 事件函数
- (void)share_icon_click:(UIButton *)sender
{
    int index = sender.tag;
    
    switch (index) {
        case 1:
        {
            [self share_to_wechat_friend];
        }
            break;
        case 2:
        {
            [self share_to_wechat_circel];
        }
            break;
        case 3:
        {
            [self share_to_wechat_fav];
        }
            break;
        case 4:
        {
            [self share_to_weibo];
        }
            break;
        default:
            break;
    }
}

@end
