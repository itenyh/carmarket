//
//  SBPlainItemTblCell.m
//  carmarket
//
//  Created by itensb on 14-11-5.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBPlainItemTblCell.h"

@implementation SBPlainItemTblCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        price = [ITUIKitHelper createLabel:@"" size:CGSizeMake([ITUIKitHelper getAppWidth] / 2.0 - 30, [SBBaseBuyCarTblCell getHeight:nil]) font:[UIFont systemFontOfSize:35 * PJSAH] color:[UIColor blackColor] marginInsets:[ITUIKitHelper ITMarginInsetsMake:-1 right:30] point:CGPointMake([ITUIKitHelper xMarLeftView:title margin:0], 0) superViewFrame:self.frame];
//        price.backgroundColor = [UIColor purpleColor];
        price.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:price];
        
    }
    
    return self;
}

- (void)displayWithTitle:(NSString *)_title price:(NSString *)_price type:(int)type
{
    title.text = _title;
    price.text = _price;
    
    if (type == 1) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else {
        self.accessoryType = UITableViewCellAccessoryNone;
    }
}

+ (float)getHeight:(NSDictionary *)info
{
    return 50;
}
@end
