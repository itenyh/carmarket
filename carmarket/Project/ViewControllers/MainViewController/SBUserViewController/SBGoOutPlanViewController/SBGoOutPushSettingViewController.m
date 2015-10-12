//
//  SBGoOutPushSettingViewController.m
//  carmarket
//
//  Created by itensb on 14-11-17.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBGoOutPushSettingViewController.h"
#import "UIImage+ITColorImage.h"

@interface SBGoOutPushSettingViewController ()
{
    UISwitch *sw;
    
    UIView *dateBg;
    UIScrollView *scrollView;
}
@end

@implementation SBGoOutPushSettingViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"推送设置";
    
    [self createTextBtn:^(id sender) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } text:@"保存" isAdjusted:NO];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [ITUIKitHelper getAppWidth], self.cotentSize.height)];
    [self addSubviewInContentView:scrollView];
    
    UIView *bgView = [self createMenuWithTitle:@"推送通知" index:0];
    UIView *bgView1 = [self createMenuWithTitle:@"仅在交通拥塞状况推送" index:1];
    
    //------------- pickview -------------
    
    UIDatePicker *picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, [ITUIKitHelper yMarTopView:bgView1 margin:20], [ITUIKitHelper getAppWidth], 90)];
    picker.datePickerMode = UIDatePickerModeTime;
    picker.backgroundColor = [UIColor whiteColor];
    [self addSubviewInContentView:picker];
    
    //------------- 周数安排 --------------
    float dateBgHeight = 40;
    dateBg = [[UIView alloc] initWithFrame:CGRectMake(0, [ITUIKitHelper yMarTopView:picker margin:20], [ITUIKitHelper getAppWidth], dateBgHeight)];
    [self addSubviewInContentView:dateBg];
    
    [self btnCreated];
    
    
}

- (UIView *)createMenuWithTitle:(NSString *)title index:(int)index
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 20 + index * 50 + index * 1, [ITUIKitHelper getAppWidth], 50)];
    bgView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:bgView];
    
    sw = [[UISwitch alloc] initWithFrame:CGRectMake([ITUIKitHelper getAppWidth] - 65, (bgView.frame.size.height - 30) / 2.0, 35, 30)];
    [sw bk_addEventHandler:^(id sender) {
        
    } forControlEvents:UIControlEventValueChanged];
    [bgView addSubview:sw];
    
    UILabel *l = [ITUIKitHelper createLabel:title size:CGSizeMake(200, bgView.frame.size.height) font:[UIFont systemFontOfSize:12] color:[ITUIKitHelper color:156 blue:164 green:161 alpha:1] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(10, 0) superViewFrame:self.view.frame];
    [bgView addSubview:l];
    
    return bgView;
}

- (void)btnCreated
{
    
    
    for (int i = 0; i < 7; i++) {
        
        UIButton *b = [[UIButton alloc] initWithFrame:CGRectMake(i * [ITUIKitHelper getAppWidth] / 7.0, 0, [ITUIKitHelper getAppWidth] / 7.0, dateBg.frame.size.height)];
        [b setTitle:[NSString stringWithFormat:@"周%@", [ITUtils num2chnDate:i + 1]] forState:UIControlStateNormal];
        b.titleLabel.font = [UIFont systemFontOfSize:10];
        b.tag = 0;
        [dateBg addSubview:b];
        [b setBackgroundImage:[UIImage imageWithColor:[ITUIKitHelper color:156 blue:164 green:161 alpha:1]] forState:UIControlStateNormal];
        [SBUIFactory decorateWithLine:b width:0.5 type:ITLineDecorateRight];
        
        [b bk_addEventHandler:^(id sender) {
            if (b.tag == 0) {[b setBackgroundImage:[UIImage imageWithColor:[ITUIKitHelper color:@"#A4D3EE"]] forState:UIControlStateNormal];b.tag = 1;}
            else {[b setBackgroundImage:[UIImage imageWithColor:[ITUIKitHelper color:156 blue:164 green:161 alpha:1]] forState:UIControlStateNormal];b.tag = 0;}
        } forControlEvents:UIControlEventTouchUpInside];
    }
    
}

@end
