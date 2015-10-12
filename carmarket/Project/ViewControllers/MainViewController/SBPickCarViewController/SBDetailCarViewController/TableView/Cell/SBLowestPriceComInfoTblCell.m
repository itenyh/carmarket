//
//  SBLowestPriceComInfoTblCell.m
//  carmarket
//
//  Created by itensb on 14-8-15.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBLowestPriceComInfoTblCell.h"

@implementation SBLowestPriceComInfoTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
   
        isSelect = [ITUIKitHelper createButtonWithUIImage:[UIImage imageNamed:@"btn_gouselect"] highlightImg:nil point:CGPointMake(29 * PJSAH, 31 * PJSAH) isBackgroundImg:YES];
        isSelect.tag = 0;
        [self.contentView addSubview:isSelect];
        
        s4Icon = [SBUIFactory getColoredRedPanel:@"4S" size:CGSizeMake(48 * PJSAH, 32 * PJSAH) color:nil font:[UIFont systemFontOfSize:25 * PJSAH]];
        [ITUIKitHelper pointSet:s4Icon piont:CGPointMake([ITUIKitHelper xMarLeftView:isSelect margin:22 * PJSAH], 17 * PJSAH)];
        [self.contentView addSubview:s4Icon];
        
        title = [ITUIKitHelper createLabel:@"" size:CGSizeMake(170, -1) font:[UIFont boldSystemFontOfSize:16] color:[UIColor blackColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:s4Icon margin:13 * PJSAH], s4Icon.frame.origin.y) superViewFrame:self.frame];
//        title.backgroundColor = TEST_BGCOLOR;
        [self.contentView addSubview:title];
        
        subtitle = [ITUIKitHelper createLabel:@"" size:CGSizeMake(title.frame.size.width + 28, -1) font:[UIFont systemFontOfSize:20 * PJSAH] color:[ITUIKitHelper color:@"828282"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(s4Icon.frame.origin.x, [ITUIKitHelper yMarTopView:title margin:8 * PJSAH] - 3) superViewFrame:self.frame];
//        subtitle.backgroundColor = TEST_BGCOLOR;
        [self.contentView  addSubview:subtitle];
        
        price = [ITUIKitHelper createLabel:@"" size:CGSizeMake(65, -1) font:[UIFont boldSystemFontOfSize:30 * PJSAH] color:[ITUIKitHelper color:@"c30114"] marginInsets:[ITUIKitHelper ITMarginInsetsMake:-1 right:28 * PJSAH] point:CGPointMake(0, [self getMiddleYByHeight:[UIFont boldSystemFontOfSize:30 * PJSAH].lineHeight]) superViewFrame:self.frame];
//        price.backgroundColor = TEST_BGCOLOR;
        price.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:price];
        
        UIView *lineView = [ITUIKitHelper createIconWithUIImage:[UIImage imageWithColor:[ITUIKitHelper color:@"d6d6d6"] size:CGSizeMake([ITUIKitHelper getAppWidth], 0.5)]];
        [ITUIKitHelper pointSet:lineView piont:CGPointMake(0, [SBLowestPriceComInfoTblCell getHeight:nil] - 0.5)];
        [self.contentView addSubview:lineView];
        
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
    
    title.text = @"万家雅迪";
    subtitle.text = @"重庆市沙坪坝区石新路（凤鸣山加油站旁）";
    price.text = @"35.85万";
    
}

+ (float)getHeight:(NSDictionary *)info
{
    return 99 * PJSAH;
}


@end
