//
//  SBUserInfoSectionView.m
//  carmarket
//
//  Created by itensb on 14-8-15.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBUserInfoSectionView.h"

@implementation SBUserInfoSectionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, [ITUIKitHelper getAppWidth], [SBUserInfoSectionView getHeight:nil])];
    
    if (self) {
        
        UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//        [bgImgView setImageToBlur:[UIImage imageNamed:@"userImage.jpg"] completionBlock:nil];
        bgImgView.image = [UIImage imageNamed:@"bg_userbg.jpg"];        
        [self addSubview:bgImgView];
        
        head = [SBUIFactory getUserHeadView:nil handler:^(id sender) {
            RUPWarning([[ITUtils viewControllerFor:self] performSelector:@selector(SBUserInfoSectionView_head:) withObject:self]);
        }];
        [ITUIKitHelper pointSet:head piont:CGPointMake((self.frame.size.width - 200 * PJSAH) / 2, 20)];
        [self addSubview:head];
        
        UIImage *bgImg = [UIImage imageNamed:@"bg_pasubmit"];
        UIImage *strechBgImg = [bgImg resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeTile];
        log = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width - 210 * PJSAH) / 2, [ITUIKitHelper yMarTopView:head margin:10], 210 * PJSAH, 64 * PJSAH)];
        [log setBackgroundImage:strechBgImg forState:UIControlStateNormal];
        [log setTitle:@"登陆/注册" forState:UIControlStateNormal];
        [log bk_addEventHandler:^(id sender) {
            RUPWarning([[ITUtils viewControllerFor:self] performSelector:@selector(SBUserInfoSectionView_log:) withObject:self]);
        } forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:log];
        
        name = [ITUIKitHelper createLabel:@"" size:CGSizeMake(150, -1) font:[UIFont boldSystemFontOfSize:35 * PJSAH] color:[ITUIKitHelper color:@"181818"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(([ITUIKitHelper getAppWidth] - 150) / 2.0, [ITUIKitHelper yMarTopView:head margin:16 * PJSAH]) superViewFrame:self.frame];
        name.textAlignment = NSTextAlignmentCenter;
        [self addSubview:name];
        
    }
    
    return self;
}

- (void)displayWithInfo:(NSDictionary *)info
{
    [head sd_setImageWithURL:[SBUtil getUserHeadImgUrlWith:info] placeholderImage:[SBUIFactory getUserHeadPlaceholderImg]];
    
    if (info) {
        log.hidden = YES;
        name.text = [info objectForKey:@"userName"];
    }
    else {
        log.hidden = NO;
        name.hidden = YES;
    }
}


+ (float)getHeight:(NSDictionary *)info
{
    return 170;
}

@end
