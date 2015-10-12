//
//  SBUserInfoDetailTblCell.m
//  carmarket
//
//  Created by itensb on 14-8-20.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBUserInfoDetailTblCell.h"

@implementation SBUserInfoDetailTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        head = [SBUIFactory getUserHeadView:nil handler:nil];
        [ITUIKitHelper pointSet:head piont:CGPointMake(([ITUIKitHelper getAppWidth] - head.frame.size.width) / 2, 13 * PJSAH)];
        [self.contentView addSubview:head];
        
        name = [ITUIKitHelper createLabel:@"" size:CGSizeMake(150, -1) font:[UIFont boldSystemFontOfSize:35 * PJSAH] color:[ITUIKitHelper color:@"181818"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(([ITUIKitHelper getAppWidth] - 150) / 2.0, [ITUIKitHelper yMarTopView:head margin:16 * PJSAH]) superViewFrame:self.frame];
        name.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:name];
        
        jifenBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, [ITUIKitHelper yMarTopView:name margin:29 * PJSAH] - 2, [ITUIKitHelper getAppWidth], 138 * PJSAH)];
        jifenBg.image = [UIImage imageNamed:@"bg_userjifen"];
        [self.contentView addSubview:jifenBg];
        
        chebi = [self createJiFen:0 title:@"车币"];
        jifen  = [self createJiFen:1 title:@"积分"];
        guanzhu = [self createJiFen:2 title:@"关注"];
        fensi = [self createJiFen:3 title:@"粉丝"];
        
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
    
    name.text = [info objectForKey:@"userName"];
}


+ (float)getHeight:(NSDictionary *)info
{
    return 433 * PJSAH;
}


- (UILabel *)createJiFen:(int)index title:(NSString *)title
{
    float onePieceLen = jifenBg.frame.size.width / 4.0f;
    
    UILabel *l = [ITUIKitHelper createLabel:@"0" size:CGSizeMake(50, -1) font:[UIFont systemFontOfSize:35 * PJSAH] color:[ITUIKitHelper color:@"4b89d2"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake((onePieceLen - 50) / 2.0f + index * onePieceLen, 10) superViewFrame:self.frame];
    l.textAlignment = NSTextAlignmentCenter;
    [jifenBg addSubview:l];
    
    UILabel *ll = [ITUIKitHelper createLabel:title size:CGSizeMake(50, -1) font:[UIFont systemFontOfSize:35 * PJSAH] color:[UIColor blackColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake((onePieceLen - 50) / 2.0f + index * onePieceLen, [ITUIKitHelper yMarTopView:l margin:5]) superViewFrame:self.frame];
    ll.textAlignment = NSTextAlignmentCenter;
    [jifenBg addSubview:ll];
    
    return l;
}

@end
