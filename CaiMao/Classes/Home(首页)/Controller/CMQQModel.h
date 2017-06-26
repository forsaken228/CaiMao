//
//  CMQQModel.h
//  CaiMao
//
//  Created by WangWei on 16/12/17.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMQQModel : NSObject
/** QQ联系人名称*/
@property(nonatomic,copy)NSString *Name;
/** QQ联系人邮箱*/
@property(nonatomic,copy)NSString *Email;
/** QQ联系人是否发送邀请*/
@property(nonatomic,assign)BOOL isSend;
@end
