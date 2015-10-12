//
//  SBLowPriceTblView.m
//  carmarket
//
//  Created by itensb on 14-11-6.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "BKDatasTblView.h"
#import "SBaseTableViewCell.h"
#import "SBLowPriceCarCell.h"

@interface BKDatasTblView () <BKUpdateTableViewDelegate, UITableViewDataSource, BKUpdateTableViewProcessingDelegate>
{
    NSMutableDictionary *infos;
    Class cellClass;
    float cellHeight;

}
@end

@implementation BKDatasTblView

- (id)initWithFrame:(CGRect)frame updateType:(BKUpdateTableViewType)updateType cellClass:(Class)_class
{
    self = [super initWithFrame:frame style:UITableViewStylePlain updateType:updateType tip:nil];
    
    if (self) {
        
        infos = [NSMutableDictionary dictionary];
        
        self.dataSource = self;
        self.backgroundColor = [UIColor clearColor];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;

        cellClass = _class;
        [self registerClass:_class forCellReuseIdentifier:NSStringFromClass(cellClass)];
        
    }
    
    return self;
}

- (void)reloadWithData:(id)_data
{
    infos = _data;
    [self reloadData];
}

#pragma - mark TableView代理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(cellClass) forIndexPath:indexPath];
    [cell display:[infos objectForKey:@"data"][indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ((NSArray *)[infos objectForKey:@"data"]).count;
}

- (BOOL)isEmpty
{
    return ((NSArray *)[infos objectForKey:@"data"]).count == 0;
}


@end
