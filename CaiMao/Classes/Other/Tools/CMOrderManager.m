//
//  CMOrderManager.m
//  CaiMao
//
//  Created by WangWei on 16/11/22.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMOrderManager.h"

@implementation CMOrderManager
CMSingletonM(CMOrderManager)

-(void)CMorderManagerFromLLSdkWithOrderDict:(NSDictionary*)orderDict PersentController:(UIViewController*)controller{
    
    LLPayUtil *payUtil = [[LLPayUtil alloc] init];
    
    // 进行签名
    NSDictionary *signedOrder = [payUtil signedOrderDic:orderDict andSignKey:PartnerKey];
    
    // NSLog(@"self.OrderDict===%@",signedOrder);
    
    self.sdk = [LLPaySdk sharedSdk];
    self.sdk.sdkDelegate = self;
    
    // 认证支付;
    [self.sdk presentLLPaySDKInViewController:controller withPayType:LLPayTypeVerify andTraderInfo:signedOrder];

}

- (void)paymentEnd:(LLPayResult)resultCode withResultDic:(NSDictionary*)dic{
    if(self.resultBlock){
    self.resultBlock(resultCode,dic);
    }
}

#pragma mark创建充值订单
-(NSMutableDictionary*)creatRechargeOrderWithPartner:(NSString*)aPartner andOrderTime:(NSString*)aOrderTime andOrderNum:(NSString *)aOrderNum andOrderMoney:(NSString*)aOrderMoney andOrderName:(NSString*)aOrderName andOrderInfo:(NSString*)aOrderInfor andOrderValid:(NSString*)aValid andUserRegistDate:(NSString*)aRegistDate WithUserName:(NSString*)UserName WithUserPhone:(NSString*)UserPhone andUserCardID:(NSString*)UserCardID andUserBankID:(NSString*)UserBankID{
    
    NSString *signType = @"MD5";
    NSString *user_id=[NSString stringWithFormat:@"%@",[CMUserDefaults objectForKey:@"userID"]];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setDictionary:@{
                           @"sign_type":signType,
                           //签名方式	partner_sign_type	是	String	RSA  或者 MD5
                           @"busi_partner":aPartner,
                           //商户业务类型	busi_partner	是	String(6)	虚拟商品销售：101001
                           @"dt_order":aOrderTime,
                           //商户订单时间	dt_order	是	String(14)	格式：YYYYMMDDH24MISS  14位数字，精确到秒
                           @"money_order":aOrderMoney,
                           @"no_order":aOrderNum,
                           //商户唯一订单号	no_order	是	String(32)	商户系统唯一订单号
                           @"name_goods":aOrderName,
                           //商品名称	name_goods	否	String(40)
                           @"info_order":aOrderInfor,
                           //订单附加信息	info_order	否	String(255)	商户订单的备注信息
                           @"valid_order":aValid,
                           //分钟为单位，默认为10080分钟（7天），从创建时间开始，过了此订单有效时间此笔订单就会被设置为失败状态不能再重新进行支付。

                           @"notify_url":@"http://m.58cm.com/handler/AppInterfaceTX.ashx",
                           
                           @"risk_item" : [LLPayUtil jsonStringOfObj:@{@"user_info_dt_register":aRegistDate,@"rms_ware_category":@"2009",@"user_info_mercht_userno":user_id,@"user_info_bind_phone":UserPhone,@"user_info_full_name":UserName,@"user_info_id_no":UserCardID,@"user_info_identify_state":@"1",@"user_info_identify_type":@"3"}],
                           
                           @"user_id":user_id,
                           //商户用户唯一编号 否 该用户在商户系统中的唯一编号，要求是该编号在商户系统中唯一标识该用户
                           @"flag_modify":@"1",
                           @"card_no":UserBankID,
                           
                           }];
    
    BOOL isIsVerifyPay = YES;
    
    if (isIsVerifyPay) {
        
        [param addEntriesFromDictionary:@{
                                          @"id_no":UserCardID,
                                          //证件号码 id_no 否 String
                                          @"acct_name":UserName,
                                          //银行账号姓名 acct_name 否 String
                                          @"id_type":@"0"
                                          }];
    }
    param[@"oid_partner"] = OidPartner;
    return param;
    
    
}


@end
