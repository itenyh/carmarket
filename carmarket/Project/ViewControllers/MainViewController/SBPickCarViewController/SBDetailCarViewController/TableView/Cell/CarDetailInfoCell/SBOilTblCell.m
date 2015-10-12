//
//  SBOilTblCell.m
//  carmarket
//
//  Created by itensb on 14-8-26.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBOilTblCell.h"

@implementation SBOilTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        float leftInset = 38 * PJSAH;
        
        UIView *bottom = [[UIView alloc] initWithFrame:CGRectMake(31 * PJSAH, 49 * PJSAH, [ITUIKitHelper getAppWidth] - 31 * PJSA, [SBOilTblCell getHeight:nil] - 49 * PJSAH)];
        [SBUIFactory decorateWithLine:bottom width:0.5 type:ITLineDecorateAll];
        [self.contentView addSubview:bottom];
        
        pailiangbiansu = [ITUIKitHelper createLabel:@"" size:CGSizeMake(150, -1) font:[UIFont systemFontOfSize:35 * PJSAH] color:[ITUIKitHelper color:@"181818"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(leftInset, 29 * PJSAH - 4) superViewFrame:self.frame];
        [bottom addSubview:pailiangbiansu];
        
        wangyouyouhao = [ITUIKitHelper createLabel:@"" size:CGSizeMake(120, -1) font:[UIFont systemFontOfSize:30 * PJSAH] color:[ITUIKitHelper color:@"c30114"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(leftInset, [ITUIKitHelper yMarTopView:pailiangbiansu margin:29 * PJSAH - 5]) superViewFrame:self.frame];
        [bottom addSubview:wangyouyouhao];
        
        UIView *lineView = [ITUIKitHelper createIconWithUIImage:[UIImage imageWithColor:[ITUIKitHelper color:@"d6d6d6"] size:CGSizeMake(bottom.frame.size.width - 2 * leftInset, 0.5)]];
        [ITUIKitHelper pointSet:lineView piont:CGPointMake(leftInset, [ITUIKitHelper yMarTopView:wangyouyouhao margin:23 * PJSAH - 3])];
        [bottom addSubview:lineView];
        
        zonghe = [ITUIKitHelper createLabel:@"综合工况油耗：" size:CGSizeMake(200, -1) font:[UIFont systemFontOfSize:30 * PJSAH] color:[UIColor grayColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(leftInset, [ITUIKitHelper yMarTopView:lineView margin:23 * PJSAH - 3]) superViewFrame:self.frame];
        [bottom addSubview:zonghe];
        
        shiqu = [ITUIKitHelper createLabel:@"市区工况油耗：" size:CGSizeMake(200, -1) font:[UIFont systemFontOfSize:30 * PJSAH] color:[UIColor grayColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(leftInset, [ITUIKitHelper yMarTopView:zonghe margin:10 * PJSAH]) superViewFrame:self.frame];
        [bottom addSubview:shiqu];
        
        shijiao = [ITUIKitHelper createLabel:@"市郊工况油耗：" size:CGSizeMake(200, -1) font:[UIFont systemFontOfSize:30 * PJSAH] color:[UIColor grayColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(leftInset, [ITUIKitHelper yMarTopView:shiqu margin:10 * PJSAH]) superViewFrame:self.frame];
        [bottom addSubview:shijiao];
        
        wangyou = [ITUIKitHelper createLabel:@"网友平均油耗" font:[UIFont systemFontOfSize:25 * PJSAH] color:[ITUIKitHelper color:@"b5b5b5"] marginInsets:[ITUIKitHelper ITMarginInsetsMake:-1 right:leftInset] point:CGPointMake(-1, wangyouyouhao.frame.origin.y + 2) superViewFrame:bottom.frame];
        [bottom addSubview:wangyou];
        
        guanfang = [ITUIKitHelper createLabel:@"官方油耗" font:[UIFont systemFontOfSize:25 * PJSAH] color:[ITUIKitHelper color:@"b5b5b5"] marginInsets:[ITUIKitHelper ITMarginInsetsMake:-1 right:leftInset] point:CGPointMake(-1, shiqu.frame.origin.y + 2) superViewFrame:bottom.frame];
        [bottom addSubview:guanfang];
        
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
    
    pailiangbiansu.text = [NSString stringWithFormat:@"%@%@", [info objectForKey:@"displacement"], [info objectForKey:@"gearboxDetail"]];
    
    zonghe.text = ([info objectForKey:@"officialvalue"] == nil || [[info objectForKey:@"officialvalue"] integerValue] == 0) ? @"综合工况油耗：           --" : [NSString stringWithFormat:@"%@  %@ L/100km", @"综合工况油耗：", [info objectForKey:@"officialvalue"]];
    shiqu.text = ([info objectForKey:@"urbanfuelvalue"] == nil || [[info objectForKey:@"urbanfuelvalue"] integerValue] == 0) ? @"市区工况油耗：           --" : [NSString stringWithFormat:@"%@  %@ L/100km", @"市区工况油耗：", [info objectForKey:@"urbanfuelvalue"]];
    shijiao.text = ([info objectForKey:@"suburbfuelvalue"] == nil || [[info objectForKey:@"suburbfuelvalue"] integerValue] == 0) ? @"市郊工况油耗：           --" : [NSString stringWithFormat:@"%@  %@ L/100km", @"市郊工况油耗：", [info objectForKey:@"suburbfuelvalue"]];
    
    wangyouyouhao.text = ([info objectForKey:@"netfuelvalue"] == nil || [[info objectForKey:@"netfuelvalue"] integerValue] == 0) ? @"   --" : [NSString stringWithFormat:@"%@ L/100km",[info objectForKey:@"netfuelvalue"]];
}

+ (float)getHeight:(NSDictionary *)info
{
    return (293 + 49) * PJSAH;
}


@end
