//
//  SBUMSocialKit.h
//  carmarket
//
//  Created by YangHan on 15/1/16.
//  Copyright (c) 2015年 chinaCQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UMSocial.h"
#import "UMSocialSnsService.h"
#import "SBBaseViewController.h"

@interface SBUMSocialKit : NSObject

@property (nonatomic, strong) SBBaseViewController *controller;

+ (SBUMSocialKit *)instance;

- (void)register_SBUMSocialKit;
- (void)start:(SBBaseViewController *)controller;

@end
