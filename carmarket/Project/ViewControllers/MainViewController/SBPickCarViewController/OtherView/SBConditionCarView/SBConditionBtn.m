//
//  SBConditionBtn.m
//  carmarket
//
//  Created by Apple on 14-8-23.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBConditionBtn.h"
#import "UIImage+ITColorImage.h"

@implementation SBConditionBtn
@synthesize btn, info;

- (id)initWithFrame:(CGRect)frame block:(SBConditionBtnClick)_block
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        block = _block;
        info = [NSDictionary dictionary];
        
        UIImage *bgImg = [UIImage imageNamed:@"bg_menuselect"];
        UIImage *strechBgImg = [bgImg resizableImageWithCapInsets:UIEdgeInsetsMake(10, 30, 10, 30) resizingMode:UIImageResizingModeTile];
        
        btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, bgImg.size.width, bgImg.size.height - 2)];
        [btn setBackgroundImage:strechBgImg forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageWithColor:[UIColor grayColor]] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:30 * PJSAH];
        [self addSubview:btn];
        
        [ITUIKitHelper sizeSet:self size:CGSizeMake(btn.frame.size.width, btn.frame.size.height)];
        
    }
    return self;
}

- (void)setWidth:(float)width
{
    [ITUIKitHelper sizeSet:btn size:CGSizeMake(width, -1)];
    [ITUIKitHelper sizeSet:self size:CGSizeMake(btn.frame.size.width, btn.frame.size.height)];
}

- (void)setTitle:(NSString *)title
{
    [btn setTitle:title forState:UIControlStateNormal];
    CGSize size = [title sizeWithFont:btn.titleLabel.font];
    [ITUIKitHelper sizeSet:btn size:CGSizeMake(size.width  + 16 * PJSAH * 2, -1)];
    [ITUIKitHelper sizeSet:self size:CGSizeMake(btn.frame.size.width, btn.frame.size.height)];
}

- (void)btnClick:(UIButton *)sender
{
    block(self);
}

- (void)setSelected:(BOOL)is
{
    [btn setSelected:is];
}

+ (float)getHeight
{
    UIImage *bgImg = [UIImage imageNamed:@"bg_menuselect"];
    return bgImg.size.height - 2;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
