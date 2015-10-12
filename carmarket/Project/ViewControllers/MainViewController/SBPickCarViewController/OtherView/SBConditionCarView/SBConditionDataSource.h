//
//  SBConditionDataSource.h
//  carmarket
//
//  Created by Apple on 14-8-30.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//
#define BUXIAN_VALUE @"-1"
#define GENGDUO_KEY @"attr"

#import <Foundation/Foundation.h>

@interface SBConditionDataSource : NSObject

+ (NSDictionary *)getBianSuXiangData;
+ (NSDictionary *)getJieGouData;
+ (NSDictionary *)getRanLiaoData;
+ (NSDictionary *)getGengDuoData;

+ (NSDictionary *)getJiaGeFanWeiData;
+ (NSArray *)getJiaGeFanWeiArray;

+ (NSDictionary *)getJiBieData;
+ (NSArray *)getJiBieArray;

+ (NSDictionary *)getGuoBieData;
+ (NSArray *)getGuoBieArray;

+ (NSDictionary *)getPaiLiangData;
+ (NSArray *)getPaiLiangArray;

+ (NSDictionary *)getGengDuoDefautParam;
+ (void)setSelectedState:(NSMutableDictionary *)selectedData targetDic:(NSDictionary *)dict;
+ (void)setSelectedState:(NSMutableDictionary *)selectedData;
+ (void)setMulSelectedState:(NSArray *)datas;

@end
