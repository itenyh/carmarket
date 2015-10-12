//
//  SBAVOSTools.m
//  carmarket
//
//  Created by itensb on 15-1-13.
//  Copyright (c) 2015年 chinaCQ. All rights reserved.
//

#import "SBAVOSTools.h"
#import "UtilsMacro.h"
#import <AVOSCloud/AVOSCloud.h>

@implementation SBAVOSTools
@synthesize ad_img_dict;

SYNTHESIZE_SINGLETON_FOR_CLASS_WITHOUTINIT(SBAVOSTools);

+ (SBAVOSTools *)instance
{
    
    @synchronized(self)
    {
        if (sharedSBAVOSTools == nil)
        {
            sharedSBAVOSTools = [SBAVOSTools new];
            sharedSBAVOSTools.ad_img_dict = [NSMutableDictionary dictionary];
        }
    }
    
    return sharedSBAVOSTools;
    
}

- (void)register_SBAVOSTools
{
    [AVOSCloud setApplicationId:@"rpoy2x6k2do4mj1ve9xhs86n2jlf24dbeay3roo5bdxe6bhq"
                      clientKey:@"jxrbvvj824o6zxgwgpqnjyjzgh7hp3kez5f5ktjrejgabw53"];
}

#pragma -mark 应用函数
//{ready:, data:[{imageName:image},], data_num:}
- (NSMutableDictionary *)start_loading_ads
{
    AVQuery *query = [AVQuery queryWithClassName:@"UserPhoto"];
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSMutableDictionary dictionary], @"data", [NSNumber numberWithInt:0], @"data_num", [NSNumber numberWithBool:NO], @"ready", nil];
    sharedSBAVOSTools.ad_img_dict = result;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (!error) {
            
            // The find succeeded.
//            NSLog(@"Successfully retrieved %d scores.", objects.count);
            
            for (AVObject *o in objects) {
                
                
                AVFile *imageFile = [o valueForKey:@"imageFile"];
                NSString *imgName = imageFile.name;
                int all_num = objects.count;
                
                [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                    
                    if (!error) {
                        
                        @try {
                            
                            
                            NSMutableDictionary *datas = [result objectForKey:@"data"];
                            [datas setObject:[UIImage imageWithData:data] forKey:imgName];
                            
                            int now_count = [[result objectForKey:@"data_num"] integerValue];
                            now_count++;
                            BOOL ready = all_num == now_count ? YES : NO;
                            
                            [result setObject:[NSNumber numberWithInt:now_count] forKey:@"data_num"];
                            [result setObject:[NSNumber numberWithBool:ready] forKey:@"ready"];
                            
//                            NSLog(@"装填完毕");
                            
                        }
                        @catch (NSException *exception) {
                            
                            NSLog(@"findObjectsInBackgroundWithBlock NSException : %@", exception);
                        }
                        
                    }
                    
                    else NSLog(@"Error: %@ %@", error, [error userInfo]);
                    
                }];
                
            }
            
            
        }
        
        else NSLog(@"Error: %@ %@", error, [error userInfo]);
        
    }];
    
    return result;
}

//没有数据，或者没请求完，都算是没有准备好
- (BOOL)is_ads_ready
{
//    NSLog(@"检测完毕");
    
    return [[sharedSBAVOSTools.ad_img_dict objectForKey:@"ready"] integerValue] == 1;
}

- (NSMutableDictionary *)get_ad_images
{
    return [sharedSBAVOSTools.ad_img_dict objectForKey:@"data"];
}

#pragma -mark 一些测试函数
- (void)test_insert_data
{
    AVObject *testObject = [AVObject objectWithClassName:@"TestObject"];
    [testObject setObject:@"bar" forKey:@"foo"];
    [testObject save];
}

- (void)test_insert_img
{
    UIImage *image = [UIImage imageNamed:@"frs.jpg"];
    NSData *imageData = UIImagePNGRepresentation(image);
    AVFile *imageFile = [AVFile fileWithName:@"testimage.jpg" data:imageData];
    [imageFile save];
    
    AVObject *userPhoto = [AVObject objectWithClassName:@"UserPhoto"];
    [userPhoto setObject:@"My trip to Hawaii!" forKey:@"imageName"];
    [userPhoto setObject:imageFile             forKey:@"imageFile"];
    [userPhoto save];
}

- (void)test_get_img
{
//    AVObject *jobApplication = [AVObject objectWithClassName:@"UserPhoto"];
//    AVFile *applicantResume = [jobApplication objectForKey:@"imageFile"];
//    NSData *resumeData = [applicantResume getData];
    
    AVQuery *query = [AVQuery queryWithClassName:@"UserPhoto"];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            
            for (AVObject *o in objects) {
                
                
                    AVFile *imageFile = [o valueForKey:@"imageFile"];
                    
                    NSLog(@"url : %@", imageFile.url);
              
        
                
            }
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}

@end
