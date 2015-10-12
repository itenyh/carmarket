//
//  SBCreateActivityViewController.m
//  carmarket
//
//  Created by itensb on 14-8-18.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#define TIME_FORMAT @"yyyy年MM月dd日 HH:mm"

#import "SBCreateActivityViewController.h"
#import "SBDatePickerView.h"
#import "SBLocationPickViewController.h"
#import "SBColoredBottomView.h"

#import "SBMapActivityViewController.h"
#import "SBActivityVCInterface.h"
#import "SBUserDataInterface.h"

@interface SBCreateActivityViewController () <UIScrollViewDelegate>
{
    UIScrollView *scrollView;
    SBDatePickerView *picker;
    
    UITextField *baomingjiezhiF;
    UITextField *huodongjieshutimeF;
    UITextField *timeF;
    
    NSDictionary *placeInfo;
    NSDictionary *jiheInfo;
    
    UITextField *titleF;
    UITextField *biaotiF;
    UITextView *contentTv;
    UITextField *lianxirenF;
    UITextField *teleF;
    UITextField *huodongyusuanF;
    UITextField *huodongrenshuF;
    
    UITextField *curTimeTextField;
    
}
@end

@implementation SBCreateActivityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitleWithImage:[UIImage imageNamed:@"icon_titlefaqihuodong"]];
    
    float inset = 41 * PJSAH;
    float tfHeight = 58 * PJSAH;
    placeInfo = [NSDictionary dictionary];
    jiheInfo = [NSDictionary dictionary];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [ITUIKitHelper getAppWidth], self.cotentSize.height)];
    scrollView.delegate = self;
    [self addSubviewInContentView:scrollView];
    
    float tfW1 = [ITUIKitHelper getAppWidth] - 102 - 15;
    float tfW2 = [ITUIKitHelper getAppWidth] - 138 - 15;
    
    UILabel *title = [self createTitleLab:@"活动主题:" point:CGPointMake(15, 30)];
    titleF = [self createTF:CGRectMake([ITUIKitHelper xMarLeftView:title margin:10], 29, tfW1, tfHeight)];
    
    UILabel *biaoti = [self createTitleLab:@"活动标题:" point:CGPointMake(15, [ITUIKitHelper yMarTopView:title margin:inset])];
    biaotiF = [self createTF:CGRectMake([ITUIKitHelper xMarLeftView:biaoti margin:10], biaoti.frame.origin.y - 1, tfW1, tfHeight)];
    
    UILabel *baomingjiezhi = [self createTitleLab:@"报名截止时间:" point:CGPointMake(15, [ITUIKitHelper yMarTopView:biaoti margin:inset])];
    baomingjiezhiF = [self createTF:CGRectMake([ITUIKitHelper xMarLeftView:baomingjiezhi margin:10], baomingjiezhi.frame.origin.y  - 1, tfW2, tfHeight) handler:^(id sender) {
        curTimeTextField = baomingjiezhiF;[picker show];[self resignResponder];
    }];
    
    UILabel *huodongjieshu = [self createTitleLab:@"活动结束时间:" point:CGPointMake(15, [ITUIKitHelper yMarTopView:baomingjiezhi margin:inset])];
    huodongjieshutimeF = [self createTF:CGRectMake([ITUIKitHelper xMarLeftView:huodongjieshu margin:10], huodongjieshu.frame.origin.y  - 1, tfW2, tfHeight) handler:^(id sender) {
        curTimeTextField = huodongjieshutimeF;[picker show];[self resignResponder];
    }];
    
    UILabel *time = [self createTitleLab:@"活动时间:" point:CGPointMake(15, [ITUIKitHelper yMarTopView:huodongjieshu margin:inset])];
    timeF = [self createTF:CGRectMake([ITUIKitHelper xMarLeftView:time margin:10], time.frame.origin.y  - 1, tfW1, tfHeight) handler:^(id sender) {
        curTimeTextField = timeF;[picker show];[self resignResponder];
    }];
    
    UILabel *place = [self createTitleLab:@"活动地点:" point:CGPointMake(15, [ITUIKitHelper yMarTopView:time margin:inset])];
    __block UITextField *placeF = [self createTF:CGRectMake([ITUIKitHelper xMarLeftView:place margin:10], place.frame.origin.y  - 1, tfW1, tfHeight) handler:^(id sender) {
        [self push_rootNaviController:[[SBLocationPickViewController alloc] initWithNavi:YES handler:^(NSDictionary *info) {
            placeF.text = [info objectForKey:@"name"];
            placeInfo = info;
        } leftBtnType:NDLeftBtnBack] animated:YES];
    }];
    
    UILabel *content = [self createTitleLab:@"行程安排:" point:CGPointMake(15, [ITUIKitHelper yMarTopView:place margin:inset])];
    contentTv = [[UITextView alloc] initWithFrame:CGRectMake([ITUIKitHelper xMarLeftView:content margin:10], content.frame.origin.y  - 1, tfW1, 413 * PJSAH)];
    contentTv.font = [UIFont systemFontOfSize:25 * PJSAH];contentTv.textColor = [ITUIKitHelper color:@"181818"];
    [SBUIFactory decorateWithLine:contentTv width:0.5 type:ITLineDecorateAll];
    [scrollView addSubview:contentTv];
    
    UILabel *jihe = [self createTitleLab:@"集合地点:" point:CGPointMake(15, [ITUIKitHelper yMarTopView:contentTv margin:inset])];
    __block UITextField *jiheF = [self createTF:CGRectMake([ITUIKitHelper xMarLeftView:jihe margin:10], jihe.frame.origin.y  - 1, tfW1, tfHeight) handler:^(id sender) {
        [self push_rootNaviController:[[SBLocationPickViewController alloc] initWithNavi:YES handler:^(NSDictionary *info) {
            jiheF.text = [info objectForKey:@"name"];
            jiheInfo = info;
        } leftBtnType:NDLeftBtnBack] animated:YES];
    }];
    
    UILabel *lianxiren = [self createTitleLab:@"联系人:" point:CGPointMake(15, [ITUIKitHelper yMarTopView:jihe margin:inset])];
    lianxirenF = [self createTF:CGRectMake([ITUIKitHelper xMarLeftView:lianxiren margin:28.5], lianxiren.frame.origin.y - 1, tfW1, tfHeight)];
    
    UILabel *tele = [self createTitleLab:@"联系电话:" point:CGPointMake(15, [ITUIKitHelper yMarTopView:lianxiren margin:inset])];
    teleF = [self createTF:CGRectMake([ITUIKitHelper xMarLeftView:tele margin:10], tele.frame.origin.y  - 1, tfW1, tfHeight)];
    teleF.keyboardType = UIKeyboardTypePhonePad;
    
    UILabel *huodongyusuan = [self createTitleLab:@"活动预算:" point:CGPointMake(15, [ITUIKitHelper yMarTopView:tele margin:inset])];
    huodongyusuanF = [self createTF:CGRectMake([ITUIKitHelper xMarLeftView:huodongyusuan margin:10], huodongyusuan.frame.origin.y  - 1, tfW1, tfHeight)];
    huodongyusuanF.placeholder = @"元/人";
    huodongyusuanF.keyboardType = UIKeyboardTypeNumberPad;
    
    UILabel *huodongrenshu = [self createTitleLab:@"活动人数:" point:CGPointMake(15, [ITUIKitHelper yMarTopView:huodongyusuan margin:inset])];
    huodongrenshuF = [self createTF:CGRectMake([ITUIKitHelper xMarLeftView:huodongrenshu margin:10], huodongrenshu.frame.origin.y  - 1, tfW1, tfHeight)];
    huodongrenshuF.placeholder = @"人数";
    huodongrenshuF.keyboardType = UIKeyboardTypeNumberPad;
    
    SBColoredBottomView *bottomViewBtn = [[SBColoredBottomView alloc] initWithType:3 view:self.contentView];
    [bottomViewBtn setTitle:@"发起" handler:^(id sender) {
        [self createActivity];
    }];
    [self addSubviewInContentView:bottomViewBtn];
    
    OneParamBlock block = ^(UIDatePicker *sender){curTimeTextField.text = [ITUtils date_parse:sender.date format:TIME_FORMAT];};
    picker = [[SBDatePickerView alloc] initWithFrame:CGRectMake(0, 0, [ITUIKitHelper getAppWidth], self.cotentSize.height)];
    [picker addValueChangeHandler:block];
    OneParamBlock block1 = ^(UIDatePicker *sender){curTimeTextField.text = @"";};
    [picker addClearHandler:block1];
    [self addSubviewInContentView:picker];
    
    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, [ITUIKitHelper yMarTopView:huodongrenshuF margin:10] + bottomViewBtn.frame.size.height)];
    
}

- (UILabel *)createTitleLab:(NSString *)title point:(CGPoint)point
{
    UILabel *l = [ITUIKitHelper createLabel:title font:[UIFont boldSystemFontOfSize:18] color:[UIColor blackColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:point superViewFrame:self.view.frame];
    [scrollView addSubview:l];
    
    return l;
}

- (UITextField *)createTF:(CGRect)frame
{
    UITextField *tf = [[UITextField alloc] initWithFrame:frame];
    tf.font = [UIFont systemFontOfSize:35 * PJSAH];
    tf.textColor = [ITUIKitHelper color:@"181818"];
    tf.borderStyle = UITextBorderStyleRoundedRect;
    tf.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:tf];
    
    return tf;
}

- (UITextField *)createTF:(CGRect)frame handler:(void (^)(id sender))handler
{
    UITextField *tf = [self createTF:frame];
    tf.font = [UIFont systemFontOfSize:30 * PJSAH];
    tf.textColor = [ITUIKitHelper color:@"181818"];
    tf.enabled = NO;
    UIButton *b = [[UIButton alloc] initWithFrame:tf.frame];
    tf.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:b];
    [b bk_addEventHandler:handler forControlEvents:UIControlEventTouchUpInside];
    
    return tf;
}

- (void)resignResponder
{
    [titleF resignFirstResponder];
    [contentTv resignFirstResponder];
    [teleF resignFirstResponder];
    
    [biaotiF resignFirstResponder];
    [lianxirenF resignFirstResponder];
    [huodongyusuanF resignFirstResponder];
    [huodongrenshuF resignFirstResponder];
    
}

- (void)createActivity
{
    NSString *actionTheme = titleF.text;
    NSString *actionTitle = biaotiF.text;
    NSString *actionContext = contentTv.text;
    NSString *actionMaxUser = huodongrenshuF.text;
    NSString *personMoney = huodongyusuanF.text;
    NSString *actionBaotime = [self getTimeWithTextField:baomingjiezhiF];
    NSString *actionStartTime = [self getTimeWithTextField:timeF];
    NSString *actionEndTime = [self getTimeWithTextField:huodongjieshutimeF];
    NSString *contactPerson = lianxirenF.text;
    NSString *personPhone = teleF.text;
    NSString *actionSite = [placeInfo objectForKey:@"name"];
    NSString *actionGatherSite = [jiheInfo objectForKey:@"name"];
    NSString *site_longitudeAndLatitude = [self getGeoData:placeInfo];
    NSString *gather_longitudeAndLatitude = [self getGeoData:jiheInfo];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:actionTheme, @"actionTheme", actionTitle, @"actionTitle", actionContext, @"actionContext", actionMaxUser, @"actionMaxUser", personMoney, @"personMoney",  actionBaotime, @"actionBaotime", actionStartTime, @"actionStartTime", actionEndTime, @"actionEndTime", contactPerson, @"contactPerson", personPhone, @"personPhone", actionSite, @"actionSite", actionGatherSite, @"actionGatherSite", site_longitudeAndLatitude, @"site_longitudeAndLatitude", gather_longitudeAndLatitude, @"gather_longitudeAndLatitude", @"1", @"userType", [SBUserDataInterface getUserId], @"userId", nil];
    
    [SBActivityVCInterface requestCreateActivity:dic successBlock:^(id successValue) {
       
//        NSLog(@"success : %@", successValue);
        
        int state = [[successValue objectForKey:@"state"] intValue];
        
        if (state != 1) [self showErrorMessageOnCenter:[successValue objectForKey:@"message"]];
        else {[self showInfoMessageOnCenter:@"活动发起成功"];[self popViewController];};
        
    } andFailBlock:^(id failValue) {
        
    }];
    
//    [self push_rootNaviController:[[SBMapActivityViewController alloc] initWithNavi:YES] animated:YES];
    
}

#pragma - mark 辅助函数
- (NSString *)getTimeWithTextField:(UITextField *)tf
{
    NSDate *_date = [ITUtils date_fomat:tf.text formte:TIME_FORMAT];
    NSTimeInterval _interval = [_date timeIntervalSince1970];
    return [NSString stringWithFormat:@"%.0f", _interval * 1000];
}

- (NSString *)getGeoData:(NSDictionary *)info
{
    NSString *latitude = [info objectForKey:@"latitude"];
    NSString *longitude = [info objectForKey:@"longitude"];
    
    if (longitude && latitude) return [NSString stringWithFormat:@"%@,%@", longitude, latitude];
    else return nil;
}

#pragma - mark ScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    [self resignResponder];
}

@end
