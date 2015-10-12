//
//  SBConditionDataSource.m
//  carmarket
//
//  Created by Apple on 14-8-30.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBConditionDataSource.h"

static NSDictionary *jiagefanwei;
static NSDictionary *jibie;
static NSDictionary *guobie;
static NSDictionary *pailiang;

static NSDictionary *biansuxiang;
static NSDictionary *jiegou;
static NSDictionary *ranliao;
static NSDictionary *gengduo;

@implementation SBConditionDataSource

+ (NSDictionary *)getBianSuXiangData
{
    if (!biansuxiang) biansuxiang = [SBConditionDataSource get:@"变速箱#t" items:[NSArray arrayWithObjects:@"不限", BUXIAN_VALUE, @"自动", @"1", @"手动", @"2", nil]];
    return biansuxiang;
}

+ (NSDictionary *)getJieGouData
{
    if (!jiegou) jiegou = [SBConditionDataSource get:@"结构#s" items:[NSArray arrayWithObjects:@"不限", BUXIAN_VALUE, @"两厢", @"1", @"三厢", @"2", @"旅行", @"3", nil]];
    return jiegou;
}

+ (NSDictionary *)getRanLiaoData
{
    if (!ranliao) ranliao = [SBConditionDataSource get:@"燃料#fuel" items:[NSArray arrayWithObjects:@"不限", BUXIAN_VALUE, @"汽油", @"1", @"柴油", @"2", @"油气混合", @"3", @"纯电动", @"4", @"油电混合", @"5", nil]];
    return ranliao;
}

+ (NSDictionary *)getGengDuoData
{
    if (!gengduo) gengduo = [SBConditionDataSource get:@"更多#attr" items:[SBConditionDataSource getGengDuoArray]];
    return gengduo;
}

+ (NSArray *)getGengDuoArray
{
    return [NSArray arrayWithObjects:@"定速巡航", @"0", @"GPS导航", @"1", @"车载冰箱", @"2", @"倒车雷达", @"3", @"倒车影像", @"4", @"遥控钥匙", @"5", @"车载电话", @"0", @"CD", @"1", @"DVD", @"2", @"空调", @"3", @"儿童锁", @"4", @"蓝牙系统", @"5", nil];
}

//------------------ list ---------------------
+ (NSDictionary *)getJiaGeFanWeiData
{
    if (!jiagefanwei) jiagefanwei = [SBConditionDataSource get:@"??#p" items:[SBConditionDataSource getJiaGeFanWeiArray]];
    return jiagefanwei;
}

+ (NSArray *)getJiaGeFanWeiArray
{
    return [NSArray arrayWithObjects:@"不限", BUXIAN_VALUE, @"3万内", @"0,3", @"3-5万", @"3,5", @"5-8万", @"5,8", @"8-12万", @"8,12", @"12-18万", @"12,18", @"18-25万", @"18,25", @"25-40万", @"25,40", @"40-80万", @"40,80", @"80-100万", @"80,100", @"100万以上", @"100,-1",nil];
}

+ (NSDictionary *)getJiBieData
{
    if (!jibie) jibie = [SBConditionDataSource get:@"??#lv" items:[SBConditionDataSource getJiBieArray]];
    return jibie;
}

+ (NSArray *)getJiBieArray
{
    return [NSArray arrayWithObjects:@"不限", BUXIAN_VALUE, @"微型车", @"1", @"小型车", @"2", @"紧凑型车", @"3", @"中型车", @"4", @"中大型车", @"5", @"豪华车", @"6", @"MPV", @"7", @"SUV", @"8", @"跑车", @"9", @"皮卡", @"10", @"面包车", @"11", nil];
}

+ (NSDictionary *)getGuoBieData
{
    if (!guobie) guobie = [SBConditionDataSource get:@"??#gb" items:[SBConditionDataSource getGuoBieArray]];
    return guobie;
}

+ (NSArray *)getGuoBieArray
{
    return [NSArray arrayWithObjects:@"不限", BUXIAN_VALUE, @"自主", @"1", @"合资", @"2", @"进口", @"3", @"德系", @"4", @"日系", @"5", @"韩系", @"6", @"美系", @"7", @"欧系", nil];
}

+ (NSDictionary *)getPaiLiangData
{
    if (!pailiang) pailiang = [SBConditionDataSource get:@"??#pl" items:[SBConditionDataSource getPaiLiangArray]];
    return pailiang;
}

+ (NSArray *)getPaiLiangArray
{
    return [NSArray arrayWithObjects:@"不限", BUXIAN_VALUE, @"1.3升以下", @"0,1.3", @"1.3-1.6升", @"1.3,1.6", @"1.7-2.0升", @"1.7,2.0", @"2.1-3.0升", @"2.1,3.0", @"3.1-5.0升", @"3.1,5.0", @"5.0升以上", @"5.0,-1", nil];
}

#pragma - mark 辅助函数
+ (NSDictionary *)get:(NSString *)_title items:(NSArray *)_items
{
    NSMutableArray *items = [SBConditionDataSource getItems:_items key:[[_title componentsSeparatedByString:@"#"] objectAtIndex:1]];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:items, @"data", [[_title componentsSeparatedByString:@"#"] objectAtIndex:0], @"title", nil];
    
    return dic;
}

+ (NSMutableArray *)getItems:(NSArray *)datas key:(NSString *)key
{
    NSMutableArray *result = [NSMutableArray array];
    
    NSString *title = nil;
    NSString *value = nil;
    
    for (int i = 0 ; i < datas.count; i++) {
        
        NSString *obj = [datas objectAtIndex:i];
        
        if (title) {
            value = obj;
            [result addObject:[SBConditionDataSource getItem:title value:value key:key]];
            title = nil;value = nil;
        }
        else {
            title = obj;
        }
        
    }
    
    return result;
}

+ (NSMutableDictionary *)getItem:(NSString *)title value:(NSString *)value key:(NSString *)key
{
    //默认选中第一项
    NSString *selected = @"0";
    if ([value isEqualToString:BUXIAN_VALUE]) selected = @"1";
        
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:title, @"title", value, @"value", key, @"key", selected, @"selected", nil];
}

#pragma - mark 公共辅助函数
+ (NSDictionary *)getGengDuoDefautParam
{
    NSArray *arr = [SBConditionDataSource getGengDuoArray];
    NSMutableString *value = [NSMutableString string];
    for (int i = 0; i < arr.count / 2; i++) {
        [value appendString:@"0"];
    }
    return [NSDictionary dictionaryWithObject:value forKey:GENGDUO_KEY];
}

+ (void)setSelectedState:(NSMutableDictionary *)selectedData targetDic:(NSDictionary *)dict
{
    NSMutableArray *items = [dict objectForKey:@"data"];
    for (NSMutableDictionary *dict in items) {
        if (dict == selectedData) [dict setObject:@"1" forKey:@"selected"];
        else [dict setObject:@"0" forKey:@"selected"];
    }
}

+ (void)setSelectedState:(NSMutableDictionary *)selectedData
{
    NSString *key = [selectedData objectForKey:@"key"];
    
    if ([key isEqualToString:@"t"]) [SBConditionDataSource setSelectedState:selectedData targetDic:[SBConditionDataSource getBianSuXiangData]];
    if ([key isEqualToString:@"s"]) [SBConditionDataSource setSelectedState:selectedData targetDic:[SBConditionDataSource getJieGouData]];
    if ([key isEqualToString:@"fuel"]) [SBConditionDataSource setSelectedState:selectedData targetDic:[SBConditionDataSource getRanLiaoData]];
    
}

//针对多选的状态改变
+ (void)setMulSelectedState:(NSArray *)datas
{
    NSDictionary *dict = [SBConditionDataSource getGengDuoData];
    NSMutableArray *items = [dict objectForKey:@"data"];
    for (NSMutableDictionary *dict in items) {
        if ([datas containsObject:dict]) [dict setObject:@"1" forKey:@"selected"];
        else [dict setObject:@"0" forKey:@"selected"];
    }

}

@end
