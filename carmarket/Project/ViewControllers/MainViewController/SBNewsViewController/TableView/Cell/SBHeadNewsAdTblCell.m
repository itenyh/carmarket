//
//  SBHeadNewsTblCell.m
//  carmarket
//
//  Created by itensb on 14-8-7.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBHeadNewsAdTblCell.h"

@implementation SBHeadNewsAdTblCell
@synthesize adDatas, mainScorllView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        adDatas = [NSArray array];
        
        mainScorllView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, [ITUIKitHelper getAppWidth], [SBHeadNewsAdTblCell getHeight:nil]) animationDuration:2];
        [self.contentView addSubview:mainScorllView];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(correctAdBug) name:NOTI_ENTER_FORGROUND object:nil];
        
    }
    
    return self;
}

#pragma mark - ImagePlayerViewDelegate
- (void)display:(NSDictionary *)info
{
    [super display:info];
}

- (void)displayWithDatas:(NSArray *)datas
{

//    if (mainScorllView) {
//        
//        [mainScorllView destroyTimer];
//        [mainScorllView removeFromSuperview];
//        mainScorllView = nil;
//        
//        mainScorllView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, [SBHeadNewsAdTblCell getHeight:nil]) animationDuration:2];
//        [self.contentView addSubview:mainScorllView];
//    }
//    
//    NSLog(@"new");
    
    adDatas = datas;
    
    int allDatasNum = (datas.count >= ADDATA_NUM ? ADDATA_NUM : datas.count);
    
    NSMutableArray *viewsArray = [@[] mutableCopy];
    
    for (int i = 0; i < allDatasNum; ++i) {
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [ITUIKitHelper getAppWidth], [SBHeadNewsAdTblCell getHeight:nil])];
        [imgView sd_setImageWithURL:[NSURL URLWithString:[[datas objectAtIndex:i] objectForKey:@"titleImg"]] placeholderImage:[SBUIFactory getPlaceHolderImg]];
                     
        UIView *bgMask = [[UIView alloc] initWithFrame:CGRectMake(0, imgView.frame.size.height - 25, imgView.frame.size.width, 25)];
        bgMask.backgroundColor = [ITUIKitHelper color:@"000000" alpha:0.5];
        [imgView addSubview:bgMask];
        
        UILabel *titleLabel = [ITUIKitHelper createLabel:[[datas objectAtIndex:i] objectForKey:@"title"] size:CGSizeMake(220, bgMask.frame.size.height) font:[UIFont systemFontOfSize:14] color:[UIColor whiteColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(8, 0) superViewFrame:self.frame];
        [bgMask addSubview:titleLabel];
        
        [viewsArray addObject:imgView];
        
    }
    
    mainScorllView.totalPagesCount = ^NSInteger(void){
        return viewsArray.count;
    };
    mainScorllView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        if(pageIndex < viewsArray.count) return viewsArray[pageIndex];
        else return [UIView new];
    };
    
    __weak UITableViewCell *temp = self;
    __weak NSArray *tempDatas = adDatas;
    
    mainScorllView.TapActionBlock = ^(NSInteger pageIndex){
        
        RUPWarning([[ITUtils viewControllerFor:temp] performSelector:@selector(SBHeadNewsAdTblCell_ADData:) withObject:[tempDatas objectAtIndex:pageIndex]]);
        
    };

}

+ (float)getHeight:(NSDictionary *)info
{
    float arg = 200.0f / 320.0f;
    return [ITUIKitHelper getAppWidth] * arg;
}

- (void)correctAdBug
{
//    NSLog(@"correctAdBug");
    [mainScorllView.scrollView setContentOffset:CGPointMake(0, 0)];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
