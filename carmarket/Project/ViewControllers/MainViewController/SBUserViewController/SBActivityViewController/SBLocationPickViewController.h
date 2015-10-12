//
//  SBLocationPickViewController.h
//  carmarket
//
//  Created by itensb on 14-8-19.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBBaseViewController.h"

@interface SBLocationPickViewController : SBBaseViewController

- (id)initWithNavi:(BOOL)navi handler:(InfoHandler)_handler leftBtnType:(NDLeftBtnType)type navTitle:(NSString *)_navTitle;
@end
