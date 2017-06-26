//
//  CMRenZheng.h
//  CaiMao
//
//  Created by MAC on 16/7/30.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessBlock)(id responseObj);

typedef void(^FailBlock)(id error);
@interface CMRequestManager : NSObject

//+ (CMRequestManager *)sharedAPI ;
CMSingletonH(CMRequestManager)
#pragma mark 请求认证信息
-(void)requestRenZhengMsgsuccess:(SuccessBlock)success andFailure:(FailBlock)Failure;
#pragma mark 请求用户银行卡列表信息
-(void)requestBankListMsgsuccess:(SuccessBlock)success andFailure:(FailBlock)Failure;
#pragma mark 支持银行卡列表
-(void)requestSupportBankListMsgsuccess:(SuccessBlock)success;
#pragma mark 同步M站
-(void)synchronizationWebSuccess:(SuccessBlock)success;
#pragma mark 获取定期宝
-(void)GetDingQiBaoProductMsgSuccess:(SuccessBlock)success andFailure:(FailBlock)Failure;
#pragma mark 获取首页顶部广告
-(void)GetHomeBarImagesAdsSuccess:(SuccessBlock)success andFailure:(FailBlock)Failure;
#pragma mark 加载最新动态
-(void)GetHomeNewActionsSuccess:(SuccessBlock)success andFailure:(FailBlock)Failure;
#pragma mark 获取月息盈
-(void)GetYueXiYingProductMsgSuccess:(SuccessBlock)success andFailure:(FailBlock)Failure;

#pragma mark 获取聚嗨利
-(void)GetJuHaiLiProductMsgSuccess:(SuccessBlock)success andFailure:(FailBlock)Failure;
#pragma mark 获取喵杀惠
-(void)GetMiaoShaHuiProductMsgSuccess:(SuccessBlock)success andFailure:(FailBlock)Failure;
#pragma mark 获取新客专享
-(void)GetXinKeProductMsgSuccess:(SuccessBlock)success andFailure:(FailBlock)Failure;

#pragma mark 获取新客专享
-(void)GetTeHuiBarMsgSuccess:(SuccessBlock)success andFailure:(FailBlock)Failure;

#pragma mark 获取新客顶部
-(void)GetTeHuiTopAdsMsgSuccess:(SuccessBlock)success andFailure:(FailBlock)Failure;

#pragma mark 获取Vip信息
-(void)GetVipMsgWithHYID:(NSString*)aHYID andSuccess:(void(^)(id responseObj))success;
#pragma mark 获取用户账户信息
-(void)GetAccountMsgWithHYID:(NSString*)aHYID andSuccess:(void(^)(id responseObj))success;
#pragma mark 上传通讯录
-(void)uploadContanctWithID:(NSString*)ID andArr:(NSMutableArray*)arr andSuccess:(void(^)(id responseObj))success;

#pragma mark 上传QQ邮箱
-(void)uploadQQEmailWithArr:(NSMutableArray*)arr andSuccess:(void(^)(id responseObj))success;

#pragma mark 发送邮件
-(void)sendEmailWithArr:(NSMutableArray*)arr andSuccess:(void(^)(id responseObj))success;

#pragma mark 是否注册
-(void)isRegistWithPhoneArr:(NSMutableArray*)arr andSuccess:(void(^)(id responseObj))success;
#pragma mark 生成短连接
-(void)shortUrl:(NSString*)longURl andSuccess:(void(^)(id responseObj))success;
#pragma mark 财猫生成短连接
-(void)CaiMaoshortUrlWithID:(NSString*)ID andPhone:(NSString*)phone andSuccess:(void(^)(id responseObj))success;

#pragma mark 请求用户状态
-(void)RequestUserStateWithUserID:(NSString*)userID andSuccess:(void(^)(id responseObj))success;
#pragma mark 手机认证
-(void)ThePhoneRenZhengWithUserID:(NSString*)userID andMobile:(NSString*)aMoile andIdeaPassword:(NSString*)aIdealPassword andSmsCode:(NSString*)acode andSuccess:(void(^)(id responseObj))success;
#pragma mark 手机认证验证码
-(void)ThePhoneRenZhengGetSmsCodeWithUserID:(NSString*)userID andMobile:(NSString*)aMobile andSuccess:(void(^)(id responseObj))success;

#pragma mark 绑定邮箱
-(void)setEmailWithUserID:(NSString*)userID andEmailCode:(NSString*)code andEmail:(NSString*)email andSuccess:(void(^)(id responseObj))success;
#pragma mark 绑定邮箱后去验证码
-(void)setEmailCodeWithUserID:(NSString*)userID andEmail:(NSString*)email andSuccess:(void(^)(id responseObj))success;


#pragma mark 修改邮箱
-(void)changeEmailWithUserID:(NSString*)userID andEmailCod:(NSString*)code andEmailName:(NSString*)email andIdealPassword:(NSString*)password andSuccess:(void(^)(id responseObj))success;
#pragma mark 修改获取邮箱验证码
-(void)changeEmailCodeWithUserID:(NSString*)userID andEmail:(NSString*)email andSuccess:(void(^)(id responseObj))success;

#pragma mark 设置交易密码
-(void)setIdealPasswordWithUserId:(NSString*)UserID andUserName:(NSString*)name andNameId:(NSString*)NameId andSMSCode:(NSString*)smsCode andIdealPassword:(NSString*)IdealPassWord andRepeatPassWord:(NSString*)RepeatPassWord andSuccess:(void(^)(id responseObj))success;
#pragma mark设置交易密码获取验证码
-(void)setIdealPasswordSmsCodeWithUserId:(NSString*)UserID andName:(NSString*)aName andNameId:(NSString*)aNameID andSuccess:(void(^)(id responseObj))success;
#pragma mark 重设交易密码
-(void)resetIdealPasswordWithUserId:(NSString*)UserID andSMSCode:(NSString*)smsCode  andNewPassWord:(NSString*)NewPassWord andRepeatPassWord:(NSString*)RepeatPassWord andSuccess:(void(^)(id responseObj))success;
#pragma mark 重设交易密码获取验证码
-(void)resetIdealPasswordGetSmsCodeWithUserId:(NSString*)UserID  andSuccess:(void(^)(id responseObj))success;
#pragma mark 重置登录密码
-(void)resetLoginPassWordWithUserID:(NSString*)userID andNewPassword:(NSString*)NewPassword andRepeatPassWord:(NSString*)RepeatPassWord andSmsCode:(NSString*)SmsCode andSuccess:(void(^)(id responseObj))success;
#pragma mark 重置登录密码获取验证码
-(void)resetLoginPassWordGetCodeWithUserID:(NSString *)userID andSuccess:(void (^)(id responseObj))success;

#pragma mark 请求用户的银行卡列表
-(void)getUserbankListWithUserID:(NSString *)userID andSuccess:(void (^)(id responseObj))success;
#pragma mark 用户身份验证One

-(void)userUserYanZhengWithUserID:(NSString*)userID andNameID:(NSString*)NameID andIdealPassword:(NSString*)IdealPassword andSuccess:(void(^)(id responseObj))success;


-(void)userUserYanZhengWithUserID:(NSString*)userID andName:(NSString*)Name andNameID:(NSString*)NameID andbankNum:(NSString*)aBankNum andfaceImage:(NSString*)faceImage  andbackImage:(NSString*)backImage andSuccess:(void(^)(id responseObj))success;

#pragma mark  我的积分详情
-(void)MyJiFenWithUserID:(NSString*)userID andPageIndex:(NSString*)pageIndex  andSuccess:(void(^)(id responseObj))success andFailure:(void(^)(id error))Failure;
#pragma mark 我的总积分
-(void)myTotalJiFenWithUserID:(NSString*)userID andSuccess:(void(^)(id responseObj))success;
#pragma mark  定期理财
-(void)MyIncomeWithUserID:(NSString*)userID andSuccess:(void(^)(id responseObj))success;

#pragma mark 定期理财持有列表
-(void)MyIncomeChiYouWithUserID:(NSString*)userID andPageIndex:(NSString*)pageIndex  andSuccess:(void(^)(id responseObj))success andFailure:(void(^)(id error))Failure;

#pragma mark 定期理财预定列表
-(void)MyIncomeOrderWithUserID:(NSString*)userID andPageIndex:(NSString*)pageIndex  andSuccess:(void(^)(id responseObj))success andFailure:(void(^)(id error))Failure;

#pragma mark 定期理财结清列表
-(void)MyIncomeJieQingWithUserID:(NSString*)userID andPageIndex:(NSString*)pageIndex  andSuccess:(void(^)(id responseObj))success andFailure:(void(^)(id error))Failure;
#pragma mark 定期理财收益列表
-(void)MyIncomeShouYiWithUserID:(NSString*)userID andProductID:(NSString*)ProductID  andPageIndex:(NSString*)pageIndex  andSuccess:(void(^)(id responseObj))success andFailure:(void(^)(id error))Failure;

#pragma mark 我的M币
-(void)MyMBinWithUserID:(NSString*)userID andPageIndex:(NSString*)pageIndex  andSuccess:(void(^)(id responseObj))success andFailure:(void(^)(id error))Failure;


#pragma mark 获取我的资料
-(void)MyMessageWithUserID:(NSString*)userID andSuccess:(void(^)(id responseObj))success;
#pragma mark 保存我的资料
-(void)SaveMyMessageWithUserID:(NSString*)userID  andNiCheng:(NSString*)NiCheng  andName:(NSString*)name andSex:(NSString*)sex andEmail:(NSString*)email andNameId:(NSString*)NameID andSuccess:(void(^)(id responseObj))success  andFailure:(void(^)(id error))Failure;

#pragma mark 我的优惠券
-(void)MyYouHuiJuanWithUserID:(NSString*)userID  andType:(NSString*)aType andPageIndex:(NSString*)pageIndex andSuccess:(void(^)(id responseObj))success  andFailure:(void(^)(id error))Failure;

#pragma mark 产品信息列表
-(void)getProductListWithUserID:(NSString*)userID  andProductId:(NSString*)Product  andSuccess:(void(^)(id responseObj))success  andFailure:(void(^)(id error))Failure;

#pragma mark 我的优惠券
-(void)getGongGaotWithType:(NSString*)aType andPageIndex:(NSString*)pageIndex andSuccess:(void(^)(id responseObj))success  andFailure:(void(^)(id error))Failure;

#pragma mark VIP
-(void)getVIPProductListandSuccess:(void(^)(id responseObj))success  andFailure:(void(^)(id error))Failure;

#pragma mark  VIP等级
-(void)getVipLevelandSuccess:(void(^)(id responseObj))success  andFailure:(void(^)(id error))Failure;
#pragma mark  签到
-(void)QianDaoandSuccess:(void(^)(id responseObj))success  andFailure:(void(^)(id error))Failure;

#pragma mark 财富宝转入
-(void)CaiFuBaoZhuangRuWithType:(NSString*)aType andAmount:(NSString*)Amount andDwAmount:(NSString*)DwAmount andBankID:(NSString*)BankID andSuccess:(void(^)(id responseObj))success  andFailure:(void(^)(id error))Failure;
#pragma mark 财富宝转出
-(void)CaiFuBaoMessageWithSuccess:(void(^)(id responseObj))success  andFailure:(void(^)(id error))Failure;

-(void)CaiFuBaoZhuanChuMessageWithSuccess:(void(^)(id responseObj))success  andFailure:(void(^)(id error))Failure;

-(void)CaiFuBaoZhuanChuConfirmWithAmount:(NSString*)mount WithSuccess:(void(^)(id responseObj))success  andFailure:(void(^)(id error))Failure;

-(void)CaiFuBaoZhuanChuSuccessWithAmount:(NSString*)mount andItemS:(NSString*)items WithSuccess:(void(^)(id responseObj))success  andFailure:(void(^)(id error))Failure;

+(BOOL)islogin;

#pragma mark 持有列表详情
-(void)allChiYouProductListPageIndex:(NSString*)pageIndex andSuccess:(void(^)(id responseObj))success  andFailure:(void(^)(id error))Failure;

-(void)allChiYouProductListPageIndex:(NSString*)pageIndex WithOrderID:(NSString*)orderID andSuccess:(void(^)(id responseObj))success  andFailure:(void(^)(id error))Failure;



#pragma mark 上传位置信息
-(void)upLoadAddressMessageWithMessageArr:(NSMutableDictionary*)dict andSuccess:(void(^)(id responseObj))success;



#pragma mark 随心存持有累计收益
-(void)getAsDepositTotalearningsSuccess:(void(^)(id responseObj))success;

#pragma mark 随心存持有列表
-(void)AsDepositHoldListWithPage:(NSInteger)page andSuccess:(void(^)(id responseObj))success;

#pragma mark 随心存赎回列表
-(void)AsDepositRedeemListWithPage:(NSInteger)page andSuccess:(void(^)(id responseObj))success;


#pragma mark 赎回订单信息
-(void)AsDepositRedeemAlertMessageWithOrderId:(NSString*)OrderId andSuccess:(void(^)(id responseObj))success;

#pragma mark 赎回
-(void)AsDepositRedeemButtonEventWithOrderId:(NSString*)OrderId andSuccess:(void(^)(id responseObj))success;


#pragma mark  随心存支付订单信息
-(void)AsDepositPayOrderMessageWithAmount:(NSString*)amount andDaysId:(NSInteger)daysId andSuccess:(void(^)(id responseObj))success;





@end
