//
//  CMChangedetailController.m
//  CaiMao
//
//  Created by MAC on 16/10/24.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMChangedetailController.h"
#import "CMChageFootview.h"
#import "CMSmsCodeAlert.h"
@interface CMChangedetailController ()

{  CMSmsCodeAlert *smsAler;
}
@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,strong)NSArray *PlaceHoldArr;
@property(nonatomic,strong)NSArray *CellStrArr;
@property(nonatomic,copy)NSString  *cellStrOne;
@property(nonatomic,copy)NSString *cellStrSecond;
@property(nonatomic,copy)NSString *cellStrThree;
@property(nonatomic,copy)NSString *cellStrFour;
@property(nonatomic,copy)NSString *cellStrFive;

@end

@implementation CMChangedetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=ViewBackColor;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self creatUiData:self.type];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"我的账户" style:UIBarButtonItemStylePlain target:self action:@selector(goMyAuccount)];
    
 //[self exitAuccount];
}

-(void)goMyAuccount{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Tcell=@"indexPath";
  CMChangeDetailViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:Tcell];
    if (!cell) {
        
        cell=[[CMChangeDetailViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Tcell];
        cell.getCode.hidden=YES;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row==0) {
        _cellStrOne=cell.detailField.text;
    }else if (indexPath.row==1){
         _cellStrSecond=cell.detailField.text;
        
    }else if (indexPath.row==2){
         _cellStrThree=cell.detailField.text;
        
    }else if (indexPath.row==3){
         _cellStrFour=cell.detailField.text;
        
    }else{
         _cellStrFive=cell.detailField.text;
    }
    cell.DetailTitle.text=self.titleArr[indexPath.row];
    cell.detailField.placeholder=self.PlaceHoldArr[indexPath.row];
    cell.detailField.tag=indexPath.row;
    [CMNSNotice addObserver:self selector:@selector(noticeTextFiled:) name:UITextFieldTextDidChangeNotification object:cell.detailField];
    switch (self.type) {
        case ChangeViewControllerTypePhoneAuthentication:
        {
            if (indexPath.row==0) {
                cell.detailField.userInteractionEnabled=NO;
                cell.detailField.text=[ [CMUserDefaults objectForKey:@"name"] stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
                [cell.getCode removeFromSuperview];
            }
           else if (indexPath.row==2) {
               [self SmsCodeBtn:cell];
           
           } else if (indexPath.row==3){
             cell.detailField.secureTextEntry=YES;
               [cell.getCode removeFromSuperview];

           }
           else{
               
                 [cell.getCode removeFromSuperview];
            }
            
        }
            break;
        case ChangeViewControllerTypeEmailSetting:
        {
          
            if (indexPath.row==1) {
               [self SmsCodeBtn:cell];
            }else{
                 [cell.getCode removeFromSuperview];
            }
            
        }
            break;
  
        case ChangeViewControllerTypeEmailChange:
        {
            if (indexPath.row==0) {
                cell.detailField.userInteractionEnabled=NO;
                cell.detailField.text=self.email;
                 [cell.getCode removeFromSuperview];
            }
            else if (indexPath.row==2) {
                [self SmsCodeBtn:cell];
            }else if (indexPath.row==3) {
                cell.detailField.secureTextEntry=YES;
                [cell.getCode removeFromSuperview];
            }
            
            else{
                 [cell.getCode removeFromSuperview];
            }
            
        }
            break;
            
        case ChangeViewControllerTypeDealPasswordSetting:
        {
            
            if (indexPath.row==2) {
               [self SmsCodeBtn:cell];
            }else if (indexPath.row==3||indexPath.row==4){
                cell.detailField.secureTextEntry=YES;
                 [cell.getCode removeFromSuperview];
                
            }
            
            else{
                
                 [cell.getCode removeFromSuperview];
            }
            
        }
            break;
  
        case ChangeViewControllerTypeDealPasswordChange:
        {
            
            if (indexPath.row==0) {
                cell.detailField.userInteractionEnabled=NO;
                cell.detailField.text=[ [CMUserDefaults objectForKey:@"name"] stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
                [cell.getCode removeFromSuperview];
            }
            else if (indexPath.row==1) {
                [self SmsCodeBtn:cell];
                
            }
            else{
                cell.detailField.secureTextEntry=YES;
                [cell.getCode removeFromSuperview];
            }
            
        }
            break;
        case ChangeViewControllerTypeLoginwordChange:
        {
             if (indexPath.row==0) {
                 cell.detailField.userInteractionEnabled=NO;
                 cell.detailField.text=[ [CMUserDefaults objectForKey:@"name"] stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
                 [cell.getCode removeFromSuperview];
            }
            else if (indexPath.row==1) {
                [self SmsCodeBtn:cell];
            }else{
                cell.detailField.secureTextEntry=YES;
                 [cell.getCode removeFromSuperview];
            }
            
        }
            break;

        default:
            break;
    }
    
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 86/2.0;
}
-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor clearColor];
    
}
-(void)creatUiData:(ChangeViewControllerType)aTapy{
    CMChageFootview *footView=[[CMChageFootview alloc]initWithFrame:CGRectMake(0,0, CMScreenW, 100)];
    footView.SureBtn.tag=aTapy;
    [footView.SureBtn addTarget:self action:@selector(SureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView=footView;
    switch (aTapy) {
        case ChangeViewControllerTypePhoneAuthentication:
            self.title=@"手机认证";
            self.titleArr=@[@"原手机号",@"新手机号",@"手机验证码",@"交易密码"];
            self.PlaceHoldArr=@[@"",@"请输入新手机号",@"请输入手机验证码",@"请输入交易密码"];
            break;
        case ChangeViewControllerTypeEmailSetting:
            self.title=@"邮箱认证";
            self.titleArr=@[@"绑定邮箱",@"邮箱验证码"];
            self.PlaceHoldArr=@[@"请输入绑定邮箱",@"请输入邮箱验证码"];
             footView.topLabel.hidden=NO;
            break;
        case ChangeViewControllerTypeEmailChange:
            self.title=@"修改邮箱";
            self.titleArr=@[@"原邮箱",@"新邮箱",@"验证码",@"交易密码"];
            self.PlaceHoldArr=@[@"",@"请输入新邮箱",@"请输入邮箱验证码",@"请输入交易密码"];
            footView.topLabel.hidden=NO;

            break;
        case ChangeViewControllerTypeDealPasswordSetting:
            self.title=@"设置交易密码";
              self.titleArr=@[@"姓名",@"身份证号",@"验证码",@"交易密码",@"确认交易密码"];
            self.PlaceHoldArr=@[@"请输入您的真实姓名",@"请输入您的身份证号",@"请输入手机验证码",@"不少于6个字符,须以字母开头",@"请确认您的交易密码"];
            footView.bottomLabel.hidden=NO;
            break;
        case ChangeViewControllerTypeDealPasswordChange:
            self.title=@"重置交易密码";
            self.titleArr=@[@"手机号",@"手机验证码",@"新交易密码",@"确认交易密码"];
            self.PlaceHoldArr=@[@"请输入手机号",@"请输入手机验证码",@"不少于6个字符,须以字母开头",@"两次输入的密码相同"];
            footView.bottomLabel.hidden=NO;
            break;
        case ChangeViewControllerTypeLoginwordChange:
           self.title=@"重置登录密码";
    
            self.titleArr=@[@"手机号码",@"验证码",@"新密码",@"确认新密码"];
            self.PlaceHoldArr=@[@"",@"请输入手机验证码",@"不少于6个字符,须以字母开头",@"两次输入的密码相同",];
           

            break;
            
        default:
            break;
            
           
    }
    
}
#pragma mark 确定按钮
-(void)SureBtnClick:(UIButton*)btn{
    DLog(@"tag+++%d",btn.tag);
//    CMTiShi(@"验证成功,请重新登录");
//    [CMUserDefaults setObject:_cellStrSecond forKey:@"name"];
//    [CMUserDefaults synchronize];
//    NSMutableArray *arr=[NSMutableArray array];
//    CMPeoplePassword *p=[CMPeoplePassword new];
//    p.name=_cellStrSecond;
//    [arr addObject:p];
//    [NSKeyedArchiver archiveRootObject:arr toFile: [CMCache getFilePath:[NSString stringWithFormat:@"%@passWord.plist",[CMUserDefaults objectForKey:@"userID"]]]];
//    [self performSelector:@selector(exitAuccount) withObject:nil afterDelay:1.0];
    switch (btn.tag) {
        case 1:
        {
            if(_cellStrSecond.length<=0){
                CMTiShi(@"请输入需要认证的新手机号");
                
                return;
            }
            if(_cellStrThree.length<=0){
                CMTiShi(@"请输入手机验证码");
                return;
            }
            if(_cellStrFour.length<=0){
                CMTiShi(@"请输入交易密码");
                return;
            }
           
        [CMRequestHandle ThePhoneRenZhengWithUserID:[CMUserDefaults objectForKey:@"userID"] andMobile:_cellStrSecond andIdeaPassword:[NSString md5:_cellStrFour] andSmsCode:_cellStrThree andSuccess:^(id responseObj) {
              DLog(@"ThePhoneRenZheng++++%@++++%@",responseObj,[responseObj objectForKey:@"Result"]);
            if ([[responseObj objectForKey:@"Status"]intValue]==200) {
                CMTiShi(@"验证成功,请重新登录");
                [CMUserDefaults setObject:_cellStrSecond forKey:@"name"];
                [CMUserDefaults synchronize];
                NSMutableArray *arr=[NSMutableArray array];
                CMPeoplePassword *p=[CMPeoplePassword new];
                p.name=_cellStrSecond;
                [arr addObject:p];
                [NSKeyedArchiver archiveRootObject:arr toFile: [CMCache getFilePath:[NSString stringWithFormat:@"%@passWord.plist",[CMUserDefaults objectForKey:@"userID"]]]];
                [self performSelector:@selector(exitAuccount) withObject:nil afterDelay:1.0];
                
             }

            else if ([[responseObj objectForKey:@"Status"]intValue]==400) {
                CMTiShi([responseObj objectForKey:@"Result"]);
            }
        }];
        }
            break;
        case 2:
        {
            if(_cellStrOne.length<=0){
                CMTiShi(@"请输入需要绑定的邮箱号");
                return;
            }
            if ([CMRegularJudement checkUserEmail:_cellStrOne]==NO) {
                CMTiShi(@"邮箱格式错误");
                return;
            }
            if(_cellStrSecond.length<=0){
                CMTiShi(@"请输入邮箱验证码");
                return;
            }
            [CMRequestHandle setEmailWithUserID:[CMUserDefaults objectForKey:@"userID"] andEmailCode:_cellStrSecond andEmail:_cellStrOne andSuccess:^(id responseObj) {
                DLog(@"emailSet++++%@++++%@",responseObj,[responseObj objectForKey:@"Result"]);
                if ([[responseObj objectForKey:@"Status"]intValue]==200) {
                   // CMTiShi(@"绑定成功");
                     [CMNSNotice postNotificationName:@"setEmailSuccess" object:nil];
                    
                    smsAler=[[CMSmsCodeAlert alloc]initCMSmsCodeAlertWithTitle:@"绑定成功"];
                    [smsAler ShowAlert];
                    [self performSelector:@selector(alertDiss) withObject:nil afterDelay:1.0];
                }
                if ([[responseObj objectForKey:@"Status"]intValue]==400) {
                    CMTiShi([responseObj objectForKey:@"Result"]);
                }
            }];
    }
            break;
        case 3:
        {
            if(_cellStrSecond.length<=0){
                CMTiShi(@"请输入新的邮箱号");
                return;
            }
            if(_cellStrThree.length<=0){
                CMTiShi(@"请输入邮箱验证码");
                return;
            }
            if(_cellStrFour.length<=0){
                CMTiShi(@"请输入交易密码");
                return;
            }
            [CMRequestHandle changeEmailWithUserID:[CMUserDefaults objectForKey:@"userID"] andEmailCod:_cellStrThree andEmailName:_cellStrSecond andIdealPassword:[NSString md5:_cellStrFour] andSuccess:^(id responseObj) {
                 DLog(@"changeEmail++++%@++++%@",responseObj,[responseObj objectForKey:@"Result"]);
                if ([[responseObj objectForKey:@"Status"]intValue]==200) {
                   // CMTiShi(@"修改成功");
                    
                    [CMNSNotice postNotificationName:@"ChangeEmailSuccess" object:nil];
                    
                    smsAler=[[CMSmsCodeAlert alloc]initCMSmsCodeAlertWithTitle:@"修改成功"];
                    [smsAler ShowAlert];
                    [self performSelector:@selector(alertDiss) withObject:nil afterDelay:1.0];
                }
                if ([[responseObj objectForKey:@"Status"]intValue]==400) {
                    CMTiShi([responseObj objectForKey:@"Result"]);
                }
            }];
    }
    
            break;
        case 4:
        {
            if(_cellStrOne.length<=0){
                CMTiShi(@"请输入您的真实姓名");
                return;
            }
            if(_cellStrSecond.length<=0){
                CMTiShi(@"请输入您的身份证号");
                return;
            }
            if(_cellStrThree.length<=0){
                CMTiShi(@"请输入手机验证码");
                return;
            }
            if(_cellStrFour.length<=0){
                CMTiShi(@"请输入交易密码");
                return;
            }
            BOOL isA = [CMRegularJudement pipeizimu:[_cellStrFour substringToIndex:1]];
            if (!isA) {
                CMAlert(@"密码必须以字母开头");
                return;
            }
            
            if (_cellStrFour.length<6 ) {
                CMAlert(@"密码长度不能小于6位");
                return;
            }
            if(_cellStrFive.length<=0){
                CMTiShi(@"确认密码不能为空");
                return;
            }
            if(![_cellStrFive isEqualToString:_cellStrFour]){
                CMTiShi(@"两次输入交易密码不相同！");
                return;
            }
            [CMRequestHandle setIdealPasswordWithUserId:[CMUserDefaults objectForKey:@"userID"] andUserName:_cellStrOne andNameId:_cellStrSecond andSMSCode:_cellStrThree andIdealPassword:_cellStrFour andRepeatPassWord:_cellStrFive andSuccess:^(id responseObj) {
                if ([[responseObj objectForKey:@"Status"]intValue]==200) {
                   // CMTiShi(@"设置成功");
                   smsAler=[[CMSmsCodeAlert alloc]initCMSmsCodeAlertWithTitle:@"设置成功"];
                    [smsAler ShowAlert];
                    [CMNSNotice postNotificationName:@"setIdealPasswordSuccess" object:nil];
                    [self performSelector:@selector(alertDiss) withObject:nil afterDelay:1.0];
                }
                if ([[responseObj objectForKey:@"Status"]intValue]==400) {
                    CMTiShi([responseObj objectForKey:@"Result"]);
                }
                
            }];
    }
            break;
        case 5:
        {
            if(_cellStrSecond.length<=0){
                CMTiShi(@"手机验证码不能为空");
                return;
            }
         
            if (![CMRegularJudement pipeizimu:[_cellStrThree substringToIndex:1]]) {
                CMAlert(@"密码必须以字母开头");
                return;
            }
            
            if (_cellStrThree.length<6 ) {
                CMAlert(@"密码长度不能小于6位");
                return;
            }
            if(_cellStrFour.length<=0){
                CMTiShi(@"确认密码不能为空");
                return;
            }
            
            if(![_cellStrThree isEqualToString:_cellStrFour]){
                CMTiShi(@"两次输入交易密码不相同！");
                return;
            }
          [CMRequestHandle  resetIdealPasswordWithUserId:[CMUserDefaults objectForKey:@"userID"] andSMSCode:_cellStrSecond andNewPassWord:_cellStrThree andRepeatPassWord:_cellStrFour andSuccess:^(id responseObj) {
              
              
              if ([[responseObj objectForKey:@"Status"]intValue]==200) {
                  // CMTiShi(@"修改成功");
                  
                  smsAler=[[CMSmsCodeAlert alloc]initCMSmsCodeAlertWithTitle:@"重置成功"];
                  [smsAler ShowAlert];
                  [CMNSNotice postNotificationName:@"setIdealPasswordSuccess" object:nil];
                  [self performSelector:@selector(alertDiss) withObject:nil afterDelay:1.0];
              }
              if ([[responseObj objectForKey:@"Status"]intValue]==400) {
                  CMTiShi([responseObj objectForKey:@"Result"]);
              }
          }];
            
    }
            break;
            
        case 6:
        {
            if(_cellStrSecond.length<=0){
                CMTiShi(@"手机验证码不能为空");
                return;
            }
            if(_cellStrThree.length<=0){
                CMTiShi(@"请输入新密码");
                return;
            }
            
            BOOL isB = [CMRegularJudement pipeizimu:[_cellStrThree substringToIndex:1]];
            if (!isB) {
                CMAlert(@"密码必须以字母开头");
                return;
            }
            
            if (_cellStrThree.length<6 ) {
                CMAlert(@"密码长度不能小于6位");
                return;
            }
            if (_cellStrThree.length>18 ) {
                CMAlert(@"密码长度不能大于18位");
                return;
            }
            
            
            if(_cellStrFour.length<=0){
                CMTiShi(@"请输入确认密码");
                return;
            }
            
            if(![_cellStrThree isEqualToString:_cellStrFour]){
                CMTiShi(@"两次输入密码不相同！");
                return;
            }
            
           [CMRequestHandle resetLoginPassWordWithUserID:[CMUserDefaults objectForKey:@"userID"] andNewPassword:_cellStrThree andRepeatPassWord:_cellStrFour andSmsCode:_cellStrSecond andSuccess:^(id responseObj) {
                DLog(@"xiuGaiLoginPassWord++++%@++++%@",responseObj,[responseObj objectForKey:@"Result"]);
               if ([[responseObj objectForKey:@"Status"]intValue]==200) {
                   NSMutableArray *arr=[NSMutableArray array];
                   CMPeoplePassword *p=[CMPeoplePassword new];
                   
                   p.password=_cellStrFour;
                   [arr addObject:p];
                   [NSKeyedArchiver archiveRootObject:arr toFile: [CMCache getFilePath:[NSString stringWithFormat:@"%@passWord.plist",[CMUserDefaults objectForKey:@"userID"]]]];
                    CMTiShi(@"重置置成功,请重新登录");
                   [self performSelector:@selector(exitAuccount) withObject:nil afterDelay:1.0];
                
                   
               }
               if ([[responseObj objectForKey:@"Status"]intValue]==400) {
                   CMTiShi([responseObj objectForKey:@"Result"]);
               }
           }];
        }
            break;

            
        default:
            break;
    }
}
-(void)alertDiss{
    
    [smsAler DissAlert];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)exitAuccount{
    
    [PassWordTool deletePassWord];
    //退出登录进入首页
    UIWindow *window= [UIApplication sharedApplication].delegate.window;
    window.rootViewController=[[CMTabBarController alloc]init];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStyleDone target:self action:nil];
    
    [CMUserDefaults removeObjectForKey:gestureFinalSaveKey];
    
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppInterface.ashx?action=quit",OnLineCode];
    [CMHttpTool getWithURL:url params:nil success:^(id responseObj) {
        
    } failure:^(NSError *error) {
        DLog(@"exitLoginAcconntError--%@",error);
    }];
   [self.navigationController popToRootViewControllerAnimated:NO];
}



#pragma mark 获取TextFiled内容
-(void)noticeTextFiled:(NSNotification*)noti{
    UITextField *field=(UITextField*)noti.object;
     //NSLog(@"%d === %@", field.tag, field.text);
    if (field.tag==0) {
        _cellStrOne=field.text;
    }else if (field.tag==1){
        _cellStrSecond=field.text;
        
    }else if (field.tag==2){
        _cellStrThree=field.text;
        
    }else if (field.tag==3){
        _cellStrFour=field.text;
        
    }else{
        _cellStrFive=field.text;
    }
   
    
}
#pragma mark 获取验证码
-(void)getSmsCod{
    
        switch (self.type) {
            case ChangeViewControllerTypePhoneAuthentication:
            {
                [CMRequestHandle ThePhoneRenZhengGetSmsCodeWithUserID:[CMUserDefaults objectForKey:@"userID"] andMobile:_cellStrSecond andSuccess:^(id responseObj) {
                    DLog(@"ThePhoneRenZhengGetSmsCode++++%@++++%@",responseObj,[responseObj objectForKey:@"Result"]);
                    if ([[responseObj objectForKey:@"Status"]intValue]==200) {
                        CMTiShi(@"验证码已发送到您手机,3分钟之后失效");
                        [self smsTime];
                    }
                    
                    if ([[responseObj objectForKey:@"Status"]intValue]==400) {
                        CMTiShi([responseObj objectForKey:@"Result"]);
                    }
                }];
            }
                break;
            case ChangeViewControllerTypeEmailSetting:
            {
                [CMRequestHandle setEmailCodeWithUserID:[CMUserDefaults objectForKey:@"userID"] andEmail:_cellStrOne andSuccess:^(id responseObj) {
                    DLog(@"setEmailCode++++%@++++%@",responseObj,[responseObj objectForKey:@"Result"]);
                    
                    if ([[responseObj objectForKey:@"Status"]intValue]==200) {
                        CMTiShi(@"验证码已发送到您邮箱,3分钟之后失效");
                        [self smsTime];
                    }if ([[responseObj objectForKey:@"Status"]intValue]==400) {
                        CMTiShi([responseObj objectForKey:@"Result"]);
                    }
                }];
            }
                break;
                
            case ChangeViewControllerTypeEmailChange:
            {
                [CMRequestHandle changeEmailCodeWithUserID:[CMUserDefaults objectForKey:@"userID"] andEmail:_cellStrSecond andSuccess:^(id responseObj) {
                    if ([[responseObj objectForKey:@"Status"]intValue]==200) {
                        CMTiShi(@"验证码已发送到您邮箱,3分钟之后失效");
                        [self smsTime];
                    }if ([[responseObj objectForKey:@"Status"]intValue]==400) {
                        CMTiShi([responseObj objectForKey:@"Result"]);
                    }
                    DLog(@"changeEmailCode++++%@++++%@",responseObj,[responseObj objectForKey:@"Result"]);
                }];
            }
                break;
                
            case ChangeViewControllerTypeDealPasswordSetting:
            {
                [CMRequestHandle setIdealPasswordSmsCodeWithUserId:[CMUserDefaults objectForKey:@"userID"] andName:_cellStrOne andNameId:_cellStrSecond andSuccess:^(id responseObj) {
                    
                    if ([[responseObj objectForKey:@"Status"]intValue]==200) {
                        CMTiShi(@"验证码已发送到您手机,3分钟之后失效");
                        [self smsTime];
                    }if ([[responseObj objectForKey:@"Status"]intValue]==400) {
                        CMTiShi([responseObj objectForKey:@"Result"]);
                    }
                    DLog(@"setIdealPasswordSmsCode++++%@++++%@",responseObj,[responseObj objectForKey:@"Result"]);
                }];
            }
                break;
            case ChangeViewControllerTypeDealPasswordChange:
            {
                
              [CMRequestHandle resetIdealPasswordGetSmsCodeWithUserId:[CMUserDefaults objectForKey:@"userID"] andSuccess:^(id responseObj) {
                  if ([[responseObj objectForKey:@"Status"]intValue]==200) {
                      CMTiShi(@"验证码已发送到您手机,3分钟之后失效");
                      [self smsTime];
                  }if ([[responseObj objectForKey:@"Status"]intValue]==400) {
                      CMTiShi([responseObj objectForKey:@"Result"]);
                  }
                  DLog(@"resetIdealPasswordSmsCode++++%@++++%@",responseObj,[responseObj objectForKey:@"Result"]);
              }];
                
            }
                break;
            case ChangeViewControllerTypeLoginwordChange:
                
            {
                [CMRequestHandle resetLoginPassWordGetCodeWithUserID:[CMUserDefaults objectForKey:@"userID"] andSuccess:^(id responseObj) {
                    DLog(@"changeLoginPassWordCode++++%@++++%@",responseObj,[responseObj objectForKey:@"Result"]);
                    if ([[responseObj objectForKey:@"Status"]intValue]==200) {
                        CMTiShi(@"验证码已发送到您手机,3分钟之后失效");
                        [self smsTime];
                    }if ([[responseObj objectForKey:@"Status"]intValue]==400) {
                        CMTiShi([responseObj objectForKey:@"Result"]);
                    }
                    
                }];
            }
                break;
                
            default:
                break;
        }

        
    

    
}
-(void)dealloc{
   [CMNSNotice removeObserver:self];
}
-(void)SmsCodeBtn:(CMChangeDetailViewCell*)cell{
    cell.getCode.hidden=NO;
    self.codeButton=cell.getCode;
    [cell.getCode addTarget:self action:@selector(getSmsCod) forControlEvents:UIControlEventTouchUpInside];
    [cell.getCode  mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cell);
        make.right.equalTo(cell.mas_right).offset(-20);
        make.height.equalTo(@23);
        make.width.equalTo(@80);
    }];
    [cell.detailField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cell);
        make.height.equalTo(@23);
        make.width.equalTo(@200);
        make.right.equalTo(cell.getCode.mas_left).offset(-10);
    }];

    
}
-(void)smsTime{
    
    self.codeButton .userInteractionEnabled=NO;
    __block int timeout=180; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.codeButton  setBackgroundColor:RedButtonColor];
                [self.codeButton  setTitle:@"重发验证码" forState:UIControlStateNormal];
                self.codeButton .userInteractionEnabled=YES;
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.codeButton setTitle:[NSString stringWithFormat:@"%d秒",timeout] forState:UIControlStateNormal];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
    
    
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat sectionHeaderHeight = 10;
    
    // NSLog(@"%f,%f",scrollView.contentOffset.x,scrollView.contentOffset.y);
    if(scrollView == self.tableView){
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>= -64) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
    
}
checkNet;
@end
