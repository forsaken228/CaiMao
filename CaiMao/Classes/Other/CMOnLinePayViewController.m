//
//  CMOnLinePayViewController.m
//  CaiMao
//
//  Created by MAC on 16/8/1.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMOnLinePayViewController.h"
#import "CMOnlinePaySuccessController.h"
#import "CMOnlineMiddleView.h"
#import "CMOnlineBottomView.h"
#import "CMBankList.h"
#import "CMAlertLICaiBenJinJuan.h"
@interface CMOnLinePayViewController ()<CMAlertLICaiBenJinJuanDelegate>
{
    CMOnlineMiddleView *middleView;
    CMOnlineBottomView *bottom;
    NSString *userName;
    NSString *OrderNum;
    NSDictionary *Bankdict;
    NSString *MBAvailAmount;
    NSString *MBMount;
    CMAlertLICaiBenJinJuan *AlertLiCaiJuan;
    float liCaiJINer;
    NSDictionary *newOrder;
}
@property(nonatomic,copy)NSString *userID;
@end

@implementation CMOnLinePayViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // 监听认证成功 （登录成功 刷新表格 显示账户信息）
        [CMNSNotice addObserver:self selector:@selector(renZhengSuccessRefreshData) name:@"renzhengSuccess" object:nil];
        
    }
    return self;
}
-(void)renZhengSuccessRefreshData{
    [self getUserBankList];
    [self getMBiList];
    [self getLiCaiBenJinJuanList];
    
}
-(void)dealloc{
    [CMNSNotice removeObserver:self];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=ViewBackColor;
    self.title=@"在线支付";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"我的账户" style:UIBarButtonItemStylePlain target:self action:@selector(enterIntoMyAccount)];
    self.navigationItem.hidesBackButton=YES;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"nav_back_btn" higlightedImage:nil target:self action:@selector(backBtnClick)];
    self.userID = [CMUserDefaults valueForKey:@"userID"];
    self.userPhoneNum = [CMUserDefaults valueForKey:@"name"];
    
    self.userAccountYuEr=[CMUserDefaults objectForKey:@"YuEr"];
   //  self.userAccountYuEr=@"991.20";

    OrderNum=[NSString  stringWithFormat:@"%@",[self.orderDict  objectForKey:@"OrderNum"]];
    [self getMBiList];
    [self getLiCaiBenJinJuanList];
    [self creatView];
    
    MBMount=@"0";
    MBAvailAmount=@"0";
    self.BenJinJuanID=@"0";
   // NSLog(@"userID---%@--bankArr==%@",self.userID,self.bankArr);
    
    self.orderDict=[[NSDictionary alloc]init];
    self.orderPayDict=[[NSDictionary alloc]init];
    
    [self statisticalPage:[NSString stringWithFormat:@"产品购买(%@)+%@",self.title,self.prTitle]];
}




-(void)backBtnClick{
    
    [self.navigationController popViewControllerAnimated:NO];
    
}
-(void)creatView{
    
    CMZhuanTopView *topView=[[CMZhuanTopView alloc]initWithImage:@"转出确认"];
    topView.frame=CGRectMake(0, 8, CMScreenW, 30);
    [self.view addSubview:topView];
   
    

    middleView=[[CMOnlineMiddleView alloc]init];//WithFrame:CGRectMake(0, 50, CMScreenW , 150)
    [self.view addSubview:middleView];
    [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(150);
        make.top.equalTo(topView.mas_bottom).offset(8);
        make.width.left.equalTo(self.view);
        
    }];
    middleView.orderNumber.text=OrderNum;
    middleView.payJinEr.text=[NSString stringWithFormat:@"%d元",self.payMoney];
    [NSString LoneAttributedStringEndString:@"元" FromLabel:middleView.payJinEr];

   
 
     [middleView.selectBtn setTitle:[NSString stringWithFormat:@"账户余额(%@元)", self.userAccountYuEr] forState:UIControlStateNormal];
   
    [NSString DoubleStringChangeColer: middleView.selectBtn.titleLabel andFromStr:@"(" ToStr:@"元" withColor:RedButtonColor];
    middleView.selectBtn.selected=NO;
    [middleView.selectBtn addTarget:self action:@selector(changeAccountYuEr) forControlEvents:UIControlEventTouchUpInside];
    middleView.accountPay.text=[NSString stringWithFormat:@"支付%@元",@"0.00"];
    self.Yuer=0.00;
   
    
     [NSString DoubleStringChangeColer:middleView.accountPay andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
    middleView.MselectBtn.selected=NO;
    [middleView.MselectBtn addTarget:self action:@selector(useMbinZheKouBtnClick) forControlEvents:UIControlEventTouchUpInside];
    middleView.LselectBtn.selected=NO;
    [middleView.LselectBtn addTarget:self action:@selector(useLiCaiJuanBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    bottom=[[CMOnlineBottomView alloc]init];
    bottom.frame=CGRectMake(0, 200,CMScreenW , CMScreenH-200);
    [self.view addSubview:bottom];

  [bottom.ZhiChiBank addTarget:self action:@selector(bankListbtnClick) forControlEvents:UIControlEventTouchUpInside];
    
   NSDictionary *dict=self.bankArr.firstObject;
   Bankdict=[dict objectForKey:@"BankData"];
    userName=[dict objectForKey:@"name"];
    self.UseBankNumber=[Bankdict objectForKey:@"BankNumber"];
    self.UseCardId=[dict objectForKey:@"cardid"];
      self.bankCode=[Bankdict objectForKey:@"zid"];
   
    if (Bankdict.count==0||Bankdict.allKeys==0) {
        bottom.BankName.text=@"银行卡支付";
        [bottom.ZhiChiBank setTitle:@"支持银行35家" forState:UIControlStateNormal];
        [bottom.BankName mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@70);
        }];
        bottom.KaitongRenZheng.textColor=RedButtonColor;
        bottom.KaitongRenZheng.text=@"开通认证支付>>";
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goRenZhengView)];
        [bottom.KaitongRenZheng addGestureRecognizer:tap];
    }
    else{
        NSString *bNum=[self.UseBankNumber substringFromIndex:self.UseBankNumber.length-4];
    bottom.BankName.text=[NSString stringWithFormat:@"%@(%@)",[Bankdict objectForKey:@"Bankname"],bNum];
      //  bottom.BankName.text=list.UseBankName;
        [bottom.ZhiChiBank setTitle:@"限额说明" forState:UIControlStateNormal];
       
        bottom.KaitongRenZheng.text=[NSString stringWithFormat:@"支付%d元",self.payMoney];
        //银行卡支付的钱
        self.bankPayMoney=[NSString stringWithFormat:@"%.2f",self.payMoney];
    // [self stringChangeColer:bottom.KaitongRenZheng andFromStr:@"付" ToStr:@"元"];
           [NSString DoubleStringChangeColer:bottom.KaitongRenZheng andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
        self.bankPayMoney=[NSString stringWithFormat:@"%.2d",self.payMoney];

    
    }
    [bottom.payBtnClick addTarget:self action:@selector(payBtnClick) forControlEvents:UIControlEventTouchUpInside];
  
}
-(void)bankListbtnClick{
    
    CMBankList *list=[[CMBankList alloc]init];
    [list show];
    
}
#pragma mark 支付界面
-(void)payBtnClick{
    
   // [self performSelector:@selector(delayBtnClick) withObject:nil afterDelay:1];
   
    [self delayBtnClick];
}
-(void)delayBtnClick{
    DLog(@"self.Yuer===%.2f,payMoney==%d,bankMoney==%@==self.account---%@===self.benjiID==%@",self.Yuer,self.payMoney,self.bankPayMoney,self.userAccountYuEr,self.BenJinJuanID);
    if (Bankdict.count==0||Bankdict.allKeys==0) {//没有认证
        
        if ([self.userAccountYuEr floatValue]<self.payMoney) {//余额不足
            [bottom.payBtnClick mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.top.equalTo(bottom.KaitongRenZheng.mas_bottom).offset(35);
                
            }];
            bottom.errorLabel.hidden=NO;
            bottom.errorLabel.text=@"*账户余额不足,请先开通认证支付";
            
        }else{//余额充足
            if (self.Yuer<=0.00) {
                NSString *msg=@"请选择支付方式！";
                CMAlert(msg);
                return;
            }
            [self YuerPay];
        }
    }else{//已经认证
        
        if ([self.userAccountYuEr floatValue]<self.payMoney) {//余额不足 银行卡支付
            
           
            if ([self.bankPayMoney isEqualToString:@"0.00"]) {
                [self YuerPay];
                return;
            }
             [self bankPay];
            
        }
        else{//余额充足
            
            if (middleView.selectBtn.selected==YES) { //选择余额支付
                
                [self YuerPay];
            }else{ //未选择余额支付
                
                [self bankPay];
                
            }
            
        }
        
    }
    
}
//银行卡支付
-(void)bankPay{
    
    
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_ProductAction.ashx?Action=3",OnLineCode];
    NSString *amount=[NSString stringWithFormat:@"%@",self.bankPayMoney];
    NSDictionary *dict=@{@"OrderID":OrderNum,@"CouponsID":self.BenJinJuanID,@"HYID":self.userID,@"MBAmount":MBAvailAmount,@"BankCardID":self.bankCode,@"Amount":amount};
    DLog(@"renzhengyinhangk===%@",dict);
    __weak typeof(self)weakSelf=self;
     [CMNSNotice postNotificationName:@"BeginRefresh" object:nil];
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
    
        DLog(@"银行卡支付===%@==result==%@",responseObj,[responseObj objectForKey:@"Result"]);
        if([[responseObj objectForKey:@"Status"]intValue]==200){
            newOrder=(NSDictionary*)responseObj;
            NSString *money=[NSString stringWithFormat:@"%@",weakSelf.bankPayMoney];
            //商务类型
            NSString *BusPartner=[NSString stringWithFormat:@"%@",[newOrder objectForKey:@"BusPartner"]];
            //订单时间
            NSString *FormateCreateOrderTime=[NSString stringWithFormat:@"%@",[newOrder  objectForKey:@"FormateCreateOrderTime"]];
            //产品名称
            NSString *ProductName=[newOrder  objectForKey:@"ProductName"];
            //订单号
            NSString *orderNu=[NSString  stringWithFormat:@"%@",[newOrder  objectForKey:@"OrderNum"]];
            //订单信息
            NSString *OrderInfo=[newOrder  objectForKey:@"OrderInfo"];
            //订单有效时间
            NSString *OrderExpireSpan=[NSString stringWithFormat:@"%@",[newOrder  objectForKey:@"OrderExpireSpan"]];
            
            //用户注册时间
            NSString *registDate=[NSString stringWithFormat:@"%@",[newOrder objectForKey:@"RegDateTime"]];

           
             NSDictionary *orderDict= [CMOrderHandle creatRechargeOrderWithPartner:BusPartner andOrderTime:FormateCreateOrderTime andOrderNum:orderNu andOrderMoney:money andOrderName:ProductName andOrderInfo:OrderInfo andOrderValid:OrderExpireSpan andUserRegistDate:registDate WithUserName:userName WithUserPhone:self.userPhoneNum andUserCardID:self.UseCardId andUserBankID:self.UseBankNumber];
        
            
            
            [CMOrderHandle CMorderManagerFromLLSdkWithOrderDict:orderDict PersentController:self];
            
            CMOrderHandle.resultBlock=^(LLPayResult resultCode,NSDictionary*resultDict){
                NSLog(@"+++%@",[resultDict objectForKey:@"ret_msg"]);
                NSString *code=[resultDict objectForKey:@"ret_code"];
                NSString *msg=[resultDict objectForKey:@"result_pay"];
                if ([code intValue]==0000&&[msg isEqualToString:@"SUCCESS"]) {
                    
                    CMOnlinePaySuccessController *vc=[[CMOnlinePaySuccessController alloc]init];
                    //vc.ProuctListArr=self.ProuctListArr;
                    if(self.isSuxincun){
                        vc.type=isSuiXinCunSuccess;
                        vc.prTitle=@"随心存";
                        
                    }else{
                        vc.type=isProductPaySuccess;
                        vc.prTitle=self.prTitle;
                        
                    }
                    [self.navigationController pushViewController:vc animated:YES];
                   
                }else{
                    
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:[resultDict objectForKey:@"ret_msg"] delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil ];
                    
                    [alert show];
                    
                }
                

                
            };
            
        }
        
        
    } failure:^(NSError *error) {
        
    }];

    
}
#pragma mark 余额支付
-(void)YuerPay{
    
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_ProductAction.ashx?Action=4",OnLineCode];
    
    NSDictionary *dict=@{@"OrderID":OrderNum,@"CouponsID":self.BenJinJuanID,@"HYID":self.userID,@"MBAmount":MBAvailAmount};
    DLog(@"已认证余额充足===%@",dict);
    [CMNSNotice postNotificationName:@"BeginRefresh" object:self];
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        
       
        DLog(@"已认证余额充足===%@==result==%@",responseObj,[responseObj objectForKey:@"Result"]);
        if ([[responseObj objectForKey:@"Status"]intValue]==200) {
            CMOnlinePaySuccessController *vc=[[CMOnlinePaySuccessController alloc]init];
            //vc.ProuctListArr=self.ProuctListArr;
            if(self.isSuxincun){
                vc.type=isSuiXinCunSuccess;
                vc.prTitle=@"随心存";
            }else{
                vc.type=isProductPaySuccess;
               vc.prTitle=self.prTitle;
            }
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            
            NSString *msg=[responseObj objectForKey:@"Result"];
            CMAlert(msg);
        }
        
        
    } failure:^(NSError *error) {
        
    }];
    

    
}
#pragma mark 去认证页面
-(void)goRenZhengView{

    CMUserTrueController *productVc = [[CMUserTrueController alloc] init];
    [self.navigationController pushViewController:productVc animated:YES];
    
    
    
    
}
#pragma mark 进入我的账户
-(void)enterIntoMyAccount{
    
    NSMutableArray  *arr=[[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    UIViewController *rootController=arr.firstObject;
    if([rootController isKindOfClass:[CMAccountViewController class]]){
        [self.navigationController popToRootViewControllerAnimated:YES];
        return;
       
    }
   
    for (UIViewController *vc in arr) {
        if ([vc isKindOfClass:[CMPayViewController class]]) {
            
            [arr removeObject:vc];
            break;
        }
    }
    //self.navigationController.viewControllers=arr;
    UIWindow *window=[UIApplication sharedApplication].windows.firstObject;
    CMTabBarController *tab=(CMTabBarController*)window.rootViewController;
    [tab selectTap:3];
 
    for (UIViewController *vc in arr) {
      
        if ([vc isKindOfClass:[self class]]) {
            
            [arr removeObject:vc];
            break;
        }    }
    self.navigationController.viewControllers=arr;
}
#pragma mark选择账户余额支付
-(void)changeAccountYuEr{
 // DLog(@"Change===self.Yuer===%.2f,payMoney==%d,bankMoney==%@==self.account---%@",self.Yuer,self.payMoney,self.bankPayMoney,self.userAccountYuEr);
   
    if (middleView.selectBtn.selected==NO) {
        
        middleView.selectBtn.selected=YES;
        [middleView.selectBtn setImage:[UIImage imageNamed:@"zhigu_xzicon-01.png"] forState:UIControlStateNormal];
        
       if (Bankdict.count>0||Bankdict.allKeys.count>0) { //认证
           if ([self.userAccountYuEr floatValue]>=self.payMoney ) {//账户充足
            
                   middleView.accountPay.text=[NSString stringWithFormat:@"支付%.2f元",(float)self.payMoney-[MBAvailAmount floatValue]];
                   self.Yuer=(float)self.payMoney-[MBAvailAmount floatValue];
                   //[self stringChangeColer: middleView.accountPay andFromStr:@"付" ToStr:@"元"];
            [NSString DoubleStringChangeColer:middleView.accountPay andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
                   if (self.liCaiArr.count>0) {
                       if (liCaiJINer*100>self.payMoney) {
                       middleView.accountPay.text=[NSString stringWithFormat:@"支付%.2f元",(float)self.payMoney-(float)liCaiJINer+10];
                       self.Yuer=self.payMoney-(int)liCaiJINer+10;
                     //  [self stringChangeColer: middleView.accountPay andFromStr:@"付" ToStr:@"元"];
                           [NSString DoubleStringChangeColer:middleView.accountPay andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
                       }else{
                           
                           middleView.accountPay.text=[NSString stringWithFormat:@"支付%.2f元",(float)self.payMoney-(float)liCaiJINer];
                           self.Yuer=self.payMoney-(float)liCaiJINer;
                        
                           [NSString DoubleStringChangeColer:middleView.accountPay andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
                       }
                  
               }
              
                   NSString *money=[NSString stringWithFormat:@"支付%.2f元",0.00];
               
                   self.bankPayMoney=[NSString stringWithFormat:@"%.2f",0.00];
                   bottom.KaitongRenZheng.text=money;
                 //  [self stringChangeColer: bottom.KaitongRenZheng andFromStr:@"付" ToStr:@"元"];
               [NSString DoubleStringChangeColer:bottom.KaitongRenZheng andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
               
           }else{ //账户不足
               
               middleView.accountPay.text=[NSString stringWithFormat:@"支付%@元",self.userAccountYuEr];
               self.Yuer=[self.userAccountYuEr intValue];
               [NSString DoubleStringChangeColer:middleView.accountPay andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
               
               if (middleView.MselectBtn.selected==YES) {//选M币
                NSString *money=[NSString stringWithFormat:@"支付%.2f元",[self.bankPayMoney floatValue]-[self.userAccountYuEr floatValue]];

                  self.bankPayMoney=[NSString stringWithFormat:@"%.2f",[self.bankPayMoney floatValue] -[self.userAccountYuEr floatValue]];
                   bottom.KaitongRenZheng.text=money;
                   
                   
                   [NSString DoubleStringChangeColer:bottom.KaitongRenZheng andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
                   
                   if ([self.bankPayMoney floatValue]<[self.userAccountYuEr floatValue]) {
                       self.bankPayMoney=@"0.00";
                       bottom.KaitongRenZheng.text=@"支付0.00元";
                       
                       middleView.accountPay.text=[NSString stringWithFormat:@"支付%.2f元",(float)self.payMoney-[MBAvailAmount floatValue]];
                       
                       [NSString DoubleStringChangeColer:middleView.accountPay andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
                       self.Yuer=(float)self.payMoney-[MBAvailAmount floatValue];
                   }
             
               }
               
          
               DLog(@"self.bankpaymoney===%.2f",[self.bankPayMoney floatValue]);
               if (middleView.LselectBtn.selected==YES) {//选理财劵
                  
                       
                       if (liCaiJINer>0) {
                           
                           NSString *money=[NSString stringWithFormat:@"支付%.2f元",[self.bankPayMoney floatValue]-[self.userAccountYuEr floatValue]];
                           
                           self.bankPayMoney=[NSString stringWithFormat:@"%.2f",[self.bankPayMoney floatValue] -[self.userAccountYuEr floatValue]];
                           bottom.KaitongRenZheng.text=money;
                          
              
                           
                           if ([self.bankPayMoney floatValue]<liCaiJINer) {
                               self.bankPayMoney=@"0.00";
                               bottom.KaitongRenZheng.text=@"支付0.00元";
                               
                               middleView.accountPay.text=[NSString stringWithFormat:@"支付%.2f元",self.payMoney-(self.payMoney/self.productFenEr)*10];
                               
                               [NSString DoubleStringChangeColer:middleView.accountPay andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
                               self.Yuer=self.payMoney-(self.payMoney/self.productFenEr)*10;
                           }
                         
                                [NSString DoubleStringChangeColer:bottom.KaitongRenZheng andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
                       }
                   
                   
               }else{//未选理财劵
                  // if (self.liCaiArr.count>0) {

                  NSString *money=[NSString stringWithFormat:@"支付%.2f元",(float)self.payMoney -[self.userAccountYuEr floatValue]];
                  self.bankPayMoney=[NSString stringWithFormat:@"%.2f",(float)self.payMoney -[self.userAccountYuEr floatValue]];
   
                   bottom.KaitongRenZheng.text=money;
                  // [self stringChangeColer: bottom.KaitongRenZheng andFromStr:@"付" ToStr:@"元"];
                   [NSString DoubleStringChangeColer:bottom.KaitongRenZheng andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];

               }
               
           
           
      }
           
       }else{ //未认证
           
           if ([self.userAccountYuEr floatValue]>=self.payMoney ) {
              
                   middleView.accountPay.text=[NSString stringWithFormat:@"支付%d元",self.payMoney-[MBAvailAmount intValue]];
                   self.Yuer=self.payMoney-[MBAvailAmount intValue];
                   //[self stringChangeColer: middleView.accountPay andFromStr:@"付" ToStr:@"元"];
               [NSString DoubleStringChangeColer:middleView.accountPay andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
               if (self.liCaiArr.count>0) {
                   
                   if (liCaiJINer/10>=self.payMoney/self.productFenEr){
               middleView.accountPay.text=[NSString stringWithFormat:@"支付%d元",self.payMoney-(self.payMoney/self.productFenEr)*10];
               self.Yuer=self.payMoney-(self.payMoney/self.productFenEr)*10;
               //[self stringChangeColer: middleView.accountPay andFromStr:@"付" ToStr:@"元"];
                       [NSString DoubleStringChangeColer:middleView.accountPay andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
                   }else{
                       
                       middleView.accountPay.text=[NSString stringWithFormat:@"支付%d元",self.payMoney-(int)liCaiJINer];
                       self.Yuer=self.payMoney-(int)liCaiJINer;
                      // [self stringChangeColer: middleView.accountPay andFromStr:@"付" ToStr:@"元"];
                       [NSString DoubleStringChangeColer:middleView.accountPay andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
 
                   }
            }
    
           }else{
               
                   middleView.accountPay.text=[NSString stringWithFormat:@"支付%@元",self.userAccountYuEr];
                   self.Yuer=[self.userAccountYuEr intValue];
                  // [self stringChangeColer: middleView.accountPay andFromStr:@"付" ToStr:@"元"];
         [NSString DoubleStringChangeColer:middleView.accountPay andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
       }
           
       }

       
        
    } else {
        
        middleView.selectBtn.selected=NO;
        [ middleView.selectBtn setImage:[UIImage imageNamed:@"zhifu_xziocn.png"] forState:UIControlStateNormal];
        middleView.accountPay.text=[NSString stringWithFormat:@"支付%@元",@"0.00"];
        self.Yuer=0.00;
        //[self stringChangeColer: middleView.accountPay andFromStr:@"付" ToStr:@"元"];
    [NSString DoubleStringChangeColer:middleView.accountPay andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
        if (Bankdict.count>0||Bankdict.allKeys.count>0) {
           
              
                if (middleView.MselectBtn.selected==NO) {
                   
                    NSString *money=[NSString stringWithFormat:@"支付%d元",self.payMoney];
                    self.bankPayMoney=[NSString stringWithFormat:@"%.2d",self.payMoney];
                    bottom.KaitongRenZheng.text=money;
                    [NSString DoubleStringChangeColer:bottom.KaitongRenZheng andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
                }else{
                    
                        NSString *money=[NSString stringWithFormat:@"支付%.2f元",(float)self.payMoney-[MBAvailAmount floatValue]];
                        self.bankPayMoney=[NSString stringWithFormat:@"%.2f",(float)self.payMoney-[MBAvailAmount floatValue]];
                        bottom.KaitongRenZheng.text=money;
                    // [self stringChangeColer: bottom.KaitongRenZheng andFromStr:@"付" ToStr:@"元"];
                [NSString DoubleStringChangeColer:bottom.KaitongRenZheng andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];}
            if (self.liCaiArr.count>0) {
                if (middleView.LselectBtn.selected==YES) {
                    
                    
                      if (liCaiJINer/10>=self.payMoney/self.productFenEr){
                    
                    NSString *Tmoney=[NSString stringWithFormat:@"支付%d元",self.payMoney-(self.payMoney/self.productFenEr)*10];
                    self.bankPayMoney=[NSString stringWithFormat:@"%.2d",self.payMoney-(self.payMoney/self.productFenEr)*10];
                    bottom.KaitongRenZheng.text=Tmoney;
                    
                   // [self stringChangeColer: bottom.KaitongRenZheng andFromStr:@"付" ToStr:@"元"];
                          [NSString DoubleStringChangeColer:bottom.KaitongRenZheng andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
                      }else{
                          
                          NSString *Tmoney=[NSString stringWithFormat:@"支付%d元",self.payMoney-(int)liCaiJINer];
                          self.bankPayMoney=[NSString stringWithFormat:@"%.2d",self.payMoney-(int)liCaiJINer];
                          bottom.KaitongRenZheng.text=Tmoney;
                          
                          //[self stringChangeColer: bottom.KaitongRenZheng andFromStr:@"付" ToStr:@"元"];
                          [NSString DoubleStringChangeColer:bottom.KaitongRenZheng andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
                      }
                    
                    
                    
                }else{
                    NSString *money=[NSString stringWithFormat:@"支付%d元",self.payMoney];
                    self.bankPayMoney=[NSString stringWithFormat:@"%.2d",self.payMoney];
                    bottom.KaitongRenZheng.text=money;
                     //[self stringChangeColer: bottom.KaitongRenZheng andFromStr:@"付" ToStr:@"元"];
                    [NSString DoubleStringChangeColer:bottom.KaitongRenZheng andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
                }
            }

            
            
        }
        
      
       
       
    }
    
}
#pragma mark使用M币支付
-(void)useMbinZheKouBtnClick{
     //DLog(@"MB===self.Yuer===%.2f,payMoney==%d,bankMoney==%@==self.account---%@",self.Yuer,self.payMoney,self.bankPayMoney,self.userAccountYuEr);
    if (middleView.MselectBtn.selected==NO) {
      
        middleView.MselectBtn.selected=YES;
        self.BenJinJuanID=@"0";
        middleView.LselectBtn.selected=NO;
        [ middleView.LselectBtn setImage:[UIImage imageNamed:@"zhifu_xziocn.png"] forState:UIControlStateNormal];
        middleView.useLiCaiLabel.hidden=YES;
         middleView.LiCaiJuanLabel.hidden=YES;
        [ middleView.MselectBtn setImage:[UIImage imageNamed:@"zhigu_xzicon-01.png"] forState:UIControlStateNormal];
         middleView.useMbinLabel.hidden=NO;
        
        MBMount=[self.MBArr objectForKey:@"MBAmount"];
        MBAvailAmount=[self.MBArr objectForKey:@"MBAvailAmount"];
     // MBAvailAmount=@"50";
         middleView.useMbinLabel.text=[NSString stringWithFormat:@"目前您有%@M币,本次可抵扣%@元",MBMount,MBAvailAmount];
       
        if (Bankdict.count>0||Bankdict.allKeys.count>0) {
          
          if ([self.userAccountYuEr floatValue]<self.payMoney) {
          
           
              if (middleView.LselectBtn.selected==YES) {
                  NSString *money=[NSString stringWithFormat:@"支付%.2f元",(float)self.payMoney-[MBAvailAmount floatValue]];
                  self.bankPayMoney=[NSString stringWithFormat:@"%.2f",(float)self.payMoney-[MBAvailAmount floatValue]];
                  bottom.KaitongRenZheng.text=money;
                  
               //   [self stringChangeColer: bottom.KaitongRenZheng andFromStr:@"付" ToStr:@"元"];
                  
                  [NSString DoubleStringChangeColer:middleView.accountPay andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
                  
              }else{
                  if (middleView.selectBtn.selected==YES) {
                     
                      NSString *money=[NSString stringWithFormat:@"支付%.2f元",(float)self.payMoney-[MBAvailAmount floatValue]-[self.userAccountYuEr floatValue]];
                      self.bankPayMoney=[NSString stringWithFormat:@"%.2f",(float)self.payMoney-[MBAvailAmount floatValue]-[self.userAccountYuEr floatValue]];
                      bottom.KaitongRenZheng.text=money;
                      
                      if ([self.bankPayMoney floatValue]<[MBAvailAmount floatValue]) {
                          self.bankPayMoney=@"0.00";
                          bottom.KaitongRenZheng.text=@"支付0.00元";
                          
                          middleView.accountPay.text=[NSString stringWithFormat:@"支付%.2f元",(float)self.payMoney-[MBAvailAmount floatValue]];
                          
                          [NSString DoubleStringChangeColer:middleView.accountPay andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
                          self.Yuer=(float)self.payMoney-[MBAvailAmount floatValue];
                      }
                      [NSString DoubleStringChangeColer:bottom.KaitongRenZheng andFromStr:@"付" ToStr:@"元"withColor:RedButtonColor];
                      
                  }else{
                  NSString *money=[NSString stringWithFormat:@"支付%.2f元",(float)self.payMoney-[MBAvailAmount floatValue]];
                  self.bankPayMoney=[NSString stringWithFormat:@"%.2f",(float)self.payMoney-[MBAvailAmount floatValue]];
                  bottom.KaitongRenZheng.text=money;
                  
                      [NSString DoubleStringChangeColer:bottom.KaitongRenZheng andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
                  }
              }

        }else{
            
            if (middleView.selectBtn.selected==YES) {
            
                middleView.accountPay.text=[NSString stringWithFormat:@"支付%.2f元",(float)self.payMoney-[MBAvailAmount floatValue]];
                self.Yuer=self.payMoney-[MBAvailAmount intValue];
               // [self stringChangeColer: middleView.accountPay    andFromStr:@"付" ToStr:@"元"];
                
   [NSString DoubleStringChangeColer:middleView.accountPay andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
                
            }else{
                NSString *money=[NSString stringWithFormat:@"支付%d元",[self.bankPayMoney intValue]-[MBAvailAmount intValue]];
                                self.bankPayMoney=[NSString stringWithFormat:@"%.2f",(float)self.payMoney-[MBAvailAmount floatValue]];
                                bottom.KaitongRenZheng.text=money;
//[self stringChangeColer: bottom.KaitongRenZheng andFromStr:@"付" ToStr:@"元"];
  [NSString DoubleStringChangeColer:bottom.KaitongRenZheng andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
                
            }
      
        }
            
        }else{
            if ([self.userAccountYuEr floatValue]<self.payMoney) {
                
                middleView.payJinEr.text=[NSString stringWithFormat:@"%d元",self.payMoney];
                [NSString LoneAttributedStringEndString:@"元" FromLabel:middleView.payJinEr];;
                
           
                }else{
                    if (middleView.selectBtn.selected==YES) {
                        
                        
                        middleView.accountPay.text=[NSString stringWithFormat:@"支付%.2f元",(float)self.payMoney-[MBAvailAmount floatValue]];
                        self.Yuer=(float)self.payMoney-[MBAvailAmount floatValue];
                      //  [self stringChangeColer: middleView.accountPay    andFromStr:@"付" ToStr:@"元"];
                        [NSString DoubleStringChangeColer:middleView.accountPay andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
           }
  
        }
            
            
        }
  

        [UIView animateWithDuration:0.1 animations:^{
            bottom.frame=CGRectMake(0, 230, CMScreenW, CMScreenH-230);
        } completion:^(BOOL finished) {
            
        }];
        
        
    } else {
        MBAvailAmount=@"0";
        MBMount=@"0";
        middleView.MselectBtn.selected=NO;
        middleView.useMbinLabel.hidden=YES;
        middleView.useLiCaiLabel.hidden=YES;
        middleView.payJinEr.text=[NSString stringWithFormat:@"%d元",self.payMoney];
        [NSString LoneAttributedStringEndString:@"元" FromLabel:middleView.payJinEr];
        
        if (Bankdict.count>0||Bankdict.allKeys.count>0) {
            
            if ([self.userAccountYuEr floatValue]<self.payMoney) {
                if (middleView.selectBtn.selected==NO) {
                    NSString *money=[NSString stringWithFormat:@"支付%d元",self.payMoney ];
                    self.bankPayMoney=[NSString stringWithFormat:@"%.2d",self.payMoney];
                    bottom.KaitongRenZheng.text=money;
                    
                    [NSString DoubleStringChangeColer:bottom.KaitongRenZheng andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
                }else{
                    
                    
                    NSString *money=[NSString stringWithFormat:@"支付%.2f元",(float)self.payMoney-[self.userAccountYuEr  floatValue] ];
                    self.bankPayMoney=[NSString stringWithFormat:@"%.2f",(float)self.payMoney-[self.userAccountYuEr  floatValue]];
                    bottom.KaitongRenZheng.text=money;
                    [NSString DoubleStringChangeColer:bottom.KaitongRenZheng andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
                    
                    middleView.accountPay.text=[NSString stringWithFormat:@"支付%.2f元",[self.userAccountYuEr  floatValue]];
                    
                    // [self stringChangeColer: middleView.accountPay andFromStr:@"付" ToStr:@"元"];
                    [NSString DoubleStringChangeColer:middleView.accountPay andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
                    
                    
                }
                
                
            }else{
                if (middleView.selectBtn.selected==YES) {
                    middleView.accountPay.text=[NSString stringWithFormat:@"支付%d元",self.payMoney];
                    self.Yuer=self.payMoney;
                   // [self stringChangeColer: middleView.accountPay andFromStr:@"付" ToStr:@"元"];
                    [NSString DoubleStringChangeColer:middleView.accountPay andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
                }else{
                    
                    NSString *money=[NSString stringWithFormat:@"支付%d元",self.payMoney ];
                    self.bankPayMoney=[NSString stringWithFormat:@"%d",self.payMoney];
                    bottom.KaitongRenZheng.text=money;
                    
                    //[self stringChangeColer: bottom.KaitongRenZheng andFromStr:@"付" ToStr:@"元"];
                    [NSString DoubleStringChangeColer:bottom.KaitongRenZheng andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
                    
                    
                }
                
            }
            
            
        }else{
            
            if ([self.userAccountYuEr floatValue]<self.payMoney) {
                
                
            }else{
                if (middleView.selectBtn.selected==YES) {
                    middleView.accountPay.text=[NSString stringWithFormat:@"支付%.2f元",(float)self.payMoney-[MBAvailAmount floatValue]];
                    self.Yuer=(float)self.payMoney-[MBAvailAmount floatValue];
                    //[self stringChangeColer: middleView.accountPay andFromStr:@"付" ToStr:@"元"];
                    [NSString DoubleStringChangeColer:middleView.accountPay andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
                }
                
            }
            
            
        }
        
        
        
        
        [ middleView.MselectBtn setImage:[UIImage imageNamed:@"zhifu_xziocn.png"] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.1 animations:^{
            bottom.frame=CGRectMake(0, 200, CMScreenW,CMScreenH-200);
        } completion:^(BOOL finished) {
            
        }];
        
    }
    
    
    
}
#pragma mark使用理财本金劵
-(void)useLiCaiJuanBtnClick{
   // self.liCaiArr=@[];

   
    if (middleView.LselectBtn.selected==NO) {
        
        middleView.MselectBtn.selected=NO;
        middleView.useMbinLabel.hidden=YES;
       [ middleView.MselectBtn setImage:[UIImage imageNamed:@"zhifu_xziocn.png"] forState:UIControlStateNormal];
        
        middleView.LselectBtn.selected=YES;
       [ middleView.LselectBtn setImage:[UIImage imageNamed:@"zhigu_xzicon-01.png"] forState:UIControlStateNormal];
       
        middleView.useLiCaiLabel.hidden=NO;
        middleView.useLiCaiLabel.text=@"温馨提醒:每1000元可用10元,每次只可使用一张";
//        middleView.LiCaiJuanLabel.hidden=NO;
//        middleView.LiCaiJuanLabel.text=@"已选择:10元面额";
        if (self.liCaiArr.count>0) {
          
                AlertLiCaiJuan=[[CMAlertLICaiBenJinJuan alloc]initWithLiCaibenJinJuandata:self.liCaiArr];
                AlertLiCaiJuan.delegate=self;
                [AlertLiCaiJuan ShowAlert];
           
            
        }else{
             if (Bankdict.count>0||Bankdict.allKeys.count>0) {
            if ([self.resultMsg isEqualToString:@"该产品不能使用喵券！"]) {
                self.liCaiArr=@[];
                AlertLiCaiJuan=[[CMAlertLICaiBenJinJuan alloc]initWithLiCaibenJinJuandata:self.liCaiArr];
                AlertLiCaiJuan.delegate=self;
                [AlertLiCaiJuan ShowAlert];
            }
             }
            DLog(@"本金劵=====%@",self.resultMsg );
            self.BenJinJuanID=@"0";
            liCaiJINer=0.00;
        }
        
        
         [UIView animateWithDuration:0.1 animations:^{
                   
        bottom.frame=CGRectMake(0, 230, CMScreenW, CMScreenH-230);
                   
        } completion:^(BOOL finished) {
            
        }];
        
        
    } else {
        self.BenJinJuanID=@"0";
        liCaiJINer=0.00;
        middleView.useMbinLabel.hidden=YES;
        middleView.useLiCaiLabel.hidden=YES;

        middleView.LselectBtn.selected=NO;
        middleView.LiCaiJuanLabel.hidden=YES;
      [ middleView.LselectBtn setImage:[UIImage imageNamed:@"zhifu_xziocn.png"] forState:UIControlStateNormal];
        
        if(self.liCaiArr.count>0){
            if (Bankdict.count>0||Bankdict.allKeys.count>0) {//认证
                
                if ([self.userAccountYuEr floatValue]<self.payMoney) {
                    if (middleView.selectBtn.selected==NO) {
                        NSString *money=[NSString stringWithFormat:@"支付%d元",self.payMoney ];
                        self.bankPayMoney=[NSString stringWithFormat:@"%.2d",self.payMoney];
                        bottom.KaitongRenZheng.text=money;
                        
                       // [self stringChangeColer: bottom.KaitongRenZheng andFromStr:@"付" ToStr:@"元"];
                        [NSString DoubleStringChangeColer:bottom.KaitongRenZheng andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
                    }else{
                        
                        
                        NSString *money=[NSString stringWithFormat:@"支付%.2f元",(float)self.payMoney-[self.userAccountYuEr  floatValue] ];
                        self.bankPayMoney=[NSString stringWithFormat:@"%.2f",(float)self.payMoney-[self.userAccountYuEr  floatValue]];
                        bottom.KaitongRenZheng.text=money;

                          middleView.accountPay.text=[NSString stringWithFormat:@"支付%.2f元",[self.userAccountYuEr  floatValue]];
                        
                        [NSString DoubleStringChangeColer:middleView.accountPay andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
                        
                        [NSString DoubleStringChangeColer:bottom.KaitongRenZheng andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
                        
                    }
                    
                    
                }else{
                    if (middleView.selectBtn.selected==YES) {
                        middleView.accountPay.text=[NSString stringWithFormat:@"支付%d元",self.payMoney];
                        self.Yuer=self.payMoney;
                        //[self stringChangeColer: middleView.accountPay andFromStr:@"付" ToStr:@"元"];
                        [NSString DoubleStringChangeColer:middleView.accountPay andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
                    }else{
                        
                        NSString *money=[NSString stringWithFormat:@"支付%d元",self.payMoney ];
                        self.bankPayMoney=[NSString stringWithFormat:@"%d",self.payMoney];
                        bottom.KaitongRenZheng.text=money;
                        
                        //[self stringChangeColer: bottom.KaitongRenZheng andFromStr:@"付" ToStr:@"元"];
                        [NSString DoubleStringChangeColer:bottom.KaitongRenZheng andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
                        
                    }
                    
                }
                

                
                
            }else{
                
                
                if ([self.userAccountYuEr floatValue]<self.payMoney) {
                    
                    
                }else{
                    if (middleView.selectBtn.selected==YES) {
                        middleView.accountPay.text=[NSString stringWithFormat:@"支付%d元",self.payMoney-(int)liCaiJINer];
                        self.Yuer=self.payMoney-(int)liCaiJINer;
                        //[self stringChangeColer: middleView.accountPay andFromStr:@"付" ToStr:@"元"];
                        [NSString DoubleStringChangeColer:middleView.accountPay andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
                    }
                    
                }
            

            }
            
            
        }
        
        
        [UIView animateWithDuration:0.1 animations:^{
            bottom.frame=CGRectMake(0, 200, CMScreenW, CMScreenH-200);
        } completion:^(BOOL finished) {
            
        }];
        
    }
 
 
}
-(void)alertViewShowTiXianWithRow:(NSInteger)aRow{
   
    NSDictionary *dict=self.liCaiArr[aRow];
  
    [UIView animateWithDuration:0.1 animations:^{
        
         middleView.frame=CGRectMake(0, 50, CMScreenW, 200);

        bottom.frame=CGRectMake(0, 260, CMScreenW, CMScreenH-260);
        
    } completion:^(BOOL finished) {
        
     middleView.LiCaiJuanLabel.hidden=NO;
         liCaiJINer= [[dict objectForKey:@"MNum"]floatValue];
        self.BenJinJuanID=[dict objectForKey:@"ID"];
     middleView.LiCaiJuanLabel.text=[NSString stringWithFormat:@"已选择:%d面额",(int)liCaiJINer];
    
    [NSString  DoubleAttributedStringFromString:@":" andEndString:@"面" FromLabel: middleView.LiCaiJuanLabel];
     [AlertLiCaiJuan dimissAlert];
      // liCaiJINer=10.00;
         if (Bankdict.count>0||Bankdict.allKeys.count>0) { //认证
             if ([self.userAccountYuEr floatValue]<self.payMoney) {//余额不足
                 if (middleView.selectBtn.selected==YES) {
                   self.bankPayMoney=[NSString stringWithFormat:@"%.2f",(float)self.payMoney-[self.userAccountYuEr  floatValue]];
                 }
                 if (liCaiJINer/10>=self.payMoney/self.productFenEr) { //每一千用10元优惠券
                   
                NSString *money=[NSString stringWithFormat:@"支付%.2f元",[self.bankPayMoney floatValue]-(self.payMoney/self.productFenEr)*10];
                    
                     self.bankPayMoney=[NSString stringWithFormat:@"%.2f",[self.bankPayMoney floatValue]-(self.payMoney/self.productFenEr)*10];
                     bottom.KaitongRenZheng.text=money;
                     
                   
                     if ([self.bankPayMoney floatValue]<liCaiJINer) {
                         self.bankPayMoney=@"0.00";
                         bottom.KaitongRenZheng.text=@"支付0.00元";
                         
                         middleView.accountPay.text=[NSString stringWithFormat:@"支付%d元",self.payMoney-(self.payMoney/self.productFenEr)*10];
                         
                         [NSString DoubleStringChangeColer:middleView.accountPay andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
                         self.Yuer=self.payMoney-(self.payMoney/self.productFenEr)*10;
                     }
                  
                     [NSString DoubleStringChangeColer:bottom.KaitongRenZheng andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];    
                     
                 }else{
                 NSString *money=[NSString stringWithFormat:@"支付%.2f元",[self.bankPayMoney floatValue]-liCaiJINer];
                 self.bankPayMoney=[NSString stringWithFormat:@"%.2f",[self.bankPayMoney floatValue]-liCaiJINer];
                 bottom.KaitongRenZheng.text=money;
                [NSString DoubleStringChangeColer:bottom.KaitongRenZheng andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
                    
                     
                 }
             }else{//余额充足
                 
                 if (middleView.selectBtn.selected==YES) {
                   
                    
                      if (liCaiJINer/10>=self.payMoney/self.productFenEr) {
                          middleView.accountPay.text=[NSString stringWithFormat:@"支付%d元",self.payMoney-(self.payMoney/self.productFenEr)*10];
                          self.Yuer=self.payMoney-(self.payMoney/self.productFenEr)*10;
                          
                          [NSString DoubleStringChangeColer:middleView.accountPay andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
                      }else{
                          
                          middleView.accountPay.text=[NSString stringWithFormat:@"支付%d元",self.payMoney-(int)liCaiJINer];
                          self.Yuer=self.payMoney-(int)liCaiJINer;
                          //[self stringChangeColer: middleView.accountPay    andFromStr:@"付" ToStr:@"元"];
                          [NSString DoubleStringChangeColer:middleView.accountPay andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
                      }
                 }else{
                     
                     if (liCaiJINer/10>=self.payMoney/self.productFenEr) {
                     NSString *money=[NSString stringWithFormat:@"支付%d元",[self.bankPayMoney intValue]-(self.payMoney/self.productFenEr)*10];
                     self.bankPayMoney=[NSString stringWithFormat:@"%.2d",[self.bankPayMoney intValue]-(self.payMoney/self.productFenEr)*10];
                     bottom.KaitongRenZheng.text=money;
                    // [self stringChangeColer: bottom.KaitongRenZheng andFromStr:@"付" ToStr:@"元"];
                         [NSString DoubleStringChangeColer:bottom.KaitongRenZheng andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
                     }
                     else{
                         NSString *money=[NSString stringWithFormat:@"支付%d元",[self.bankPayMoney intValue]-(int)liCaiJINer];
                         self.bankPayMoney=[NSString stringWithFormat:@"%.2d",[self.bankPayMoney intValue]-(int)liCaiJINer];
                         bottom.KaitongRenZheng.text=money;
                         //[self stringChangeColer: bottom.KaitongRenZheng andFromStr:@"付" ToStr:@"元"];
                         [NSString DoubleStringChangeColer:bottom.KaitongRenZheng andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
                         
                         
                     }
                     
                 }

             }
             
             
         }else{
             
             if ([self.userAccountYuEr floatValue]<self.payMoney) {
                 
                 middleView.payJinEr.text=[NSString stringWithFormat:@"%d元",self.payMoney];
                 NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithString:middleView.payJinEr.text];
                 
                 NSRange qiToRang = [middleView.payJinEr.text rangeOfString:@"元"];
                 [str addAttribute:NSForegroundColorAttributeName value:RedButtonColor range:NSMakeRange(0, qiToRang.location)];
                 middleView.payJinEr.attributedText=str;
                 
                 
             }else{
                 if (middleView.selectBtn.selected==YES) {
                     
                     
                     middleView.accountPay.text=[NSString stringWithFormat:@"支付%d元",self.payMoney-(int)liCaiJINer];
                     self.Yuer=self.payMoney-(int)liCaiJINer;
                     //[self stringChangeColer: middleView.accountPay    andFromStr:@"付" ToStr:@"元"];
                     [NSString DoubleStringChangeColer:middleView.accountPay andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
                 }
                 
             }
             
             
             
             
             
         }
        
    }];

      
}
-(void)tapDimissAlertView{
    
    middleView.useMbinLabel.hidden=YES;
    middleView.useLiCaiLabel.hidden=YES;
    middleView.LselectBtn.selected=NO;
    middleView.LiCaiJuanLabel.hidden=YES;
     if ([self.userAccountYuEr floatValue]<self.payMoney) {
    if (middleView.selectBtn.selected==YES) {
        NSString *money=[NSString stringWithFormat:@"支付%.2f元",(float)self.payMoney-[self.userAccountYuEr  floatValue] ];
        self.bankPayMoney=[NSString stringWithFormat:@"%.2f",(float)self.payMoney-[self.userAccountYuEr  floatValue]];
        bottom.KaitongRenZheng.text=money;
        
        //[self stringChangeColer: bottom.KaitongRenZheng andFromStr:@"付" ToStr:@"元"];
        [NSString DoubleStringChangeColer:bottom.KaitongRenZheng andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
        
    }else{
        
        NSString *money=[NSString stringWithFormat:@"支付%.2f元",(float)self.payMoney];
        self.bankPayMoney=[NSString stringWithFormat:@"%.2f",(float)self.payMoney];
        bottom.KaitongRenZheng.text=money;
        
        //[self stringChangeColer: bottom.KaitongRenZheng andFromStr:@"付" ToStr:@"元"];
        [NSString DoubleStringChangeColer:bottom.KaitongRenZheng andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
        
    }
   
     }else{
       if (middleView.selectBtn.selected==NO) {
         NSString *money=[NSString stringWithFormat:@"支付%.2f元",(float)self.payMoney ];
         self.bankPayMoney=[NSString stringWithFormat:@"%.2f",(float)self.payMoney];
         bottom.KaitongRenZheng.text=money;
         [NSString DoubleStringChangeColer:bottom.KaitongRenZheng andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
       }else{
           NSString *money=[NSString stringWithFormat:@"支付%.2f元",0.00 ];
           self.bankPayMoney=[NSString stringWithFormat:@"%.2f",0.00];
           bottom.KaitongRenZheng.text=money;
           [NSString DoubleStringChangeColer:bottom.KaitongRenZheng andFromStr:@"付" ToStr:@"元" withColor:RedButtonColor];
       }
         
     }
   [ middleView.LselectBtn setImage:[UIImage imageNamed:@"zhifu_xziocn.png"] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.1 animations:^{
        bottom.frame=CGRectMake(0, 200, CMScreenW,CMScreenH-200);
    } completion:^(BOOL finished) {
        
    }];
[AlertLiCaiJuan dimissAlert];
    
}


#pragma mark 获得M币
-(void)getMBiList{
 
     NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_ProductAction.ashx?Action=2",OnLineCode];
  
    NSDictionary *dict=@{@"HYID":self.userID,@"OrderID":OrderNum};
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        
      //DLog(@"MBi=====%@",responseObj );
        self.MBArr=(NSDictionary*)responseObj;
        
    } failure:^(NSError *error) {
        
        
    }];
    
    
    
}
-(void)getUserBankList{
    [CMRequestHandle requestBankListMsgsuccess:^(id responseObj) {
        
        if ([[responseObj objectForKey:@"status"]intValue]==200) {
            
            self.bankArr=[responseObj objectForKey:@"result"];
            
        }
//     else if ([[responseObj objectForKey:@"status"]intValue]==300) {
//           [self loginAuto];
//        
//        }        else if([[responseObj objectForKey:@"result"]isEqualToString:@"账户失效，请重新登录！"]){
//        
//          [self loginAuto];
//      
//       }

    } andFailure:^(id error) {
       

        
        
        
    }];
    

    
    
}
#pragma mark 理财本金劵
-(void)getLiCaiBenJinJuanList{
    
    NSString *url=[NSString stringWithFormat:@"http://www.58cm.com/handler/BenefitInfo.ashx?Action=2"];
    
    NSDictionary *dict=@{@"HYID":self.userID,@"OrderID":OrderNum};
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        
    DLog(@"本金劵=====%@===%@",responseObj,[responseObj valueForKey:@"Result"] );
        if([[responseObj objectForKey:@"Status"]intValue]==200){
          self.liCaiArr=[responseObj objectForKey:@"ItemList"];
        }else{
            if ([[responseObj valueForKey:@"Result"] isEqualToString:@"该产品不能使用喵券！"]) {
                self.resultMsg=[responseObj valueForKey:@"Result"];
            }
            
        }
        
    } failure:^(NSError *error) {
        
        
    }];
    
}
/*
#pragma mark - 取出用户名密码自动登陆
- (void)loginAuto
{
    // 取出账号、密码
    NSUserDefaults *userDefault = CMUserDefaults;
    NSString *name = [userDefault objectForKey:@"name"];
    NSString *password = [PassWordTool readPassWord];
    if (name&&password) {
        
       NSString *urlStr = [NSString stringWithFormat:@"%@/handler/AppInterface.ashx?action=login&mobile=%@&pwd=%@&type=%@&id=%@",OnLineCode,name,password,@"1",[JPUSHService registrationID]];
 //  NSString *urlStr = [NSString stringWithFormat:@"%@/handler/AppInterface.ashx?action=login&mobile=%@&pwd=%@",OnLineCode,name,password];
        [CMHttpTool getWithURL:urlStr params:nil success:^(id responseObj) {
            
            //  DLog(@"loginAutoLogingChenggong----- %@",responseObj);
            
            NSString *strStatus = [responseObj valueForKey:@"status"];
            NSString *userID = [[[responseObj valueForKey:@"userMess"] objectAtIndex:0] valueForKey:@"userID"];
         
            if ([strStatus isEqualToString:@"200"]) {
                [CMUserDefaults objectForKey:@"userID"];
                [CMCookie getAndSaveCookie];
                [CMUserDefaults synchronize];
                // 请求用户信息
                NSString *url = [NSString stringWithFormat:@"%@/handler/app_interface.ashx?action=IcmIndex&hyid=%@",OnLineCode,userID];
                [CMHttpTool getWithURL:url params:nil success:^(id responseObj) {
                    
                    // DLog(@"UserMes======  %@",[responseObj objectForKey:@"result"]);
                    NSString *statusStr = [responseObj valueForKey:@"status"];
                    
                    if ([statusStr isEqualToString:@"200"]) {
                        
                        
                        NSString *userStr = name;
                        NSString *jinriStr = [[[responseObj valueForKey:@"result"] valueForKey:@"today_ShouYi_Amount"] objectAtIndex:0]; // 今日收益
                        NSString *leijiStr = [[[responseObj valueForKey:@"result"] valueForKey:@"leiji_shouyi_Amount"] objectAtIndex:0]; // 累计收益
                        NSString *yueStr = [[[responseObj valueForKey:@"result"] valueForKey:@"ky_amount"] objectAtIndex:0]; // 账户余额
                        NSString *zongStr = [[[responseObj valueForKey:@"result"] valueForKey:@"total_Amount"] objectAtIndex:0]; // 总资产
                        
                        NSDictionary *infoSign = @{@"userID":userID,
                                                   @"user":userStr,
                                                   @"jinrishouyi":jinriStr,
                                                   @"leijishouyi":leijiStr,
                                                   @"zhanghuyue":yueStr,
                                                   @"zongzichan":zongStr};
                      
                        [CMUserDefaults setObject:yueStr forKey:@"YuEr"];
                        [CMUserDefaults synchronize];
                        [CMNSNotice postNotificationName:@"MesToAccount" object:self userInfo:infoSign]; // 发送通知 —— 账户
                       
                    }
                    
                } failure:^(NSError *error) {
                    
                }];
                
            }
            
        } failure:^(NSError *error) {
            DLog(@"自动陆失败------%@",error);
            [CMUserDefaults removeObjectForKey:@"password"];
            NSString *url=[NSString stringWithFormat:@"%@/handler/AppInterface.ashx?action=quit",OnLineCode];
           
            [CMHttpTool getWithURL:url params:nil success:^(id responseObj) {
                
            } failure:^(NSError *error) {
                DLog(@"exitLoginAcconntError--%@",error);
            }];

            
        }];
        
    }
}
*/

@end
