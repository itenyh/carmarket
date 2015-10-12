//
//  SBPickCarView.m
//  carmarket
//
//  Created by itensb on 14-11-3.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBPickCarView.h"

@interface SBPickCarView ()
{

}

@end

@implementation SBPickCarView
@synthesize brandListView, tbView;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        tbView = [[SBPickCarTableView alloc] initWithFrame:CGRectMake(0, 0, [ITUIKitHelper getAppWidth], frame.size.height)];
        [self addSubview:tbView];
        
        brandListView = [[SBSingleBrandlListView alloc] initWithFrame:CGRectMake([ITUIKitHelper getAppWidth] - 552 * PJSAH, 0, 552 * PJSAH, frame.size.height)];
        [self addSubview:brandListView];
        [brandListView hide:NO];
        
    }
    
    return self;
    
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    [ITUIKitHelper sizeSet:tbView size:frame.size];
    [ITUIKitHelper sizeSet:brandListView size:CGSizeMake(-1, frame.size.height)];
}

- (void)setTargetVC:(UIViewController *)tc
{
    tbView.targetVC = tc;
    brandListView.targetVC = tc;
}

- (void)setBrandListData:(NSArray *)data
{
    tbView.data = [NSMutableArray arrayWithArray:data];
}

- (void)setHotBrandData:(NSDictionary *)dic
{
    tbView.hotdata = dic;
}

@end
