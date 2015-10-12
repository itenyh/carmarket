//
//  SBPriceDetailViewController.h
//  carmarket
//
//  Created by Apple on 14-8-17.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBBaseViewController.h"

#import "SBLowPriceCarInfoTblCell.h"
#import "SBLowPriceCarComTblCell.h"
#import "SBLowPriceConcreteTblCell.h"
#import "SBLowPriceStrechBtnTblCell.h"
#import "SBLowPriceCarComNameTblCell.h"
#import "SBLowPriceCarComAddTblCell.h"
#import "SBLowPriceComTeleTblCell.h"
#import "SBDetailInfoDealerInfoTblCell.h"
#import "SBDetailInfoOtherInfoTblCell.h"

#import "BKUpdateTableView.h"

#import "SBLowPriceBottomMenu.h"
#import "SBBuyCarVCInterface.h"
#import "SBPriceConsultViewController.h"

#import "SBMapViewController.h"
#import "SBWebViewController.h"

@interface SBPriceDetailViewController : SBBaseViewController
{
    NSMutableDictionary *infos;
    BKUpdateTableView *tbView;
}

@end
