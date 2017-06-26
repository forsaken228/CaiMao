//
//  CMLoginController.m
//  CaiMao
//
//  Created by Fengpj on 15/12/24.
//  Copyright © 2015年 58cm. All rights reserved.
//

#import "CMLoginController.h"
#import "CMLoginView.h"
@interface CMLoginController ()<UITextFieldDelegate>

@property(nonatomic,strong)CMLoginView *loginView;
@end

@implementation CMLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    self.view.backgroundColor=[UIColor whiteColor];

    [CMNSNotice addObserver:self selector:@selector(isForgetGesture) name:@"isForgetGesture" object:nil];
    //[self createLoginView];
    [self setupUI];
 

    if ([[NSFileManager defaultManager]fileExistsAtPath:[CMCache getFilePath:[NSString stringWithFormat:@"%@passWord.plist", [CMUserDefaults objectForKey:@"userID"]]]]) {
        
        if ([CMUserDefaults objectForKey:gestureFinalSaveKey]&&[PCCircleViewConst getGestureWithKey:gestureFinalSaveKey]!=nil) {
            
            CMLoginGestureController *gestureVc = [[CMLoginGestureController alloc] init];
            //[gestureVc setType:GestureViewControllerTypeLogin];
            gestureVc.isFromLogin=YES;
        
            [self.navigationController pushViewController:gestureVc animated:NO];
        }
        
    }
  

}
#pragma mark Lazy
-(CMLoginView*)loginView{
    if (!_loginView) {
        _loginView=[[CMLoginView alloc]initWithFrame:self.view.frame];
    }
    return _loginView;
}
-(void)isForgetGesture{
    
    self.title=@"验证密码";
    self.loginView.phoneTextField.userInteractionEnabled=NO;
    self.navigationItem.rightBarButtonItem=nil;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    [self cleanPwdText];
    
self.tabBarController.tabBar.hidden = YES;
   }



- (void)setupUI
{
    // 取出账号
    NSString *name = [CMUserDefaults objectForKey:@"name"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(goRegist)];
    [self.view addSubview:self.loginView];
    
    
    self.loginView.phoneTextField.text = name;
    self.loginView.pwdTextField.delegate=self;
    self.loginView.phoneTextField.delegate=self;
    
    [self.loginView.loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView.forgetPsw addTarget:self action:@selector(findPwd) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView.phoneClearBtn addTarget:self action:@selector(cleanPhoneText) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView.pwdClearBtn addTarget:self action:@selector(cleanPwdText) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView.phoneTextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventAllEvents];
    [self.loginView.pwdTextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventAllEvents];

}

- (void)goRegist
{
    CMRegistController *regiVc = [[CMRegistController alloc] init];
    [self.navigationController pushViewController:regiVc animated:YES];
}

- (void)cleanPhoneText
{
    self.loginView.phoneTextField.text = @"";
    self.loginView.phoneClearBtn.hidden = YES;
    
    [CMUserDefaults removeObjectForKey:@"switNo"];
    [PCCircleViewConst removeGesture:gestureOneSaveKey];
    [PCCircleViewConst removeGesture:gestureFinalSaveKey];// 点

} 
- (void)cleanPwdText
{
    self.loginView.pwdTextField.text = @"";
    self.loginView.pwdClearBtn.hidden = YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.loginView.phoneTextField) {
        self.loginView.phoneLeftIcon.image = [UIImage imageNamed:@"denglu_shouji_fill"];
        self.loginView.pwdLeftIcon.image = [UIImage imageNamed:@"denglu_mima"];
        self.loginView.pwdClearBtn.hidden = YES;
    }
    if (textField == self.loginView.pwdTextField) {
        self.loginView.pwdLeftIcon.image = [UIImage imageNamed:@"denglu_mima_fill"];
        self.loginView.phoneLeftIcon.image = [UIImage imageNamed:@"denglu_shouji"];
        self.loginView.phoneClearBtn.hidden = YES;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    /*
        if (textField == self.phoneTextField) {
            self.phoneLeftIcon.image = [UIImage imageNamed:@"denglu_shouji"];
            self.phoneClearBtn.hidden = YES;
        }
        if (textField == self.pwdTextField) {
            self.pwdLeftIcon.image = [UIImage imageNamed:@"denglu_mima"];
            self.pwdClearBtn.hidden = YES;
        }
  */
}

#pragma mark 监听用户输入
- (void)textFieldChange:(CMTextField *)textField
{
    if (textField == self.loginView.phoneTextField && [self.loginView.phoneTextField.text length] > 0) {
        self.loginView.phoneClearBtn.hidden = NO;
      

    }
    if (textField == self.loginView.pwdTextField && [self.loginView.pwdTextField.text length] > 0) {
        self.loginView.pwdClearBtn.hidden = NO;
        
    
    }
    
 
}

#pragma mark - 点击登录
- (void)loginBtnClick
{
    
    if(self.loginView.phoneTextField.text.length<=0){
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入手机号！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
        
    if(self.loginView.pwdTextField.text.length<=0){
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入密码！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    if ([CMRegularJudement checkTelNumber:self.loginView.phoneTextField.text] && ![self.loginView.pwdTextField.text isEqualToString:@""]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // 提示框
            MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
            [self.navigationController.view addSubview:hud];
            
            [hud showAnimated:YES whileExecutingBlock:^{
                sleep(1);
            } completionBlock:^{
                [hud removeFromSuperview];
                [self postLoginMess];
            }];
        });
        
    } else  {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"财猫网提示" message:@"手机号格式错误！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)postLoginMess
{
    
    
    if (![self checkNetWork]) {
        return;
    }
  
     NSString *urlStr = [NSString stringWithFormat:@"%@/handler/AppInterface.ashx?action=login&mobile=%@&pwd=%@&type=%@&id=%@",OnLineCode,self.loginView.phoneTextField.text,self.loginView.pwdTextField.text,@"1",[JPUSHService registrationID]];
 // DLog(@"+++%@",[JPUSHService registrationID]);
 //   NSString *urlStr = [NSString stringWithFormat:@"http://%@/handler/AppInterface.ashx?action=login&mobile=%@&pwd=%@",OnLineCode,self.phoneTextField.text,self.pwdTextField.text];
    [CMHttpTool getWithURL:urlStr params:nil success:^(id responseObj) {
       DLog(@"+++%@+++%@",responseObj,urlStr);
        NSString *strStatus = [responseObj valueForKey:@"status"];
        NSString *mes = [responseObj valueForKey:@"result"];
               if ([strStatus isEqualToString:@"200"]) {
                   [CMUserDefaults setObject:self.loginView.phoneTextField.text forKey:@"name"];

//                   
                 NSDictionary*dcit=@{@"responseObj":responseObj,@"passWord":self.loginView.pwdTextField.text,@"name":self.loginView.phoneTextField.text};
                  //  DLog(@"registrationID+++%@",[JPUSHService registrationID]);
                   GestureViewController *gestureVc = [[GestureViewController alloc] init];
                   gestureVc.type = GestureViewControllerTypeSetting;
                   gestureVc.isFirst=YES;
                   gestureVc.userDict=dcit;
                   gestureVc.FromRenZheng=self.FromRenZheng;
                   [self.navigationController pushViewController:gestureVc animated:YES];
                 
               }
        
        if ([strStatus isEqualToString:@"400"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"财猫网提示" message:mes delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    } failure:^(NSError *error) {
        DLog(@"LoginError------%@",error);
    }];
    
 
    
      
    
}

- (void)findPwd
{
    CMFindPwdController *findVc = [[CMFindPwdController alloc] init];
    [self.navigationController pushViewController:findVc animated:YES];
}

checkNet

@end
