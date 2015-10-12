//
//  SBGoOutPlanTitle.m
//  carmarket
//
//  Created by itensb on 14-11-14.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBGoOutPlanTitle.h"

@implementation SBGoOutPlanTitle

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.contentView.backgroundColor = [ITUIKitHelper color:140 blue:229 green:194 alpha:1];
        
        float itemWidth = [ITUIKitHelper getAppWidth] / 2.0;
        float itemHeight = 90;
        float inset = 8;
        UIFont *font =  [UIFont fontWithName:@"Helvetica-Bold" size:45 * PJSAH];;
        
        ll = [ITUIKitHelper createLabel:@"" size:CGSizeMake([ITUIKitHelper getAppWidth] - itemWidth - 2 * inset, itemHeight) font:font color:[ITUIKitHelper color:@"ffffff"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(inset, 0) superViewFrame:self.contentView.frame];
        ll.textAlignment = NSTextAlignmentCenter;
//        ll.backgroundColor = TEST_BGCOLOR;
        ll.adjustsFontSizeToFitWidth = YES;
        ll.numberOfLines = 2;
        ll.minimumScaleFactor = 0.8;
        [self.contentView addSubview:ll];
        
        UIButton *lb = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, itemWidth, itemHeight)];
        lb.tag = 0;
        [lb bk_addEventHandler:^(id sender) {
            RUPWarning([[ITUtils viewControllerFor:self] performSelector:@selector(SBGoOutPlanTitle_Cell:Btn:) withObject:self withObject:lb]);
        } forControlEvents:UIControlEventTouchUpInside];
        [ITUIKitHelper decorateWithLine:lb color:[UIColor whiteColor] lineWidth:0.5 type:ITLineDecorateRight];
        [self.contentView addSubview:lb];
        
        UILabel *qidian = [ITUIKitHelper createLabel:@"起点" font:[UIFont systemFontOfSize:9] color:[UIColor whiteColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(2, 5) superViewFrame:self.contentView.frame];
        [ll addSubview:qidian];
        UIImageView *naviIcon = [[UIImageView alloc] initWithFrame:CGRectMake([ITUIKitHelper xMarLeftView:qidian margin:2], 6, 10, 10)];
        naviIcon.image = [UIImage imageNamed:@"btn_navinavi"];
        [ll addSubview:naviIcon];
       
        rl = [ITUIKitHelper createLabel:@"" size:CGSizeMake([ITUIKitHelper getAppWidth] - itemWidth - 2 * inset, itemHeight) font:font color:[ITUIKitHelper color:@"ffffff"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:lb margin:inset], 0) superViewFrame:self.contentView.frame];
        rl.textAlignment = NSTextAlignmentCenter;
//        rl.backgroundColor = TEST_BGCOLOR;
        rl.adjustsFontSizeToFitWidth = YES;
        rl.minimumScaleFactor = 0.8;
        rl.numberOfLines = 2;
        [self.contentView addSubview:rl];
        
        UIButton *rb = [[UIButton alloc] initWithFrame:CGRectMake([ITUIKitHelper xMarLeftView:lb margin:0], 0, itemWidth, itemHeight)];
        rb.tag = 1;
        [rb bk_addEventHandler:^(id sender) {
            RUPWarning([[ITUtils viewControllerFor:self] performSelector:@selector(SBGoOutPlanTitle_Cell:Btn:) withObject:self withObject:rb]);
        } forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:rb];
        
        UILabel *zhongdian = [ITUIKitHelper createLabel:@"终点" font:[UIFont systemFontOfSize:9] color:[UIColor whiteColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(2, 5) superViewFrame:self.contentView.frame];
        [rl addSubview:zhongdian];
        UIImageView *naviIcon1 = [[UIImageView alloc] initWithFrame:CGRectMake([ITUIKitHelper xMarLeftView:qidian margin:2], 6, 10, 10)];
        naviIcon1.image = [UIImage imageNamed:@"btn_navinavi"];
        [rl addSubview:naviIcon1];
        
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
}

- (void)display:(NSString *)lt content:(NSString *)rt
{
    ll.text = lt;
    rl.text = rt;
}

+ (float)getHeight:(NSDictionary *)info
{
    return 90;
}

@end
