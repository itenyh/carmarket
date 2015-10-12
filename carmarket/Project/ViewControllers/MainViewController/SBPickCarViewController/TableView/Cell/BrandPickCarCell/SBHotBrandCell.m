//
//  SBHotBrandCell.m
//  carmarket
//
//  Created by itensb on 14-8-5.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#define LINE_NUM 5.0f

#import "SBHotBrandCell.h"
#import "UIImage+ITColorImage.h"

@implementation SBHotBrandCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    
    [super display:info];
    
    NSArray *datas = [info objectForKey:@"data"];
    
    float viewHeight = 166 * PJSAH;
    float viewWidth = ([ITUIKitHelper getAppWidth] - 15) / LINE_NUM;
    
    [self clearCell];
    
    //垫一层防止点击cell
    UIButton *b = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, [ITUIKitHelper getAppWidth], [SBHotBrandCell getHeight:nil])];
    [self.contentView addSubview:b];

    for (int i = 0; i < datas.count; i++) {
        
        NSDictionary *data = [datas objectAtIndex:i];
        
        int r = i / (int)LINE_NUM;
        int c = i % (int)LINE_NUM;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(c * (viewWidth), r * (viewHeight), viewWidth, viewHeight)];
        [self.contentView addSubview:view];
        
        UIImageView *b = [[UIImageView alloc] initWithFrame:CGRectMake((viewWidth - 70 * PJSAH) / 2.0, 35 * PJSAH, 70 * PJSAH, 70 * PJSAH)];
        [b sd_setImageWithURL:[SBUtil getBrandImgURLWith:data] placeholderImage:[SBUIFactory getPlaceHolderImg]];
        [view addSubview:b];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, [ITUIKitHelper yMarTopView:b margin:0], viewWidth, 30)];
        lab.text = [data objectForKey:@"name"];
        lab.textColor = [ITUIKitHelper color:@"070707"];
        lab.font = [UIFont systemFontOfSize:30 * PJSAH];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.backgroundColor = [UIColor clearColor];
        [view addSubview:lab];
        
        UIButton *bb = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
        bb.tag = i;
        [bb setBackgroundImage:[UIImage imageWithColor:[ITUIKitHelper color:@"ffffff" alpha:0.05]] forState:UIControlStateNormal];
        [bb bk_addEventHandler:^(id sender) {
            if (_delegate && [_delegate respondsToSelector:@selector(sBHotBrandCell:btn:data:)]) {
                [_delegate sBHotBrandCell:self btn:bb data:data];
            }
        } forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:bb];

    }

    
}

+ (float)getHeight:(NSDictionary *)info
{
    NSArray *datas = [info objectForKey:@"data"];
    return ceil(datas.count / LINE_NUM) * 166 * PJSAH;
}

- (void)clearCell
{
    [self.contentView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
}

@end
