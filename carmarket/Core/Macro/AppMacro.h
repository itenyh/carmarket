//
//  AppMacro.h
//  CoacoapodsDemo
//
//  Created by Apple on 14-7-22.
//  Copyright (c) 2014年 itenyhCom. All rights reserved.
//
#define gMainQueueT dispatch_get_main_queue()
#define gAsynQueueT dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

#define IT_SYSTEM_VERSION [[UIDevice currentDevice] systemVersion]
#define IT_APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define IT_INTERFACE_VERSION @"1"
#define IT_PHONE_MODEL [[UIDevice currentDevice] model]
#define IT_UUID_APP [[NSUUID UUID] UUIDString]

//[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]