
//
//  SBUpdateSegViewCell.m
//  carmarket
//
//  Created by itensb on 14-8-6.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBUpdateSegViewCell.h"
#import "SBCarCommentTblCell.h"

@implementation SBUpdateSegViewCell

- (void)createView:(UITableViewStyle)tableStyle
{
    
    if (tbView != nil) return; //保证只初始化一次
    
    SBCommentReportSegView *segmentedControl = [[SBCommentReportSegView alloc] initWithFrame:CGRectMake(20 * PJSAH, 26 * PJSAH, ([ITUIKitHelper getAppWidth] - 20 * PJSA), 68 * PJSAH) datas:[NSArray arrayWithObjects:@"口碑报告", @"好评", @"中评", @"差评", nil]];
    segmentedControl.delegate = self;
    [self.contentView addSubview:segmentedControl];
    
    [self createView:tableStyle frame:CGRectMake(0, [ITUIKitHelper yMarTopView:segmentedControl margin:10], self.frame.size.width, self.frame.size.height - 10 * 2 - segmentedControl.frame.size.height)];

    commentTbView = [[SBCommentReportTbView alloc] initWithFrame:CGRectMake(0, [ITUIKitHelper yMarTopView:segmentedControl margin:0], self.frame.size.width, self.frame.size.height - segmentedControl.frame.size.height)];
    [self.contentView addSubview:commentTbView];
    
}

#pragma - mark TableView代理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cid = @"carPickId";
    
    SBCarCommentTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
    if (!cell) cell = [[SBCarCommentTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
    [cell display:nil];
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

- (CGFloat)BKUpdateTableView:(BKUpdateTableView *)updateTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)BKUpdateTableViewDidSelectRowAtIndexPath:(BKUpdateTableView *)updateTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma - mark 其他代理
- (void)SBCommentReportSegView:(SBCommentReportSegView *)view btn:(UIButton *)btn
{
    int index = btn.tag;
    if (index == 0) {
        tbView.hidden = YES;
        commentTbView.hidden = NO;
    }
    else {
        tbView.hidden = NO;
        commentTbView.hidden = YES;
    }

}


@end
