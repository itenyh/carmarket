//
//  SBNewsVCInterface.h
//  carmarket
//
//  Created by itensb on 14-9-9.
//  Copyright (c) 2014年 chinaCQ. All rights reserved.
//

#import "SBBaseInterface.h"

@interface SBNewsVCInterface : SBBaseInterface

+ (void)requestNewsTypeWithsuccessBlock:(void (^)(id successValue))successBlock  andFailBlock:(void (^)(id failValue))failBlock;

+ (void)requestNewsWithTypeId:(NSString *)typeId pageNum:(int)pageNum pageIndex:(int)pageIndex successBlock:(void (^)(id successValue))successBlock  andFailBlock:(void (^)(id failValue))failBlock;

@end
