//
//  CMRenZheng.m
//  CaiMao
//
//  Created by MAC on 16/7/30.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMRequestManager.h"

@implementation CMRequestManager
CMSingletonM(CMRequestManager)
//+ (CMRequestManager *)sharedAPI {
//    static CMRequestManager *_sharedRequestAPI = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _sharedRequestAPI = [[CMRequestManager alloc] init];
//    });
//    return _sharedRequestAPI;
//}
-(void)requestRenZhengMsgsuccess:(SuccessBlock)success andFailure:(FailBlock)Failure{
    
  //  NSString *urlStr=@"http://m.58cm.com/Handler/app_interface.ashx?action=RenZhengInfo";
     NSString *urlStr=[NSString stringWithFormat:@"%@/Handler/app_interface.ashx?action=RenZhengInfo",OnLineCode];
    [CMCookie setCoookieForHost:urlStr];
    [CMHttpTool getAndCookiesWithURL:urlStr params:nil success:^(id responseObj) {
        
       // DLog(@"RenZhengMsgsuccess数据---%@",responseObj);
            
                      if (success) {
//                          NSArray *arr=(NSArray*)[responseObj objectForKey:@"result"];
                          
                          NSDictionary *dict=(NSDictionary*)responseObj;
                         
                          if ([[dict objectForKey:@"status"] isEqualToString:@"300"]) {
                              [self loginAuto];
                              [self requestRenZhengMsgsuccess:^(id responseObj) {
                                  NSDictionary *NewDict=(NSDictionary*)responseObj;
                                  if (success) {
                                      success(NewDict);
                                  }
                                  
                              } andFailure:^(id error) {
                                  
                              }];
                          }
                          if([[dict objectForKey:@"status"] isEqualToString:@"400"]){
                              if([[responseObj objectForKey:@"result"]isEqualToString:@"账户失效，请重新登录！"]){
                                  [self loginAuto];
                                  [self requestBankListMsgsuccess:^(id responseObj) {
                                      NSDictionary *NewDict=(NSDictionary*)responseObj;
                                      if (success) {
                                          success(NewDict);
                                      }
                                  } andFailure:^(id error) {
                                      
                                  }];
                              }
                          }
                          if ([[dict objectForKey:@"status"] isEqualToString:@"200"]) {
                              
                               success(dict);
                          }
                         
                          
  
        }
        
        
        
    } failure:^(NSError *error) {
        
        DLog(@"ListError---%d--%@",error.code,error.description);
        if (error.code==1011) {
            if (error) {
                Failure(error);
            }
        }
        
    }];
 
    
}
-(void)requestBankListMsgsuccess:(SuccessBlock)success andFailure:(FailBlock)Failure{
   // NSString *url=@"http://m.58cm.com/handler/app_interface.ashx?action=bankList";
    NSString *url=[NSString stringWithFormat:@"%@/handler/app_interface.ashx?action=bankList",OnLineCode];
    [CMHttpTool getAndCookiesWithURL:url params:nil success:^(id responseObj) {
        
        
        
     //DLog(@"认证数据---%@",responseObj);
        
        if (success) {
         
            NSDictionary *dict=(NSDictionary*)responseObj;
            if ([[dict objectForKey:@"status"] isEqualToString:@"300"]) {
                [self loginAuto];
                [self requestBankListMsgsuccess:^(id responseObj) {
                NSDictionary *NewDict=(NSDictionary*)responseObj;
                    if (success) {
                        success(NewDict);
                    }
                } andFailure:^(id error) {
                    
                }];
            }
        
            if([[dict objectForKey:@"status"] isEqualToString:@"400"]){
                if([[responseObj objectForKey:@"result"]isEqualToString:@"账户失效，请重新登录！"]){
                [self loginAuto];
                [self requestBankListMsgsuccess:^(id responseObj) {
                    NSDictionary *NewDict=(NSDictionary*)responseObj;
                    if (success) {
                        success(NewDict);
                    }
                } andFailure:^(id error) {
                    
                }];
                }
            }

            
            if ([[dict objectForKey:@"status"] isEqualToString:@"200"]) {
                
                success(dict);
            }
        
        }
        
        
        
        
        

    } failure:^(NSError *error) {
        DLog(@"ListError---%d--%@",error.code,error.description);
        if (error.code==1011) {
            if (error) {
                Failure(error);
            }
        }
    }];

    
}



-(void)requestSupportBankListMsgsuccess:(SuccessBlock)success{
    NSString *urlStr=[NSString stringWithFormat:@"%@/Handler/app_interface.ashx?action=bankInfo",OnLineCode];
    
    [CMHttpTool getWithURL:urlStr params:nil success:^(id responseObj) {
        
        if (success) {
            //                          NSArray *arr=(NSArray*)[responseObj objectForKey:@"result"];
            
            NSDictionary *dict=(NSDictionary*)responseObj;
            
            success(dict);
        }
    } failure:^(NSError *error) {
        DLog(@"ListError---%d--%@",error.code,error.description);
        
    }];

    
    
}

- (void)loginAuto
{
    // 取出账号、密码
    
    NSString *name = [CMUserDefaults objectForKey:@"name"];
    NSString *password = [PassWordTool readPassWord];
    
    if (name&&password) {
        
        NSString *urlStr = [NSString stringWithFormat:@"%@/handler/AppInterface.ashx?action=login&mobile=%@&pwd=%@&type=%@&id=%@",OnLineCode,name,password,@"1",[JPUSHService registrationID]];
        
        [CMHttpTool getWithURL:urlStr params:nil success:^(id responseObj) {
            
            
        
            NSString *strStatus = [responseObj valueForKey:@"status"];
            
    
            
            if ([strStatus isEqualToString:@"200"]) {
    
                [CMCookie getAndSaveCookie];
            }
            
        } failure:^(NSError *error) {
            DLog(@"自动陆失败------%@",error);
            NSString *url=[NSString stringWithFormat:@"%@/handler/AppInterface.ashx?action=quit",OnLineCode];
            [PassWordTool deletePassWord];
            [CMHttpTool getWithURL:url params:nil success:^(id responseObj) {
                //isLoginStatus=NO;
                [CMCookie deleteCookie];
            } failure:^(NSError *error) {
        
                DLog(@"exitLoginAcconntError--%@",error);
            }];
            
        }];
        
        
        
        
    }
}


-(void)synchronizationWebSuccess:(SuccessBlock)success{
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppInterface.ashx?action=getCode",OnLineCode];
    
    [CMHttpTool getWithURL:url params:nil success:^(id responseObj) {
        if (success) {
            NSDictionary *dict=(NSDictionary*)responseObj;
            
            success(dict);
        }
        
    } failure:^(NSError *error) {
      
        DLog(@"ListError---%d--%@",error.code,error.description);
    }];

    
}
-(void)GetDingQiBaoProductMsgSuccess:(SuccessBlock)success andFailure:(FailBlock)Failure{
    NSString *urlStr = [NSString stringWithFormat:@"%@/handler/app_interface.ashx?action=Product&mark=dingqibao",OnLineCode];
    [CMHttpTool getWithURL:urlStr params:nil success:^(id responseObj) {
        //DLog(@"定期宝------%@",responseObj);
        if (success) {
            NSDictionary *dict=(NSDictionary*)responseObj;
            
            success(dict);
        }

        
    } failure:^(NSError *error) {
        DLog(@"ListError---%d--%@",error.code,error.description);
        if (error.code==1011) {
            if (error) {
                Failure(error);
            }
        }
    }];
    

    
    
}
-(void)GetHomeBarImagesAdsSuccess:(SuccessBlock)success andFailure:(FailBlock)Failure{
    NSString *urlStr = [NSString stringWithFormat:@"%@/handler/AppInterface.ashx?action=ads",OnLineCode];
    [CMHttpTool getWithURL:urlStr params:nil success:^(id responseObj) {
      
        if (success) {
            NSDictionary *dict=(NSDictionary*)responseObj;
            
            success(dict);
        }
        
    } failure:^(NSError *error) {
       DLog(@"ListError---%d--%@",error.code,error.description);
        if (error.code==1011) {
            if (error) {
                Failure(error);
            }
        }
    }];

    
    
}
-(void)GetHomeNewActionsSuccess:(SuccessBlock)success andFailure:(FailBlock)Failure{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/handler/app_interface.ashx?action=DtDefault",OnLineCode];
    [CMHttpTool getWithURL:urlStr params:nil success:^(id responseObj) {
        if (success) {
            NSDictionary *dict=(NSDictionary*)responseObj;
            
            success(dict);
        }
        
    } failure:^(NSError *error) {
        DLog(@"ListError---%d--%@",error.code,error.description);
        if (error.code==1011) {
            if (error) {
                Failure(error);
            }
        }
    }];

    
}
-(void)GetYueXiYingProductMsgSuccess:(SuccessBlock)success andFailure:(FailBlock)Failure{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/handler/app_interface.ashx?action=Product&mark=yuexiying",OnLineCode];
    [CMHttpTool getWithURL:urlStr params:nil success:^(id responseObj) {
        if (success) {
            NSDictionary *dict=(NSDictionary*)responseObj;
            
            success(dict);
        }

        
    } failure:^(NSError *error) {
       DLog(@"ListError---%d--%@",error.code,error.description);
        if (error.code==1011) {
            if (error) {
                Failure(error);
            }
        }
    }];

}

-(void)GetJuHaiLiProductMsgSuccess:(SuccessBlock)success andFailure:(FailBlock)Failure{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/handler/app_interface.ashx?action=Product&mark=juhaili",OnLineCode];
    [CMHttpTool getWithURL:urlStr params:nil success:^(id responseObj) {
        
        if (success) {
            NSDictionary *dict=(NSDictionary*)responseObj;
            
            success(dict);
        }
        
    } failure:^(NSError *error) {
        DLog(@"ListError---%d--%@",error.code,error.description);
        if (error.code==1011) {
            if (error) {
                Failure(error);
            }
        }
    }];

    
}

-(void)GetMiaoShaHuiProductMsgSuccess:(SuccessBlock)success andFailure:(FailBlock)Failure{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/handler/app_interface.ashx?action=Product&mark=miaosha",OnLineCode];
    [CMHttpTool getWithURL:urlStr params:nil success:^(id responseObj) {
        if (success) {
            NSDictionary *dict=(NSDictionary*)responseObj;
            
            success(dict);
        }
    
    } failure:^(NSError *error) {
        DLog(@"ListError---%d--%@",error.code,error.description);
        if (error.code==1011) {
            if (error) {
                Failure(error);
            }
        }
    }];

    
}

-(void)GetXinKeProductMsgSuccess:(SuccessBlock)success andFailure:(FailBlock)Failure{
    
    NSString *urlStr = [NSString stringWithFormat:@"https://www.58cm.com/handler/app_interface.ashx?action=Product&mark=xk"];
    [CMHttpTool getWithURL:urlStr params:nil success:^(id responseObj) {
      //  DLog(@"新客产品---%@",responseObj);
        
        if (success) {
            NSDictionary *dict=(NSDictionary*)responseObj;
            
            success(dict);
        }
        
           } failure:^(NSError *error) {
        DLog(@"新客产品ListError---%@",error);
               if (error.code==1011) {
                   if (error) {
                       Failure(error);
                   }
               }
    }];

}
-(void)GetTeHuiBarMsgSuccess:(void(^)(id responseObj))success andFailure:(FailBlock)Failure{
    
    NSString *urlStr =[NSString stringWithFormat:@"%@/handler/app_interface.ashx?action=BannerIMG",OnLineCode] ;
    [CMHttpTool getWithURL:urlStr params:nil success:^(id responseObj) {
        
        if (success) {
            NSDictionary *dict=(NSDictionary*)responseObj;
            
            success(dict);
        }
    
    } failure:^(NSError *error) {
        DLog(@"ListError---%d--%@",error.code,error.description);
        if (error.code==1011) {
            if (error) {
                Failure(error);
            }
        }
    }];

}

-(void)GetTeHuiTopAdsMsgSuccess:(SuccessBlock)success andFailure:(FailBlock)Failure{
    
    NSString *urlStr =[NSString stringWithFormat:@"%@/handler/app_interface.ashx?action=Tehui",OnLineCode] ;
    [CMHttpTool getWithURL:urlStr params:nil success:^(id responseObj) {
        
        if (success) {
            NSDictionary *dict=(NSDictionary*)responseObj;
            
            success(dict);
        }
        
    } failure:^(NSError *error) {
       
        DLog(@"ListError---%d--%@",error.code,error.description);
        if (error.code==1011) {
            if (error) {
                Failure(error);
            }
        }
    }];
    
}

-(void)GetVipMsgWithHYID:(NSString *)aHYID andSuccess:(void (^)(id))success{
    NSString *urlStr = [NSString stringWithFormat:@"%@/handler/app_interface.ashx?action=vipInfo&hyid=%@",OnLineCode,aHYID];
    [CMHttpTool getWithURL:urlStr params:nil success:^(id responseObj) {
        
        if (success) {
            NSDictionary *dict=(NSDictionary*)responseObj;
            
            success(dict);
        }
       
       
    } failure:^(NSError *error) {
        DLog(@"vipMessageError--- %@",error);
    }];
    

    
}

-(void)GetAccountMsgWithHYID:(NSString*)aHYID andSuccess:(void(^)(id responseObj))success{
     NSString *url = [NSString stringWithFormat:@"%@/handler/app_interface.ashx?action=IcmIndex&hyid=%@",OnLineCode,aHYID];
    [CMHttpTool getWithURL:url params:nil success:^(id responseObj) {
        
        if (success) {
            NSDictionary *dict=(NSDictionary*)responseObj;
            
            success(dict);
        }
        
        
    } failure:^(NSError *error) {
        DLog(@"vipMessageError--- %@",error);
    }];
    
}
-(void)uploadContanctWithID:(NSString*)ID andArr:(NSMutableArray*)arr andSuccess:(void(^)(id responseObj))success{
    
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_InviteAction.ashx?Action=6",OnLineCode];
    NSDictionary *dict=@{@"HYID":ID,
                         @"TList":arr};
   // DLog(@"arr++++++%@+%@++",dict,url);
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        if(success){
            
            success(responseObj);
        }
       
        
    } failure:^(NSError *error) {
        
        DLog(@"错误++++++%@",error);
    }];
    
}

-(void)uploadQQEmailWithArr:(NSMutableArray*)arr andSuccess:(void(^)(id responseObj))success{
    NSString *upId=nil;
    if ([CMRequestManager islogin]) {
        upId=[CMUserDefaults objectForKey:@"userID"];
    }else{
        
        upId=@"0";
    }
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_InviteAction.ashx?Action=9",OnLineCode];
    NSDictionary *dict=@{@"HYID":upId,
                         @"TList":arr};
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        if(success){
            
            success(responseObj);
        }
        
        
    } failure:^(NSError *error) {
        
        DLog(@"错误++++++%@",error);
    }];
    
}
-(void)sendEmailWithArr:(NSMutableArray*)arr andSuccess:(void(^)(id responseObj))success{
    NSString *upId=nil;
    if ([CMRequestManager islogin]) {
        upId=[CMUserDefaults objectForKey:@"userID"];
    }else{
        
        upId=@"0";
    }
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_InviteAction.ashx?Action=10",OnLineCode];
    NSDictionary *dict=@{@"HYID":upId,
                         @"TList":arr};
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        if(success){
            
            success(responseObj);
        }
        
        
    } failure:^(NSError *error) {
        
        DLog(@"错误++++++%@",error);
    }];
    
}

-(void)isRegistWithPhoneArr:(NSMutableArray*)arr andSuccess:(void(^)(id responseObj))success{
    
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_InviteAction.ashx?Action=7",OnLineCode];
    NSDictionary *dict=@{ @"TList":arr};
    
   // DLog(@"++%@",dict);
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        
        if(success){
            
            success(responseObj);
        }
        
        
    } failure:^(NSError *error) {
        
        DLog(@"错误++++++%@",error);
    }];
    
}

-(void)shortUrl:(NSString*)longURl andSuccess:(void(^)(id responseObj))success{
    NSString *url=[NSString stringWithFormat:@"http://api.t.sina.com.cn/short_url/shorten.json?source=376421421&url_long=%@",longURl];
    [CMHttpTool getWithURL:url params:nil success:^(id responseObj) {
        if (success) {
          
            success(responseObj);
        }
        
        
    } failure:^(NSError *error) {
        
    }];

    
}
-(void)CaiMaoshortUrlWithID:(NSString*)ID andPhone:(NSString*)phone andSuccess:(void(^)(id responseObj))success{
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_InviteAction.ashx?Action=8",OnLineCode];
    NSDictionary *dict=@{ @"HYID":ID,
                          @"Tel":phone};
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        if(success){
            
            success(responseObj);
        }
        
        
    } failure:^(NSError *error) {
        
        DLog(@"错误++++++%@",error);
    }];
    
    
}

-(void)ThePhoneRenZhengWithUserID:(NSString*)userID andMobile:(NSString*)aMoile andIdeaPassword:(NSString*)aIdealPassword andSmsCode:(NSString*)acode andSuccess:(void(^)(id responseObj))success{
    
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_Approve.ashx?action=ChangeMobile",OnLineCode];
    NSDictionary *dict=@{@"HYID": userID,
                         @"mobile":aMoile,
                         @"jypassword":aIdealPassword,
                         @"vercode":acode
                         };
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        
        if (success) {
            success(responseObj);
        }
        
    } failure:^(NSError *error) {
        DLog(@"ThePhoneRenZhengerror++++%@++++",error);
    }];

}
-(void)ThePhoneRenZhengGetSmsCodeWithUserID:(NSString*)userID andMobile:(NSString*)aMobile andSuccess:(void(^)(id responseObj))success{
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_MySendCode.ashx?action=MobileSmsCode",OnLineCode];
    NSDictionary *dict=@{@"HYID": userID,
                         @"mobile":aMobile
                         };
    DLog(@"+++%@",dict);
    
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        if (success) {
            success(responseObj);
        }
        
    } failure:^(NSError *error) {
        DLog(@"ThePhoneRenZhengGetSmsCode++++%@++++",error);
    }];
    

}
-(void)changeEmailWithUserID:(NSString*)userID andEmailCod:(NSString*)code andEmailName:(NSString*)email andIdealPassword:(NSString*)password andSuccess:(void(^)(id responseObj))success{
    
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_Approve.ashx?action=ChangeEmail",OnLineCode];
    NSDictionary *dict=@{@"HYID": userID,
                         @"vercode":code,
                         @"email":email,
                         @"jypassword":password
                         };
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        if (success) {
            success(responseObj);
        }
       
    } failure:^(NSError *error) {
        DLog(@"changeEmail++++%@++++",error);
    }];

}
-(void)changeEmailCodeWithUserID:(NSString *)userID andEmail:(NSString *)email andSuccess:(void (^)(id))success{
    
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_MySendCode.ashx?action=ChangeEmailCode",OnLineCode];
    NSDictionary *dict=@{@"HYID":userID,
                         @"email":email,
                         };
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        if (success) {
            success(responseObj);
        }

    } failure:^(NSError *error) {
        DLog(@"changeEmailCode++++%@++++",error);
    }];
    

}
-(void)setEmailWithUserID:(NSString *)userID andEmailCode:(NSString *)code andEmail:(NSString *)email andSuccess:(void (^)(id))success{
    
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_Approve.ashx?action=BingEmail",OnLineCode];
    NSDictionary *dict=@{@"HYID": userID,
                         @"vercode":code,
                         @"email":email
                         };
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        if (success) {
            success(responseObj);
        }
       
    } failure:^(NSError *error) {
        DLog(@"emailSet++++%@++++",error);
    }];

}
-(void)setEmailCodeWithUserID:(NSString *)userID andEmail:(NSString *)email andSuccess:(void (^)(id))success{
    
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_MySendCode.ashx?action=BingEmailCode",OnLineCode];
    NSDictionary *dict=@{@"HYID":userID,
                         @"email":email,
                         };
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        if (success) {
            success(responseObj);
        }
       
    } failure:^(NSError *error) {
        DLog(@"setEmailCode++++%@++++",error);
    }];

}
-(void)resetLoginPassWordWithUserID:(NSString*)userID andNewPassword:(NSString*)NewPassword andRepeatPassWord:(NSString*)RepeatPassWord andSmsCode:(NSString*)SmsCode andSuccess:(void(^)(id responseObj))success{
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_Approve.ashx?action=ChangePassword",OnLineCode];
    NSDictionary *dict=@{@"HYID": userID,
                         @"password":NewPassword,
                         @"repassword":RepeatPassWord,
                         @"vercode":SmsCode
                         };
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        if (success) {
            success(responseObj);
        }
       
    } failure:^(NSError *error) {
        DLog(@"xiuGaiLoginPassWord++++%@++++",error);
    }];
    
}
-(void)setIdealPasswordWithUserId:(NSString *)UserID andUserName:(NSString *)name andNameId:(NSString *)NameId andSMSCode:(NSString *)smsCode andIdealPassword:(NSString *)IdealPassWord andRepeatPassWord:(NSString *)RepeatPassWord andSuccess:(void (^)(id))success{
    
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_Approve.ashx?action=BingJyPassword",OnLineCode];
    NSDictionary *dict=@{@"HYID": UserID,
                         @"name":name,
                         @"sfzh":NameId,
                         @"jypassword":IdealPassWord,
                         @"rejypassword":RepeatPassWord,
                         @"vercode":smsCode
                         };
  
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        DLog(@"+++%@",responseObj);
        if (success) {
            success(responseObj);
        }
        
    } failure:^(NSError *error) {
        DLog(@"setIdealPassWord++++%@++++",error);
    }];
    
    
    
}


-(void)resetLoginPassWordGetCodeWithUserID:(NSString *)userID andSuccess:(void (^)(id responseObj))success{
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_MySendCode.ashx?action=SendSmsCode",OnLineCode];
    NSDictionary *dict=@{@"HYID":userID
                         };
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        if (success) {
            success(responseObj);
        }
        
           } failure:^(NSError *error) {
        DLog(@"changeLoginPassWordCode++++%@++++",error);
    }];

    
}
-(void)setIdealPasswordSmsCodeWithUserId:(NSString*)UserID andName:(NSString*)aName andNameId:(NSString*)aNameID andSuccess:(void(^)(id responseObj))success{
    
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_MySendCode.ashx?action=BingJySmsCode",OnLineCode];
    NSDictionary *dict=@{@"HYID":UserID,
                         @"name":aName,
                         @"sfzh":aNameID
                         };
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        if(success){
            success(responseObj);
        }
    } failure:^(NSError *error) {
        DLog(@"setIdealPasswordSmsCode++++%@++++",error);
    }];

}
-(void)resetIdealPasswordWithUserId:(NSString*)UserID andSMSCode:(NSString*)smsCode  andNewPassWord:(NSString*)NewPassWord andRepeatPassWord:(NSString*)RepeatPassWord andSuccess:(void(^)(id responseObj))success{
    
    
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_Approve.ashx?action=ChangeJyPassword",OnLineCode];
    NSDictionary *dict=@{@"HYID":UserID,
                         @"jypassword":NewPassWord,
                         @"rejypassword": RepeatPassWord,
                         @"vercode":smsCode
                         };
      DLog(@"+++%@",dict);
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        if (success) {
            success(responseObj);
        }
    } failure:^(NSError *error) {
        DLog(@"resetIdealPassword++++%@++++",error);
    }];

}
-(void)resetIdealPasswordGetSmsCodeWithUserId:(NSString*)UserID  andSuccess:(void(^)(id responseObj))success{
    
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_MySendCode.ashx?action=SendSmsCode",OnLineCode];
    NSDictionary *dict=@{@"HYID": UserID
                         };
   DLog(@"+++%@",dict);
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        if(success){
            success(responseObj);
        }
    } failure:^(NSError *error) {
        DLog(@"resetIdealPasswordSmsCode++++%@++++",error);
    }];

}
-(void)RequestUserStateWithUserID:(NSString*)userID andSuccess:(void(^)(id responseObj))success{
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_Approve.ashx?action=GetApprove",OnLineCode];
    NSDictionary *dict=@{@"HYID":userID};
    
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        if (success) {
            success(responseObj);
        }
    } failure:^(NSError *error) {
        DLog(@"error++++%@++++",error);
    }];
   
}
-(void)getUserbankListWithUserID:(NSString *)userID andSuccess:(void (^)(id responseObj))success{
    
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_MyCard.ashx?action=CardList",OnLineCode];
    NSDictionary *dict=@{@"HYID":userID};
    
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        if (success) {
            success(responseObj);
        }
    
    } failure:^(NSError *error) {
        DLog(@"error++++%@++++",error);
    }];

    
}

-(void)userUserYanZhengWithUserID:(NSString*)userID andNameID:(NSString*)NameID andIdealPassword:(NSString*)IdealPassword andSuccess:(void(^)(id responseObj))success{
    
    
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_MyCard.ashx?action=ChangeCardOne",OnLineCode];
    NSDictionary *dict=@{@"HYID":[CMUserDefaults objectForKey:@"userID"],
                         @"sfzh":NameID,
                         @"password":IdealPassword
                         };
    DLog(@"+++%@",dict);
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        if (success) {
            success(responseObj);
        }
    } failure:^(NSError *error) {
        DLog(@"error++++%@++++",error);
    }];

}
-(void)userUserYanZhengWithUserID:(NSString *)userID andName:(NSString *)Name andNameID:(NSString *)NameID andbankNum:(NSString *)aBankNum andfaceImage:(NSString *)faceImage andbackImage:(NSString *)backImage andSuccess:(void (^)(id))success{
    NSString *url=[NSString stringWithFormat:@"%@//handler/AppService_MyCard.ashx?action=ChangeCardTwo",OnLineCode];
    NSDictionary *dict=@{@"HYID":userID,
                         @"name":Name,
                         @"sfzh":NameID,
                         @"yhkh":aBankNum,
                         @"front":faceImage,
                         @"opposite":backImage,
                         
                         };
      // DLog(@"+++%@",dict);
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        if (success) {
            success(responseObj);
        }
    } failure:^(NSError *error) {
        DLog(@"error++++%@++++",error);
    }];
  
    
}
-(void)MyJiFenWithUserID:(NSString*)userID andPageIndex:(NSString*)pageIndex  andSuccess:(void(^)(id responseObj))success andFailure:(void(^)(id error))Failure{
    
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_MyCount.ashx?Action=3",OnLineCode];
    NSDictionary *dict=@{@"HYID":userID,@"PageIndex":pageIndex};
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        DLog(@"积分明细===%@",responseObj);
        if (success) {
            success(responseObj);
        }
        
    } failure:^(NSError *error) {
        if (Failure) {
            Failure(error);
        }
       
    }];
    

}

-(void)myTotalJiFenWithUserID:(NSString*)userID andSuccess:(void(^)(id responseObj))success{
    
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_MyCount.ashx?Action=1",OnLineCode];
    
    NSDictionary *dict=@{@"HYID":userID};
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        DLog(@"我的积分===%@",responseObj);
        if (success) {
            success(responseObj);
        }

        
    } failure:^(NSError *error) {
        
        
    }];

}
-(void)MyIncomeWithUserID:(NSString*)userID andSuccess:(void(^)(id responseObj))success{
    
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_MyIncome.ashx?action=MyIncome",OnLineCode];
    
    NSDictionary *dict=@{@"HYID":userID};
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
       
        if (success) {
            success(responseObj);
        }
        
        
    } failure:^(NSError *error) {
        
        
    }];
}
-(void)MyIncomeChiYouWithUserID:(NSString*)userID andPageIndex:(NSString*)pageIndex  andSuccess:(void(^)(id responseObj))success andFailure:(void(^)(id error))Failure{
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_MyIncome.ashx?action=HoldList",OnLineCode];
    NSDictionary *dict=@{@"HYID":userID,@"PageIndex":pageIndex};
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
       
        if (success) {
            success(responseObj);
        }
        
    } failure:^(NSError *error) {
        if (Failure) {
            Failure(error);
        }
        
    }];
    
    
}

-(void)MyIncomeOrderWithUserID:(NSString*)userID andPageIndex:(NSString*)pageIndex  andSuccess:(void(^)(id responseObj))success andFailure:(void(^)(id error))Failure{
    
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_MyIncome.ashx?action=ReserveList",OnLineCode];
    NSDictionary *dict=@{@"HYID":userID,@"PageIndex":pageIndex};
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {

        if (success) {
            success(responseObj);
        }
        
    } failure:^(NSError *error) {
        if (Failure) {
            Failure(error);
        }
        
    }];
    
}

-(void)MyIncomeJieQingWithUserID:(NSString*)userID andPageIndex:(NSString*)pageIndex  andSuccess:(void(^)(id responseObj))success andFailure:(void(^)(id error))Failure{
    
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_MyIncome.ashx?action=SettleList",OnLineCode];
    NSDictionary *dict=@{@"HYID":userID,@"PageIndex":pageIndex};
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        
        if (success) {
            success(responseObj);
        }
        
    } failure:^(NSError *error) {
        if (Failure) {
            Failure(error);
        }
        
    }];
}
-(void)MyIncomeShouYiWithUserID:(NSString*)userID andProductID:(NSString*)ProductID  andPageIndex:(NSString*)pageIndex  andSuccess:(void(^)(id responseObj))success andFailure:(void(^)(id error))Failure{
    
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_MyIncome.ashx?action=IncomeDetail",OnLineCode];
    NSDictionary *dict=@{@"HYID":userID,
                         @"OrderID":ProductID,
                         @"PageIndex":pageIndex};
       DLog(@"参数===%@",dict);
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        DLog(@"收益详情===%@===%@",responseObj,[responseObj objectForKey:@"Result"]);
        if (success) {
            success(responseObj);
        }
        
    } failure:^(NSError *error) {
        if (Failure) {
            Failure(error);
        }
        
    }];
}
-(void)MyMBinWithUserID:(NSString*)userID andPageIndex:(NSString*)pageIndex  andSuccess:(void(^)(id responseObj))success andFailure:(void(^)(id error))Failure{
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_MyInfo.ashx?action=MyWam",OnLineCode];
    NSDictionary *dict=@{@"HYID":userID,
                            @"PageIndex":pageIndex};
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
    
        if (success) {
            success(responseObj);
        }
        
    } failure:^(NSError *error) {
        if (Failure) {
            Failure(error);
        }
        
    }];

    
}


-(void)MyMessageWithUserID:(NSString*)userID andSuccess:(void(^)(id responseObj))success{
    
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_MyInfo.ashx?action=MyData",OnLineCode];
    NSDictionary *dict=@{@"HYID":userID};
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        if (success) {
            success(responseObj);
        }
    } failure:^(NSError *error) {
        DLog(@"error++++%@++++",error);
    }];
  
}
-(void)SaveMyMessageWithUserID:(NSString*)userID  andNiCheng:(NSString*)NiCheng  andName:(NSString*)name andSex:(NSString*)sex andEmail:(NSString*)email andNameId:(NSString*)NameID andSuccess:(void(^)(id responseObj))success  andFailure:(void(^)(id error))Failure{
    
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_MyInfo.ashx?action=SaveData",OnLineCode];
    NSDictionary *dict=@{@"HYID":userID,
                         @"nicheng":NiCheng,
                         @"uname":name,
                         @"sex":sex,
                         @"email":email,
                         @"sfzh":NameID};
     DLog(@"++++%@++++",dict);
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        if (success) {
            success(responseObj);
        }
    } failure:^(NSError *error) {
        DLog(@"error++++%@++++",error);
    }];
    
}

-(void)MyYouHuiJuanWithUserID:(NSString*)userID  andType:(NSString*)aType andPageIndex:(NSString*)pageIndex andSuccess:(void(^)(id responseObj))success  andFailure:(void(^)(id error))Failure{
    
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_MyInfo.ashx?action=MyCoupon",OnLineCode];
    NSDictionary *dict=@{@"HYID":userID,
                        @"type":aType,
                         @"PageIndex":pageIndex
                             
                             };
 
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        if (success) {
            success(responseObj);
        }
    } failure:^(NSError *error) {
        DLog(@"error++++%@++++",error);
    }];

    
    
}

-(void)getProductListWithUserID:(NSString*)userID  andProductId:(NSString*)Product  andSuccess:(void(^)(id responseObj))success  andFailure:(void(^)(id error))Failure{
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_MyIncome.ashx?action=ProductDetail",OnLineCode];
    NSDictionary *dict=@{@"HYID":userID,
                         @"PID":Product
                         
                         };

    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        if (success) {
            success(responseObj);
        }
    } failure:^(NSError *error) {
        DLog(@"error++++%@++++",error);
    }];
    
    
}

-(void)getGongGaotWithType:(NSString*)aType andPageIndex:(NSString*)pageIndex andSuccess:(void(^)(id responseObj))success  andFailure:(void(^)(id error))Failure{
    
    NSString *url=[NSString stringWithFormat:@"%@/handler/app_interface.ashx?action=newsInfo",OnLineCode];
    NSDictionary *dict=@{
                         @"type":aType,
                         @"PageIndex":pageIndex
                         };
     DLog(@"++++%@++++",dict);
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        if (success) {
            success(responseObj);
        }
    } failure:^(NSError *error) {
        DLog(@"error++++%@++++",error);
    }];

    
}
-(void)getVIPProductListandSuccess:(void(^)(id responseObj))success  andFailure:(void(^)(id error))Failure{
    NSString *url=[NSString stringWithFormat:@"%@/handler/app_interface.ashx?action=Vip",OnLineCode];
 
    [CMHttpTool postWithURL:url params:nil success:^(id responseObj) {
        if (success) {
            success(responseObj);
        }
    } failure:^(NSError *error) {
        DLog(@"error++++%@++++",error);
    }];
 
}

-(void)getVipLevelandSuccess:(void(^)(id responseObj))success  andFailure:(void(^)(id error))Failure{
    
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_MyInfo.ashx?action=MyVip",OnLineCode];
    NSDictionary *dict=@{
                         @"HYID":[CMUserDefaults objectForKey:@"userID"]
                         
                         };
  
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        if (success) {
            success(responseObj);
        }
    } failure:^(NSError *error) {
        DLog(@"error++++%@++++",error);
    }];

    
    
}

-(void)QianDaoandSuccess:(void(^)(id responseObj))success  andFailure:(void(^)(id error))Failure{
    
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_MyInfo.ashx?action=MySign",OnLineCode];
    NSDictionary *dict=@{
                         @"HYID":[CMUserDefaults objectForKey:@"userID"]
                         
                         };
    
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        if (success) {
            success(responseObj);
        }
    } failure:^(NSError *error) {
        DLog(@"error++++%@++++",error);
    }];

    
}
-(void)CaiFuBaoZhuangRuWithType:(NSString*)aType andAmount:(NSString*)Amount andDwAmount:(NSString*)DwAmount andBankID:(NSString*)BankID andSuccess:(void(^)(id responseObj))success  andFailure:(void(^)(id error))Failure{
    
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_MyCfb.ashx?action=Into",OnLineCode];
    NSDictionary *dict=@{
                         @"HYID":[CMUserDefaults objectForKey:@"userID"],
                          @"type":aType,
                          @"amount":Amount,
                          @"dwamount":DwAmount,
                          @"bankid":BankID,
                         };
    
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        if (success) {
            success(responseObj);
        }
    } failure:^(NSError *error) {
        DLog(@"error++++%@++++",error);
    }];
    
    
    
}

-(void)CaiFuBaoMessageWithSuccess:(void(^)(id responseObj))success  andFailure:(void(^)(id error))Failure{
    
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_MyCfb.ashx?action=In",OnLineCode];
    NSDictionary *dict=@{
                         @"HYID":[CMUserDefaults objectForKey:@"userID"],
                         
                         };
    
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        if (success) {
            success(responseObj);
        }
    } failure:^(NSError *error) {
        DLog(@"error++++%@++++",error);
    }];
    

    
}

-(void)CaiFuBaoZhuanChuMessageWithSuccess:(void(^)(id responseObj))success  andFailure:(void(^)(id error))Failure{
    
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_MyCfb.ashx?action=Out",OnLineCode];
    NSDictionary *dict=@{
                         @"HYID":[CMUserDefaults objectForKey:@"userID"],
                         
                         };
    
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        if (success) {
            success(responseObj);
        }
    } failure:^(NSError *error) {
        DLog(@"error++++%@++++",error);
    }];
    
}

-(void)CaiFuBaoZhuanChuConfirmWithAmount:(NSString*)mount WithSuccess:(void(^)(id responseObj))success  andFailure:(void(^)(id error))Failure{
    
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_MyCfb.ashx?action=OutConfirm",OnLineCode];
    NSDictionary *dict=@{
                         @"HYID":[CMUserDefaults objectForKey:@"userID"],
                         @"amount":mount
                         };
    
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        if (success) {
            success(responseObj);
        }
    } failure:^(NSError *error) {
        DLog(@"error++++%@++++",error);
    }];
    
    
}
-(void)CaiFuBaoZhuanChuSuccessWithAmount:(NSString*)mount andItemS:(NSString*)items WithSuccess:(void(^)(id responseObj))success  andFailure:(void(^)(id error))Failure{
    
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_MyCfb.ashx?action=Outto",OnLineCode];
    NSDictionary *dict=@{
                         @"HYID":[CMUserDefaults objectForKey:@"userID"],
                         @"amount":mount,
                         @"items":items,
                         };
    
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        if (success) {
            success(responseObj);
        }
    } failure:^(NSError *error) {
        DLog(@"error++++%@++++",error);
    }];
    
    
}
+(BOOL)islogin
{
    NSString *name = [CMUserDefaults objectForKey:@"name"];
    NSString *password = [PassWordTool readPassWord];
    if (name.length>0&&password.length>0) {
        
        return YES;
    }else{
        return NO;
        
    }
    
}

-(void)allChiYouProductListPageIndex:(NSString*)pageIndex andSuccess:(void(^)(id responseObj))success  andFailure:(void(^)(id error))Failure{
    
    
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_MyIncome.ashx?action=IncomeList",OnLineCode];
    NSDictionary *dict=@{
                         @"HYID":[CMUserDefaults objectForKey:@"userID"],
                         @"PageIndex":pageIndex,
                         };
    
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        if (success) {
            success(responseObj);
        }
    } failure:^(NSError *error) {
        DLog(@"error++++%@++++",error);
    }];
    

    
}

-(void)allChiYouProductListPageIndex:(NSString*)pageIndex WithOrderID:(NSString*)orderID andSuccess:(void(^)(id responseObj))success  andFailure:(void(^)(id error))Failure{
    
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_MyIncome.ashx?action=IncomeMore",OnLineCode];
    NSDictionary *dict=@{  //780146
                         @"HYID":[CMUserDefaults objectForKey:@"userID"],
                         @"OrderID":orderID,
                         @"PageIndex":pageIndex,
                         };
    
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        if (success) {
            success(responseObj);
        }
    } failure:^(NSError *error) {
        DLog(@"error++++%@++++",error);
    }];
    
    
}


-(void)upLoadAddressMessageWithMessageArr:(NSMutableDictionary*)dict andSuccess:(void(^)(id responseObj))success{
   
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_CommonAction.ashx",OnLineCode];
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        if(success){
            
            success(responseObj);
        }
        
        
    } failure:^(NSError *error) {
        
        DLog(@"错误++++++%@",error);
    }];
    

    
}

-(void)getAsDepositTotalearningsSuccess:(void(^)(id responseObj))success{
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_SuiXinCun.ashx?action=GetMySuiXinCunInfo",OnLineCode];
    
   if ([CMUserDefaults objectForKey:@"userID"]!=nil) {
        
    
    NSDictionary *dict=@{
                         @"hyid":[CMUserDefaults objectForKey:@"userID"]
                         };
        [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
            if(success){
                
                success(responseObj);
            }
            
            
        } failure:^(NSError *error) {
            
            DLog(@"错误++++++%@",error);
        }];

  }
    
    
    
}

-(void)AsDepositHoldListWithPage:(NSInteger)page andSuccess:(void(^)(id responseObj))success{
    NSString *pageIndex=[NSString stringWithFormat:@"%ld",page];
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_SuiXinCun.ashx?action=GetChiYouItemList",OnLineCode];
    NSDictionary *dict=@{
                         @"hyid":[CMUserDefaults objectForKey:@"userID"],
                         @"PageSize":@"5",
                         @"PageIndex":pageIndex
                         };
    
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        if(success){
            
            success(responseObj);
        }
        
        
    } failure:^(NSError *error) {
        
        DLog(@"错误++++++%@",error);
    }];

    
}
-(void)AsDepositRedeemListWithPage:(NSInteger)page andSuccess:(void(^)(id responseObj))success{
    NSString *pageIndex=[NSString stringWithFormat:@"%ld",page];
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_SuiXinCun.ashx?action=GetShuHuiItemList",OnLineCode];
    NSDictionary *dict=@{
                         @"hyid":[CMUserDefaults objectForKey:@"userID"],
                         @"PageSize":@"5",
                         @"PageIndex":pageIndex
                         };
    
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        if(success){
            
            success(responseObj);
        }
        
        
    } failure:^(NSError *error) {
        
        DLog(@"错误++++++%@",error);
    }];
    
    
}

-(void)AsDepositRedeemAlertMessageWithOrderId:(NSString*)OrderId andSuccess:(void(^)(id responseObj))success{
    
   
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_SuiXinCun.ashx?action=ShuHui_GetInfo",OnLineCode];
    NSDictionary *dict=@{
                         @"hyid":[CMUserDefaults objectForKey:@"userID"],
                         @"OrderID":OrderId
                         };
    
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        NSLog(@"+++%@",dict);
        if(success){
            
            success(responseObj);
        }
        
        
    } failure:^(NSError *error) {
        
        DLog(@"错误++++++%@",error);
    }];
    
    
}
-(void)AsDepositRedeemButtonEventWithOrderId:(NSString*)OrderId andSuccess:(void(^)(id responseObj))success{
   
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_SuiXinCun.ashx?action=ShuHui",OnLineCode];
    NSDictionary *dict=@{
                         @"hyid":[CMUserDefaults objectForKey:@"userID"],
                         @"OrderID":OrderId
                         };
    
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        if(success){
            
            success(responseObj);
        }
        
        
    } failure:^(NSError *error) {
        
        DLog(@"错误++++++%@",error);
    }];
    
}

-(void)AsDepositPayOrderMessageWithAmount:(NSString*)amount andDaysId:(NSInteger)daysId andSuccess:(void(^)(id responseObj))success{
    
    NSString *Order=[NSString stringWithFormat:@"%ld",daysId];
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_SuiXinCun.ashx?action=SubmitJingPaiDingDan&Amount=%@&Days_Syl_Id=%@",OnLineCode,amount,Order];
    NSDictionary *dict=@{
                         @"hyid":[CMUserDefaults objectForKey:@"userID"],
                         };
 
    
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
   
        if(success){
            
            success(responseObj);
        }
        
        
    } failure:^(NSError *error) {
        
        DLog(@"错误++++++%@",error);
    }];
    
}
@end
