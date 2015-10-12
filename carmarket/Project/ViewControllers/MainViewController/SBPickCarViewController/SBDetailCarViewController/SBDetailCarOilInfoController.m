//
//  SBDetailCarOilInfoController.m
//  carmarket
//
//  Created by itensb on 14-8-26.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBDetailCarOilInfoController.h"
#import "BKUpdateTableView.h"
#import "SBOilTblCell.h"
#import "SBPickCarVCInterface.h"

@interface SBDetailCarOilInfoController () <BKUpdateTableViewProcessingDelegate, UITableViewDataSource>
{
    NSMutableArray *datas;
}
@end

@implementation SBDetailCarOilInfoController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setTitleWithImage:[UIImage imageNamed:@"icon_titleyouhao"]];
    
    datas = [NSMutableArray array];
    
    BKUpdateTableView *tbView = [[BKUpdateTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.cotentSize.height) style:UITableViewStylePlain updateType:BKUpdateTableViewTypeNoUpdate];
    tbView.dataSource = self;
    tbView.backgroundColor = [UIColor clearColor];
    tbView.processingDelegate = self;
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubviewInContentView:tbView];
    
    NSString *brandId = [[SBRequestParamBus instance] getParamWith:self key:@"brandId"];
    NSString *carId = [[SBRequestParamBus instance] getParamWith:self key:@"carId"];
    
    [SBPickCarVCInterface requestCarOilCostWith:brandId model:carId SuccessBlock:^(id successValue) {
        
        datas = successValue;
        
        [tbView reloadData];
        
    } andFailBlock:^(id failValue) {
        
    }];
}

#pragma - mark TableView代理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *id1 = @"d1";
    SBOilTblCell *cell = [tableView dequeueReusableCellWithIdentifier:id1];
    if (!cell) cell = [[SBOilTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id1];
    [cell display:[datas objectAtIndex:indexPath.row]];
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return datas.count;
}

- (CGFloat)BKUpdateTableView:(BKUpdateTableView *)updateTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == datas.count - 1) return [SBOilTblCell getHeight:nil] + 20;
    return [SBOilTblCell getHeight:nil];
}


@end
