//
//  BKAlterView.h
//  PregnancyParter
//
//  Created by 显宏 黄 on 12-7-11.
//  Copyright (c) 2012年 beikr.com. All rights reserved.
//

#define TankWidth 150
#define TankHeight 120

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum {
    BKMsgInfo, //信息
    BKMsgError, //错误
    BKMsgTblIndex
} BKMsg;

@interface BKAlertView : UIView

@property(nonatomic,retain) UILabel *msglabel;

+(void)showMsg:(NSString *)msg type:(BKMsg)type inview:(UIView*)inview offsetY:(float)offsetY;
+(void)showInfoMsg:(NSString *)msg inview:(UIView*)inview offsetY:(float)offsetY;
+(void)showErrorMsg:(NSString *)msg inview:(UIView*)inview offsetY:(float)offsetY;
+(void)showTblIndexMsg:(NSString *)msg inview:(UIView*)inview offsetY:(float)offsetY;

+ (BOOL)isExisting;

@end
