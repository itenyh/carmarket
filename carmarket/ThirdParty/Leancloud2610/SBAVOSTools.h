//
//  SBAVOSTools.h
//  carmarket
//
//  Created by itensb on 15-1-13.
//  Copyright (c) 2015年 chinaCQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBAVOSTools : NSObject

@property(nonatomic, strong) NSMutableDictionary *ad_img_dict; //广告业面的异步图片

+ (SBAVOSTools *)instance;

- (void)test_insert_data;
- (void)test_insert_img;
- (void)test_get_img;

- (void)register_SBAVOSTools;
- (NSMutableDictionary *)start_loading_ads;
- (BOOL)is_ads_ready;
- (NSMutableDictionary *)get_ad_images;

@end
