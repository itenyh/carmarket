//
//  SBArgDetailColCell.m
//  carmarket
//
//  Created by itensb on 14-8-11.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBArgDetailColCell.h"
#import "SBCarArgBasicInfoCell.h"

#import "SBCarArgViewController.h"

@interface SBArgDetailColCell ()
{
    SBCarArgViewController *vc;
}
@end

@implementation SBArgDetailColCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        
        
    }
    
    return self;
}

- (void)createView:(UIViewController *)paraVc
{
    if (!vc) {
       
        NSString *brandId = [[SBRequestParamBus instance] getParamWith:paraVc key:@"brandId"];
        NSString *carModelId = [[SBRequestParamBus instance] getParamWith:paraVc key:@"modelId"];
        NSString *carStyleId = [[SBRequestParamBus instance] getParamWith:paraVc key:@"carStyle"];
        
        vc = [[SBCarArgViewController alloc] initWithNavi:YES leftBtnType:NDLeftBtnBack];
        vc.tbView.frame =  CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [self.contentView addSubview:vc.tbView];
        
        [[SBRequestParamBus instance] setParamWith:vc key:@"brandId" value:brandId];
        [[SBRequestParamBus instance] setParamWith:vc key:@"modelId" value:carModelId];
        [[SBRequestParamBus instance] setParamWith:vc key:@"carStyle" value:carStyleId];
        
        [vc requestNetWork];
        
    }
}



@end
