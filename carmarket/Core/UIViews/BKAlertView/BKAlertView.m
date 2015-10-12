//
//  BKAlterView.m
//  PregnancyParter
//
//  Created by 显宏 黄 on 12-7-11.
//  Copyright (c) 2012年 beikr.com. All rights reserved.
//

#define UTAG 523498

#import "BKAlertView.h"

@interface BKAlertView()

-(void)hideMessage;

@end

@implementation BKAlertView
@synthesize msglabel=_msglabel;

+(void)showMsg:(NSString *)msg type:(BKMsg)type inview:(UIView*)inview offsetY:(float)offsetY {
    
    BKAlertView *alt = [[BKAlertView alloc] initWithFrame:CGRectMake(0, 0, inview.bounds.size.width, inview.bounds.size.height) andType:type withMsg:msg offsetY:offsetY view:inview];
    alt.alpha = 0.0f;
    
    [inview addSubview:alt];
    [UIView animateWithDuration:0.3 animations:^{
        alt.alpha = 1.0f;
    }];
    
}

+(void)showInfoMsg:(NSString *)msg inview:(UIView*)inview offsetY:(float)offsetY {
    [BKAlertView showMsg:msg type:BKMsgInfo inview:inview offsetY:offsetY];
}

+(void)showErrorMsg:(NSString *)msg inview:(UIView*)inview offsetY:(float)offsetY {
    [BKAlertView showMsg:msg type:BKMsgError inview:inview offsetY:offsetY];
}

+(void)showTblIndexMsg:(NSString *)msg inview:(UIView*)inview offsetY:(float)offsetY {
    
    BKAlertView *alt = [[BKAlertView alloc] initWithFrame:CGRectMake(0, 0, inview.bounds.size.width,inview.bounds.size.height) andType:BKMsgTblIndex withMsg:msg offsetY:offsetY view:inview];
    [inview addSubview:alt];
}

- (id)initWithFrame:(CGRect)frame andType:(BKMsg)type withMsg:(NSString *)msg offsetY:(float)offsetY view:(UIView *)view
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.tag = UTAG;
        
        UIFont *disF = [UIFont boldSystemFontOfSize:15];
        
        NSString *imgname;
        if (type == BKMsgError) {imgname = @"Error";}
        else if (type == BKMsgInfo) {imgname = @"ATick";}
        else if (type == BKMsgTblIndex) {imgname = @"";}
        
        if (type != BKMsgTblIndex) {
            
//            UIView *old_alt = [view viewWithTag:UTAG];
//            if (!old_alt) {[old_alt removeFromSuperview];NSLog(@"remove view ~~~");}
            
            UIView *tank = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TankWidth, TankHeight)];
            tank.layer.cornerRadius = 5;
            tank.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.63];
            [self addSubview:tank];
            
            self.frame = CGRectMake((view.frame.size.width - TankWidth) / 2 - 5, offsetY, TankWidth, TankHeight);
            
            UIImage *img = [UIImage imageNamed:imgname];
            UIImageView *imgview = [[UIImageView alloc] initWithImage:img];
            imgview.frame = CGRectMake((TankWidth - img.size.width) / 2, 15, img.size.width, img.size.height);
            imgview.backgroundColor = [UIColor clearColor];
            [tank addSubview:imgview];
            
            _msglabel = [[UILabel alloc] initWithFrame:CGRectMake(10, imgview.frame.size.height + imgview.frame.origin.y + 10 , TankWidth - 20, disF.lineHeight)];
            _msglabel.textAlignment = NSTextAlignmentCenter;
            _msglabel.backgroundColor = [UIColor clearColor];
            _msglabel.font = disF;
            _msglabel.numberOfLines = 2;
            _msglabel.textColor = [UIColor whiteColor];
            _msglabel.text = msg;
            [tank addSubview:_msglabel];
            
            CGSize maxSize = CGSizeMake(_msglabel.frame.size.width, 999);
            CGSize labelSize = [msg sizeWithFont:_msglabel.font
                               constrainedToSize: maxSize
                                   lineBreakMode: NSLineBreakByTruncatingTail];
            [ITUIKitHelper sizeSet:_msglabel size:CGSizeMake(-1, labelSize.height)];
            _msglabel.text = msg;

            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = frame;
            [btn addTarget:self action:@selector(hideMessage) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            
            [self performSelector:@selector(hideMessage) withObject:nil afterDelay:1.5];
            
        }
        
        else {
            
            UIView *old_alt = [view viewWithTag:UTAG];
            if (old_alt) [old_alt removeFromSuperview];
            
            float width = 50;
            float height = 50;
            int fontSize = 35;
            
            UIView *tank = [[UIView alloc] initWithFrame:CGRectMake((view.frame.size.width - width) / 2 - 5, offsetY, width, height)];
            tank.layer.cornerRadius = 5;
            tank.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.63];
            [self addSubview:tank];
            
            _msglabel = [[UILabel alloc] initWithFrame:CGRectMake((tank.frame.size.width - width) / 2, (tank.frame.size.height - [UIFont boldSystemFontOfSize:fontSize].lineHeight) / 2 , width, [UIFont boldSystemFontOfSize:fontSize].lineHeight)];
            _msglabel.textAlignment = NSTextAlignmentCenter;
            _msglabel.backgroundColor = [UIColor clearColor];
            _msglabel.font = [UIFont boldSystemFontOfSize:fontSize];
            _msglabel.textColor = [UIColor whiteColor];
            _msglabel.text = msg;
            [tank addSubview:_msglabel];

            [self performSelector:@selector(hideMessageNoAnimation) withObject:nil afterDelay:0.5];
            
        }
    
    }
    
    return self;
    
}

+ (BOOL)isExisting
{
    UIView *view = [[UIApplication sharedApplication].windows objectAtIndex:0];
    if (view) {
        UIView *old_alt = [view viewWithTag:UTAG];
        return old_alt != nil;
    }
    else {
        return NO;
    }
    
}

-(void)hideMessage
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)hideMessageNoAnimation
{
    self.alpha = 0.0;
    [self removeFromSuperview];
}

@end
