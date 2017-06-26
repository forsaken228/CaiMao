//
//  CMOrderManager.h
//  CaiMao
//
//  Created by WangWei on 16/11/22.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMOrderManager : NSObject<LLPaySdkDelegate>
CMSingletonH(CMOrderManager)
@property(nonatomic,retain)LLPaySdk *sdk;

-(void)CMorderManagerFromLLSdkWithOrderDict:(NSDictionary*)orderDict PersentController:(UIViewController*)controller;

-(NSMutableDictionary*)creatRechargeOrderWithPartner:(NSString*)aPartner andOrderTime:(NSString*)aOrderTime andOrderNum:(NSString *)aOrderNum andOrderMoney:(NSString*)aOrderMoney andOrderName:(NSString*)aOrderName andOrderInfo:(NSString*)aOrderInfor andOrderValid:(NSString*)aValid andUserRegistDate:(NSString*)aRegistDate WithUserName:(NSString*)UserName WithUserPhone:(NSString*)UserPhone andUserCardID:(NSString*)UserCardID andUserBankID:(NSString*)UserBankID;

@property(nonatomic,copy)void(^resultBlock)(LLPayResult resultcode, NSDictionary *resultDict);
@end
