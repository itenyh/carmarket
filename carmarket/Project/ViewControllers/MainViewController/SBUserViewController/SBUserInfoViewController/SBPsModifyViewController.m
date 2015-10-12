//
//  SBPsModifyViewController.m
//  carmarket
//
//  Created by itensb on 14-12-5.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBPsModifyViewController.h"
#import "BKUpdateTableView.h"

#import "SBUserInfoInputTblCell.h"
#import "SBColoredBtnTblCell.h"

#import "SBActivityVCInterface.h"
#import "SBUserDataInterface.h"

@interface SBPsModifyViewController () <BKUpdateTableViewDelegate, BKUpdateTableViewProcessingDelegate, UITableViewDataSource>
{
    BKUpdateTableView *tbView;
}
@end

@implementation SBPsModifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"密码修改";
    
    tbView = [[BKUpdateTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.cotentSize.height) style:UITableViewStyleGrouped updateType:BKUpdateTableViewTypeNoUpdate];
    tbView.dataSource = self;
    tbView.backgroundColor = [UIColor clearColor];
    tbView.processingDelegate = self;
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubviewInContentView:tbView];
    
}

#pragma - mark TableView代理
- (CGFloat)BKUpdateTableView:(BKUpdateTableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
  
        NSString *cid = @"1id";
        SBUserInfoInputTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
        if (!cell) cell = [[SBUserInfoInputTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
        if (indexPath.row == 0) [cell display:@"" title:@"旧密码" isEditable:YES isSecury:YES placeholder:nil];
        if (indexPath.row == 1) [cell display:@"" title:@"新密码" isEditable:YES isSecury:YES placeholder:@"请输入至少6位字符"];
        if (indexPath.row == 2) [cell display:@"" title:@"确认新密码" isEditable:YES isSecury:YES placeholder:@"请输入至少6位字符"];
        
        return cell;
        
    }
    
    else {
        
        NSString *cid = @"2id";
        SBColoredBtnTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
        if (!cell) cell = [[SBColoredBtnTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
        [cell display:nil title:@"确认" type:2];
        return cell;
        
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return 3;
    else return 1;
}

- (CGFloat)BKUpdateTableView:(BKUpdateTableView *)updateTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) return [SBUserInfoInputTblCell getHeight:nil];
    else return [SBColoredBtnTblCell getHeight:nil];
}

- (void)BKUpdateTableViewDidSelectRowAtIndexPath:(BKUpdateTableView *)updateTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma - mark 其他代理
- (void)SBUserInfoLogOutTblCell_LogOut:(SBaseTableViewCell *)cell
{
    SBUserInfoInputTblCell *c1 = (SBUserInfoInputTblCell *)[tbView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    SBUserInfoInputTblCell *c2 = (SBUserInfoInputTblCell *)[tbView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    SBUserInfoInputTblCell *c3 = (SBUserInfoInputTblCell *)[tbView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    
    NSString *old = [c1 getContent];
    NSString *new = [c2 getContent];
    NSString *sure = [c3 getContent];
    
    if (new.length == 0 || old.length == 0 || sure.length == 0) [self showErrorMessageOnCenter:@"请完善信息"];
    else {
        if (![sure isEqualToString:new]) [self showErrorMessageOnCenter:@"密码输入不一致"];
        else {
            NSDictionary *info = [SBUserDataInterface getInfo];
            [SBActivityVCInterface requestPsModify:old new:new phone:[info objectForKey:@"userPhone"] uid:[info objectForKey:@"userId"] SuccessBlock:^(id successValue) {
               
                int state = [[successValue objectForKey:@"state"] integerValue];
//                NSLog(@"aaaa : %@", [successValue objectForKey:@"message"]);
                NSString *me = [successValue objectForKey:@"message"];
                if (state == -1) [self showErrorMessageOnCenter:[me stringByReplacingOccurrencesOfString:@"。" withString:@""]];
                else {
                    [self showInfoMessageOnCenter:@"修改成功"];
                    [self performSelector:@selector(popViewController) withObject:nil afterDelay:1];
                }
                
                
            } andFailBlock:^(id failValue) {
                
                [self showErrorMessageOnCenter:@"修改失败"];
                
            }];
        }
    }
    
    
}

@end
