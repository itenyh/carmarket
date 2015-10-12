//
//  SBCarStylePriceTblCell.m
//  carmarket
//
//  Created by itensb on 14-8-6.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBCarStylePriceTblCell.h"

static const CGFloat titleCellWidth = 372 * PJSAH;

@implementation SBCarStylePriceTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        kCellHeightMax = [UIFont boldSystemFontOfSize:35 * PJSAH].lineHeight * 2;
        
        btns = [NSMutableArray array];
        
        bottom = [[UIView alloc] initWithFrame:CGRectMake(26 * PJSAH, 20 * PJSAH, ([ITUIKitHelper getAppWidth] - 26 * PJSA), 0)];
        bottom.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bottom];
        
        title = [ITUIKitHelper createLabel:@"" size:CGSizeMake(titleCellWidth, -1) font:[UIFont boldSystemFontOfSize:35 * PJSAH] color:[ITUIKitHelper color:@"181818"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(24 * PJSAH, 25 * PJSAH) superViewFrame:self.frame];
        title.numberOfLines = 2;
        [bottom addSubview:title];
        
        subTitle = [ITUIKitHelper createLabel:@"" size:CGSizeMake(titleCellWidth, -1) font:[UIFont systemFontOfSize:25 * PJSAH] color:[ITUIKitHelper color:@"878787"] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(title.frame.origin.x, [ITUIKitHelper yMarTopView:title margin:26 * PJSAH]) superViewFrame:self.frame];
        [bottom addSubview:subTitle];
        
        price = [ITUIKitHelper createLabel:@"" size:CGSizeMake(219 * PJSAH, -1) font:[UIFont systemFontOfSize:28 * PJSAH] color:[ITUIKitHelper color:@"c30114"] marginInsets:[ITUIKitHelper ITMarginInsetsMake:-1 right:60 * PJSAH] point:CGPointMake(-1, 31 * PJSAH) superViewFrame:bottom.frame];
        price.textAlignment = NSTextAlignmentRight;
        [bottom addSubview:price];
        
        subPrice = [ITUIKitHelper createLabel:@"" size:CGSizeMake(219 * PJSAH, -1) font:[UIFont systemFontOfSize:25 * PJSAH] color:[ITUIKitHelper color:@"878787"] marginInsets:[ITUIKitHelper ITMarginInsetsMake:-1 right:60 * PJSAH] point:CGPointMake(0, 5) superViewFrame:bottom.frame];
        subPrice.textAlignment = NSTextAlignmentRight;
        [bottom addSubview:subPrice];
        
//        [self createBottomBtn:@"加入对比" index:0];
//        [self createBottomBtn:@"购车计算" index:1];
//        [self createBottomBtn:@"一键询价" index:2];
        
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
 
    NSString *carName = [info objectForKey:@"carName"];
    CGSize maxSize = CGSizeMake(titleCellWidth, kCellHeightMax);
    CGSize labelSize = [carName sizeWithFont:title.font
                                         constrainedToSize: maxSize
                                             lineBreakMode: NSLineBreakByTruncatingTail];
    title.text = carName;
    [ITUIKitHelper sizeSet:title size:labelSize];
    
    subTitle.text = [NSString stringWithFormat:@"%@马力%@档%@", [info objectForKey:@"horsepower"], [info objectForKey:@"forwardGearNum"], [info objectForKey:@"gearboxDetail"]];
    [ITUIKitHelper pointSet:subTitle piont:CGPointMake(-1, [ITUIKitHelper yMarTopView:title margin:26 * PJSAH])];

    price.text = [NSString stringWithFormat:@"%@万起", [SBUtil getOneWeiFloatStr:[info objectForKey:@"dealerMinPrice"]]];
    
    subPrice.text = [NSString stringWithFormat:@"指导价：%@", [info objectForKey:@"factoryPrice"]];
    [ITUIKitHelper pointSet:subPrice piont:CGPointMake(-1, subTitle.frame.origin.y)]; //对其subtitle
    
    [ITUIKitHelper sizeSet:bottom size:CGSizeMake(-1, [SBCarStylePriceTblCell getHeight:info] - 20 * PJSAH * 2)];
    
    [btns bk_each:^(UIButton *obj) {
        [ITUIKitHelper pointSet:obj piont:CGPointMake(-1, bottom.frame.size.height - obj.frame.size.height)];
    }];
    
    [ITUIKitHelper removeLineViews:bottom];
    [SBUIFactory decorateWithLine:bottom width:0.5 type:ITLineDecorateAll];
}

+ (float)getHeight:(NSDictionary *)info
{
    NSString *cellString = [info objectForKey:@"carName"];
    CGSize maxSize = CGSizeMake(titleCellWidth, [UIFont boldSystemFontOfSize:35 * PJSAH].lineHeight * 2);
    CGSize labelSize = [cellString sizeWithFont:[UIFont boldSystemFontOfSize:35 * PJSAH]
                              constrainedToSize: maxSize
                                  lineBreakMode: NSLineBreakByTruncatingTail];
    
    return 95 + labelSize.height - 78 * PJSAH;
}

- (void)createBottomBtn:(NSString *)t index:(int)index
{
    
//    UIButton *duibi = [[UIButton alloc] initWithFrame:CGRectMake(bottom.frame.size.width / 3.0 * index, bottom.frame.size.height - 78 * PJSAH, bottom.frame.size.width / 3.0, 78 * PJSAH)];
    UIButton *duibi = [[UIButton alloc] initWithFrame:CGRectMake(0, bottom.frame.size.height - 78 * PJSAH, bottom.frame.size.width, 78 * PJSAH)];
    [duibi setTitleColor:[ITUIKitHelper color:@"434343"] forState:UIControlStateNormal];
    duibi.titleLabel.font = [UIFont systemFontOfSize:35 * PJSAH];
    [duibi setTitle:t forState:UIControlStateNormal];
    [duibi setBackgroundColor:[ITUIKitHelper color:245 blue:245 green:245 alpha:1]];
    duibi.tag = index;
    [duibi bk_addEventHandler:^(id sender) {
        RUPWarning([[ITUtils viewControllerFor:self] performSelector:@selector(SBCarStylePriceTblCell_Button:Cell:) withObject:duibi withObject:self]);
    } forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:duibi];
    [bottom addSubview:duibi];
}

@end
