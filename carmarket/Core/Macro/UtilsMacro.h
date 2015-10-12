//
//  UtilsMacro.h
//  CoacoapodsDemo
//
//  Created by Apple on 14-7-22.
//  Copyright (c) 2014年 itenyhCom. All rights reserved.
//

//快捷定义单例模式，自己在头文件添加 +(classname *)instance 方法
#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
static classname *shared##classname = nil; \
+ (classname *)instance \
{\
@synchronized(self) \
{\
if (shared##classname == nil) \
{\
shared##classname = [[self alloc] init]; \
if ([shared##classname respondsToSelector:@selector(setup)]) \
RUPWarning([shared##classname performSelector:@selector(setup)]); \
} \
} \
return shared##classname; \
} \
+ (id)allocWithZone:(NSZone *)zone \
{\
@synchronized(self) \
{\
if (shared##classname == nil) \
{\
shared##classname = [super allocWithZone:zone]; \
return shared##classname; \
} \
} \
return nil; \
} \
- (id)copyWithZone:(NSZone *)zone \
{ \
return self; \
} \

#define SYNTHESIZE_SINGLETON_FOR_CLASS_WITHOUTINIT(classname) \
static classname *shared##classname = nil; \
+ (id)allocWithZone:(NSZone *)zone \
{\
@synchronized(self) \
{\
if (shared##classname == nil) \
{\
shared##classname = [super allocWithZone:zone]; \
return shared##classname; \
} \
} \
return nil; \
} \
- (id)copyWithZone:(NSZone *)zone \
{ \
return self; \
}