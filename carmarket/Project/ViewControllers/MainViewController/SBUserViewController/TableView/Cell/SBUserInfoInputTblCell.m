//
//  SBUserInfoInputTblCell.m
//  carmarket
//
//  Created by itensb on 14-8-20.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBUserInfoInputTblCell.h"

@implementation SBUserInfoInputTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        title = [ITUIKitHelper createLabel:@"" size:CGSizeMake(80, [SBUserInfoInputTblCell getHeight:nil]) font:[UIFont boldSystemFontOfSize:35 * PJSAH] color:[UIColor blackColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(0, 0) superViewFrame:self.frame];
//        title.backgroundColor = TEST_BGCOLOR;
        title.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:title];
        
        tf = [[UITextField alloc] initWithFrame:CGRectMake(title.frame.size.width + 10, 0, [ITUIKitHelper getAppWidth] - title.frame.size.width - 20, [SBUserInfoInputTblCell getHeight:nil])];
        tf.font = [UIFont systemFontOfSize:35 * PJSAH];
        tf.textColor = [ITUIKitHelper color:@"acacac"];
//        tf.backgroundColor = [UIColor purpleColor];
        [self.contentView addSubview:tf];
        
//        [SBUIFactory decorateWithLine:self width:0.5 type:ITLineDecorateDown];
        
    }
    
    return self;
}

- (void)display:(NSString *)info title:(NSString *)_title isEditable:(BOOL)isE isSecury:(BOOL)isS placeholder:(NSString *)placeholder
{
    [self display:info title:_title];
    
    tf.enabled = isE;
    tf.secureTextEntry = isS;
    if (placeholder) tf.placeholder = placeholder;
}

- (void)display:(NSString *)info title:(NSString *)_title
{
    title.text = _title;
    tf.text = info;
    
}

- (NSString *)getContent
{
    return tf.text;
}

+ (float)getHeight:(NSDictionary *)info
{
    return 50;
}


@end
