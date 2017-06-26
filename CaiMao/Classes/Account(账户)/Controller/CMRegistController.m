//
//  CMRegistController.m
//  CaiMao
//
//  Created by Fengpj on 16/1/14.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMRegistController.h"


@interface CMRegistController ()<UITextFieldDelegate>

@property (strong, nonatomic)  UIImageView *phoneLeftView;
@property (strong, nonatomic)  UIImageView *codeLeftView;
@property (strong, nonatomic)  UIImageView *pwdLeftView;
@property (strong, nonatomic)  UIImageView *quePwdLeftView;
@property (strong, nonatomic)  CMTextField *phoneTextField;
@property (strong, nonatomic)  CMTextField *codeTextField;
@property (strong, nonatomic)  CMTextField *pwdTextField;
@property (strong, nonatomic)  CMTextField *quePwdTextField;
@property (strong, nonatomic)  UIButton *phoneCleanBtn;
@property (strong, nonatomic)  UIButton *codeCleanBtn;
@property (strong, nonatomic)  UIButton *pwdCleanBtn;
@property (strong, nonatomic)  UIButton *quePwdCleanBtn;
@property (strong, nonatomic)  UIButton *getCodeBtn;
@property (strong, nonatomic)  UIButton *registBtn;


@end

@implementation CMRegistController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册账号";
    [self createFindUiView];
    [self setupUI];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    
    
    self.tabBarController.tabBar.hidden = YES;
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear: animated];
    self.tabBarController.tabBar.hidden = NO;
    
}

- (void)setupUI
{
    
    [self.phoneTextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventAllEvents];
    [self.codeTextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventAllEvents];
    [self.pwdTextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventAllEvents];
    [self.quePwdTextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventAllEvents];
    
}

- (void)getCodeBtnClick
{
    if (![self checkNetWork]) {
        return;
    }
    
    if(self.phoneTextField.text.length<=0){
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入手机号！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    NSString *urlAuthStr = [NSString stringWithFormat:@"%@/handler/AppInterface.ashx?action=SendVerCode&mobile=%@",OnLineCode,self.phoneTextField.text];
    
    [CMHttpTool getWithURL:urlAuthStr params:nil success:^(id responseObj) {
        
        DLog(@"getCodeBtnClick---%@",responseObj);
        
        NSString *statusStr = [responseObj valueForKey:@"status"];
        NSString *resultStr = [responseObj valueForKey:@"result"];
        
        if ([statusStr isEqualToString:@"400"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"财猫网提示" message:resultStr delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        } else if ([statusStr isEqualToString:@"200"]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"财猫网提示" message:resultStr delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    } failure:^(NSError *error) {
//        DLog(@"getCodeshibai------");
    }];
}

- (void)registBtnClick
{
//    CMRegistSuccessController *vc=[[CMRegistSuccessController alloc]init];
//    vc.type=isZhuCeSuccess;
//    [self.navigationController pushViewController:vc animated:YES];
//   
    BOOL isA = [CMRegularJudement pipeizimu:[self.pwdTextField.text substringToIndex:1]];
    if (!isA) {
        CMAlert(@"密码必须以字母开头");
        return;
    }
    
    if (self.pwdTextField.text.length<6 ) {
        CMAlert(@"密码长度不能小于6位");
        return;
    }
    if (self.pwdTextField.text.length>18 ) {
        CMAlert(@"密码长度不能大于18位");
        return;
    }
    

    if (![self.pwdTextField.text isEqualToString:self.quePwdTextField.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"财猫网提示" message:@"两次密码不一致！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
        NSString *regUrlStr = [NSString stringWithFormat:@"%@/handler/AppInterface.ashx?action=register&mobile=%@&vercode=%@&pwd=%@",OnLineCode,self.phoneTextField.text,self.codeTextField.text, self.pwdTextField.text];
        
        if (![self checkNetWork]) {
            return;
        }
    
        [CMHttpTool getWithURL:regUrlStr params:nil success:^(id responseObj)
         {
             NSString *statusStr = [responseObj valueForKey:@"status"];
             NSString *resultStr = [responseObj valueForKey:@"result"];
             
             if ([statusStr isEqualToString:@"200"]) {
//                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"财猫网提示" message:@"注册成功，去账户登陆吧！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                 [alert show];
                 NSString *idfaStr = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
                 NSString *urlStr = [NSString stringWithFormat:@"http://www.58cm.com/domob/action.aspx?mac=02:00:00:00:00:00&idfa=%@",idfaStr];
                 
                 [CMHttpTool getWithURL:urlStr params:nil success:^(id responseObj) {
                 } failure:^(NSError *error) {
                 }];
                 

                 CMRegistSuccessController *vc=[[CMRegistSuccessController alloc]init];
                 vc.type=isZhuCeSuccess;
                 [self.navigationController pushViewController:vc animated:YES];
             }
             if ([statusStr isEqualToString:@"400"]) {
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"财猫网提示" message:resultStr delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                 [alert show];
             }
             
         } failure:^(NSError *error) {
//             DLog(@"ZhuShibai------");
         }];
   
   
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
        // 传递idfa
        NSString *idfaStr = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        NSString *urlStr = [NSString stringWithFormat:@"http://www.58cm.com/domob/action.aspx?mac=02:00:00:00:00:00&idfa=%@",idfaStr];
        
        [CMHttpTool getWithURL:urlStr params:nil success:^(id responseObj) {
        } failure:^(NSError *error) {
        }];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.phoneTextField) {
        self.phoneLeftView.image = [UIImage imageNamed:@"zhuce_shouji_red"];
         self.phoneCleanBtn.hidden = NO;
    }
    if (textField == self.codeTextField) {
        self.codeLeftView.image = [UIImage imageNamed:@"zhuce_yanzheng_red"];
        self.codeCleanBtn.hidden = NO;
        
    }
    if (textField == self.pwdTextField) {
        self.pwdLeftView.image = [UIImage imageNamed:@"denglu_mima_fill"];
        self.pwdCleanBtn.hidden = NO;
    }
    if (textField == self.quePwdTextField) {
        self.quePwdLeftView.image = [UIImage imageNamed:@"denglu_mima_fill"];
        self.quePwdCleanBtn.hidden = NO;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.phoneTextField) {
        self.phoneLeftView.image = [UIImage imageNamed:@"zhuce_shouji_hui"];
        self.phoneCleanBtn.hidden = YES;
    }
    if (textField == self.codeTextField) {
        self.codeLeftView.image = [UIImage imageNamed:@"zhuce_yanzheng_hui"];
        self.codeCleanBtn.hidden = YES;
    }
    if (textField == self.pwdTextField) {
        self.pwdLeftView.image = [UIImage imageNamed:@"denglu_mima"];
        self.pwdCleanBtn.hidden = YES;
    }
    if (textField == self.quePwdTextField) {
        self.quePwdLeftView.image = [UIImage imageNamed:@"denglu_mima"];
        self.quePwdCleanBtn.hidden = YES;
    }
}

#pragma mark 监听用户输入
- (void)textFieldChange:(CMTextField *)textField
{
    if ((textField == self.phoneTextField && [_phoneTextField.text length] > 0)) {
        self.phoneCleanBtn.hidden = NO;
        self.getCodeBtn.userInteractionEnabled = YES;
        self.getCodeBtn.alpha = 1.0;
        [self.getCodeBtn setBackgroundColor:RedButtonColor];
    }
    if (textField == self.codeTextField && [self.codeTextField.text length] > 0) {
        self.codeCleanBtn.hidden = NO;
    }
    if (textField == self.pwdTextField && [_pwdTextField.text length] > 0) {
        self.pwdCleanBtn.hidden = NO;
    }
    if (textField == self.quePwdTextField && [self.quePwdTextField.text length] > 0) {
        self.quePwdCleanBtn.hidden = NO;
    }
    if (([_phoneTextField.text length] > 0 && [_pwdTextField.text length] > 0) && ([_codeTextField.text length] > 0 && [_quePwdTextField.text length] > 0)) {
        self.registBtn.userInteractionEnabled = YES;
        //self.registBtn.alpha = 1.0;
        [self.registBtn setBackgroundColor:RedButtonColor];

    } else {
        self.registBtn.userInteractionEnabled = NO;
        //self.registBtn.alpha = 0.5;
        [self.registBtn setBackgroundColor:[UIColor lightGrayColor]];
        
       

    }
}

- (void)cleanTextField:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 101:
            self.phoneTextField.text = @"";
            self.phoneCleanBtn.hidden = YES;
            self.getCodeBtn.userInteractionEnabled = NO;
            //self.registBtn.alpha = 0.5;
            [self.getCodeBtn setBackgroundColor:[UIColor lightGrayColor]];
            break;
        case 102:
            self.codeTextField.text = @"";
            self.codeCleanBtn.hidden = YES;
            break;
        case 103:
            self.pwdTextField.text = @"";
            self.pwdCleanBtn.hidden = YES;
            break;
        case 104:
            self.quePwdTextField.text = @"";
            self.quePwdCleanBtn.hidden = YES;
            break;
        default:
            break;
    }
}
-(void)createFindUiView{
    self.view.backgroundColor=[UIColor whiteColor];
    #pragma mark 请输入手机号
  
    
    CMTextField  *phone=[[CMTextField alloc]init];//WithFrame:CGRectMake(45, 74, 196, 40)
    phone.placeholder=@"请输入手机号";
    phone.keyboardType=UIKeyboardTypeNumberPad;
    self.phoneTextField=phone;
    phone.delegate=self;
    [self.view addSubview:phone];
    [phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(37);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(280);
        make.top.equalTo(self.view.mas_top).offset(10);
        
    }];
    UIView *line=[[UIView alloc]init];
    //line.frame=CGRectMake(10, 115, 300, 1);
    line.backgroundColor=separateLineColor;
    [self.view addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phone.mas_bottom);
        make.height.mas_equalTo(0.5);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        //make.centerX.equalTo(self.view.mas_centerX);
        
    }];
    UIImageView *icon=[[UIImageView alloc]init];
    //icon.frame=CGRectMake(15, 81, 27, 27);
    icon.image=[UIImage imageNamed:@"zhuce_shouji_hui.png"];
    self.phoneLeftView=icon;
    [self.view addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line.mas_left);
        make.height.width.mas_equalTo(27);
        make.centerY.equalTo(phone);
        
    }];
    UIButton *phoneClean=[UIButton buttonWithType:UIButtonTypeSystem];
    phoneClean.frame=CGRectMake(271, 86, 17, 17);
    self.phoneCleanBtn=phoneClean;
    phoneClean.hidden=YES;
    phoneClean.tag=101;
    [phoneClean setBackgroundImage:[UIImage imageNamed:@"denglu_guanbi.png"] forState:UIControlStateNormal];
    [phoneClean addTarget:self action:@selector(cleanTextField:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:phoneClean];
    [phoneClean mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(line.mas_right).offset(-10);
        make.height.width.mas_equalTo(17);
        
        make.bottom.equalTo(line.mas_top).offset(-10);
        
    }];
    
    
  #pragma mark 请输入验证码
    
    UIImageView *icon1=[[UIImageView alloc]init];
    icon1.frame=CGRectMake(15, 129, 27, 27);
    icon1.image=[UIImage imageNamed:@"zhuce_yanzheng_hui.png"];
    self.codeLeftView=icon1;
    [self.view addSubview:icon1];
    [icon1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.width.equalTo(icon);
        make.top.equalTo(line.mas_bottom).offset(15);
        
    }];
    
    CMTextField  *code=[[CMTextField alloc]init];//WithFrame:CGRectMake(45, 122, 105, 40)
    code.placeholder=@"请输入验证码";
    code.keyboardType=UIKeyboardTypeNumberPad;
    self.codeTextField=code;
    code.delegate=self;
    [self.view addSubview:code];
    [code mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.equalTo(phone);
        make.width.mas_equalTo(105);
        make.top.equalTo(line.mas_bottom).offset(10);
        
    }];
    
    UIButton *smgCod=[UIButton buttonWithType:UIButtonTypeSystem];
   // smgCod.frame=CGRectMake(176, 134, 17, 17);
    self.codeCleanBtn=smgCod;
    smgCod.hidden=YES;
    smgCod.tag=102;
    [smgCod setBackgroundImage:[UIImage imageNamed:@"denglu_guanbi.png"] forState:UIControlStateNormal];
    [smgCod addTarget:self action:@selector(cleanTextField:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:smgCod];
    
    [smgCod mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(phoneClean);
        make.left.equalTo(code.mas_right).offset(5);
        make.top.equalTo(line.mas_bottom).offset(20);
        
    }];
    UIView *line2=[[UIView alloc]init];
   
    //line2.frame=CGRectMake(10, 163, 300, 1);
    line2.backgroundColor=separateLineColor;
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(line);
        make.top.equalTo(code.mas_bottom).offset(5);
        
    }];
    
    
    UIButton *getCode=[UIButton buttonWithType:UIButtonTypeSystem];
    //getCode.frame=CGRectMake(218, 124, 87, 34);
    getCode.layer.cornerRadius=5.0;
    getCode.clipsToBounds=YES;
    //getCode.enabled=NO;
    self.getCodeBtn=getCode;
    [getCode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [getCode setBackgroundColor:[UIColor lightGrayColor]];
    getCode.titleLabel.font=[UIFont systemFontOfSize:14.0];
    [getCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getCode addTarget:self action:@selector(getCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    getCode.userInteractionEnabled=NO;
    [self.view addSubview:getCode];

    [getCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(line2);
        make.height.mas_equalTo(34);
        make.width.mas_equalTo(87);
        make.centerY.equalTo(code);
        
    }];
#pragma mark 请输入新密码

    UIImageView *icon2=[[UIImageView alloc]init];
    icon2.frame=CGRectMake(15, 178, 27, 27);
    icon2.image=[UIImage imageNamed:@"denglu_mima.png"];
    self.pwdLeftView=icon2;
    [self.view addSubview:icon2];
    
    [icon2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.width.equalTo(icon1);
        make.top.equalTo(line2.mas_bottom).offset(10);
        
    }];
    
    CMTextField  *psw=[[CMTextField alloc]init];//WithFrame:CGRectMake(45, 171, 196, 40)
    psw.placeholder=@"请输入新密码";
    psw.secureTextEntry=YES;
    self.pwdTextField=psw;
    psw.delegate=self;
    [self.view addSubview:psw];
    
    [psw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.equalTo(code);
        make.width.mas_equalTo(196);
        make.top.equalTo(line2.mas_bottom).offset(5);
        
    }];
    
    
    UIView *line3=[[UIView alloc]init];
 //   line3.frame=CGRectMake(10, 212, 300, 1);
    line3.backgroundColor=separateLineColor;
    [self.view addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(line2);
        make.top.equalTo(psw.mas_bottom).offset(5);
        
    }];
    
    UIButton *pwdClean=[UIButton buttonWithType:UIButtonTypeSystem];
   // pwdClean.frame=CGRectMake(271, 182, 17, 17);
    self.pwdCleanBtn=pwdClean;
    pwdClean.hidden=YES;
    pwdClean.tag=103;
    [pwdClean setBackgroundImage:[UIImage imageNamed:@"denglu_guanbi.png"] forState:UIControlStateNormal];
    [pwdClean addTarget:self action:@selector(cleanTextField:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pwdClean];
    
    [pwdClean mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.width.height.equalTo(phoneClean);
        
        
        make.bottom.equalTo(line3.mas_top).offset(-15);
        
    }];
    
#pragma mark 请确认密码
    
    UIImageView *icon3=[[UIImageView alloc]init];
    //icon3.frame=CGRectMake(15, 226, 27, 27);
    icon3.image=[UIImage imageNamed:@"denglu_mima.png"];
    self.quePwdLeftView=icon3;
    [self.view addSubview:icon3];
    
    [icon3 mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.height.left.width.equalTo(icon2);
        make.top.equalTo(line3.mas_bottom).offset(10);
        
    }];
    
    
    UIView *line4=[[UIView alloc]init];
    //line4.frame=CGRectMake(10, 260, 300, 1);
    line4.backgroundColor=separateLineColor;
    [self.view addSubview:line4];
    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.left.width.equalTo(line3);
        make.top.equalTo(icon3.mas_bottom).offset(10);
        
    }];
  
    
    
    CMTextField  *que=[[CMTextField alloc]init];//WithFrame:CGRectMake(45, 219, 196, 40)
    que.placeholder=@"请确认新密码";
    que.secureTextEntry=YES;
    self.quePwdTextField=que;
    que.delegate=self;
    [self.view addSubview:que];
    [que mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.width.equalTo(psw);
        
        make.top.equalTo(line3.mas_bottom).offset(5);
        
    }];
    
    UIButton *qPwdClean=[UIButton buttonWithType:UIButtonTypeSystem];
   // qPwdClean.frame=CGRectMake(271, 231, 17, 17);
    self.quePwdCleanBtn=qPwdClean;
    qPwdClean.tag=104;
    qPwdClean.hidden=YES;
    [qPwdClean setBackgroundImage:[UIImage imageNamed:@"denglu_guanbi.png"] forState:UIControlStateNormal];
    [qPwdClean addTarget:self action:@selector(cleanTextField:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:qPwdClean];
    
    [qPwdClean mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.width.height.equalTo(pwdClean);
        
        
        make.bottom.equalTo(line4.mas_top).offset(-15);
        
    }];
    
    
    
    UIButton *CommtionBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    //CommtionBtn.frame=CGRectMake(15, 293, 290, 44);
    CommtionBtn.layer.cornerRadius=5.0;
    CommtionBtn.clipsToBounds=YES;
    CommtionBtn.userInteractionEnabled=NO;
    self.registBtn=CommtionBtn;
    [CommtionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [CommtionBtn setBackgroundColor:[UIColor lightGrayColor]];
    CommtionBtn.titleLabel.font=[UIFont systemFontOfSize:19.0];
    [CommtionBtn setTitle:@"注册" forState:UIControlStateNormal];
    [CommtionBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CommtionBtn];
    [CommtionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line4.mas_bottom).offset(15);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(40);
        make.left.equalTo(line.mas_left).offset(10);
        make.right.equalTo(line.mas_right).offset(-10);
    }];
    
//    UILabel *RTitle=[[UILabel alloc]init];
//    RTitle.text=@"已有账户,去";
//    RTitle.textAlignment=NSTextAlignmentRight;
//    RTitle.font=
//    UIButton *GoLogin=[UIButton buttonWithType:UIButtonTypeSystem];
//    //CommtionBtn.frame=CGRectMake(15, 293, 290, 44);
//   
//    [GoLogin setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//   // [CommtionBtn setBackgroundColor:[UIColor lightGrayColor]];
//    //GoLogin.titleLabel.font=[UIFont systemFontOfSize:16.0];
//    [GoLogin setTitle:@"登录>" forState:UIControlStateNormal];
//    [GoLogin addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:GoLogin];
//    [GoLogin mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(CommtionBtn.mas_bottom).offset(10);
//        make.right.equalTo(self.view.mas_right).offset(-10);
//        make.height.mas_equalTo(20);
//        make.width.mas_equalTo(50);
//    }];
    
    
}
-(void)loginBtnClick{
    
    CMLoginController *vc=[[CMLoginController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
    
}

checkNet
@end
