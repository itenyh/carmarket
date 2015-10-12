//
//  SBUserSettingCachClearTblCell.m
//  carmarket
//
//  Created by itensb on 14-8-20.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBUserSettingCachClearTblCell.h"

@implementation SBUserSettingCachClearTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        cache = [ITUIKitHelper createLabel:@"" size:CGSizeMake(100, -1) font:[UIFont systemFontOfSize:15] color:[UIColor blackColor] marginInsets:[ITUIKitHelper ITMarginInsetsMake:10 right:100] point:CGPointMake(-1, -1) superViewFrame:self.contentView.frame];
        cache.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:cache];
        
        clear = [[UIButton alloc] initWithFrame:CGRectMake([ITUIKitHelper xMarLeftView:cache margin:10], ([SBUserSettingBaseTblCell getHeight:nil] - 30) / 2.0, 80, 30)];
        [clear setTitle:@"清除缓存" forState:UIControlStateNormal];
        [clear setTitleColor:[ITUIKitHelper color:@"454545"] forState:UIControlStateNormal];
        clear.titleLabel.font = [UIFont systemFontOfSize:15];
        [SBUIFactory decorateWithLine:clear width:1 type:ITLineDecorateAll];
        [self.contentView addSubview:clear];
        
    }
    
    return self;
    
}

- (void)displayWithTilte:(NSString *)_title cache:(NSString *)_cache
{
    [super displayWithTilte:_title];
    
    if (_cache) {
        cache.text = [NSString stringWithFormat:@"%@M", _cache];
    }
}


@end
