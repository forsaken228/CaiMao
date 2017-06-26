
#import "GestureVerifyViewController.h"
#import "PCCircleViewConst.h"
#import "PCCircleView.h"
#import "PCLockLabel.h"
#import "GestureViewController.h"

@interface GestureVerifyViewController ()<CircleViewDelegate>
{
    CMLoginUsePassWordAlert  *LoginAlert;
}
/**
 *  文字提示Label
 */
@property (nonatomic, strong) PCLockLabel *msgLabel;

@end

@implementation GestureVerifyViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     self.tabBarController.tabBar.hidden = YES;
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.view setBackgroundColor:CircleViewBackgroundColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"验证手势解锁";
    
    PCCircleView *lockView = [[PCCircleView alloc] init];
    lockView.delegate = self;
    [lockView setType:CircleViewTypeVerify];
    [self.view addSubview:lockView];
    [lockView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo([UIScreen mainScreen].bounds.size.width - CircleViewEdgeMargin * 2);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width - CircleViewEdgeMargin * 2);
        make.centerY.equalTo(self.view.mas_centerY);
        make.centerX.equalTo(self.view.mas_centerX);
    }];

    PCLockLabel *msgLabel = [[PCLockLabel alloc] init];
  
    [msgLabel showNormalMsg:gestureTextOldGesture];
    self.msgLabel = msgLabel;
    [self.view addSubview:msgLabel];
    [msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(CMScreenW);
        make.bottom.equalTo(lockView.mas_top).offset(-10);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    self.navigationItem.hidesBackButton=YES;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"nav_back_btn" higlightedImage:nil target:self action:@selector(backBtnClick)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"密码验证" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didClickBtn) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(CMScreenW);
        make.top.equalTo(lockView.mas_bottom).offset(30);
        make.centerX.equalTo(self.view.mas_centerX);
    }];

    
    
    
}
-(void)didClickBtn{
    
    LoginAlert=[[CMLoginUsePassWordAlert alloc ]initLoginUsePassWordAlert];
    LoginAlert.mainTitle.text=@"验证密码修改手势";
    LoginAlert.delegate=self;
    [LoginAlert ShowLoginAlert];

}
#pragma mark账户登录
-(void)exitView:(NSString *)passWord{
    DLog(@"password==%@",passWord);
    
        
        
        NSString *password = [PassWordTool readPassWord];
        if ([password isEqualToString:LoginAlert.passWordField.text]) {
            [LoginAlert dimissLoginAlert];
            if (self.isToSwitch) {
                self.block();
                [self.navigationController popViewControllerAnimated:YES];
            }else{
            GestureViewController *gestureVc = [[GestureViewController alloc] init];
            gestureVc.isYanZheng=YES;
            [gestureVc setType:GestureViewControllerTypeSetting];
            [self.navigationController pushViewController:gestureVc animated:YES];
            }
            
        }else{
            LoginAlert.errorlabel.text=@"登录密码错误!";
            
        }
        if (LoginAlert.passWordField.text.length<=0) {
            LoginAlert.errorlabel.text=@"请输入登录密码!";
            
        }
    
}


- (void)backBtnClick
{
 
    
  
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
#pragma mark - login or verify gesture
- (void)circleView:(PCCircleView *)view type:(CircleViewType)type didCompleteLoginGesture:(NSString *)gesture result:(BOOL)equal
{
    if (type == CircleViewTypeVerify) {
        
        if (equal) {
            NSLog(@"验证成功");
            
            if (self.isToSetNewGesture) {
                GestureViewController *gestureVc = [[GestureViewController alloc] init];
                gestureVc.isYanZheng=YES;
                [gestureVc setType:GestureViewControllerTypeSetting];
                [self.navigationController pushViewController:gestureVc animated:YES];
                
            } else {
                self.block();
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        } else {
            NSLog(@"密码错误！");
            [self.msgLabel showWarnMsgAndShake:gestureTextGestureVerifyError];
        }
    }
}

@end
