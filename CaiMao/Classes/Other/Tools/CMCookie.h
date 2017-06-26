//
//  CMCookie.h
//  CaiMao
//
//  Created by WangWei on 17/1/3.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMCookie : NSObject
+(void)getAndSaveCookie; //获取和保存cookie
+(void)deleteCookie;//删除cookie

+(void)setCoookieForHost:(NSString*)Host;
@end
