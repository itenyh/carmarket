//
//  SBConditionItemsPanel.m
//  carmarket
//
//  Created by Apple on 14-8-23.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBConditionItemsPanel.h"

static SBConditionItemsPanel *panel;

@interface SBConditionItemsPanel ()
{
    float nowViewHeight;
}
@end

@implementation SBConditionItemsPanel
@synthesize datas, zuoyou, shangxia, multiSelect, selecedSet, selecedInfos, delegate, btns;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        // Initialization code
        multiSelect = NO;
        btns = [NSMutableArray array];
        self.backgroundColor = [UIColor clearColor];
        nowViewHeight = frame.size.height;
        selecedSet = [NSMutableIndexSet indexSet];
        selecedInfos = [NSMutableArray array];
    }
    
    return self;
}

- (void)setDatas:(NSMutableArray *)_datas
{
    
    [selecedSet removeAllIndexes];
    
    [btns removeAllObjects];
    
    datas = _datas;
    
    [self reload];
    
    [ITUIKitHelper sizeSet:self size:CGSizeMake(-1, nowViewHeight)];
}

- (void)reload
{
    
    float allRowWidth = 0;
    float lineNum = 0;
    
    for (int i = 0; i < datas.count; i++) {
        
        int oldLineNum = lineNum;
        __block SBConditionBtn *l = [[SBConditionBtn alloc] initWithFrame:CGRectZero block:^(SBConditionBtn *btn) {
            [self selectIndex:l.tag];
        }];
        
        l.info = [datas objectAtIndex:i];
        [btns addObject:l];
        l.tag = i;
        [l setTitle:[[datas objectAtIndex:i] objectForKey:@"title"]];
        [self addSubview:l];
        
        //每行首个标签
        if (allRowWidth == 0) {
            
            //如果单个label的长度已经大于一行，则设定其长度等于这一行
            if (l.frame.size.width > self.frame.size.width) {
                [l setWidth:self.frame.size.width];
                [ITUIKitHelper pointSet:l piont:CGPointMake(0, lineNum * [SBConditionBtn getHeight])];
                lineNum++;
            }
            
            else {
                [ITUIKitHelper pointSet:l piont:CGPointMake(0, lineNum * [SBConditionBtn getHeight])];
                allRowWidth += l.frame.size.width;
            }
            
        }
//        164.8888 + 68.2222 +
        else {
         
            //相当于成为下一行的首个
            if (allRowWidth + l.frame.size.width + zuoyou > self.frame.size.width) {
                allRowWidth = 0;
                lineNum++;
                
                //如果单个label的长度已经大于一行，则设定其长度等于这一行
                if (l.frame.size.width > self.frame.size.width) {
                    [l setWidth:self.frame.size.width];
                    [ITUIKitHelper pointSet:l piont:CGPointMake(0, lineNum * [SBConditionBtn getHeight])];
                    lineNum++;
                }
                
                else {
                    [ITUIKitHelper pointSet:l piont:CGPointMake(0, lineNum * [SBConditionBtn getHeight])];
                    allRowWidth += l.frame.size.width;
                }
                    
            }
            
            else {
                
                [ITUIKitHelper pointSet:l piont:CGPointMake(allRowWidth + zuoyou, lineNum * [SBConditionBtn getHeight])];
                allRowWidth += l.frame.size.width + zuoyou;
                
            }
            
        }
        
        oldLineNum == lineNum ? [ITUIKitHelper pointSet:l piont:CGPointMake(-1 , l.frame.origin.y + shangxia * oldLineNum)] :
        [ITUIKitHelper pointSet:l piont:CGPointMake(-1 , l.frame.origin.y + shangxia * lineNum)];

        nowViewHeight = [ITUIKitHelper yMarTopView:l margin:0];
    }
    
}

- (void)selectIndex:(int)index
{
    if (!multiSelect) {
        for (SBConditionBtn *btn in btns) {
            [btn setSelected:NO];
        }
    }
    
    SBConditionBtn *sb = [btns objectAtIndex:index];
    if (multiSelect) {
        [[btns objectAtIndex:index] setSelected:(sb.btn.isSelected ? NO : YES)];
    }
    else {
        [[btns objectAtIndex:index] setSelected:YES];
    }
    [self reloadSelectedSet];
}

- (void)reloadSelectedSet
{
    for (SBConditionBtn *btn in btns) {
        if (btn.btn.isSelected) {
            [selecedSet addIndex:btn.tag];
        }
        else {
            [selecedSet removeIndex:btn.tag];
        }
    }
    
    selecedInfos = [NSMutableArray array];
    for (SBConditionBtn *btn in [btns objectsAtIndexes:selecedSet]) {
        [selecedInfos addObject:btn.info];
    }
    
    [delegate SBConditionItemsPanel:self selectedDatas:selecedInfos];
    
}

+ (float)getHeight:(NSMutableArray *)a width:(float)width zuoyou:(float)zuoyou shangxia:(float)shangxia
{
    
    if (!panel) {
       panel = [[SBConditionItemsPanel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    }

    panel.zuoyou = zuoyou;
    panel.shangxia = shangxia;
    panel.datas = a;
    
    return panel.frame.size.height;
    
}

#pragma - mark 公共函数
- (void)clearAll
{
    for (SBConditionBtn *btn in btns) {
        [btn setSelected:NO];
    }
    [self reloadSelectedSet];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
