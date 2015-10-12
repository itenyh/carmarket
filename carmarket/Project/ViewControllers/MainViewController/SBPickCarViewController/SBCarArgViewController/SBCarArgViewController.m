//
//  SBCarArgViewController.m
//  carmarket
//
//  Created by itensb on 14-11-11.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#define SECTION_HEIGHT 60 * PJSAH

#import "SBCarArgViewController.h"
#import "SBCarArgTblCell.h"
#import "SBPickCarVCInterface.h"

#import "SBJson.h"

@interface SBCarArgViewController () <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *tbView;
    NSMutableDictionary *oInfo;
    NSArray *sections;
}
@end

@implementation SBCarArgViewController
@synthesize tbView;

- (id)initWithNavi:(BOOL)navi leftBtnType:(NDLeftBtnType)type
{
    self = [super initWithNavi:navi leftBtnType:type];
    
    if (self) {
        
        self.view.frame = CGRectMake(0, 0, [ITUIKitHelper getAppWidth], [ITUIKitHelper getAppHeight]);
        
    }
    
    
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"参数配置";
    
    oInfo = [NSMutableDictionary dictionary];
    sections = [NSArray array];
    
    tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [ITUIKitHelper getAppWidth], self.cotentSize.height) style:UITableViewStylePlain];
    [self addSubviewInContentView:tbView];
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tbView.delegate = self;
    tbView.dataSource = self;

}

- (void)requestNetWork
{
    
//    NSString *brandId = [[SBRequestParamBus instance] getParamWith:self key:@"brandId"];
//    NSString *modelId = [[SBRequestParamBus instance] getParamWith:self key:@"modelId"];
    NSString *carStyle = [[SBRequestParamBus instance] getParamWith:self key:@"carStyle"];
    
    [SBPickCarVCInterface requestAttributeCarStyle:carStyle SuccessBlock:^(id successValue) {
        
        [self deal_net_data:successValue];
        
    } andFailBlock:^(id failValue) {
        
    }];

}

- (void)deal_net_data:(id)net_data
{
    NSArray *keys = [net_data allKeys];
    for (NSString *key in keys) {
        
        NSString *value = [net_data objectForKey:key];
        
        //            NSLog(@"value : %@", value);
        
        if ([value isKindOfClass:[NSString class]]) {
            
            
            NSError *error = nil;
            NSDictionary *JSON =
            [NSJSONSerialization JSONObjectWithData: [value dataUsingEncoding:NSUTF8StringEncoding]
                                            options: NSJSONReadingMutableContainers
                                              error: &error];
            
            if (JSON && [JSON isKindOfClass:[NSDictionary class]]) {
                [oInfo setValue:JSON forKey:key];
            }
        }
        
    }
    
    sections = [oInfo allKeys];
    sections = [self sortSection:sections];
    
    [tbView reloadData];
}

#pragma - mark tabelView delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cid1 = @"id1";
    SBCarArgTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid1];
    if (!cell) {
        cell = [[SBCarArgTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid1];
    }
    
    NSDictionary *info = [oInfo objectForKey:sections[indexPath.section]];
    NSArray *keys = [info allKeys];
    
    NSString *key = keys[indexPath.row];
    NSString *value = [info objectForKey:key];
    if (!value || value.length == 0) value = @"-";
    
    [cell displayWith:key value:value];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [SBCarArgTblCell getHeight:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *info = [oInfo objectForKey:sections[section]];
    return [info allKeys].count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [ITUIKitHelper getAppWidth], SECTION_HEIGHT)];
    view.backgroundColor = [ITUIKitHelper color:@"faf4f6" alpha:0.9];
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, [ITUIKitHelper getAppWidth] - 20, SECTION_HEIGHT)];
    l.font = [UIFont systemFontOfSize:30 * PJSAH];
    l.textColor = [ITUIKitHelper color:@"757575"];
    l.backgroundColor = [UIColor clearColor];
    l.shadowColor = [UIColor whiteColor];
    l.shadowOffset = CGSizeMake(5, 5);
    [view addSubview:l];
  
    l.text = [self sectionEn2Chn:sections[section]];
    
    [SBUIFactory decorateWithLine:view width:0.5 type:ITLineDecorateUpDown];
  
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return SECTION_HEIGHT;
}

#pragma - mark 数据处理
- (NSString *)sectionEn2Chn:(NSString *)key
{
    NSDictionary *en2chn = [NSDictionary dictionaryWithObjectsAndKeys:@"安全配置", @"safetyConfig", @"基本信息", @"carBaseInfo", @"基本性能", @"carBaseFun", @"车身结构", @"carStructure", @"外部配置", @"extemalConfig", @"内部尺寸" ,@"internalSize", @"外部尺寸", @"externalSize", @"影音空调", @"audio", @"便利功能", @"convenienceFun", @"其他配置", @"otherConfig", @"内饰", @"trim", @"燃油&发动机", @"fuelEngine" , @"底盘操控", @"control" ,nil];
    
    NSString *result = [en2chn objectForKey:key];
    
    return result == nil ? key : result;
}

- (NSArray *)sortSection:(NSArray *)_sections
{
    NSArray *target = [NSArray arrayWithObjects:@"基本信息", @"基本性能", @"车身结构", @"安全配置", @"外部配置", @"其他配置", @"内部尺寸", @"外部尺寸",  @"影音空调",  @"便利功能", @"内饰",  @"燃油&发动机", @"底盘操控", nil];
    
    NSMutableArray *result = [NSMutableArray array];
    
    for (NSString *s in target) {
        
        for (NSString *s1 in _sections) {
            
            NSString *chn = [self sectionEn2Chn:s1];
            
            if ([s isEqualToString:chn]) {
        
                [result addObject:s1];
                break;

            }
            
        }
        
    }
    
    //如果有没有加入到result里面的，补进去
    for (NSString *s in _sections) {
        
        BOOL find = NO;
        
        for (NSString *s1 in result) {
            
            if ([s1 isEqualToString:s]) {
                
                find = YES;
                break;
            }
            
        }
        
        if (!find) {
            NSLog(@"============== 补加一个数据 注意检查 : %@", s);
            [result addObject:s];
        }
        
    }
    
    return [NSArray arrayWithArray:result];
    
}

- (BOOL)shouldAutorotate
{
    return NO;
}


@end
