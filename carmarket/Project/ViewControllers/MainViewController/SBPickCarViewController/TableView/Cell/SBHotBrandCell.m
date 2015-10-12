//
//  SBHotBrandCell.m
//  carmarket
//
//  Created by itensb on 14-8-5.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#define LINE_NUM 5

#import "SBHotBrandCell.h"
#import "UIImage+ITColorImage.h"

@implementation SBHotBrandCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {

//        self.selectionStyle = []
        
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    
    [super display:info];
    
    float viewHeight = 166 * PJSAH;
    float viewWidth = ([ITUIKitHelper getAppWidth] - 15) / LINE_NUM;
    
    [self clearCell];
    
    //垫一层防止点击cell
    UIButton *b = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, [ITUIKitHelper getAppWidth], [SBHotBrandCell getHeight:nil])];
    [self.contentView addSubview:b];

    for (int i = 0; i < 10.0; i++) {
        
        int r = i / LINE_NUM;
        int c = i % LINE_NUM;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(c * (viewWidth), r * (viewHeight), viewWidth, viewHeight)];
        [self.contentView addSubview:view];
        
        UIImageView *b = [[UIImageView alloc] initWithFrame:CGRectMake((viewWidth - 70 * PJSAH) / 2.0, 35 * PJSAH, 70 * PJSAH, 70 * PJSAH)];
        [b sd_setImageWithURL:[NSURL URLWithString:TEST_CHEXINGURL]placeholderImage:[SBUIFactory getPlaceHolderImg]];
        [view addSubview:b];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, [ITUIKitHelper yMarTopView:b margin:0], viewWidth, 30)];
        lab.text = @"长安";
        lab.textColor = [ITUIKitHelper color:@"070707"];
        lab.font = [UIFont systemFontOfSize:30 * PJSAH];
        lab.textAlignment = NSTextAlignmentCenter;
        [view addSubview:lab];
        
        UIButton *bb = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
        bb.tag = i;
        [bb setBackgroundImage:[UIImage imageWithColor:[ITUIKitHelper color:@"ffffff" alpha:0.05]] forState:UIControlStateNormal];
        [bb bk_addEventHandler:^(id sender) {
            RUPWarning([[ITUtils viewControllerFor:self] performSelector:@selector(SBHotBrandCell_Btn:Cell:) withObject:bb withObject:self]);
        } forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:bb];

    }

    
}

+ (float)getHeight:(NSDictionary *)info
{
    return ceil(10.0 / LINE_NUM) * 166 * PJSAH;
}

- (void)clearCell
{
    [self.contentView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
}

@end
