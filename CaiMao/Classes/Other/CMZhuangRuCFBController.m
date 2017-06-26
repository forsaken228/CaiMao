//
//  CMZhuangRuCFBController.m
//  CaiMao
//
//  Created by MAC on 16/11/9.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMZhuangRuCFBController.h"
#import "CMZhuanRuView.h"
@interface CMZhuangRuCFBController ()


@property(nonatomic,strong)NSArray  *bankListArray;
@property(nonatomic,strong)NSArray  *RenZhengbankArray;
@property(nonatomic,strong)NSDictionary  *bankDataDict;
@property(nonatomic,strong)NSDictionary  *CFbDataDict;

@property(nonatomic,copy)NSString  *YuEr;
@property(nonatomic,copy)NSString  *SelectYuEr;
@property(nonatomic,copy)NSString  *inputAmount;
@property(nonatomic,copy)NSString  *bankAmount;
@property(nonatomic,assign)BOOL  isSelectYuer;



@property(nonatomic,copy)NSString  *userBankID;
@property(nonatomic,copy)NSString  *userBankName;
@property(nonatomic,strong)UITableView  *MyTableView;
@end

@implementation CMZhuangRuCFBController
-(void)loadView{
    [super loadView];
    //[self loginAuto];
  
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loaddata];
    [CMNSNotice addObserver:self selector:@selector(renzhengSuccess) name:@"renzhengSuccess" object:nil];
    self.title=@"转入财富宝";
    self.view.backgroundColor=ViewBackColor;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"我的账户" style:UIBarButtonItemStylePlain target:self action:@selector(GOAuccout)];
    self.SelectYuEr=@"0";
    self.inputAmount=@"0";
    self.bankAmount=@"0";
    self.isSelectYuer=NO;
    self.YuEr=[CMUserDefaults objectForKey:@"YuEr"];
    //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
      //  dispatch_async(dispatch_get_main_queue(), ^{
    
             [self ViewCreateFootViewAndHeadView];
             [self.view addSubview:self.MyTableView];

      //  });
        
  //  });
    
   

  }

-(void)loaddata{
    [self showDefaultProgressHUD];
    self.MyTableView.hidden=YES;
    [self getBankList];
    [self getRenZhengBankList];
    [self getCfbMessage];
}
-(void)renzhengSuccess{
    [self loaddata];
 
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([self.YuEr floatValue]<1.0){
        
      return 1;
    }else{
    return 2;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

   if(indexPath.row==0){
       
       if([self.YuEr floatValue]<1.0){
          
           return  [self theSecodCellWithTableView:tableView];

      
       }else{
           
           return [self theFirstCellWithTableView:tableView];
       
       
       }
   }
   else{
       return [self theSecodCellWithTableView:tableView];
   }
    
}

-(void)GOAuccout{
    if (self.isFromHome) {
        [self GOAuccoutOrHomeWithTap:3];
    }else{
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
    
}
#pragma mark 单元格
-(UITableViewCell*)theSecodCellWithTableView:(UITableView*)tableView{
    
    static NSString *Scell=@"CMCFBZhuangRuTwoCell";
    CMCFBZhuangRuTwoCell *cell=[tableView dequeueReusableCellWithIdentifier:Scell];
    if (!cell) {
        cell=[[CMCFBZhuangRuTwoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Scell];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    [cell.XianEDetailBtn  addTarget:self action:@selector(BankDeatilAction) forControlEvents:UIControlEventTouchUpInside];
       
 
    self.userBankID=[NSString stringWithFormat:@"%@",[self.CFbDataDict objectForKey:@"bankid"]];
    self.userBankName=[self.CFbDataDict objectForKey:@"bankname"];
        if ([self.userBankID isEqualToString:@"0"]) {
            
            cell.bankNameLabel.text=@"银行卡支付";
            cell.BankZhanRuAmountLabel.text=@"开通认证支付>>";
            cell.BankZhanRuAmountLabel.textColor=RedButtonColor;
            
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(GoRenZhengAction)];
            [cell.BankZhanRuAmountLabel  addGestureRecognizer:tap];
            
        }else{
            
       
                 cell.bankNameLabel.text=[NSString stringWithFormat:@"%@",self.userBankName];
                        cell.BankZhanRuAmountLabel.text=[NSString stringWithFormat:@"转入:%@元",self.bankAmount];
                        [NSString DoubleStringChangeColer: cell.BankZhanRuAmountLabel andFromStr:@":" ToStr:@"元" withColor:RedButtonColor];
            
            
        }
        
    
    CGRect  rect=[cell.bankNameLabel.text  boundingRectWithSize:CGSizeMake(120, 20) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil];
    [cell.bankNameLabel  mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(rect.size.width+2);
    }];
    
    
    return cell;

    
}
-(UITableViewCell*)theFirstCellWithTableView:(UITableView*)tableView{
    
    static NSString *Tcell=@"indexPath";
    CMCFBZhuangRuOneCell *cell=[tableView dequeueReusableCellWithIdentifier:Tcell];
    if (!cell) {
        cell=[[CMCFBZhuangRuOneCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Tcell];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    cell.BalanceAmountBtn.rightLabel.text=[NSString stringWithFormat:@"账户余额(%.2f)",[self.YuEr floatValue]];
    [NSString DoubleStringChangeColer: cell.BalanceAmountBtn.rightLabel andFromStr:@"(" ToStr:@")" withColor:RedButtonColor];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choiceZhangHuYuErAction:)];
   // cell.BalanceAmountBtn.tag=indexPath.row;
    [cell.BalanceAmountBtn  addGestureRecognizer:tap];
    cell.ZhanRuAmountLabel.text=[NSString stringWithFormat:@"转入:%@元",self.SelectYuEr];
    [NSString DoubleStringChangeColer: cell.ZhanRuAmountLabel andFromStr:@":" ToStr:@"元" withColor:RedButtonColor];
    return cell;

    
    
}
-(void)ViewCreateFootViewAndHeadView{
    
    CMZhuanRuView *ZhuanRuView=[[CMZhuanRuView  alloc]init];
    ZhuanRuView.backgroundColor=ViewBackColor;
    ZhuanRuView.frame=CGRectMake(0, 0, CMScreenW, 100);
    [CMNSNotice  addObserver:self selector:@selector(noticeTextFieldChange:) name:UITextFieldTextDidChangeNotification object:ZhuanRuView.ZhanRuAmountField];
    ZhuanRuView.ZhanRuAmountField.text=self.productCount;
    if ([self.productCount isEqualToString:@""]||self.productCount==nil||[self.productCount isEqual:[NSNull null]]) {
         self.inputAmount=@"0";
    }else{
    self.inputAmount=self.productCount;
    }
    if(self.isSelectYuer==NO){
        
        self.bankAmount=[NSString stringWithFormat:@"%d",[self.inputAmount intValue]];
        
    }
    ZhuanRuView.ZhanRuAmountField.delegate=self;
    self.MyTableView.tableHeaderView=ZhuanRuView;
    CMCFBZhuangFootView *FootView=[[CMCFBZhuangFootView alloc]init];
    FootView.frame=CGRectMake(0, 0, CMScreenW, CMScreenH);
    [FootView.ZhuangRuBtn addTarget:self action:@selector(ZhuangRuAction) forControlEvents:UIControlEventTouchUpInside];
    self.MyTableView.tableFooterView=FootView;


}

-(void)dealloc{
    [CMNSNotice removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    
}
-(void)noticeTextFieldChange:(NSNotification*)notice{
    UITextField *field=(UITextField*)notice.object;
    DLog(@"++%@",field.text);
    if([field.text intValue]>50000.00){
        CMTiShi(@"单笔金额不能超过5万");
        field.text=@"50000";
        return ;
    }
    
     self.inputAmount=field.text;
    if(self.isSelectYuer==NO){
        
        self.bankAmount=self.inputAmount;
        
    }else{
        if ([self.YuEr intValue]>=[field.text intValue]) {
            //余额大于输入
            self.SelectYuEr=field.text;
            self.bankAmount=@"0";
        }else{
            
            self.SelectYuEr=[NSString stringWithFormat:@"%d",[self.YuEr intValue]];
            self.bankAmount=[NSString stringWithFormat:@"%d",[self.inputAmount intValue]-[self.YuEr intValue]];
        }
    }
    if ([field.text isEqualToString:@""]||field.text.length<=0 ||field.text==nil||[field.text isKindOfClass:[NSNull class]]) {
        self.inputAmount=@"0";
        self.bankAmount=@"0";
        self.SelectYuEr=@"0";
    }
    
    
    [self.MyTableView reloadData];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField.text intValue]==0||textField.text.length<=0 ||[textField.text isKindOfClass:[NSNull class]]) {
        self.inputAmount=@"0";
    }
    
}
#pragma clang diagnostic ignored"-Wunused-variable"
#pragma mark我的账户
-(void)GOAuccoutOrHomeWithTap:(int)tap{
    UIWindow *window=[UIApplication sharedApplication].windows.firstObject;
    CMTabBarController *tab=(CMTabBarController*)window.rootViewController;
    [tab selectTap:tap];
    NSMutableArray  *arr=[[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    for (UIViewController *vc in arr) {
        
         [arr removeObjectsInRange:NSMakeRange(1, arr.count - 1)];
            break;
        //}
    }
    self.navigationController.viewControllers=arr;
    

}
#pragma mark Lazy

-(NSArray*)bankListArray{
    
    if (!_bankListArray) {
        _bankListArray=[NSArray array];
    }
    return _bankListArray;
}
-(NSArray*)RenZhengbankArray{
    
    if (!_RenZhengbankArray) {
        _RenZhengbankArray=[NSArray array];
    }
    return _RenZhengbankArray;
}
-(UITableView*)MyTableView{
    if (!_MyTableView) {
        _MyTableView=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _MyTableView.delegate=self;
        _MyTableView.dataSource=self;
        _MyTableView.scrollEnabled=NO;
    }
    return _MyTableView;
}
-(NSDictionary*)bankDataDict{
    if (!_bankDataDict) {
        _bankDataDict=[NSDictionary dictionary];
    }
    return _bankDataDict;
    
}
-(NSDictionary*)CFbDataDict{
    if (!_CFbDataDict) {
        _CFbDataDict=[NSDictionary dictionary];
    }
    return _CFbDataDict;
    
}

#pragma mark 选择账户余额
-(void)choiceZhangHuYuErAction:(UIGestureRecognizer*)tap{

//    CMCFBZhuangRuOneCell *cell=nil;
//        if (IOS8_LATER ) {
//            cell=(CMCFBZhuangRuOneCell*)tap.view.superview;
//        }else{
//            cell=(CMCFBZhuangRuOneCell*)tap.view.superview.superview;
//        }
 
    DLog(@"self.input===%@",self.inputAmount);
    
    
    NSIndexPath *index=[NSIndexPath  indexPathForRow:0 inSection:0];
    CMCFBZhuangRuOneCell *cell=[self.MyTableView  cellForRowAtIndexPath:index];
  static  BOOL isSelect;
    if (isSelect) {
         cell.BalanceAmountBtn.LeftimageView.image=[UIImage imageNamed:@"zhigu_xzicon-01"];
        self.isSelectYuer=YES;
        
        if ([self.YuEr intValue]>=[self.inputAmount intValue]) {
            //余额大于输入
            cell.ZhanRuAmountLabel.text=[NSString stringWithFormat:@"转入:%@元",self.inputAmount];
            [NSString DoubleStringChangeColer: cell.ZhanRuAmountLabel andFromStr:@":" ToStr:@"元" withColor:RedButtonColor];
            self.SelectYuEr=self.inputAmount;
            self.bankAmount=@"0";
        }else{
            cell.ZhanRuAmountLabel.text=[NSString stringWithFormat:@"转入:%d元",[self.YuEr intValue]];
            [NSString DoubleStringChangeColer: cell.ZhanRuAmountLabel andFromStr:@":" ToStr:@"元" withColor:RedButtonColor];
            self.SelectYuEr=[NSString stringWithFormat:@"%d",[self.YuEr intValue]];
            self.bankAmount=[NSString stringWithFormat:@"%d",[self.inputAmount intValue]-[self.YuEr intValue]];

            
        }
        

        
    } else {
         cell.BalanceAmountBtn.LeftimageView.image=[UIImage imageNamed:@"zhifu_xziocn"];
        self.isSelectYuer=NO;
        cell.ZhanRuAmountLabel.text=[NSString stringWithFormat:@"转入:%@元",self.inputAmount];
        self.SelectYuEr=@"0";
        self.bankAmount=self.inputAmount;
        [NSString DoubleStringChangeColer: cell.ZhanRuAmountLabel andFromStr:@":" ToStr:@"元" withColor:RedButtonColor];
        
    }
    isSelect =!isSelect;
   [self.MyTableView reloadData];
  
}
#pragma mark  转入方法
-(void)ZhuangRuAction{
//    DLog(@"+%@++%@+++%@++%@++%@++",self.inputAmount,self.SelectYuEr,self.bankAmount,self.userBankID,[CMUserDefaults objectForKey:@"name"]);
    

    if ([self.inputAmount intValue]<1) {
        CMTiShi( @"转入金额不能小于或等于0");
        return;
    }
    self.userBankID=[NSString stringWithFormat:@"%@",[self.CFbDataDict objectForKey:@"bankid"]];
    self.userBankName=[self.CFbDataDict objectForKey:@"bankname"];
    if ([self.userBankID isEqualToString:@"0"]) {
        
        if (self.isSelectYuer==YES) { //选择余额
            if ([self.YuEr intValue]>=[self.inputAmount intValue]) {
                
                NSString *str=[NSString stringWithFormat:@"转入财富宝%@元",self.inputAmount];
                CMZhuanRuConfirmAlert  *confrimAlert=[[CMZhuanRuConfirmAlert alloc]initWithTitle:@"确认支付" WithDeatilTitle:str WithCancleTitle:@"取消" WithDetaildown:@"立即转入"];
                confrimAlert.delegate=self;
                [confrimAlert ShowAlert];
                
                [NSString DoubleStringChangeColer:confrimAlert.detailLabel andFromStr:@"宝" ToStr:@"元" withColor:RedButtonColor];
              //  [self userYuErPayWithAmount:self.SelectYuEr andDwamount:@"0" andBankID:self.userBankID];
            }else{
                
                CMTiShi(@"账户余额不足,请先开通银行卡支付!");
                
            }
            
        }else{
            
        CMTiShi(@"账户余额不足,请先开通银行卡支付!");
            
            
        }
        

        
        
        
    }else{
        
        NSString *str=[NSString stringWithFormat:@"转入财富宝%@元",self.inputAmount];
        CMZhuanRuConfirmAlert  *confrimAlert=[[CMZhuanRuConfirmAlert alloc]initWithTitle:@"确认支付" WithDeatilTitle:str WithCancleTitle:@"取消" WithDetaildown:@"立即转入"];
        confrimAlert.delegate=self;
        [confrimAlert ShowAlert];
        
        [NSString DoubleStringChangeColer:confrimAlert.detailLabel andFromStr:@"宝" ToStr:@"元" withColor:RedButtonColor];
    }
 
    
   

    
}

-(void)ConfirmViewActionWithIndex:(NSInteger)Index{
    
     DLog(@"indesx+++%d+",Index);
    
    if(Index==1){
        self.userBankID=[NSString stringWithFormat:@"%@",[self.CFbDataDict objectForKey:@"bankid"]];
        self.userBankName=[self.CFbDataDict objectForKey:@"bankname"];
        if ([self.userBankID isEqualToString:@"0"]) {
            
             [self userYuErPayWithAmount:self.SelectYuEr andDwamount:@"0" andBankID:self.userBankID];
            
            
        }else{
            if (self.isSelectYuer==YES) { //选择余额
                if ([self.YuEr intValue]>=[self.inputAmount intValue]) {
                    [self userYuErPayWithAmount:self.SelectYuEr andDwamount:@"0" andBankID:self.userBankID];
                }else{
                    
                    [self userBankPayWithAmount:self.bankAmount andDwamount:self.SelectYuEr andBankID:self.userBankID];
                    
                }
                
            }else{
                
                [self userBankPayWithAmount:self.bankAmount andDwamount:@"0" andBankID:self.userBankID];
                
                
            }
            
            
        }

            
        }
        
}
-(void)jumpViewWithIndex:(NSInteger)Index{
    DLog(@"+++%d++%d",Index,self.isFromHome);
    switch (Index) {
        case 0:
        {
            
           
            if (self.isFromHome) {
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            }else{
                NSMutableArray  *arr=[[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
                for (UIViewController *vc in arr) {
                    
                    if ([vc isKindOfClass:[CMCFBBackGroundController class]]) {
                        
                        [arr removeObject:vc];
                        break;
                    }    }
                self.navigationController.viewControllers=arr;
                [self GOAuccoutOrHomeWithTap:0];
            }
            
        }
            break;
            
        case 1:
        {
            if (self.isFromHome) {
              
                 [self GOAuccoutOrHomeWithTap:3];

            }else{
                      [self.navigationController popToRootViewControllerAnimated:YES];
            }

        }
            break;
            
        default:
            break;
    }
    
}

#pragma mark  银行卡支付
-(void)userBankPayWithAmount:(NSString*)Amount andDwamount:(NSString*)DwAmount andBankID:(NSString*)BankID{
    
    [CMRequestHandle CaiFuBaoZhuangRuWithType:@"2" andAmount:Amount andDwAmount:DwAmount andBankID:BankID andSuccess:^(id responseObj) {
        
       // DLog(@"zhifu++++%@++%@",responseObj,[responseObj objectForKey:@"Result"]);
        
        if ([[responseObj objectForKey:@"Status"]intValue]==200) {
            NSDictionary *dict=[responseObj objectForKey:@"t"];
             DLog(@"zhifu++++%@++",dict);
            //商务类型
            NSString *BusPartner=[NSString stringWithFormat:@"%@",[dict objectForKey:@"busi_partner"]];
            //订单时间
            NSString *FormateCreateOrderTime=[dict objectForKey:@"dt_order"];
            //产品名称
            NSString *ProductName=[dict objectForKey:@"name_goods"];
            //订单号
            NSString *OrderNum=[NSString stringWithFormat:@"%@",[dict objectForKey:@"no_order"]];
            //订单信息
            NSString *OrderInfo=[dict objectForKey:@"info_order"];
            //订单有效时间
            NSString *OrderExpireSpan=[NSString stringWithFormat:@"%@",[dict objectForKey:@"valid_order"]];
            
            //用户真实姓名
            NSString *Acc_name=[dict objectForKey:@"acct_name"];
          //身份证号
            NSString *NameID=[dict objectForKey:@"id_no"];
            //银行卡号
            NSString *bankID=[NSString stringWithFormat:@"%@",[dict objectForKey:@"card_no"]];
            //手机号
            NSString *phone=[NSString stringWithFormat:@"%@",[dict objectForKey:@"phone"]];
            //用户注册时间
            NSString *registDate=[dict objectForKey:@"register"];
            //JInEr
            NSString *money_order=[NSString stringWithFormat:@"%@",[dict objectForKey:@"money_order"]];

            NSDictionary *orderDict=[CMOrderHandle creatRechargeOrderWithPartner:BusPartner andOrderTime:FormateCreateOrderTime andOrderNum:OrderNum andOrderMoney:money_order andOrderName:ProductName andOrderInfo:OrderInfo andOrderValid:OrderExpireSpan andUserRegistDate:registDate WithUserName:Acc_name WithUserPhone:phone andUserCardID:NameID andUserBankID:bankID];
            
            
            
            [CMOrderHandle CMorderManagerFromLLSdkWithOrderDict:orderDict PersentController:self];
            CMOrderHandle.resultBlock=^(LLPayResult resultCode,NSDictionary*resultDict){
                NSLog(@"resultCode==%u,dic==%@",resultCode,resultDict);
                NSLog(@"+++%@",[resultDict objectForKey:@"ret_msg"]);
                NSString *code=[resultDict objectForKey:@"ret_code"];
                NSString *msg=[resultDict objectForKey:@"result_pay"];
                
                if ([code intValue]==0000&&[msg isEqualToString:@"SUCCESS"]) {
                    
                    NSString *str=[NSString stringWithFormat:@"成功转入%@元",self.inputAmount];
                    CMCFBZhuangRuAlertView *DetailAlert=[[CMCFBZhuangRuAlertView alloc]initWithDeatilTitle:str WithCancleTitle:@"返回首页" WithDetaildown:@"查看我账户" withTag:10];
                    DetailAlert.delegate=self;
                    [DetailAlert ShowAlert];
                    
                    [NSString DoubleStringChangeColer:DetailAlert.detailLabel andFromStr:@"入" ToStr:@"元" withColor:RedButtonColor];
                    [CMNSNotice postNotificationName:@"BeginRefresh" object:nil];
                    
                }else{
                    
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:[resultDict objectForKey:@"ret_msg"] delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil ];
                    
                    [alert show];
                    
                }

                
            };
        }
        
        
        
        
        
    } andFailure:^(id error) {
     
        
        
        
        
    }];

}

#pragma mark  余额支付
-(void)userYuErPayWithAmount:(NSString*)Amount andDwamount:(NSString*)DwAmount andBankID:(NSString*)BankID{
    
    [CMRequestHandle CaiFuBaoZhuangRuWithType:@"1" andAmount:Amount andDwAmount:DwAmount andBankID:BankID andSuccess:^(id responseObj) {
        
        DLog(@"zhifu++++%@++%@",responseObj,[responseObj objectForKey:@"Result"]);
        
        if([[responseObj objectForKey:@"Status"]intValue]==200){
            NSString *str=[NSString stringWithFormat:@"成功转入%@元",self.inputAmount];
            CMCFBZhuangRuAlertView *DetailAlert=[[CMCFBZhuangRuAlertView alloc]initWithDeatilTitle:str WithCancleTitle:@"返回首页" WithDetaildown:@"查看我账户" withTag:10];
            DetailAlert.delegate=self;
            [DetailAlert ShowAlert];
            
            [NSString DoubleStringChangeColer:DetailAlert.detailLabel andFromStr:@"入" ToStr:@"元" withColor:RedButtonColor];
            [CMNSNotice postNotificationName:@"BeginRefresh" object:nil];
        }
        
        
        
    } andFailure:^(id error) {
        
        
        
        
        
    }];
    
}

#pragma mark 支持银行卡列表
-(void)BankDeatilAction{
    DLog(@"转入方法");
    
    CMBankList *list=[[CMBankList alloc]initCreateBankListArry:self.bankListArray];
    [list show];

    
}


#pragma mark 获取银行卡限额列表
-(void)getBankList{
    
    [CMRequestHandle requestSupportBankListMsgsuccess:^(id responseObj) {
       
        
        if ([[responseObj objectForKey:@"status"]intValue]==200) {
        NSArray *result=[responseObj objectForKey:@"result"];
        for (NSDictionary *dict in result) {
            NSArray  *listArray=[dict objectForKey:@"bankName"];
            self.bankListArray=listArray;
            [self.MyTableView reloadData];
        }
        }
        [self hiddenProgressHUD];
        self.MyTableView.hidden=NO;
    }];
    
}
-(void)getRenZhengBankList{
    
    [CMRequestHandle requestBankListMsgsuccess:^(id responseObj) {
        //DLog(@"认证%@",responseObj);
        if ([[responseObj objectForKey:@"status"]intValue]==200) {
            self.RenZhengbankArray=[responseObj objectForKey:@"result"];
    
            [self.MyTableView reloadData];
        }
//        else if ([[responseObj objectForKey:@"status"]intValue]==300){
//            
//            [self loginAuto];
//        }
//        
//        else if ([[responseObj objectForKey:@"result"] isEqualToString:@"账户失效，请重新登录！"]) {
//            [self loginAuto];
//        
//        }
    }andFailure:^(id error) {
        
    }];
    
}
#pragma mark 去认证
-(void)GoRenZhengAction{
    DLog(@"rezheng");

    CMUserTrueController *productVc = [[CMUserTrueController alloc] init];
    [self.navigationController pushViewController:productVc animated:YES];
    

}
/*
#pragma mark - 取出用户名密码自动登陆
- (void)loginAuto
{
    // 取出账号、密码
    
    NSString *name = [CMUserDefaults objectForKey:@"name"];
    NSString *password = [PassWordTool readPassWord];
    if (name&&password) {
        
       NSString *urlStr = [NSString stringWithFormat:@"%@/handler/AppInterface.ashx?action=login&mobile=%@&pwd=%@&type=%@&id=%@",OnLineCode,name,password,@"1",[JPUSHService registrationID]];
       //   NSString *urlStr = [NSString stringWithFormat:@"%@/handler/AppInterface.ashx?action=login&mobile=%@&pwd=%@",OnLineCode,name,password];
        [CMHttpTool getWithURL:urlStr params:nil success:^(id responseObj) {
            
            
            
            NSString *strStatus = [responseObj valueForKey:@"status"];
            NSString *userID = [[[responseObj valueForKey:@"userMess"] objectAtIndex:0] valueForKey:@"userID"];
            [CMUserDefaults objectForKey:@"userID"];
            [CMUserDefaults setObject:name forKey:@"userphone"];
            [CMUserDefaults synchronize];
            if ([strStatus isEqualToString:@"200"]) {
                [self.MyTableView reloadData];
                [CMRequestHandle GetAccountMsgWithHYID:userID andSuccess:^(id responseObj) {
                    NSString *statusStr = [responseObj valueForKey:@"status"];
                    
                    if ([statusStr isEqualToString:@"200"]) {
                        
                        
                        NSString *userStr = name;
                        NSString *jinriStr = [[[responseObj valueForKey:@"result"] valueForKey:@"today_ShouYi_Amount"] objectAtIndex:0]; // 今日收益
                        NSString *leijiStr = [[[responseObj valueForKey:@"result"] valueForKey:@"leiji_shouyi_Amount"] objectAtIndex:0]; // 累计收益
                        NSString *yueStr = [[[responseObj valueForKey:@"result"] valueForKey:@"ky_amount"] objectAtIndex:0]; // 账户余额
                        NSString *zongStr = [[[responseObj valueForKey:@"result"] valueForKey:@"total_Amount"] objectAtIndex:0]; // 总资产
                        NSString *diongjie=[[[responseObj valueForKey:@"result"] valueForKey:@"ky_amount_dj"] objectAtIndex:0];
                        NSDictionary *infoSign = @{@"userID":userID,
                                                   @"user":userStr,
                                                   @"jinrishouyi":jinriStr,
                                                   @"leijishouyi":leijiStr,
                                                   @"zhanghuyue":yueStr,
                                                   @"zongzichan":zongStr,
                                                   @"dongjie":diongjie
                                                   };
                        
                        [CMUserDefaults setObject:yueStr forKey:@"YuEr"];
                        [CMUserDefaults synchronize];
                        [CMNSNotice postNotificationName:@"MesToAccount" object:self userInfo:infoSign]; // 发送通知 —— 账户
        
                    }
                }];
                
            }
        } failure:^(NSError *error) {
            DLog(@"自动陆失败------%@",error);
            NSString *url=[NSString stringWithFormat:@"%@/handler/AppInterface.ashx?action=quit",OnLineCode];
            [PassWordTool deletePassWord];
            [CMHttpTool getWithURL:url params:nil success:^(id responseObj) {
                
            } failure:^(NSError *error) {
                DLog(@"exitLoginAcconntError--%@",error);
            }];
            
        }];
        
    }
}
*/
-(void)getCfbMessage{
     [CMRequestHandle CaiFuBaoMessageWithSuccess:^(id responseObj) {
         
      
         
         if([[responseObj objectForKey:@"Status"]intValue]==200){
             self.YuEr=[[responseObj objectForKey:@"t"]objectForKey:@"amount"];
             [CMUserDefaults setObject:self.YuEr forKey:@"YuEr"];
             [CMUserDefaults synchronize];
             self.CFbDataDict=[responseObj objectForKey:@"t"];
         }
         
         [self.MyTableView reloadData];
     } andFailure:^(id error) {
         

     }];
    
    
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [NSString validateNumber:string];
}

@end
