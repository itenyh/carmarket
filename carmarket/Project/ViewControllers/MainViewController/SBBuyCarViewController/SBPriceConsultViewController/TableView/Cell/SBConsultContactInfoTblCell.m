//
//  SBConsultContactInfoTblCell.m
//  carmarket
//
//  Created by itensb on 14-8-14.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBConsultContactInfoTblCell.h"

@implementation SBConsultContactInfoTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self createTextFieldView:@"城    市：" index:0];
        [self createTextFieldView:@"姓    名：" index:1];
        [self createTextFieldView:@"手    机：" index:2];
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
    
}

+ (float)getHeight:(NSDictionary *)info
{
    return 3 * 89 * PJSAH + 63 * PJSAH;
}

- (void)createTextFieldView:(NSString *)title index:(int)index
{
    UIView *inputBg = [[UIView alloc] initWithFrame:CGRectMake(24 * PJSAH, index * 89 * PJSAH, [ITUIKitHelper getAppWidth] - 24 * PJSA, 89 * PJSAH)];
    inputBg.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:inputBg];
    
    UILabel *city = [ITUIKitHelper createLabel:title size:CGSizeMake(0, inputBg.frame.size.height) font:[UIFont systemFontOfSize:35 * PJSAH] color:[ITUIKitHelper color:@"aaaaaa"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(24 * PJSAH, 0) superViewFrame:inputBg.frame];
    [city sizeWidthToFit];
    [inputBg addSubview:city];
    
    UITextField *cityf = [[UITextField alloc] initWithFrame:CGRectMake([ITUIKitHelper xMarLeftView:city margin:23 * PJSAH], 0, inputBg.frame.size.width - [ITUIKitHelper xMarLeftView:city margin:23 * PJSAH], inputBg.frame.size.height)];
    cityf.backgroundColor = [UIColor clearColor];
    cityf.font = [UIFont systemFontOfSize:35 * PJSAH];
    cityf.textColor = [ITUIKitHelper color:@"3c3c3c"];
    [inputBg addSubview:cityf];
    
    if (index == 0 || index == 1) [SBUIFactory decorateWithLine:inputBg width:0.5 type:ITLineDecorateExceptDown];
    else [SBUIFactory decorateWithLine:inputBg width:0.5 type:ITLineDecorateAll];
}


@end
