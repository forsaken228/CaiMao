//
//  CMUserTrueController.m
//  CaiMao
//
//  Created by MAC on 16/6/15.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMUserTrueController.h"
#import "CMOrderCreat.h"

@interface CMUserTrueController ()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate,changeBankDelegate>
{
    CMUserMsgCell *userCell;
    ChangeBank *_bank;
    CMUserSureViewCell  *_tcell;
    
 
}
@property(nonatomic,retain)UITableView *SelfTableView;
@property(nonatomic,strong)NSArray *listArr;
@property(nonatomic,copy)NSString *errorMsg;
@property(nonatomic,strong)NSArray *NewArr;


@end

@implementation CMUserTrueController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"银行卡认证";
    self.view.backgroundColor=ViewBackColor;
    [self getBankList];
    
    [self.view addSubview:self.SelfTableView];

}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
   // if (self.isloginStatues==NO) {
        //[self.SelfTableView.mj_header beginRefreshing];
   // }
    
}
-(void)LoadHudWithMessage:(NSString*)Message{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = Message;
}
- (void)HidHubTacit {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

#pragma mark Lazy
-(UITableView*)SelfTableView{
    if (!_SelfTableView) {
      _SelfTableView=[[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
       _SelfTableView.delegate=self;
        _SelfTableView.dataSource=self;
        _SelfTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _SelfTableView.scrollEnabled=NO;
    }
    return _SelfTableView;
    
    
}
#pragma mark 创建单元格
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.userMessageArray.count<=0) {
        return 1;
    }
    return 2;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   if (self.userMessageArray.count>0) {
  
      if (indexPath.section%2==0)
    { //展示第一种单元格
        static NSString *cell1=@"cell1";
        _tcell=[tableView dequeueReusableCellWithIdentifier:cell1];
        if (!_tcell) {
            _tcell= [[CMUserSureViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell1];
            _tcell.selectionStyle=UITableViewCellSelectionStyleNone;
            [_tcell.changeBank addTarget:self action:@selector(changeBank) forControlEvents:UIControlEventTouchUpInside];
            _tcell.useNewBank.hidden=YES;
            //银行卡尾号
            //for (NSDictionary *dict in self.userMessageArray) {
                NSDictionary *dict=self.userMessageArray.firstObject;
                NSString *banknumber=[dict objectForKey:@"BankNumber"];
                
                 NSString *testBank;

                  testBank=[banknumber substringFromIndex:banknumber.length-4];
        
              _tcell.bankNum.text=[NSString stringWithFormat:@"尾号:%@",testBank];
                //  self.bankName.text=[dict objectForKey:@"UseBankName"];
                //银行卡标志
                [_tcell.BankBg sd_setImageWithURL:[dict objectForKey:@"BankIcon"]];
            // }
          
            
        }
        
        return _tcell;
    }
  
    else
    {  //展示第二种
      
   static NSString *cell2=@"cell2";
   userCell=[tableView dequeueReusableCellWithIdentifier:cell2];
    if (!userCell) {
        userCell= [[CMUserMsgCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell2];
        userCell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
        //持卡人说明
        [userCell.NameDetail addTarget:self action:@selector(BankOwnerDetail:) forControlEvents:UIControlEventTouchUpInside];
        userCell.NameDetail.tag=10;
        [userCell.bankDetail addTarget:self action:@selector(BankOwnerDetail:) forControlEvents:UIControlEventTouchUpInside];
            userCell.bankDetail.tag=11;
        userCell.errorLabel.hidden=YES;
        [userCell.joinMakeSure addTarget:self action:@selector(joinMakeSurePeople) forControlEvents:UIControlEventTouchUpInside];
        [userCell.supportBank addTarget:self action:@selector(supportBankCard) forControlEvents:UIControlEventTouchUpInside];
        
       

      userCell.realName.text=[self.userMsg objectForKey:@"name"];
        userCell.realName.userInteractionEnabled=YES;
        userCell.realNameId.text=[self.userMsg objectForKey:@"nameID"];
          userCell.realNameId.userInteractionEnabled=YES;
        userCell.realName.clearButtonMode=UITextFieldViewModeWhileEditing;
        userCell.realName.clearsOnBeginEditing=YES;
        
        userCell.tBankNum.text=[self.userMessageArray.firstObject objectForKey:@"BankNumber"];;
       
      //  userCell.bankNum.delegate=self;
        
    return userCell;
}
    }else{
        
        
    static NSString *cell3=@"cell3";
    userCell=[tableView dequeueReusableCellWithIdentifier:cell3];
        if (!userCell) {
            userCell= [[CMUserMsgCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell3];
            userCell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        //持卡人说明
        [userCell.NameDetail addTarget:self action:@selector(BankOwnerDetail:) forControlEvents:UIControlEventTouchUpInside];
        userCell.NameDetail.tag=10;
        [userCell.bankDetail addTarget:self action:@selector(BankOwnerDetail:) forControlEvents:UIControlEventTouchUpInside];
        userCell.bankDetail.tag=11;
        
        userCell.realName.text=[self.userMsg objectForKey:@"name"];
        userCell.realName.userInteractionEnabled=YES;
        userCell.realNameId.text=[self.userMsg objectForKey:@"nameID"];
        userCell.realNameId.userInteractionEnabled=YES;
        userCell.errorLabel.hidden=YES;
        
        [userCell.joinMakeSure addTarget:self action:@selector(joinMakeSurePeople) forControlEvents:UIControlEventTouchUpInside];
        [userCell.supportBank addTarget:self action:@selector(supportBankCard) forControlEvents:UIControlEventTouchUpInside];
        
        return userCell;
        
    }

}


#pragma mark 支持银行卡
-(void)supportBankCard{
    
    CMBankList *list=[[CMBankList alloc]init];
    [list show];
    
}
#pragma mark 立即认证
-(void)joinMakeSurePeople{
//    [CMNSNotice postNotificationName:@"renzhengSuccess" object:nil];
//    // [self.navigationController popViewControllerAnimated:YES];
//    CMRegistSuccessController *vc=[[CMRegistSuccessController alloc]init];
//    vc.type=isReZhengSuccess;
//    [self.navigationController pushViewController:vc animated:YES];
   

      if(userCell.realName.text.length<=0&&[userCell.realName.text isEqualToString:@""]){
        userCell.errorLabel.hidden=NO;
        
        userCell.errorLabel.text=@"*请输入真实姓名";
        return;
    }
    if(userCell.realNameId.text.length<=0&&[userCell.realNameId.text isEqualToString:@""]){
        userCell.errorLabel.hidden=NO;
        
        userCell.errorLabel.text=@"*请输入正确身份证号";
        return;
    }
    
    if (userCell.tBankNum.text.length<=0&&[userCell.tBankNum.text isEqualToString:@""]) {
        userCell.errorLabel.hidden=NO;
        
        userCell.errorLabel.text=@"*请输入银行卡号";
        return;
    }
  BOOL isRight= [CMRegularJudement  checkUserIdCard:userCell.realNameId.text];
    
    if (!isRight) {
        userCell.errorLabel.hidden=NO;
        
        userCell.errorLabel.text=@"*请输入正确格式身份证号";
        return;
    }

   // NSLog(@"---%@---%@--%@---%@",userCell.tBankNum.text,userCell.realName.text,userCell.realNameId.text,[CMUserDefaults objectForKey:@"userID"]);

  NSString *name=[userCell.realName.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

        //renzheng===该身份证号已经在财猫网通过实名认证，您不能再用该身份证进行认证！
       //9558800200135073266---李甜--610526199006054620---654144
  [[CMOrderCreat sharedAPI ]requestBankSureOrderMessageWithBankNum:userCell.tBankNum.text andHYID:[CMUserDefaults objectForKey:@"userID"] andUserName:name andUserID:userCell.realNameId.text success:^(id responseObj) {
     //   NSLog(@"renzheng===%@===%@",[responseObj objectForKey:@"Result"],responseObj);
      
      NSString*msg=[responseObj objectForKey:@"Result"];
      if (msg.length>0||![msg isEqualToString:@""]) {
          
          UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil ];
          [alert show];
          return ;
      }
      
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

    
      
      NSDictionary *orderDict= [CMOrderHandle creatRechargeOrderWithPartner:BusPartner andOrderTime:FormateCreateOrderTime andOrderNum:OrderNum andOrderMoney:@"1" andOrderName:ProductName andOrderInfo:OrderInfo andOrderValid:OrderExpireSpan andUserRegistDate:registDate WithUserName:userCell.realName.text WithUserPhone:[CMUserDefaults objectForKey:@"name"] andUserCardID:userCell.realNameId.text andUserBankID:userCell.tBankNum.text];
     // DLog(@"orderDict+++%@",orderDict);
      [CMOrderHandle CMorderManagerFromLLSdkWithOrderDict:orderDict PersentController:self];
      
      CMOrderHandle.resultBlock=^(LLPayResult resultCode,NSDictionary*resultDict){
      //    NSLog(@"resultCode==%u,dic==%@",resultCode,resultDict);
          
          self.errorMsg=[resultDict objectForKey:@"ret_code"];
          NSString *name=[resultDict objectForKey:@"ret_msg"];
          userCell.errorLabel.hidden=NO;
          
          userCell.errorLabel.text=name;
          NSString *code=[resultDict objectForKey:@"ret_code"];
          NSString *msg=[resultDict objectForKey:@"result_pay"];
          if([self.errorMsg isEqualToString:@"0101"]){
              userCell.errorLabel.hidden=NO;
              
              userCell.errorLabel.text=@"*请检查身份证号和姓名是否一致";
              
          }
          if ([name isEqualToString:@"请输入正确的银行卡号"]) {
              userCell.errorLabel.text=@"*请输入正确的银行卡号";
              userCell.errorLabel.hidden=NO;
          }
          
          
          if ([code intValue]==0000&&[msg isEqualToString:@"SUCCESS"]) {
              
              [CMNSNotice postNotificationName:@"renzhengSuccess" object:nil];
              // [self.navigationController popViewControllerAnimated:YES];
              CMRegistSuccessController *vc=[[CMRegistSuccessController alloc]init];
              vc.type=isReZhengSuccess;
              [self.navigationController pushViewController:vc animated:YES];
          }

      };
  }];

  
  
}



#pragma mark 更换银行卡
-(void)changeBank{

    NSDictionary *dict=[self.NewArr objectAtIndex:0];
    
         NSArray *bankArr=[dict objectForKey:@"AddBankData"];
          self.listArr=bankArr;
         NSMutableArray *bankArray=[[NSMutableArray alloc]initWithCapacity:0];
    
    
          for (NSDictionary *dic in bankArr) {
    
    
               NSString *testBank;
              NSString *num=[dic objectForKey:@"BankNumber"];
    
               testBank=[num substringFromIndex:num.length-4];
              NSString *bank=[NSString stringWithFormat:@"%@(尾号:%@)",[dic objectForKey:@"Bankname"],testBank];
    
    
              [bankArray addObject:bank];
    
          }
          _bank=[[ChangeBank alloc]initWithHistoryBankListWithBankList:bankArray];
          _bank.delegate=self;
          [_bank ShowAlert];

    
   
    
}
#pragma mark changeBankDelegate 代理协议方法
-(void)alertViewShowWithSection:(NSInteger)section andRow:(NSInteger)aRow{
  
  
 
    if (section==1&&aRow==0) {
 
        _tcell.lineView.hidden=YES;
        _tcell.BankBg.hidden=YES;
        _tcell.bankNum.hidden=YES;
        _tcell.useNewBank.hidden=NO;
        _tcell.useNewBank.text=@"使用新卡认证";
        _tcell.useNewBank.font=[UIFont systemFontOfSize:14];
        _tcell.useNewBank.textColor=CMColor(27, 133, 239);
        userCell.tBankNum.text=@"";
        //userCell.realName.text=@"";
        
        _tcell.lineView.hidden=YES;
       
        [_bank dimissAlert];
    }else if (section==0){
        
        //NSLog(@"_bankArray++%@",self.listArr);
        NSMutableArray *icoArr=[[NSMutableArray alloc]initWithCapacity:0];
        NSMutableArray *numArr=[[NSMutableArray alloc]initWithCapacity:0];
        
        for (NSDictionary *dict in self.listArr) {
            NSString *icon=[dict objectForKey:@"BankIcon"];
            [icoArr addObject:icon];
            
            NSString *num=[dict objectForKey:@"BankNumber"];
            [numArr addObject:num];
            
        }
        _tcell.BankBg.hidden=NO;
        _tcell.lineView.hidden=NO;
        _tcell.bankNum.hidden=NO;
         _tcell.useNewBank.hidden=YES;
        //userCell.realName.text=@"";
        [_tcell.BankBg sd_setImageWithURL:icoArr[aRow]];
         NSString *testBank;
        NSString *num=numArr[aRow];

          testBank=[num substringFromIndex:num.length-4];
        _tcell.bankNum.text= [NSString stringWithFormat:@"尾号:%@",testBank];
       
        userCell.tBankNum.text=numArr[aRow];
       
        [_bank dimissAlert];
    }
    

}
#pragma mark 持卡人说明
-(void)BankOwnerDetail:(UIButton*)btn{
 
    if (btn.tag==10) {
CMAlertView *alert=[[CMAlertView alloc]initWithCancleButtonTitle:@"知道了" WithTitle:@"持卡人说明" WithDetailUp:@"为了您的账号和资金安全，只能绑定持卡人本人的银行卡" WithDetaildown:@"获取更多帮助，可致电客服400-999-3972"];
       
       
        [alert ShowAlert];
        
    }
    else {
        CMAlertView *alert=[[CMAlertView alloc]initWithCancleButtonTitle:@"知道了" WithTitle:@"银行卡说明" WithDetailUp:@"请填写您本人姓名开户的储蓄卡" WithDetaildown:@"绑定成功后，该卡将作为您在财猫网的唯一资金进出卡，请谨慎填写"];
        [alert ShowAlert];
        
    }
    
    
}

//cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.userMessageArray.count>0) {
        if (indexPath.section%2==0) {
            return 70;
        }
        return 450;
    }
    return 450;
   
}
//区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.userMessageArray.count>0){
    if (section==0) {
        return 10;
    }
    return 0;
    }
    return 0;
}
//区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 40;
    }
        return 0;
   
}
//表头
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    static NSString *reuse=@"reuse";
    UITableViewHeaderFooterView  *view=[tableView dequeueReusableHeaderFooterViewWithIdentifier:reuse];
    if (!view) {
        view=[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:reuse];
        //view.contentView.backgroundColor=[UIColor grayColor];
       
    }else{
        for (UILabel *label in view.contentView.subviews) {
            [label removeFromSuperview];
        }
        
    }
    
    if (section==0) {
        UILabel *tLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 320, 40)];
        tLabel.text=@"选择您常用的银行卡进行认证";
        tLabel.font=[UIFont systemFontOfSize:14];
        tLabel.textColor=[UIColor lightGrayColor];
        [view.contentView addSubview:tLabel];
        
 
    }
    
    return  view;
    
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat sectionHeaderHeight =40;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y> 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }else
        if(scrollView.contentOffset.y >= sectionHeaderHeight){
            
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
}
#pragma mark 刷新页面
- (void)refreshWebView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    // 弹框
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:hud];
    
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(1);
       
    } completionBlock:^{

        userCell.realName.text=@"";
        userCell.realNameId.text=@"";
        [hud removeFromSuperview];
        
    }];

    }


-(void)getBankList{
    self.SelfTableView.hidden=YES;
    [self LoadHudWithMessage:@""];
    [CMRequestHandle requestBankListMsgsuccess:^(id responseObj) {
        //NSLog(@"++=%@===%@",responseObj,[responseObj objectForKey:@"result"]);
        if ([[responseObj objectForKey:@"status"]intValue]==200) {
            self.SelfTableView.hidden=NO;
            [self HidHubTacit];
            //[self.SelfTableView.mj_header endRefreshing];
            self.NewArr=(NSArray*)[responseObj objectForKey:@"result"];
         //   DLog(@"+++%@",self.NewArr);
            NSDictionary *dic=[self.NewArr firstObject];
            //DLog(@"renzheng===%@",self.NewBankArr);
            NSString *name=[dic objectForKey:@"name"];
            NSString *nameID=[dic objectForKey:@"cardid"];
            NSMutableDictionary *userDic=[[NSMutableDictionary alloc]initWithCapacity:0];
            [userDic setObject:name forKey:@"name"];
            [userDic setObject:nameID forKey:@"nameID"];
            self.userMessageArray=[dic objectForKey:@"AddBankData"];
            self.userMsg=userDic;
            [self.SelfTableView reloadData];
            
        }
//        else if ([[responseObj objectForKey:@"status"]intValue]==300) {
//            
//            self.isloginStatues=NO;
//        }
//        else if([[responseObj objectForKey:@"result"]isEqualToString:@"账户失效，请重新登录！"]){
//            
//            self.isloginStatues=NO;
//                 }
//        else{
//            CMAlert([responseObj objectForKey:@"result"]);
//        }
        
    } andFailure:^(id error) {
      
[self HidHubTacit];
        
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
    //     NSString *urlStr = [NSString stringWithFormat:@"%@/handler/AppInterface.ashx?action=login&mobile=%@&pwd=%@",OnLineCode,name,password];
        [CMHttpTool getWithURL:urlStr params:nil success:^(id responseObj) {
            //  DLog(@"登录---%@",responseObj);
            
            
            [self.SelfTableView.mj_header endRefreshing];
            NSString *strStatus = [responseObj valueForKey:@"status"];
            
            //NSString *userID = [[[responseObj valueForKey:@"userMess"] objectAtIndex:0] valueForKey:@"userID"];
            
            if ([strStatus isEqualToString:@"200"]) {
               
            }
            
        } failure:^(NSError *error) {
            DLog(@"自动陆失败------%@",error);
            NSString *url=[NSString stringWithFormat:@"%@/handler/AppInterface.ashx?action=quit",OnLineCode];
            [PassWordTool deletePassWord];
            [CMHttpTool getWithURL:url params:nil success:^(id responseObj) {
                
                
            } failure:^(NSError *error) {
                [self.SelfTableView.mj_header endRefreshing];
                DLog(@"exitLoginAcconntError--%@",error);
            }];
            
        }];
        
        
        
        
    }
}
*/
@end
