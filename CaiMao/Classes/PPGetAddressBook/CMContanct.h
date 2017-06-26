//
//  CMContanct.h
//  CaiMao
//
//  Created by MAC on 16/10/12.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CMContanct : NSObject<NSCoding>
/** 联系人姓名*/
@property (nonatomic, copy) NSString *Name;
/** 联系人电话数组,因为一个联系人可能存储多个号码*/
@property (nonatomic, strong) NSMutableArray *mobileArray;
/** 联系人电话*/
@property (nonatomic, copy) NSString *Tel;
/** 联系人头像*/
@property (nonatomic, strong) NSData *headerImage;
/** 联系人头像颜色*/
@property (nonatomic, strong) UIColor *headerbackColor;

/** 联系人邮箱数组,因为一个联系人可能存储多个邮箱*/
@property (nonatomic, copy) NSString *Email;
/** 联系人是否发送邀请*/
@property (nonatomic, assign) BOOL isSend;

/** 联系人是否被邀请*/
@property (nonatomic, assign) BOOL isInvation;

@end
