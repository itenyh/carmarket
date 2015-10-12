//
//  SBSecondCarOtherInfoTblCell.m
//  carmarket
//
//  Created by Apple on 14-9-23.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBSecondCarOtherInfoTblCell.h"

@implementation SBSecondCarOtherInfoTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        float inset = 10;
        
        UILabel *shangpaishijian = [self createLabel:@"上牌照时间:" point:CGPointMake(34 * PJSAH, 10)];
        UILabel *didian = [self createLabel:@"拍照地点:" point:CGPointMake(34 * PJSAH, [ITUIKitHelper yMarTopView:shangpaishijian margin:inset])];
        UILabel *huanbao = [self createLabel:@"环保标准:" point:CGPointMake(34 * PJSAH, [ITUIKitHelper yMarTopView:didian margin:inset])];
        UILabel *cheshen = [self createLabel:@"车身颜色:" point:CGPointMake(34 * PJSAH, [ITUIKitHelper yMarTopView:huanbao margin:inset])];
        UILabel *neibu = [self createLabel:@"内饰颜色:" point:CGPointMake(34 * PJSAH, [ITUIKitHelper yMarTopView:cheshen margin:inset])];
        UILabel *nianjian = [self createLabel:@"年检到期:" point:CGPointMake(34 * PJSAH, [ITUIKitHelper yMarTopView:neibu margin:inset])];
        UILabel *baoxian = [self createLabel:@"保险到期:" point:CGPointMake(34 * PJSAH, [ITUIKitHelper yMarTopView:nianjian margin:inset])];
        UILabel *dianhua = [self createLabel:@"资讯电话:" point:CGPointMake(34 * PJSAH, [ITUIKitHelper yMarTopView:baoxian margin:inset])];
        UILabel *shuxing = [self createLabel:@"其他属性:" point:CGPointMake(34 * PJSAH, [ITUIKitHelper yMarTopView:dianhua margin:inset])];
        
        shangpaishijianL = [self createLabelL:shangpaishijian];
        didianL = [self createLabelL:didian];
        huanbaoL = [self createLabelL:huanbao];
        cheshenL = [self createLabelL:cheshen];
        neibuL = [self createLabelL:neibu];
        nianjianL = [self createLabelL:nianjian];
        baoxianL = [self createLabelL:baoxian];
        dianhuaL = [self createLabelL:dianhua];
        shuxingL = [self createLabelL:shuxing];
    }
    
    return self;
    
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
    
    NSDictionary *data = [info objectForKey:@"data"];
    NSDictionary *oldData = [info objectForKey:@"oldData"];
    
    shangpaishijianL.text = [SBUtil getTimeWithTimeInterval:data key:@"cardTime"];
    didianL.text = [data objectForKey:@"carCardAddr"];
    huanbaoL.text = [data objectForKey:@"eps"];
    cheshenL.text = [data objectForKey:@"carColor"];
    neibuL.text = [data objectForKey:@"interiorColor"];
    nianjianL.text = [SBUtil getTimeWithTimeInterval:data key:@"annualExpire"];
    baoxianL.text = [SBUtil getTimeWithTimeInterval:data key:@"insuranceExpire"];
    shuxingL.text = [data objectForKey:@"otherAttr"];
    if(oldData) dianhuaL.text = [oldData objectForKey:@"createPhone"];
    
}

- (UILabel *)createLabel:(NSString *)title point:(CGPoint)point
{
    UILabel *l = [ITUIKitHelper createLabel:title font:[UIFont systemFontOfSize:30 * PJSAH] color:[ITUIKitHelper color:@"727272"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:point superViewFrame:self.frame];
    [self.contentView addSubview:l];
    return l;
}

- (UILabel *)createLabelL:(UILabel *)lf
{
    UILabel *l = [ITUIKitHelper createLabel:@"" size:CGSizeMake(200, -1) font:[UIFont systemFontOfSize:30 * PJSAH] color:[ITUIKitHelper color:@"727272"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:lf margin:4], lf.frame.origin.y) superViewFrame:self.frame];
    [self.contentView addSubview:l];
    return l;
}

+ (float)getHeight:(NSDictionary *)info
{
    return 250;
}

@end
