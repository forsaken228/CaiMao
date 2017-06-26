
#import "GestureViewController.h"
#import "PCCircleView.h"
#import "PCCircleViewConst.h"
#import "PCLockLabel.h"
#import "PCCircleInfoView.h"
#import "PCCircle.h"
#import "CMGestureAgainLogin.h"
@interface GestureViewController ()<CircleViewDelegate>

{
    CMLoginUsePassWordAlert *LoginAlert;
      int count;
}

/**
 *  提示Label
 */
@property (nonatomic, strong) PCLockLabel *msgLabel;

/**
 *  解锁界面
 */
@property (nonatomic, strong) PCCircleView *lockView;

/**
 *  infoView
 */
@property (nonatomic, strong) PCCircleInfoView *infoView;

@end

@implementation GestureViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
      self.tabBarController.tabBar.hidden = YES;
        self.navigationItem.hidesBackButton=YES;
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"nav_back_btn" higlightedImage:nil target:self action:@selector(backBtnClick)];
    
    // 进来先清空存的第一个密码
    [PCCircleViewConst saveGesture:nil Key:gestureOneSaveKey];
}

- (void)backBtnClick
{
    if (self.type==GestureViewControllerTypeSetting) {
        if (!self.isYanZheng) {
            if (!self.isFirst) {
                self.block();
            }
            

        }
        if(self.isFirst){
            [PassWordTool deletePassWord];
        }

        
    }

        [self.navigationController popViewControllerAnimated:YES];
        
   
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:CircleViewBackgroundColor];
    
    // 1.界面相同部分生成器
    [self setupSameUI];
    
    // 2.界面不同部分生成器
    [self setupDifferentUI];
}


#pragma mark - 界面不同部分生成器
- (void)setupDifferentUI
{
    switch (self.type) {
        case GestureViewControllerTypeSetting:
            [self setupSubViewsSettingVc];
            break;
//        case GestureViewControllerTypeLogin:
//            [self setupSubViewsLoginVc];
//            break;
        default:
            break;
    }
}

#pragma mark - 界面相同部分生成器
- (void)setupSameUI
{

    // 解锁界面
    PCCircleView *lockView = [[PCCircleView alloc] init];
    lockView.delegate = self;
    self.lockView = lockView;
  
    [self.view addSubview:lockView];
    [lockView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo([UIScreen mainScreen].bounds.size.width - CircleViewEdgeMargin *3);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width - CircleViewEdgeMargin * 2);
        make.centerY.equalTo(self.view.mas_centerY).offset(-20);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    

}

#pragma mark - 设置手势密码界面
- (void)setupSubViewsSettingVc
{
    [self.lockView setType:CircleViewTypeSetting];
    
    self.title = @"设置手势密码";
    
    PCCircleInfoView *infoView = [[PCCircleInfoView alloc] init];
    self.infoView = infoView;
    [self.view addSubview:infoView];
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CircleRadius * 2 * 0.6);
        make.width.mas_equalTo(CircleRadius * 2 * 0.6);
        make.top.equalTo(self.view.mas_top).offset(10);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    PCLockLabel *msgLabel = [[PCLockLabel alloc] init];
    self.msgLabel = msgLabel;
   
    msgLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:msgLabel];
    [msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(CMScreenW);
        make.top.equalTo(infoView.mas_bottom).offset(40);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    if (self.isYanZheng) {
        [self.msgLabel showNormalMsg:@"请输入新的手势密码"];

    }else{
      [self.msgLabel showNormalMsg:gestureTextBeforeSet];
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"重新设置" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:RedButtonColor forState:UIControlStateNormal];

    button.titleLabel.font = [UIFont systemFontOfSize:18];
    button.tag=buttonTagReset;
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(CMScreenW);
        make.top.equalTo(self.lockView.mas_bottom).offset(40);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    //self.resetBtn = button;
    
}
#pragma mark - button点击事件
- (void)didClickBtn:(UIButton *)sender
{
    NSLog(@"%ld", (long)sender.tag);
    switch (sender.tag) {
        case buttonTagReset:
        {
            NSLog(@"点击了重设按钮");
              
            // 2.infoView取消选中
            [self infoViewDeselectedSubviews];
            
            // 3.msgLabel提示文字复位
            if(self.isYanZheng){
                [self.msgLabel showNormalMsg:@"请输入新的手势密码"];
 
            }else{
            [self.msgLabel showNormalMsg:gestureTextBeforeSet];
            }
            // 4.清除之前存储的密码
            [PCCircleViewConst saveGesture:nil Key:gestureOneSaveKey];
            
            
        }
            break;
               default:
            break;
    }
}
#pragma mark - circleView - delegate
#pragma mark - circleView - delegate - setting
- (void)circleView:(PCCircleView *)view type:(CircleViewType)type connectCirclesLessThanNeedWithGesture:(NSString *)gesture
{
    NSString *gestureOne = [PCCircleViewConst getGestureWithKey:gestureOneSaveKey];

    // 看是否存在第一个密码
    if ([gestureOne length]) {

        [self.msgLabel showWarnMsgAndShake:gestureTextDrawAgainError];
    } else {
        NSLog(@"密码长度不合法%@", gesture);
        [self.msgLabel showWarnMsgAndShake:gestureTextConnectLess];
    }
}

- (void)circleView:(PCCircleView *)view type:(CircleViewType)type didCompleteSetFirstGesture:(NSString *)gesture
{
    NSLog(@"获得第一个手势密码%@", gesture);
    
    [self.msgLabel showWarnMsg:gestureTextDrawAgain];
    
    // infoView展示对应选中的圆
    [self infoViewSelectedSubviewsSameAsCircleView:view];
}

- (void)circleView:(PCCircleView *)view type:(CircleViewType)type didCompleteSetSecondGesture:(NSString *)gesture result:(BOOL)equal
{
    NSLog(@"获得第二个手势密码%@",gesture);
    
    if (equal) {
        
        NSLog(@"两次手势匹配！可以进行本地化保存了++%@--%@",gesture,[CMUserDefaults objectForKey:@"name"]);
        
        [self.msgLabel showWarnMsg:gestureTextSetSuccess];
        [PCCircleViewConst saveGesture:gesture Key:gestureFinalSaveKey];
        
        
        [self  performSelector:@selector(setGestureRecognizerSuccess:) withObject:gesture afterDelay:1];
     
    } else {
        NSLog(@"两次手势不匹配！");
        
        [self.msgLabel showWarnMsgAndShake:gestureTextDrawAgainError];
       
    }
}

-(void)setGestureRecognizerSuccess:(id)note{
    DLog(@"mimashi---%@",note);
    if (self.isYanZheng) {
        [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
    }else{
        if (self.isFirst) {
          
            [CMUserDefaults setBool:YES forKey:@"switNo"];
            
            [CMUserDefaults synchronize];
            NSString *name=[self.userDict objectForKey:@"name"];
            NSString *passWord=[self.userDict objectForKey:@"passWord"];
            NSString *GesturePass=(NSString*)note;
                NSString *userID = [[[[self.userDict objectForKey:@"responseObj"] objectForKey:@"userMess"] objectAtIndex:0] objectForKey:@"userID"];
                //if ([strStatus isEqualToString:@"200"]) {
                    [CMUserDefaults setObject:userID forKey:@"userID"];
                    [CMUserDefaults setObject:[NSDate date] forKey:@"expires_in"];
                          // 登陆成功后 保存用户名和密码
                    [CMUserDefaults setObject:[self.userDict objectForKey:@"name"] forKey:@"name"];
                    [PassWordTool savePassWord:[self.userDict objectForKey:@"passWord"]];
//                    [CMUserDefaults setObject:[NSDate date] forKey:@"saveUserMessager"];
                    [CMUserDefaults  setBool:NO forKey:@"invition"];
                    [CMUserDefaults  setBool:NO forKey:@"gesture"];

                    [CMUserDefaults synchronize];
                    //沙盒数据用户密码缓存
              [CMCookie getAndSaveCookie];
            NSMutableArray *arr=[NSMutableArray array];
            CMPeoplePassword *p=[CMPeoplePassword new];
            p.name=name;
            p.password=passWord;
            p.GesturePass=GesturePass;
            [arr addObject:p];
            [CMCache getFilePath:[NSString stringWithFormat:@"%@passWord.plist",userID]];
            [NSKeyedArchiver archiveRootObject:arr toFile: [CMCache getFilePath:[NSString stringWithFormat:@"%@passWord.plist",userID]]];
      
                    NSString *url = [NSString stringWithFormat:@"%@/handler/app_interface.ashx?action=IcmIndex&hyid=%@",OnLineCode,userID];
                    [CMHttpTool getWithURL:url params:nil success:^(id responseObj) {
                    //DLog(@"--%@",responseObj);
                        NSString *statusStr = [responseObj valueForKey:@"status"];
                        
                        if ([statusStr isEqualToString:@"200"]) {
        
                          //  NSString *userStr =[self.userDict objectForKey:@"name"];
                            NSString *jinriStr = [[[responseObj valueForKey:@"result"] valueForKey:@"today_ShouYi_Amount"] objectAtIndex:0]; // 今日收益
                            NSString *leijiStr = [[[responseObj valueForKey:@"result"] valueForKey:@"leiji_shouyi_Amount"] objectAtIndex:0]; // 累计收益
                            NSString *yueStr = [[[responseObj valueForKey:@"result"] valueForKey:@"ky_amount"] objectAtIndex:0]; // 账户余额
                            NSString *zongStr = [[[responseObj valueForKey:@"result"] valueForKey:@"total_Amount"] objectAtIndex:0]; // 总资产
                            NSString *cfb = [[[responseObj valueForKey:@"result"] valueForKey:@"cfb_xianzhi_Amount"] objectAtIndex:0];
                          NSString *diongjie=[[[responseObj valueForKey:@"result"] valueForKey:@"ky_amount_dj"] objectAtIndex:0];
                            NSDictionary *infoSign = @{@"userID":userID,
                                                       @"user":name,
                                                       @"jinrishouyi":jinriStr,
                                                       @"leijishouyi":leijiStr,
                                                       @"zhanghuyue":yueStr,
                                                       @"zongzichan":zongStr,
                                                       @"cfb_xianzhi_Amount":cfb,
                                                       @"dongjie":diongjie
                                                       };
                            [CMUserDefaults setObject:yueStr forKey:@"YuEr"];
                            
                            [CMUserDefaults synchronize];
                            [CMNSNotice postNotificationName:@"MesToAccount" object:self userInfo:infoSign]; // 发送通知 —— 账户
                            [CMNSNotice postNotificationName:@"MesToHome" object:self userInfo:infoSign];
                            [self.navigationController popToRootViewControllerAnimated:YES];
                        }
                    } failure:^(NSError *error) {
                        
                    }];
               // }
                
//                if ([strStatus isEqualToString:@"400"]) {
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"财猫网提示" message:mes delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                    [alert show];
//                }
//                
//            } failure:^(NSError *error) {
//                DLog(@"LoginError------%@",error);
//            }];
 
            
            
            
        }else{
        
    [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
#pragma mark - infoView展示方法
#pragma mark - 让infoView对应按钮选中
- (void)infoViewSelectedSubviewsSameAsCircleView:(PCCircleView *)circleView
{
    for (PCCircle *circle in circleView.subviews) {
        
        if (circle.state == CircleStateSelected || circle.state == CircleStateLastOneSelected) {
            
            for (PCCircle *infoCircle in self.infoView.subviews) {
                if (infoCircle.tag == circle.tag) {
                   [infoCircle setState:CircleStateSelected];
                    
                }
            }
        }
    }
}

#pragma mark - 让infoView对应按钮取消选中
- (void)infoViewDeselectedSubviews
{
    [self.infoView.subviews enumerateObjectsUsingBlock:^(PCCircle *obj, NSUInteger idx, BOOL *stop) {
        [obj setState:CircleStateNormal];
       
    }];
}

@end
