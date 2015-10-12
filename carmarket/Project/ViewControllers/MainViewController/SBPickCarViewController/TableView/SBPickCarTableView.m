//
//  SBPickCarTableView.m
//  carmarket
//
//  Created by itensb on 14-8-5.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#define SECTION_HEIGHT 60 * PJSAH

#import "SBPickCarTableView.h"
#import "PinYin4Objc.h"
#import "SBHotBrandCell.h"
#import "SBCarSaveTblCell.h"
#import "SBBrandNameTblCell.h"

@interface  SBPickCarTableView () <BKUpdateTableViewDelegate, BKUpdateTableViewProcessingDelegate, UITableViewDataSource, SBHotBrandCellDelegate>
{
    NSMutableDictionary* objectsByLetter;
    NSMutableArray* filteredAlphabet;
}

@end

@implementation SBPickCarTableView
@synthesize data, hotdata, targetVC;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame style:UITableViewStylePlain updateType:BKUpdateTableViewTypeOnlyRefresh];
    
    if (self) {
        
        data = [NSMutableArray array];
        hotdata = [NSDictionary dictionary];
        
        self.dataSource = self;
        self.backgroundColor = [UIColor clearColor];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.pullUpdateDelegate  = self;
        self.processingDelegate = self;
        
        objectsByLetter = [NSMutableDictionary dictionary];
        filteredAlphabet = [NSMutableArray array];
        
    }
    
    return self;
}

- (void)setData:(NSMutableArray *)_data
{
    [objectsByLetter removeAllObjects];
    [filteredAlphabet removeAllObjects];
    
    data = _data;
    
    //添加拼音
    for (NSMutableDictionary *d in data) {
//        NSString *pname = [self toPinYin:[d objectForKey:@"name"]];
        NSString *pname = [d objectForKey:@"type"];
        [d setObject:pname forKey:@"pname"];
    }
    
    [self sortByAlphabet7CreateRelated:data];
    
    [self reloadData];
    
}

- (void)setHotdata:(NSDictionary *)_hotdata
{
    hotdata = _hotdata;
    [self reloadData];
}

- (NSString *)toPinYin:(NSString *)sourceText
{
    HanyuPinyinOutputFormat *outputFormat=[[HanyuPinyinOutputFormat alloc] init];
    [outputFormat setToneType:ToneTypeWithoutTone];
    [outputFormat setVCharType:VCharTypeWithV];
    [outputFormat setCaseType:CaseTypeLowercase];
    
    NSString *outputPinyin = [PinyinHelper toHanyuPinyinStringWithNSString:sourceText withHanyuPinyinOutputFormat:outputFormat withNSString:@" "];

    return outputPinyin;
    
}

- (void)sortByAlphabet7CreateRelated:(NSArray*)array {
    
    NSComparator sort = ^(NSMutableDictionary* a, NSMutableDictionary* b) {
        return [[a objectForKey:@"pname"] compare:[b objectForKey:@"pname"]];
    };
    
    for(NSMutableDictionary *object in array) {
        NSString *letter = [self keyOnPath:@"title" forObject:[object objectForKey:@"pname"]];
        NSMutableArray *objects = [objectsByLetter objectForKey:letter];
        if(!objects) {
            objects = [NSMutableArray array];
            [objectsByLetter setObject:objects forKey:letter];
        }
        [objects addObject:object];
    }
    
    [objectsByLetter enumerateKeysAndObjectsUsingBlock:^(NSString* letter, NSMutableArray* objects, BOOL *stop) {
        [objects sortUsingComparator:sort];
    }];
    
    [self updateFilteredArray];
}

- (void)updateFilteredArray {
    
    [filteredAlphabet addObject:@"#"]; //#对应表顶
    
    NSArray* lettersInUse = [objectsByLetter allKeys];
    NSArray *temp = [lettersInUse sortedArrayUsingComparator:^(NSString* a, NSString* b) {
        return [a compare:b];
    }];
    
    [filteredAlphabet addObjectsFromArray:temp];
}

- (NSString*)keyOnPath:(NSString*)path forObject:(NSString *)object {
    
    // some titles won't start with a letter or have
    // a number or a weird character.  in this case we'll
    // dump them into the empty space section
    
    static NSCharacterSet *s = nil;
    
    if(!s) s = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"];
    
    NSString* letter = nil;
    if([object length]) {
        letter = [[object substringToIndex:1] uppercaseString];
    } else {
        letter = @" ";
    }
    
    NSRange r = [letter rangeOfCharacterFromSet:s];
    
    if(r.location == NSNotFound) {
        letter = @" ";
    }
    
    return letter;
}

#pragma - mark TableView代理
- (CGFloat)BKUpdateTableView:(BKUpdateTableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) return 0;
    
    return SECTION_HEIGHT;
}

- (UIView *)BKUpdateTableView:(BKUpdateTableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) return nil;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [ITUIKitHelper getAppWidth], SECTION_HEIGHT)];
    view.backgroundColor = [ITUIKitHelper color:@"faf4f6"];
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, [ITUIKitHelper getAppWidth] - 20, SECTION_HEIGHT)];
    l.font = [UIFont systemFontOfSize:30 * PJSAH];
    l.textColor = [ITUIKitHelper color:@"757575"];
    l.backgroundColor = [UIColor clearColor];
    [view addSubview:l];
    
    [SBUIFactory decorateWithLine:view width:0.5 type:ITLineDecorateUpDown];
    
    if (section == 1) l.text = @"热门品牌";
    else l.text = [filteredAlphabet objectAtIndex:section - 1];
    
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [filteredAlphabet count] + 1; //除了字母，加入热门品牌、车型收藏(由#对应)
}

- (CGFloat)BKUpdateTableView:(BKUpdateTableView *)updateTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 && indexPath.section == 1) return [SBHotBrandCell getHeight:hotdata];
    else if (indexPath.row == 0 && indexPath.section == 0) return [SBCarSaveTblCell getHeight:nil];
    return [SBBrandNameTblCell getHeight:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cid = @"carPickId";
    static NSString *sid = @"scarPickId";
    static NSString *hid = @"hcarPickId";
    
    if (indexPath.row == 0 && indexPath.section == 0) {
        
        SBCarSaveTblCell *cell = [tableView dequeueReusableCellWithIdentifier:sid];
        if (!cell) cell = [[SBCarSaveTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sid];
        return cell;
    }
    
    else if (indexPath.row == 0 && indexPath.section == 1) {
        SBHotBrandCell *cell = [tableView dequeueReusableCellWithIdentifier:hid];
        if (!cell) {
            cell = [[SBHotBrandCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hid];
            cell.delegate = self;
        }
        [cell display:hotdata];
        return cell;
    }
    
    else {
        SBBrandNameTblCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
        if (!cell) cell = [[SBBrandNameTblCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
        [cell display:[[objectsByLetter objectForKey:[filteredAlphabet objectAtIndex:indexPath.section - 1]] objectAtIndex:indexPath.row]];
        return cell;
    }
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return 0;
    if (section == 1) return 1;
    return [[objectsByLetter objectForKey:[filteredAlphabet objectAtIndex:section - 1]] count];
}

- (void)BKUpdateTableViewDidSelectRowAtIndexPath:(BKUpdateTableView *)updateTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (targetVC) RUPWarning([targetVC performSelector:@selector(SBPickCarTableView_Cell:) withObject:[updateTableView cellForRowAtIndexPath:indexPath]]);
    else RUPWarning([[ITUtils viewControllerFor:self] performSelector:@selector(SBPickCarTableView_Cell:) withObject:[updateTableView cellForRowAtIndexPath:indexPath]]);
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return filteredAlphabet;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (targetVC) RUPWarning([targetVC performSelector:@selector(SBPickCarTableView_SectionIndex:) withObject:title]);
    else RUPWarning([[ITUtils viewControllerFor:self] performSelector:@selector(SBPickCarTableView_SectionIndex:) withObject:title]);
    
    if (index == 0) return 0;
    
    return index + 1;
}

- (void)sBHotBrandCell:(SBHotBrandCell *)cell btn:(UIButton *)btn data:(NSDictionary *)_data
{
    if (targetVC) RUPWarning([targetVC performSelector:@selector(SBHotBrandCell_Btn:Data:) withObject:btn withObject:_data]);
}


@end
