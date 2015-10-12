//
//  SBCarArgTblCell.m
//  carmarket
//
//  Created by itensb on 14-11-11.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#define CellHeight 33

#import "SBCarArgTblCell.h"

@implementation SBCarArgTblCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        title = [self createTitle];
        c1 = [self createItem:[ITUIKitHelper xMarLeftView:title margin:0] width:[ITUIKitHelper getAppWidth] - title.frame.size.width];
        
    }
    
    return self;
}

- (void)displayWith:(NSString *)_title value:(NSString *)_value
{
    title.text = [NSString stringWithFormat:@"   %@", _title];
    c1.text = [NSString stringWithFormat:@"   %@", _value];
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
}

+ (float)getHeight:(NSDictionary *)info
{
    return CellHeight;
}

#pragma - mark 辅助函数
- (UILabel *)createTitle
{
    UILabel *b1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [ITUIKitHelper getAppWidth] / 2.0, CellHeight)];
    b1.font = [UIFont boldSystemFontOfSize:13];
    b1.textColor = [UIColor blackColor];
    [SBUIFactory decorateWithLine:b1 width:.5 type:ITLineDecorateRight];
    [SBUIFactory decorateWithLine:b1 width:.5 type:ITLineDecorateDown];
    [self.contentView addSubview:b1];
    
    return b1;
}

- (UILabel *)createItem:(float)x width:(float)width
{
    UILabel *b2 = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, width, CellHeight)];
    b2.font = [UIFont systemFontOfSize:13];
    b2.textColor = [UIColor darkGrayColor];
    b2.adjustsFontSizeToFitWidth = YES;
    b2.minimumScaleFactor = 0.8;
    b2.numberOfLines  = 2;
    [SBUIFactory decorateWithLine:b2 width:.5 type:ITLineDecorateRight];
    [SBUIFactory decorateWithLine:b2 width:.5 type:ITLineDecorateDown];
    [self.contentView addSubview:b2];
    
    return b2;
}

@end
