//
//  SBPriceInputTblCell.m
//  carmarket
//
//  Created by itensb on 14-11-5.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBPriceInputTblCell.h"

@implementation SBPriceInputTblCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        title.text = @"请输入裸车价格";
        
        [self createTextField:@"" rect:CGRectMake([ITUIKitHelper xMarLeftView:title margin:10] - 30, 10, [ITUIKitHelper getAppWidth] - [ITUIKitHelper xMarLeftView:title margin:10] + 30 - 30 * PJSAH, [SBPriceInputTblCell getHeight:nil] - 20)];
    }
    
    return self;
}

+ (float)getHeight:(NSDictionary *)info
{
    return 50;
}

- (UITextField *)createTextField:(NSString *)placeholder rect:(CGRect)rect
{
    UITextField *tf = [[UITextField alloc] initWithFrame:rect];
    tf.font = [UIFont systemFontOfSize:35 * PJSAH];
    tf.textColor = [ITUIKitHelper color:@"ccccd2"];
    [self.contentView addSubview:tf];
    tf.placeholder = placeholder;
    tf.borderStyle = UITextBorderStyleRoundedRect;
    tf.backgroundColor = [UIColor whiteColor];
    tf.textColor = [ITUIKitHelper color:@"181818"];
    
    return tf;
}

@end
