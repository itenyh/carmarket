//
//  SBSubmitTblCell.m
//  carmarket
//
//  Created by itensb on 14-8-14.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBSubmitTblCell.h"

@implementation SBSubmitTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        UIImage *bgImg = [UIImage imageNamed:@"bg_pasubmit"];
        UIImage *strechBgImg = [bgImg resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeTile];
        
        submit = [[UIButton alloc] initWithFrame:CGRectMake(23 * PJSAH, 0, [ITUIKitHelper getAppWidth] - 23 * PJSA, 78 * PJSAH)];
        [submit setBackgroundImage:strechBgImg forState:UIControlStateNormal];
        [submit setTitle:@"提交" forState:UIControlStateNormal];
        submit.titleLabel.font = [UIFont systemFontOfSize:40 * PJSAH];
        [submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.contentView addSubview:submit];
        
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
}

+ (float)getHeight:(NSDictionary *)info
{
    return 78 * PJSAH;
}

@end
