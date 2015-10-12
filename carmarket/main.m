//
//  main.m
//  carmarket
//
//  Created by itensb on 14-8-4.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UI7Kit/UI7Kit.h>
#import "SBAppDelegate.h"

#import "UI7Switch.h"

int main(int argc, char * argv[])
{
    @autoreleasepool {
        
        [UI7TableView patchIfNeeded];
        [UI7SegmentedControl patchIfNeeded];
        [UI7Toolbar patchIfNeeded];  //键盘上面的工具条
        [UI7Switch patchIfNeeded];
        [UI7TextField patchIfNeeded];
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([SBAppDelegate class]));
    }
}

