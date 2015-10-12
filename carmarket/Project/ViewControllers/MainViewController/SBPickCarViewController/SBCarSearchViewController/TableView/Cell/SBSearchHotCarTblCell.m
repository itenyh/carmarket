//
//  SBSearchHotCarTblCell.m
//  carmarket
//
//  Created by itensb on 14-8-22.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBSearchHotCarTblCell.h"

@implementation SBSearchHotCarTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        //        self.selectionStyle = []
        
        UILabel *remen = [ITUIKitHelper createLabel:@"热门车型"  font:[UIFont systemFontOfSize:(30 * PJSAH)] color:[ITUIKitHelper color:@"515151"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(48 * PJSAH, 49 * PJSAH) superViewFrame:self.contentView.frame];
        [self.contentView addSubview:remen];
        
        lineView = [ITUIKitHelper createIconWithUIImage:[UIImage imageWithColor:[ITUIKitHelper color:@"d6d6d6"] size:CGSizeMake((720 - 68) * PJSAH, 0.5)]];
        [ITUIKitHelper pointSet:lineView piont:CGPointMake(34 * PJSAH, [ITUIKitHelper yMarTopView:remen margin:18 * PJSAH])];
        [self.contentView addSubview:lineView];
        
        
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    
    [super display:info];
    
    NSArray *hots = [info objectForKey:@"data"];
    
    UIImage *bg = [UIImage imageNamed:@"bg_searchresult"];
    
    float viewHeight = bg.size.height;
    float viewWidth = bg.size.width;
    int LINE_NUM = 3;
    
    [self clearCell];
    
    for (int i = 0; i < hots.count; i++) {
        
        int r = i / LINE_NUM;
        int c = i % LINE_NUM;
        
        NSDictionary *dic = [hots objectAtIndex:i];
        
        UIButton *hotB = [ITUIKitHelper createButtonWithUIImage:bg highlightImg:nil point:CGPointMake(34 * PJSAH + c * (viewWidth), [ITUIKitHelper yMarTopView:lineView margin:34 * PJSAH] + r * (viewHeight)) isBackgroundImg:YES];
        [ITUIKitHelper sizeSet:hotB size:CGSizeMake(hotB.frame.size.width * PJSA, hotB.frame.size.height * PJSA)];
        
        [self.contentView addSubview:hotB];

        [hotB setTitle:[dic objectForKey:@"name"] forState:UIControlStateNormal];
        [hotB setTitleColor:[ITUIKitHelper color:@"262626"] forState:UIControlStateNormal];
        hotB.titleLabel.font = [UIFont systemFontOfSize:30 * PJSAH];
        hotB.tag = i;
        [hotB bk_addEventHandler:^(id sender) {
            RUPWarning([[ITUtils viewControllerFor:self] performSelector:@selector(SBSearchHotCarTblCell_Btn:Cell:) withObject:hotB withObject:self]);
        } forControlEvents:UIControlEventTouchUpInside];

        
    }
    
}

- (void)clearCell
{
    [self.contentView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if([obj isKindOfClass:[UIButton class]]) [obj removeFromSuperview];
    }];
}

+ (float)getHeight:(NSDictionary *)info
{
    return 300;
}


@end
