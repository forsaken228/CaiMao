//
//  CMOrderCreat.m
//  CaiMao
//
//  Created by MAC on 16/7/21.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMOrderCreat.h"

@implementation CMOrderCreat

+ (CMOrderCreat *)sharedAPI {
    static CMOrderCreat *_sharedRequestAPI = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedRequestAPI = [[CMOrderCreat alloc] init];
    });
    return _sharedRequestAPI;
}

#pragma mark 银行卡认证创建订单
-(void)requestBankSureOrderMessageWithBankNum:(NSString*)aBankNum andHYID:(NSString*)aHYID andUserName:(NSString*)aUserName andUserID:(NSString *)aUserID success:(void(^)(id))sucess{
    NSString *str=[NSString stringWithFormat:@"%@//handler/AppInterfaceTX.ashx?Action=%d&BCNum=%@&CardID=%@&HYID=%@&Name=%@",OnLineCode,6,aBankNum,aUserID,aHYID,aUserName];
    [CMHttpTool  getRecordWithURL:str params:nil success:^(id responseObj) {
        
        if (sucess) {
            
            NSDictionary *dict=(NSDictionary*)responseObj;
            sucess(dict);
            
        }
        
    } failure:^(NSError *error) {
        
    }];

}
#pragma mark 充值订单
-(void)requeRechargeOrderMessageWithBankCode:(NSString*)aBankCode andHYID:(NSString*)aHYID andMount:(NSString *)aMount success:(void(^)(id))sucess{
    
    // NSString *name=[userCell.realName.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *str=[NSString stringWithFormat:@"%@/handler/AppInterfaceTX.ashx?Action=%d&Amount=%@&BCardID=%@&HYID=%@",OnLineCode,4,aMount,aBankCode,aHYID];
    DLog(@"----%@",str);
    [CMHttpTool  getRecordWithURL:str params:nil success:^(id responseObj) {
      
        if (sucess) {
            NSDictionary *dic=(NSDictionary*)responseObj;
            
            sucess(dic);
        }
       
   
        
        
    } failure:^(NSError *error) {
        
    }];

    
    
}
@end
