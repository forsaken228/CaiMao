//
//  CMRechargeViewController.m
//  CaiMao
//
//  Created by MAC on 16/6/14.
//  Copyright © 2016年 58cm. All rights reserved.
//
#import "CMOnlinePaySuccessController.h"
#import "CMReChargeView.h"
#import "CMRecordOfCharge.h"
#import "CMOrderCreat.h"
@interface CMRechargeViewController ()<UITextFieldDelegate>
@property(nonatomic,copy)NSString *tBankName;
@property(nonatomic,copy)NSString *tBankNum;
@property(nonatomic,copy)NSString *tUserName;
@property(nonatomic,copy)NSString *tUserID;
@property(nonatomic,copy)NSString *RequestBankNum;
@property(copy,nonatomic)NSString *userPhoneNum;
@property(nonatomic,strong)NSArray *bankListArray;

@property(nonatomic,strong) CMReChargeView *ChargeView;

@property(nonatomic,copy)NSString *bank_code;


@end

@implementation CMRechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.title=@"充值";
   
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"充值记录" style:UIBarButtonItemStylePlain target:self action:@selector(enterIntoRecordOfTiXian)];
     self.userPhoneNum=[CMUserDefaults objectForKey:@"name"];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //异步操作代码块
       [self getBankList];
       [self renzhengSuccess];
        dispatch_async(dispatch_get_main_queue(), ^{
            //回到主线程操作代码块
            [self showDefaultProgressHUD];
            self.ChargeView.hidden=YES;
            [self.view addSubview:self.ChargeView];
            
             [self updateUI]; 
            
        });
        
    });
  
   
 //  NSLog(@"--------%@---%@",self.userDict,[CMUserDefaults objectForKey:@"userID"]);
}




#pragma mark 更新UI
-(void)updateUI{
    
    [CMRequestHandle requestRenZhengMsgsuccess:^(id responseObj) {
        if ([[responseObj objectForKey:@"status"]intValue]==200) {
            
            self.ChargeView.hidden=NO;
            [self hiddenProgressHUD];
        NSArray  * bankList=[responseObj objectForKey:@"result"];
            
            
            NSString *yuer=[CMUserDefaults objectForKey:@"YuEr"];
            //账户余额
            self.ChargeView.BalanceLabel.text=[NSString stringWithFormat:@"%@ 元",yuer];
            
            //充值金额
            self.ChargeView.RechargeNum.delegate=self;
            self.ChargeView.RechargeLimit.text=[NSString stringWithFormat:@"充值后账户余额%.2f元",[yuer floatValue]];
            
            //  qiStr = [NSString stringWithFormat:@"期限%d年",list.jkqx];
            [NSString DoubleStringChangeColer:self.ChargeView.RechargeLimit andFromStr:@"额" ToStr:@"元" withColor:RedButtonColor];
            [CMNSNotice addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification object:nil];
            
            [self.ChargeView.Rechargebtn addTarget:self action:@selector(rechargeBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
            //限额说明
            [self.ChargeView.limitContent addTarget:self action:@selector(limitContentBntClick) forControlEvents:UIControlEventTouchUpInside];
            //银行卡尾号
            
            for (NSDictionary *dict in bankList) {
                NSString *banknumber=[dict objectForKey:@"UseBankNumber"];
                self.RequestBankNum=banknumber;
                NSString *limit=[dict objectForKey:@"UseBankQuota"];
                //截取银行卡后四位
                NSString *number=[banknumber substringFromIndex:banknumber.length-4];
                self.tBankNum=banknumber;
                self.ChargeView.bankNum.text=[NSString stringWithFormat:@"尾号:%@",number];
                self.tBankName=[dict objectForKey:@"UseBankName"];
                //银行卡标志
                [self.ChargeView.bankIcon sd_setImageWithURL:[dict objectForKey:@"UseBankIcon"]];
                self.tUserName=[dict objectForKey:@"UseName"];
                self.tUserID=[dict objectForKey:@"UseID"];
                self.ChargeView.limitMoney.text=limit;
                
            }

            
            
            
            
        }
    } andFailure:^(id error) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"数据加载失败,请重新加载!";
        [hud hide:YES afterDelay:3];
        
       
    }];
    
    
    
    
}
#pragma mark Lazy
-(CMReChargeView*)ChargeView{
    if (!_ChargeView) {
         _ChargeView=[[CMReChargeView alloc]init];
    }
    return _ChargeView;
}

#pragma mark 资金记录
-(void)enterIntoRecordOfTiXian{
    CMRecordOfCharge *vc=[[CMRecordOfCharge alloc]init];
    vc.selectIndex=1;
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark  充值方法
-(void)rechargeBtnClick{
 
      //认证支付
    if (self.ChargeView.RechargeNum.text.length<=0) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入充值金额" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alert show];
        return ;
    }
    if([self.ChargeView.RechargeNum.text floatValue]<=1.0){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入充值金额大于1的数字" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alert show];
        return ;
    }
    if([self.ChargeView.RechargeNum.text floatValue]>50000.00){
        CMAlert(@"单笔金额不能超过5万");
        return ;
    }
    
   [ [CMOrderCreat sharedAPI]requeRechargeOrderMessageWithBankCode:self.bank_code andHYID:[CMUserDefaults objectForKey:@"userID"] andMount:self.ChargeView.RechargeNum.text success:^(id responseObj) {
       //DLog(@"----======%@",responseObj);
       //商务类型
       NSString *BusPartner=[NSString stringWithFormat:@"%@",[responseObj objectForKey:@"BusPartner"]];
       //订单时间
       NSString *FormateCreateOrderTime=[responseObj objectForKey:@"FormateCreateOrderTime"];
       //产品名称
       NSString *ProductName=[responseObj objectForKey:@"ProductName"];
       //订单号
       NSString *OrderNum=[NSString stringWithFormat:@"%@",[responseObj objectForKey:@"OrderNum"]];
       //订单信息
       NSString *OrderInfo=[responseObj objectForKey:@"OrderInfo"];
       //订单有效时间
       NSString *OrderExpireSpan=[NSString stringWithFormat:@"%@",[responseObj objectForKey:@"OrderExpireSpan"]];
   
       //用户注册时间
       NSString *registDate=[responseObj objectForKey:@"RegDateTime"];
      
      NSDictionary *orderDict= [CMOrderHandle creatRechargeOrderWithPartner:BusPartner andOrderTime:FormateCreateOrderTime andOrderNum:OrderNum andOrderMoney:self.ChargeView.RechargeNum.text andOrderName:ProductName andOrderInfo:OrderInfo andOrderValid:OrderExpireSpan andUserRegistDate:registDate WithUserName:self.tUserName WithUserPhone:self.userPhoneNum andUserCardID:self.tUserID andUserBankID:self.tBankNum];
     
       [CMOrderHandle CMorderManagerFromLLSdkWithOrderDict:orderDict PersentController:self];
     
       CMOrderHandle.resultBlock=^(LLPayResult resultCode,NSDictionary*resultDict){
           
          // NSLog(@"resultCode==%u,dic==%@",resultCode,resultDict);
          // NSLog(@"+++%@",[resultDict objectForKey:@"ret_msg"]);
           NSString *code=[resultDict objectForKey:@"ret_code"];
           NSString *msg=[resultDict objectForKey:@"result_pay"];
           
           if ([code intValue]==0000&&[msg isEqualToString:@"SUCCESS"]) {
               

               CMOnlinePaySuccessController *vc=[[CMOnlinePaySuccessController alloc]init];
               
               vc.type=isChongZhiPaySuccess;
               [self.navigationController pushViewController:vc animated:YES];
               [CMNSNotice postNotificationName:@"BeginRefresh" object:nil];
           }else{
               
               UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:[resultDict objectForKey:@"ret_msg"] delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil ];
               
               [alert show];
               
           }
           
     } ;
       
   }];
   
    }

#pragma mark 限额说明
-(void)limitContentBntClick{
    
    CMBankList *list=[[CMBankList alloc]initCreateBankListArry:self.bankListArray];
    [list show];      
    
    
}

-(void)dealloc{
    [CMNSNotice removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

#pragma mark监听textField金额变动
- (void)textFieldChanged:(NSNotification *)notic{
  
    float recharge=[self.ChargeView.RechargeNum.text floatValue];
 
    float balance=[[CMUserDefaults objectForKey:@"YuEr"] floatValue];
    float totoal=recharge+balance;
    self.ChargeView.RechargeLimit.text=[NSString stringWithFormat:@"充值后账户余额%.2f元",totoal];
     [NSString DoubleStringChangeColer:self.ChargeView.RechargeLimit andFromStr:@"额" ToStr:@"元" withColor:RedButtonColor];
    
    
}

-(void)getBankList{
    
#pragma mark 支持银行卡
    [CMRequestHandle requestSupportBankListMsgsuccess:^(id responseObj) {
        
        NSArray *result=[responseObj objectForKey:@"result"];
        
        for (NSDictionary *dict in result) {
            NSArray  *listArray=[dict objectForKey:@"bankName"];
            self.bankListArray=listArray;
            
        }
        
        
    }];
    
    
 
    
}

-(void)renzhengSuccess{
    
   
    
    [CMRequestHandle requestBankListMsgsuccess:^(id responseObj) {
        
        if ([[responseObj objectForKey:@"status"]intValue]==200) {
            
           NSArray *bankInfroArr=[responseObj objectForKey:@"result"];
            
            NSDictionary *dic=[bankInfroArr firstObject];
            NSDictionary  *bankData=[dic objectForKey:@"BankData"];
            self.bank_code=[bankData objectForKey:@"zid"];
            
                    }
    } andFailure:^(id error) {
        
    }];
    
}



@end
