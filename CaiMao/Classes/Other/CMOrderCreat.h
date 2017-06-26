//
//  CMOrderCreat.h
//  CaiMao
//
//  Created by MAC on 16/7/21.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMOrderCreat : NSObject
+ (CMOrderCreat *)sharedAPI ;
-(void)requestBankSureOrderMessageWithBankNum:(NSString*)aBankNum andHYID:(NSString*)aHYID andUserName:(NSString*)aUserName andUserID:(NSString *)aUserID success:(void(^)(id))sucess;
-(void)requeRechargeOrderMessageWithBankCode:(NSString*)aBankCode andHYID:(NSString*)aHYID andMount:(NSString *)aMount success:(void(^)(id))sucess;
@end
