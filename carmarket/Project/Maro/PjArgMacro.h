//
//  PjArgMacro.h
//  CarMarket
//
//  Created by Apple on 14-7-22.
//  Copyright (c) 2014年 itenyhCom. All rights reserved.
//

typedef void (^OneParamBlock)(id obj);

#define SB_APP_VERSION @"20001"
#define IS_UP7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_UP8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define APP_ID @"918385397"
#define APP_STORE_ADD @"https://itunes.apple.com/us/app/zhong-qing-shang-bao-zhang/id918385397?l=zh&ls=1&mt=8"
#define YOUMENG_APPKEY @"5493df6efd98c5751f000ec9"

#define TABBAR_HEIGHT (IS_UP7? 114 * PJSAH : 114 * PJSAH)
#define PLACEHOLDER_IMAGE @"icon_xiangmu_0_110"

//@"http://buycar.wicp.net" @"http://imgs.wicp.net" @"http://app.icq100.com" @"http://buycarnews.icq100.com"
#define API_DOMAIN @"http://interface.icq100.com"
#define API_NEWS_DOMAIN @"http://buycarnews.icq100.com"
#define API_DIS_ADD @"http://buycarbbs.icq100.com/html/index.html"
#define HANHAN_API_DOMAIN @"http://cqcarmarket.com:8080"

#define GAODE_MAP_KEY @"401b2d5e8770b5176401036779e1ab09"
#define BAIDU_NAVI_KEY @"PKh14N8xWGPcUiTARG788ejK"

#define PJSA 640.0 / 720.0
#define PJSAH 640.0 / 720.0 / 2 //0.44

#define NETREQUEST_TIMEOUT 10

#define DEFAULT_PAGESIZE 20

#define DEFAULT_BG_COLOR [ITUIKitHelper color:@"f2f2f2"]

//RemoveUndeclarePerformerWarning
#define RUPWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wundeclared-selector\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#define ADDATA_NUM 4

//测试用
#define TEST_IMGURL @"http://www.cn357.com/upload/article/images/1021431786.jpg"
#define TEST_NEWSIMGURL @"http://c.hiphotos.baidu.com/image/pic/item/e850352ac65c1038b92e8e96b0119313b07e8916.jpg"
#define TEST_USERHEADURL @"http://img4.duitang.com/uploads/blog/201307/04/20130704171234_SWj8A.thumb.600_0.jpeg"
#define TEST_BGCOLOR [UIColor orangeColor]
#define TEST_CHEXINGURL @"http://res.76868.com/res/images/b2a448d7-b3ac-4738-ad7d-5040402bc80a.jpg"
#define TEST_USER_ACCOUNT @"sbiten"

//提示用语
#define NO_DATA_INFO @"暂无数据"
#define LOADING_FAIL_INFO @"加载失败"

//通知
#define NOTI_ENTER_FORGROUND @"NOTI_ENTER_FORGROUND"

//UserDefault
#define GLOBAL_USER @"global_user_123"
