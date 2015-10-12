//
//  SBCarCommentTblCell.m
//  carmarket
//
//  Created by itensb on 14-8-13.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBCarCommentTblCell.h"

@implementation SBCarCommentTblCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
       
        title = [ITUIKitHelper createLabel:@"" size:CGSizeMake(240, -1) font:[UIFont boldSystemFontOfSize:14] color:[UIColor blackColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(5, 10) superViewFrame:self.frame];
        title.backgroundColor = TEST_BGCOLOR;
        [self.contentView addSubview:title];
        
        author = [ITUIKitHelper createLabel:@"" size:CGSizeMake(120, -1) font:[UIFont boldSystemFontOfSize:12] color:[UIColor lightGrayColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake(5, [ITUIKitHelper yMarTopView:title margin:5]) superViewFrame:self.frame];
        author.backgroundColor = TEST_BGCOLOR;
        [self.contentView addSubview:author];
        
        time = [ITUIKitHelper createLabel:@"" size:CGSizeMake(120, -1) font:[UIFont boldSystemFontOfSize:12] color:[UIColor lightGrayColor] marginInsets:[ITUIKitHelper InvalideITMarginInsets] point:CGPointMake([ITUIKitHelper xMarLeftView:author margin:20], [ITUIKitHelper yMarTopView:title margin:5]) superViewFrame:self.frame];
        time.backgroundColor = TEST_BGCOLOR;
        [self.contentView addSubview:time];
        
    }
    
    return self;
}

- (void)display:(NSDictionary *)info
{
    [super display:info];
    
    title.text = @"二线城市幸福多，开着F3唱着歌";
    author.text = @"谁给我的世界";
    time.text = @"2014-7-17";
    
}

+ (float)getHeight:(NSDictionary *)info
{
    return 50;
}

@end
