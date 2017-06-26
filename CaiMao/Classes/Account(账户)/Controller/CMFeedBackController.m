//
//  CMFeedBackController.m
//  CaiMao
//
//  Created by Fengpj on 16/1/15.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMFeedBackController.h"
#import "CMFeedTextView.h"

@interface CMFeedBackController ()<UIAlertViewDelegate>


@property (strong, nonatomic)  CMFeedTextView *feedView;
@property (strong, nonatomic)  CMTextField *emailTextField;
@property (strong, nonatomic)  UIButton *submitBtn;

@end

@implementation CMFeedBackController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    [self creatUiView];
    [self sutupUI];
 
}

- (void)sutupUI
{
    self.view.backgroundColor=ViewBackColor;
  
    
    
    
//    self.feedView.layer.masksToBounds = YES;
//    self.feedView.layer.borderWidth = 0;
//    self.feedView.layer.cornerRadius = 5.0;
//    self.feedView.layer.borderColor = [[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0] CGColor];
//    
    [CMNSNotice addObserver:self selector:@selector(textFieldChange) name:UITextFieldTextDidChangeNotification object:self.feedView];
    [CMNSNotice addObserver:self selector:@selector(textFieldChange) name:UITextFieldTextDidChangeNotification object:self.emailTextField];
    
    
   
}

- (void)dealloc
{
    [CMNSNotice removeObserver:self];
}

#pragma mark 监听用户输入
- (void)textFieldChange
{
    if (([self.feedView.text length] > 0 && [self.emailTextField.text length] > 0)) {
        self.submitBtn.enabled = YES;
        self.submitBtn.alpha = 1.0;
    }
}
// 提交
- (void)submitClick
{
    if ([self.feedView.text isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入您的反馈内容" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    } else if (![CMRegularJudement checkUserEmail:self.emailTextField.text]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的邮箱地址" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    } else {
        
        NSString *currUrlStr = [NSString stringWithFormat:@"%@/handler/AppInterface.ashx?action=feedback&email=%@&feedback=%@&source=IOS",OnLineCode,self.emailTextField.text,self.feedView.text];
        
        NSString *urlStr = [currUrlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        if (![self checkNetWork]) {
            return;
        }
        [CMHttpTool getWithURL:urlStr params:nil success:^(id responseObj) {
            
            NSString *statusStr = [responseObj objectForKey:@"status"];
            NSString *mess = [responseObj objectForKey:@"result"];
            
            if ([statusStr isEqualToString:@"200"]) {
           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:mess delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alert show];
            }
            
        } failure:^(NSError *error) {
//            DLog(@"提交失败。。。。");
        }];
    }

}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
//        DLog(@"0000------");
    } else {
//        DLog(@"11111------");
        [self.navigationController   popToRootViewControllerAnimated:YES];
    }
}


-(void)creatUiView{
    UIImage *image=[UIImage imageNamed:@"反馈"];
    UIImageView *topImage=[UIImageView new];
    topImage.image=image;
    [self.view addSubview:topImage];
    [topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view);
        make.height.mas_equalTo(f_i5real(image.size.height));
    }];
    
    
    UIView *topBgView=[[UIView alloc]init];
    topBgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:topBgView];
    [topBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(topImage.mas_bottom);
        make.height.equalTo(@110);
    }];
    
    self.feedView = [[CMFeedTextView alloc] init];
    //WithFrame:CGRectMake(20, 15, 280, 100)
   // feed.frame=CGRectMake(0, 0, 280, 100);
    self.feedView.placeholder = @"请在这里输入您的意见或建议,我们\n将用心倾听,及时跟进解决。";
    self.feedView.font = [UIFont systemFontOfSize:14.0];
    
    [topBgView addSubview:self.feedView];
    [self.feedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topBgView.mas_left).offset(20);
        make.top.height.equalTo(topBgView);
        make.right.equalTo(topBgView.mas_right).offset(-15);
    }];
    
    UIView *line=[[UIView alloc]init];
   // line.frame=CGRectMake(20, 120, 280, 1);
    line.backgroundColor=ViewBackColor;
    [self.view addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(10);
        make.width.mas_equalTo(self.feedView);
        make.top.equalTo(topBgView.mas_bottom);
        make.left.equalTo(self.feedView);
    }];
    
    
    UIView *bgview=[[UIView alloc]init];
    bgview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bgview];
    [bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.right.left.equalTo(self.view);
        make.top.equalTo(line.mas_bottom).offset(10);
    }];
    self.emailTextField=[[CMTextField alloc]init];
    //WithFrame:CGRectMake(20, 174, 280, 30)
     self.emailTextField.placeholder=@"请输入您的邮箱";
     self.emailTextField.borderStyle=UITextBorderStyleNone;
    [bgview addSubview: self.emailTextField];
    
    [ self.emailTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.right.top.equalTo(bgview);
        make.left.equalTo(bgview.mas_left).offset(20);
    }];
    
//     UIView *line1=[[UIView alloc]init];
//    //line1.frame=CGRectMake(20, 205, 280, 1);
//    line1.backgroundColor=[UIColor redColor];
//    [self.view addSubview:line1];
//    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(0.5);
//        make.width.mas_equalTo(feed);
//        make.top.equalTo(text.mas_bottom).offset(0.5);
//        make.left.equalTo(feed);
//    }];
//    
    UIButton *CommtionBtn=[UIButton buttonWithType:UIButtonTypeSystem];
   // CommtionBtn.frame=CGRectMake(15, 222, 290, 44);
    CommtionBtn.backgroundColor=RedButtonColor;
    CommtionBtn.layer.cornerRadius=5.0;
    CommtionBtn.clipsToBounds=YES;
    self.submitBtn=CommtionBtn;
    [CommtionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    CommtionBtn.titleLabel.font=[UIFont systemFontOfSize:19.0];
    [CommtionBtn setTitle:@"提交" forState:UIControlStateNormal];
    [CommtionBtn addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CommtionBtn];
    [CommtionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(buttonHeight);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.top.equalTo( self.emailTextField.mas_bottom).offset(30);
        
        make.right.equalTo(self.view.mas_right).offset(-15);
    }];
   
    
}
checkNet

@end
