//
//  SBCompareDetailViewController.m
//  carmarket
//
//  Created by itensb on 14-11-4.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#define SECTION_HEIGHT 60 * PJSAH

#import "SBCompareDetailViewController.h"
#import "SBCarCompareTblCell.h"

//关于数据的协议：所有项必须有

@interface SBCompareDetailViewController () <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *tbView;
    
    NSMutableArray *sections;
//    NSMutableArray *datas;
    NSMutableArray *cars;
}
@end

@implementation SBCompareDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    sections = [NSMutableArray array];
//    datas = [NSMutableArray array];
    cars = [NSMutableArray array];
    
    self.title = @"车型对比";
    
    tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [ITUIKitHelper getAppWidth], self.cotentSize.height) style:UITableViewStylePlain];
    [self addSubviewInContentView:tbView];
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tbView.delegate = self;
    tbView.dataSource = self;
    
    [self reloadWithData:nil];
    
}

- (void)reloadWithData:(id)_data
{
//    originalData : [s1 : [p1 : p , p2 : p], s2 : [p1 : p , p2 : p]];
    
    NSDictionary *price = [NSDictionary dictionaryWithObject:@"31.28万" forKey:@"厂家指导价"];
    NSDictionary *bianshuxiang = [NSDictionary dictionaryWithObject:@"8档，CVT无极变速" forKey:@"变速箱形式"];
    NSArray *proArr = [NSArray arrayWithObjects:price, bianshuxiang, nil];
    NSDictionary *d11 = [NSDictionary dictionaryWithObjectsAndKeys:proArr, @"基本信息", nil];
    
    NSDictionary *zOil = [NSDictionary dictionaryWithObject:@"6.2 L/100km" forKey:@"综合工况耗油"];
    NSDictionary *sOil = [NSDictionary dictionaryWithObject:@"8.60 L/100km" forKey:@"市区工况耗油"];
    NSArray *Oils = [NSArray arrayWithObjects:zOil, sOil, nil];
    NSDictionary *d12 = [NSDictionary dictionaryWithObjectsAndKeys:Oils, @"基本性能", nil];
    
    NSMutableArray *originalData1 = [NSMutableArray arrayWithObjects:d11, d12, nil];
    
    //获取section
    for (NSDictionary *dic in originalData1) {
        NSArray *pKeys = [dic allKeys];
        [sections addObject:(pKeys.count > 0 ? pKeys[0] : @"~")];
    }
    
    [cars addObject:originalData1];
    
    price = [NSDictionary dictionaryWithObject:@"31.28万" forKey:@"厂家指导价"];
    bianshuxiang = [NSDictionary dictionaryWithObject:@"9档，CVT无极变速" forKey:@"变速箱形式"];
    proArr = [NSArray arrayWithObjects:price, bianshuxiang, nil];
    d11 = [NSDictionary dictionaryWithObjectsAndKeys:proArr, @"基本信息", nil];
    
    zOil = [NSDictionary dictionaryWithObject:@"6.1 L/100km" forKey:@"综合工况耗油"];
    sOil = [NSDictionary dictionaryWithObject:@"8.60 L/100km" forKey:@"市区工况耗油"];
    Oils = [NSArray arrayWithObjects:zOil, sOil, nil];
    d12 = [NSDictionary dictionaryWithObjectsAndKeys:Oils, @"基本性能", nil];
    
    NSMutableArray *originalData2 = [NSMutableArray arrayWithObjects:d11, d12, nil];
    
    [cars addObject:originalData2];
    
}

#pragma - mark tabelView delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cid1 = @"id1";
    SBCarCompareTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid1];
    if (!cell) {
        cell = [[SBCarCompareTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid1];
    }
    
//    NSArray *properties = [datas objectForKey:sections[indexPath.section]];
    
    NSArray *a1 = cars[0];
    NSArray *a2 = cars[1];
    
    NSArray *properties = [a1[indexPath.section] objectForKey:sections[indexPath.section]];
    NSDictionary *property = properties[indexPath.row];
    
    properties = [a2[indexPath.section] objectForKey:sections[indexPath.section]];
    NSDictionary *property1 = properties[indexPath.row];
    
    [cell displayWithTitle:[property allKeys][0] p1:[property allValues][0] p2:[property1 allValues][0]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [SBCarCompareTblCell getHeight:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (cars.count <= 0) return 0;
    return sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSArray *properties = [datas objectForKey:sections[section]];
    if (cars.count <= 0) return 0;
    NSArray *properties = [cars[0][section] objectForKey:sections[section]];
    return properties.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [ITUIKitHelper getAppWidth], SECTION_HEIGHT)];
    view.backgroundColor = [ITUIKitHelper color:@"faf4f6" alpha:0.5];
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, [ITUIKitHelper getAppWidth] - 20, SECTION_HEIGHT)];
    l.font = [UIFont systemFontOfSize:30 * PJSAH];
    l.textColor = [ITUIKitHelper color:@"757575"];
    l.backgroundColor = [UIColor clearColor];
    [view addSubview:l];
    
    [SBUIFactory decorateWithLine:view width:0.5 type:ITLineDecorateUpDown];
    
    l.text = sections[section];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return SECTION_HEIGHT;
}

@end
