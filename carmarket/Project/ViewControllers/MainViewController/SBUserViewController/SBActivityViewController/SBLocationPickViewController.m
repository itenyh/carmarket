//
//  SBLocationPickViewController.m
//  carmarket
//
//  Created by itensb on 14-8-19.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBLocationPickViewController.h"
#import <AMapSearchKit/AMapSearchAPI.h>
#import "ITMapSearcher.h"
#import "ITMapper.h"

#import "SBMapActivityViewController.h"
#import "SBLocPickViewTblCell.H"

@interface SBLocationPickViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
{
    NSMutableArray *datas;
    UITableView *tbView;
    UISearchBar *searchBar;
    NSMutableDictionary *info;
    
    NSString *navTitle;
    
    BOOL is_inner;
    
}
@end

@implementation SBLocationPickViewController

- (id)initWithNavi:(BOOL)navi handler:(InfoHandler)_handler leftBtnType:(NDLeftBtnType)type navTitle:(NSString *)_navTitle
{
    self = [super initWithNavi:navi handler:_handler leftBtnType:type];
    
    if (self) {
        
        navTitle = _navTitle;
        is_inner = NO;
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    datas = [NSMutableArray array];
    info = [NSMutableDictionary dictionary];
    
    if (navTitle) self.title = navTitle;
    else [self setTitleWithImage:[UIImage imageNamed:@"icon_titledidianxuanzhe"]];
    
    tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [ITUIKitHelper getAppWidth], self.cotentSize.height)];
    tbView.delegate = self;
    tbView.dataSource  = self;
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubviewInContentView:tbView];
    
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, 40)];
    searchBar.placeholder = @"输入地点";
    searchBar.delegate = self;
    tbView.tableHeaderView = searchBar;
    searchBar.autocorrectionType = UITextAutocorrectionTypeNo;

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [searchBar performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.3];
    
}

#pragma -mark table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SBLocPickViewTblCell *cell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (!cell) {
        cell = [[SBLocPickViewTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"activityCell"];
        
    }
    
    AMapTip *tip = datas[indexPath.row];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:tip.name, @"name", tip.district, @"district", nil];
    
    [cell display:dic];
 
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AMapTip *tip = datas[indexPath.row];
    
    [info setObject:tip.name forKey:@"name"];
    NSString *key = [info objectForKey:@"name"];
    
    [[ITMapSearcher instance] GDSearchGeocodeWithKey:key adcode:tip.adcode searchResult:^(AMapGeocodeSearchResponse *response) {
        
        if(response.count > 0) {
            
            if (response.count > 1 && is_inner == NO) {
                
                is_inner = YES;
                
                NSMutableArray *preciousTips = [NSMutableArray array];
                for (AMapGeocode *geo in response.geocodes) {
                    [preciousTips addObject:[AMapTip tipWithName:geo.formattedAddress adcode:geo.adcode district:geo.district]];
                }
                datas = preciousTips;
                [tbView reloadData];
                
                [searchBar resignFirstResponder];
                
            }
            
            else {
            
                AMapGeocode *geo = response.geocodes[0];
                
                [info setObject:[NSString stringWithFormat:@"%f", geo.location.latitude] forKey:@"latitude"];
                [info setObject:[NSString stringWithFormat:@"%f", geo.location.longitude] forKey:@"longitude"];
                [info setObject:geo.formattedAddress forKey:@"name"];
                [info setObject:[NSString stringWithFormat:@"%@%@", geo.city, geo.district] forKey:@"add"];
                
//                NSLog(@"lon : %f lat : %f", geo.location.longitude, geo.location.latitude);
                
                self.handler(info);
                
                [self popViewController];
                
            }
            
            
        }
        
        else [self showErrorMessageOnCenter:@"无效地点"];
        
    }];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [searchBar resignFirstResponder];
}

#pragma - mark 键盘代理
- (void)searchBarSearchButtonClicked:(UISearchBar *)_searchBar
{
    [_searchBar resignFirstResponder];
}

#pragma - mark SearchBar Delegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    is_inner = NO;
    
    if (searchText.length > 0) {
        
        [[ITMapSearcher instance] GDSearchTipsWithKey:searchText searchResult:^(AMapInputTipsSearchResponse *response) {
            
            datas = [response.tips mutableCopy];
            [tbView reloadData];
            
        }];
        
    }
    
    else {
        
        [datas removeAllObjects];
        [tbView reloadData];
        
    }
}


@end
