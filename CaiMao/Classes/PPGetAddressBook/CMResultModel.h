//
//  CMResultModel.h
//  CaiMao
//
//  Created by WangWei on 16/12/19.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMResultModel : NSObject
/** 联系人是否已注册*/
@property(nonatomic,copy)NSString *HYID;
/** 已注册联系人电话*/
@property(nonatomic,copy)NSString *Tel;
@end
