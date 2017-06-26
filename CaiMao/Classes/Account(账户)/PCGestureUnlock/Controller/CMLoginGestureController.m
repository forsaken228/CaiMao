//
//  CMLoginGestureController.m
//  CaiMao
//
//  Created by MAC on 16/8/25.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMLoginGestureController.h"
#import "PCCircleView.h"
#import "PCCircleViewConst.h"
#import "PCLockLabel.h"
#import "PCCircleInfoView.h"
#import "PCCircle.h"
#import "CMGestureAgainLogin.h"

@interface CMLoginGestureController ()<CircleViewDelegate,CMGestureAgainLoginDelegate,CMLoginUsePassWordAlertDelegate>
{
    CMLoginUsePassWordAlert *LoginAlert;
    int count;
    CMGestureAgainLogin *CMGestureAlert;
}
/**
 *  提示Label
 */
@property (nonatomic, strong) PCLockLabel *msgLabel;

/**
 *  解锁界面
 */
@property (nonatomic, strong) PCCircleView *lockView;
@end

@implementation CMLoginGestureController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   [self.view setBackgroundColor:CircleViewBackgroundColor];  
    [self setupSameUI];
    
    if (self.isFromLogin) {
        self.title=@"手势登录";
        self.navigationItem.hidesBackButton=YES;
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"nav_back_btn" higlightedImage:nil target:self action:@selector(backBtnClick)];
      //  NSLog(@"______%@++++",self.navigationController.viewControllers);
       
    }
}
-(void)backBtnClick{
    
    [self.navigationController popToRootViewControllerAnimated:NO];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!self.isFromLogin) {
        [self.navigationController setNavigationBarHidden:YES animated:animated];
    }
  
    
    // 进来先清空存的第一个密码
    [PCCircleViewConst saveGesture:nil Key:gestureOneSaveKey];
}

- (void)setupSameUI
{
    
    // 解锁界面
    PCCircleView *lockView = [[PCCircleView alloc] init];
    lockView.delegate = self;
    self.lockView = lockView;
    [self.lockView setType:CircleViewTypeLogin];

    [self.view addSubview:lockView];
    [lockView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo([UIScreen mainScreen].bounds.size.width - CircleViewEdgeMargin *3);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width - CircleViewEdgeMargin * 2);
        make.centerY.equalTo(self.view.mas_centerY);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    // 头像
    UIImage *Image=[UIImage imageNamed:@"headIcon"];
    UIImageView  *imageView = [[UIImageView alloc] init];
    [imageView setImage:Image];
    [self.view addSubview:imageView];
    if(!self.isFromLogin){
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(Image.size.height);
        make.width.mas_equalTo(Image.size.width);
        make.top.equalTo(self.view.mas_top).offset(60);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    }else{
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(Image.size.height);
            make.width.mas_equalTo(Image.size.width);
            make.top.equalTo(self.view.mas_top).offset(20);
            make.centerX.equalTo(self.view.mas_centerX);
        }];
    }
    
    PCLockLabel *msgLabel = [[PCLockLabel alloc] init];
    // self.msgLabel = msgLabel;
    NSString *name=[CMUserDefaults objectForKey:@"name"];
    if (name.length>=6) {
        msgLabel.text=[name stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }
    
    msgLabel.font=[UIFont systemFontOfSize:18];
    msgLabel.textAlignment=NSTextAlignmentCenter;
    msgLabel.textColor=UIColorFromRGB(0x7c7c7c);
    [self.view addSubview:msgLabel];
    
    if(CMScreenH<=568){
        [msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(CMScreenW);
            make.top.equalTo(imageView.mas_bottom);
            make.centerX.equalTo(self.view.mas_centerX);
        }];
    }else{
        
        [msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(CMScreenW);
            make.top.equalTo(imageView.mas_bottom).offset(20);
            make.centerX.equalTo(self.view.mas_centerX);
        }];
    }
   
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftBtn setTitle:@"忘记手势密码?" forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.tag=buttonTagForget;
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(150);
        make.top.equalTo(self.lockView.mas_bottom).offset(50);
        make.left.equalTo(self.view.mas_left).offset(10);
    }];
    
    
//    UIView *linView=[[UIView alloc]init];
//    //linView.backgroundColor=UIColorFromRGB(0x888888);
//    linView.backgroundColor=CMColor(101, 153, 255);
//    [self.view addSubview:linView];
//    [linView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.top.equalTo(leftBtn);
//        make.width.equalTo(@1);
//        make.centerX.equalTo(self.view.mas_centerX);
//    }];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [rightBtn setTitle:@"账户重新登录" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.tag=buttonTagManager;
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
   // [rightBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    
    [self.view addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(150);
        make.bottom.equalTo(leftBtn.mas_bottom);
        make.right.equalTo(self.view.mas_right).offset(-10);
    }];
    

    
}

#pragma mark - button点击事件
- (void)didClickBtn:(UIButton *)sender
{
    
    NSLog(@"%ld", (long)sender.tag);
    switch (sender.tag) {
        case buttonTagManager:
        {
           // NSLog(@"点击账户登录");
            if(!self.isFromLogin){

                [self exitView];
                [self dismissViewControllerAnimated:YES completion:nil                ];
                
            }else{

                [self.navigationController popViewControllerAnimated:NO];
            }
      
        }
            break;
        case buttonTagForget:
            //NSLog(@"点击了忘记手势");
            if(!self.isFromLogin){
            LoginAlert=[[CMLoginUsePassWordAlert alloc ]initLoginUsePassWordAlert];
            LoginAlert.tag=1001;
             LoginAlert.mainTitle.text=@"账户登录";
            LoginAlert.delegate=self;
            [LoginAlert ShowLoginAlert];
            }
            else{
              
            
              [self.navigationController popViewControllerAnimated:NO];
                [CMNSNotice postNotificationName:@"isForgetGesture" object:nil];
            }
            break;
        default:
            break;
    }
}
#pragma mark账户登录
-(void)exitView:(NSString *)passWord{
    DLog(@"password==%@===%@",passWord,[CMUserDefaults objectForKey:@"password"]);
    if (LoginAlert.tag==1000) {
        
      //if(!self.isFromLogin){
               DLog(@"账户登录");
       NSString *password =[PassWordTool readPassWord];
        if ([password isEqualToString:LoginAlert.passWordField.text]) {
            [LoginAlert dimissLoginAlert];
            count=0;
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            LoginAlert.errorlabel.text=@"登录密码错误!";
            
        }
        if (LoginAlert.passWordField.text.length<=0) {
            LoginAlert.errorlabel.text=@"请输入登录密码!";
            
        }
        
  // }
  //else{
//            [CMUserDefaults removeObjectForKey:@"gestureFinalSaveKey"];
//            [self.navigationController popViewControllerAnimated:NO];
   
      
      //  }
    }else{
        DLog(@"忘记");
      //  if(!self.isFromLogin){
        NSString *password = [PassWordTool readPassWord];
        if ([password isEqualToString:LoginAlert.passWordField.text]) {
            [LoginAlert dimissLoginAlert];
            count=0;

            [self dismissViewControllerAnimated:YES completion:^{
                //[self exitView];
            }];

        }else{
            LoginAlert.errorlabel.text=@"登录密码错误!";
            
        }
        if (LoginAlert.passWordField.text.length<=0) {
            LoginAlert.errorlabel.text=@"请输入登录密码!";
            
        }
      //  }else{
            
        
//            [CMUserDefaults removeObjectForKey:@"gestureFinalSaveKey"];
//            [self.navigationController popViewControllerAnimated:NO];
//            GestureViewController *gestureVc = [[GestureViewController alloc] init];
//            gestureVc.isYanZheng=YES;
//            [gestureVc setType:GestureViewControllerTypeSetting];
//            [self.navigationController pushViewController:gestureVc animated:YES];
//            
//        }
        NSLog(@"点击了忘记手势弹框");
    }
    
    
}



#pragma mark - circleView - delegate - login or verify gesture
- (void)circleView:(PCCircleView *)view type:(CircleViewType)type didCompleteLoginGesture:(NSString *)gesture result:(BOOL)equal
{
    
    // 此时的type有两种情况 Login or verify
    if (type == CircleViewTypeLogin) {

        //static  int count;
        if (equal) {
            NSLog(@"登陆成功！");
            count=0;
            if (self.isFromLogin) {
                [self loginAccount];
            }else{
                
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            
        } else {
            NSLog(@"密码错误！");
            
            count++;
            NSString *string=[NSString stringWithFormat:@"绘制手势密码错误,还可以绘制%d次",5-count];
            [self.msgLabel showWarnMsgAndShake:string];
           
            if (count==5) {
                count=0;
                CMGestureAlert=[[CMGestureAgainLogin alloc]initWithRegist];
                CMGestureAlert.delegate=self;
                [CMGestureAlert ShowAlert];
                
                [self.msgLabel showNormalMsg:@"请输入手势密码"];
            }else{
                
                 CMAlert(string);
            }
            
        }
    }
}
#pragma mark 退出登录
-(void)exitView{
    if (!self.isFromLogin) {
       
   
    [CMUserDefaults removeObjectForKey:@"switNo"];
    //[PCCircleViewConst removeGesture:gestureOneSaveKey];
    [PCCircleViewConst removeGesture:gestureFinalSaveKey];// 点击确定
    // 移除密码
    [PassWordTool deletePassWord];
  
    [CMUserDefaults removeObjectForKey:@"YuEr"];
    [CMUserDefaults synchronize];
   
   
    //退出登录进入首页
    UIWindow *window= [UIApplication sharedApplication].keyWindow;
    window.rootViewController=[[CMTabBarController alloc]init];
    // 清除缓存
//
   [CMHttpTool getWithURL:[NSString stringWithFormat:@"%@/handler/AppInterface.ashx?action=quit",OnLineCode] params:nil success:^(id responseObj) {
       
   } failure:^(NSError *error) {
        DLog(@"exitLoginAcconntError--%@",error);
    }];
  }else{
//        
        [CMGestureAlert dimissAlert];
        [CMUserDefaults removeObjectForKey:@"gestureFinalSaveKey"];
        [self.navigationController popViewControllerAnimated:NO];
   }
    
}


-(void)loginAccount{
    
    
//    NSArray *arr=[NSArray arrayWithContentsOfFile:[CMCache getFilePath:[NSString stringWithFormat:@"%@passWord.plist", [CMUserDefaults objectForKey:@"name"]]]];
    NSArray *arr=[NSKeyedUnarchiver unarchiveObjectWithFile:[CMCache getFilePath:[NSString stringWithFormat:@"%@passWord.plist", [CMUserDefaults objectForKey:@"userID"]]]];
    
    CMPeoplePassword *p=arr.firstObject;
    NSString *name=p.name;
    NSString *password=p.password;
//DLog(@"arr++++%@+++%@++%@",name,password,p.GesturePass);
   // NSString *urlStr = [NSString stringWithFormat:@"%@/handler/AppInterface.ashx?action=login&mobile=%@&pwd=%@",OnLineCode,name,password];
    
   NSString *urlStr = [NSString stringWithFormat:@"%@/handler/AppInterface.ashx?action=login&mobile=%@&pwd=%@&type=%@&id=%@",OnLineCode,name,password,@"1",[JPUSHService registrationID]];
    [CMHttpTool getWithURL:urlStr params:nil success:^(id responseObj) {
        
        NSString *strStatus = [responseObj valueForKey:@"status"];
        NSString *mes = [responseObj valueForKey:@"result"];
        if ([strStatus isEqualToString:@"200"]) {
            
            NSString *userID = [[[responseObj valueForKey:@"userMess"] objectAtIndex:0] valueForKey:@"userID"];
            [CMUserDefaults setObject:userID forKey:@"userID"];
            // 登陆成功后 保存用户名和密码
            [CMUserDefaults setObject:name forKey:@"name"];
            [PassWordTool savePassWord:password];
            [CMUserDefaults synchronize];
            [CMCookie getAndSaveCookie];
            // 请求用户信息
            if (![self checkNetWork]) {
                return;
            }
            
            NSString *url = [NSString stringWithFormat:@"%@/handler/app_interface.ashx?action=IcmIndex&hyid=%@",OnLineCode,userID];
            [CMHttpTool getWithURL:url params:nil success:^(id responseObj) {
                DLog(@"--%@",responseObj);
                NSString *statusStr = [responseObj valueForKey:@"status"];
                
                if ([statusStr isEqualToString:@"200"]) {
                    
                    NSString *userStr =name;
                    NSString *jinriStr = [[[responseObj valueForKey:@"result"] valueForKey:@"today_ShouYi_Amount"] objectAtIndex:0]; // 今日收益
                    NSString *leijiStr = [[[responseObj valueForKey:@"result"] valueForKey:@"leiji_shouyi_Amount"] objectAtIndex:0]; // 累计收益
                    NSString *yueStr = [[[responseObj valueForKey:@"result"] valueForKey:@"ky_amount"] objectAtIndex:0]; // 账户余额
                    NSString *zongStr = [[[responseObj valueForKey:@"result"] valueForKey:@"total_Amount"] objectAtIndex:0]; // 总资产
                    NSString *cfb = [[[responseObj valueForKey:@"result"] valueForKey:@"cfb_xianzhi_Amount"] objectAtIndex:0];
                    NSDictionary *infoSign = @{@"userID":userID,
                                               @"user":userStr,
                                               @"jinrishouyi":jinriStr,
                                               @"leijishouyi":leijiStr,
                                               @"zhanghuyue":yueStr,
                                               @"zongzichan":zongStr,
                                               @"cfb_xianzhi_Amount":cfb
                                               };
                    [CMUserDefaults setObject:[NSDate date] forKey:@"expires_in"];
                    [CMUserDefaults setObject:yueStr forKey:@"YuEr"];
                    [CMUserDefaults synchronize];
                    [CMNSNotice postNotificationName:@"MesToAccount" object:self userInfo:infoSign];
                    [CMNSNotice postNotificationName:@"MesToHome" object:self userInfo:infoSign];// 发送通知 —— 账户
                   
                 
                 [self.navigationController popToRootViewControllerAnimated:YES];
                   
                }
            } failure:^(NSError *error) {
                
            }];
            
        }
        
        if ([strStatus isEqualToString:@"400"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"财猫网提示" message:mes delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    } failure:^(NSError *error) {
        DLog(@"LoginError------%@",error);
    }];
    
    

    
}
checkNet
@end
