//
//  SBMenuBtn.m
//  carmarket
//
//  Created by itensb on 14-8-22.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBMenuBtn.h"

@implementation SBMenuBtn
@synthesize on, title, b;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        on = NO;
        
        self.backgroundColor = [ITUIKitHelper color:251 blue:251 green:251 alpha:1];
        
        atPanel = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, self.frame.size.height)];
        [self addSubview:atPanel];
        
        title = [ITUIKitHelper createLabel:@"" font:[UIFont systemFontOfSize:30 * PJSAH] color:[ITUIKitHelper color:@"757575"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(0, (atPanel.frame.size.height - [UIFont systemFontOfSize:30 * PJSAH].lineHeight) / 2.0) superViewFrame:self.frame];
        [atPanel addSubview:title];
        
        [ITUIKitHelper sizeSet:atPanel size:CGSizeMake(-1, title.frame.size.height)];
        
        array = [ITUIKitHelper createIconWithUIImage:[UIImage imageNamed:@"icon_arraydowngray"]];
        [ITUIKitHelper pointSet:array piont:CGPointMake(0, (self.frame.size.height - array.frame.size.height) / 2.0)];
        [atPanel addSubview:array];

        b = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:b];
        
    }
    
    return self;
}

- (void)setTag:(NSInteger)tag
{
    [super setTag:tag];
    
    b.tag = tag;
}

- (void)addTarget:(id)target action:(SEL)action
{
    [b addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)setMenuTitle:(NSString *)_title
{
    title.text = _title;
    [title sizeWidthToFit];
    
    [ITUIKitHelper pointSet:array piont:CGPointMake([ITUIKitHelper xMarLeftView:title margin:8], -1)];
    [ITUIKitHelper sizeSet:atPanel size:CGSizeMake(title.frame.size.width + 8 + array.frame.size.width, -1)];
    [ITUIKitHelper pointSet:atPanel piont:CGPointMake((self.frame.size.width - atPanel.frame.size.width) / 2.0, -1)];
}

- (void)setMenuTitleUnchangeSize:(NSString *)_title
{
    title.text = _title;
}

- (void)setMenuBtnState:(BOOL)_on
{
    on = _on;
    
    if (_on) {
        title.textColor = [ITUIKitHelper color:@"c30114"];
        [array setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_arrayupred"]]];
    }
    else {
        title.textColor = [ITUIKitHelper color:@"757575"];
        [array setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_arraydowngray"]]];
    }
}

@end
