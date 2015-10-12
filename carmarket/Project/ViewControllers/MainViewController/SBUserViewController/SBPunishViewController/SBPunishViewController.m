//
//  SBPunishViewController.m
//  carmarket
//
//  Created by itensb on 14-10-15.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBPunishViewController.h"

@interface SBPunishViewController ()

@end

@implementation SBPunishViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"违章查询";
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"punishment" ofType:@"html"];
    
    [self loadWebPageWithString:[NSURL URLWithString:path]];
    
}


@end
