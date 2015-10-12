//
//  SBGoOutCreateTblCell.m
//  carmarket
//
//  Created by itensb on 14-11-12.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBGoOutCreateTblCell.h"

@implementation SBGoOutCreateTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        UITextField *p1 = [SBUIFactory getCusTextField:@"输入端点" rect:CGRectMake(5, ([SBGoOutCreateTblCell getHeight:nil] - 20) / 2.0, 100, 20)];
        [self.contentView addSubview:p1];
        
        UITextField *p2 = [SBUIFactory getCusTextField:@"输入端点" rect:CGRectMake([ITUIKitHelper xMarLeftView:p1 margin:15], ([SBGoOutCreateTblCell getHeight:nil] - 20) / 2.0, 100, 20)];
        [self.contentView addSubview:p2];
        
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
}


+ (float)getHeight:(NSDictionary *)info
{
    return 130 * PJSAH;
}


@end
