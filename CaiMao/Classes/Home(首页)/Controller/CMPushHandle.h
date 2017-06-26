//
//  CMPushHandle.h
//  CaiMao
//
//  Created by WangWei on 16/11/19.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMPushHandle : NSObject
+(void)PushMessageWithDict:(NSDictionary*)dict withController:(UIViewController*)controlller;
@end
