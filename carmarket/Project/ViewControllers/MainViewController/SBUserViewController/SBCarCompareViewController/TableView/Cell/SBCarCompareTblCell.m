//
//  SBCarCompareTblCell.m
//  carmarket
//
//  Created by itensb on 14-11-4.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#define CellHeight 50

#import "SBCarCompareTblCell.h"

@implementation SBCarCompareTblCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        title = [self createTitle];
        c1 = [self createItem:[ITUIKitHelper xMarLeftView:title margin:0] width:([ITUIKitHelper getAppWidth] - title.frame.size.width) / 2.0];
        c2 = [self createItem:[ITUIKitHelper xMarLeftView:c1 margin:0] width:c1.frame.size.width];
        
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
}

- (void)displayWithTitle:(NSString *)_title p1:(NSString *)p1 p2:(NSString *)p2
{
    title.text = _title;
    [c1 setTitle:p1 forState:UIControlStateNormal];
    [c2 setTitle:p2 forState:UIControlStateNormal];
    
    if ([p1 isEqualToString:p2]) {
        [c1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [c2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    else {
        [c1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [c2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
}

#pragma - mark 辅助函数
- (UILabel *)createTitle
{
    UILabel *b1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, CellHeight)];
    b1.font = [UIFont systemFontOfSize:12];
    b1.textColor = [UIColor blackColor];
    b1.numberOfLines = 2;
    b1.textAlignment = NSTextAlignmentCenter;
    [SBUIFactory decorateWithLine:b1 width:.5 type:ITLineDecorateRight];
    [SBUIFactory decorateWithLine:b1 width:.5 type:ITLineDecorateDown];
    [self.contentView addSubview:b1];
    
    return b1;
}

- (UIButton *)createItem:(float)x width:(float)width
{
    UIButton *b2 = [[UIButton alloc] initWithFrame:CGRectMake(x, 0, width, CellHeight)];
    b2.titleLabel.font = [UIFont systemFontOfSize:12];
    [b2 setTitle:@"三年或10万公里" forState:UIControlStateNormal];
    [b2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [SBUIFactory decorateWithLine:b2 width:.5 type:ITLineDecorateRight];
    [SBUIFactory decorateWithLine:b2 width:.5 type:ITLineDecorateDown];
    [self.contentView addSubview:b2];
    
    return b2;
}

+ (float)getHeight:(NSDictionary *)info
{
    return CellHeight;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
