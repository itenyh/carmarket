//
//  SBaseTableViewCell.m
//  carmarket
//
//  Created by itensb on 14-8-6.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBaseTableViewCell.h"
#import "UIImage+ITColorImage.h"

@implementation SBaseTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
      
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    self.info = info;
}

+ (float)getHeight:(NSDictionary *)info
{
    return 50;
}

- (float)getMiddleYByHeight:(float)height
{
    return ([SBaseTableViewCell getHeight:nil] - height) / 2.0;
}

@end
