//
//  SBCarSearchViewController.m
//  carmarket
//
//  Created by itensb on 14-8-22.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBCarSearchViewController.h"
#import "UIImage+ITColorImage.h"
#import "SBSearchHotCarTblCell.h"
#import "SBSearchResultTblCell.h"
#import "SBPickCarVCInterface.h"

@interface SBCarSearchViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UIScrollViewDelegate>
{
    UITableView *tbView;
    
    NSMutableArray *datas;
    NSMutableArray *hotDatas;
    
    UISearchBar *searchBar;
    
    BOOL isSearched;
}
@end

@implementation SBCarSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    datas = [NSMutableArray array];
    hotDatas = [NSMutableArray array];
    isSearched = NO;
    
    tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [ITUIKitHelper getAppWidth], self.cotentSize.height)];
    tbView.delegate = self;
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tbView.dataSource  = self;
    [self addSubviewInContentView:tbView];
    
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(100 * PJSAH, self.navigationBar.frame.size.height - 20 * PJSAH - 66 * PJSAH, 590 * PJSAH, 66 * PJSAH)];
    searchBar.placeholder = @"搜索车型";
    searchBar.delegate = self;
    searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    searchBar.backgroundColor = [UIColor clearColor];
    [searchBar setBackgroundImage:[UIImage imageWithColor:self.navigationBar.backgroundColor size:CGSizeMake(1, searchBar.frame.size.height)]];
    [self.navigationBar addSubview:searchBar];
    
    [SBPickCarVCInterface requestHotBrandCarSuccessBlock:^(id successValue) {
        
        hotDatas = successValue;
        [tbView reloadData];
        
    } andFailBlock:^(id failValue) {}];
    
}

#pragma -mark table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isSearched) return datas.count;
    else return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isSearched) {
        
        SBSearchResultTblCell *cell = [tableView dequeueReusableCellWithIdentifier:@"2d"];
        if (!cell) cell = [[SBSearchResultTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"2d"];
        [cell display:[datas objectAtIndex:indexPath.row]];
        return cell;
        
    }
    
    else {
        
        SBSearchHotCarTblCell *cell = [tableView dequeueReusableCellWithIdentifier:@"1d"];
        if (!cell) cell = [[SBSearchHotCarTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"1d"];
        [cell display:[NSDictionary dictionaryWithObject:hotDatas forKey:@"data"]];
        return cell;
       
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isSearched) return [SBSearchResultTblCell getHeight:nil];
    return [SBSearchHotCarTblCell getHeight:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isSearched) {
        
    }
    
    else return;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [searchBar resignFirstResponder];
}

#pragma - mark SearchBar Delegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    if (searchText.length > 0) {
        
        isSearched = YES;
        
        NSLog(@"现在搜索 ： %@", searchText);
        
        [SBPickCarVCInterface requestBrandCarSearchWithKeyword:searchText SuccessBlock:^(id successValue) {
            
            datas = successValue;
            [tbView reloadData];
            
        } andFailBlock:^(id failValue) {
        
        
        }];
        
    }
    
    else {
        isSearched = NO;
        [datas removeAllObjects];
        [tbView reloadData];
    }
    
    
}

#pragma - mark 代理函数
- (void)SBSearchHotCarTblCell_Btn:(UIButton *)btn Cell:(SBaseTableViewCell *)cell
{
    
}


@end
