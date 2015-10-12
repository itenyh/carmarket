//
//  SBDotColorLabel.m
//  carmarket
//
//  Created by itensb on 14-11-6.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBDotColorLabel.h"

@implementation SBDotColorLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
//        self.backgroundColor = TEST_BGCOLOR;
        
        UIFont *font = [UIFont systemFontOfSize:12];
        float height = font.lineHeight > 5 ? font.lineHeight : 5;
        
        UIImage *dotImg = [UIImage imageNamed:@"icon_graydot"];
        UIImageView *dotImgView = [[UIImageView alloc] initWithFrame:CGRectMake(2, (height - 5) / 2.0, 5, 5)];
        dotImgView.image = dotImg;
        [self addSubview:dotImgView];
        
        l = [ITUIKitHelper createLabel:@"" size:CGSizeMake(0, frame.size.height) font:font color:[UIColor blackColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:dotImgView margin:5], 0) superViewFrame:self.frame];
        [self addSubview:l];
        
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, 2 + 5 + 5, height);
        
    }
    
    return self;
}

+ (SBDotColorLabel *)dotColorLable:(NSString *)title point:(CGPoint)point
{
    SBDotColorLabel *l = [[SBDotColorLabel alloc] initWithFrame:CGRectMake(point.x, point.y, 0, 0)];
    [l setContent:title];
    return l;
}

- (void)setContent:(NSString *)content
{
    float oldL = l.frame.size.width;
    
    l.text = content;
    [l sizeToFit];
    
    float addedL = l.frame.size.width - oldL;
    
    [ITUIKitHelper sizeSet:self size:CGSizeMake(self.frame.size.width + addedL, -1)];
    
}


@end
