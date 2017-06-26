//
//  CMYZSFController.m
//  CaiMao
//
//  Created by MAC on 16/10/25.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMYZSFController.h"

@interface CMYZSFController ()
@property(nonatomic,strong)UITextField *UserID;
@property(nonatomic,strong)UITextField *Password;
@property(nonatomic,strong)UILabel *errorLabel;
@end

@implementation CMYZSFController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.title=@"身份验证";
    self.view.backgroundColor=ViewBackColor;
self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled=NO;
     self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"我的账户" style:UIBarButtonItemStylePlain target:self action:@selector(goMyAuccount)];
    if (![self checkNetWork]) {
        return;
    }
}
-(void)goMyAuccount{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.UserID.text=@"";
    self.Password.text=@"";
    self.errorLabel.text=@"";
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 200;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0,0, CMScreenW, 40)];
    bgView.backgroundColor=ViewBackColor;
    UILabel *label=[[UILabel alloc]init];
    //label.backgroundColor=ViewBackColor;
    label.text=@"为检验您的身份,请填写以下信息";
    label.font=[UIFont systemFontOfSize:13];
    label.textColor=UIColorFromRGB(0x8e8e93);
    //label.textAlignment=NSTextAlignmentCenter;
    [bgView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.centerY.equalTo(bgView);
        make.left.equalTo(bgView.mas_left).offset(30);
        make.width.equalTo(@200);
    }];
    UIImage *image=[UIImage imageNamed:@"topTiShi_image"];
    UIImageView *imageView=[[UIImageView alloc]init];
    imageView.image=image;
    [bgView addSubview:imageView];
   [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.height.mas_equalTo(f_i5real(image.size.height));
       make.width.mas_equalTo(f_i5real(image.size.width));
       make.centerY.equalTo(label);
       make.right.equalTo(label.mas_left).offset(-5);
   }];
    return bgView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, 200)];
    
    UIView *bottomView=[[UIView alloc]init];
    bottomView.backgroundColor=[UIColor whiteColor];
    [bgView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.equalTo(bgView);
        make.height.mas_equalTo(90);
    }];
    UILabel *tID=[[UILabel alloc]init];
    tID.text=@"身份证号";
    tID.font=[UIFont systemFontOfSize:14.0];
    tID.textColor=UIColorFromRGB(0x333333);
    [bottomView addSubview:tID];
    [tID mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@80);
        make.left.equalTo(bgView.mas_left).offset(15);
        make.height.equalTo(@20);
        make.top.equalTo(bgView.mas_top).offset(20);
    }];
    [bottomView addSubview:self.UserID];
    [self.UserID mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@200);
        make.height.bottom.equalTo(tID);
        make.left.equalTo(tID.mas_right);
    }];
    
    
    UILabel *line=[[UILabel alloc]init];
    line.backgroundColor=separateLineColor;
    [bottomView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CMScreenW);
        make.left.equalTo(bgView);
        make.height.equalTo(@0.5);
        make.top.equalTo(tID.mas_bottom).offset(10);

        
    }];

    
    UILabel *tPass=[[UILabel alloc]init];
    tPass.text=@"交易密码";
    tPass.font=[UIFont systemFontOfSize:14.0];
    tPass.textColor=UIColorFromRGB(0x333333);
    [bottomView addSubview:tPass];
    [tPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.left.width.equalTo(tID);
        make.top.equalTo(line.mas_bottom).offset(10);
    }];
    [bottomView addSubview:self.Password];
    [self.Password mas_makeConstraints:^(MASConstraintMaker *make) {
      make.height.left.width.equalTo(self.UserID);
        make.bottom.equalTo(tPass);
    }];
    
    
   
    [bgView addSubview:self.errorLabel];
    [self.errorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@15);
        make.left.equalTo(tPass);
        make.top.equalTo(bottomView.mas_bottom).offset(20);
        make.width.equalTo(@200);
    }];
    
    
    UIButton *ReChargeBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    ReChargeBtn.titleLabel.font=[UIFont systemFontOfSize:14.0];
    [ReChargeBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [ReChargeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    ReChargeBtn.layer.cornerRadius=4.0;
    ReChargeBtn.clipsToBounds=YES;
    [ReChargeBtn setBackgroundColor:RedButtonColor];
    [ReChargeBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:ReChargeBtn];
    [ReChargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left).offset(15);
        make.right.equalTo(bgView.mas_right).offset(-15);
        make.top.equalTo(self.errorLabel.mas_bottom).offset(20);
        make.height.mas_equalTo(buttonHeight);
        
    }];
    
       return bgView;
}
-(void)nextBtnClick{
   
    if (self.UserID.text.length<=0) {
        self.errorLabel.text=@"*身份证号不能为空";
        return;
    }
    if (self.Password.text.length<=0) {
        self.errorLabel.text=@"*交易密码不能为空";
        return;
    }
//    CMUploadUserIDController *vc=[[CMUploadUserIDController alloc]init];
//    vc.bankListArr=self.bankListArr;
//    CMPush(vc);
//
    [CMRequestHandle  userUserYanZhengWithUserID:[CMUserDefaults objectForKey:@"userID"] andNameID:self.UserID.text andIdealPassword:[NSString md5:self.Password.text] andSuccess:^(id responseObj) {
        DLog(@"++++%@+++%@",responseObj,[responseObj objectForKey:@"Result"]);
        if ([[responseObj objectForKey:@"Status"]intValue]==200) {
            CMUploadUserIDController *vc=[[CMUploadUserIDController alloc]init];
            vc.bankListArr=self.bankListArr;
            CMPush(vc);
            
        }else{
            
            self.errorLabel.text=[NSString stringWithFormat:@"*%@",[responseObj objectForKey:@"Result"]];
        }
        
        
    }];
    }
-(UITextField*)UserID{
    if (!_UserID) {
        _UserID=[[UITextField alloc]init];
        _UserID.placeholder=@"请输入您的身份证号";
        _UserID.font=[UIFont systemFontOfSize:14.0];
        _UserID.textColor=UIColorFromRGB(0x8e8e93);
        
    }
    return _UserID;
}
-(UITextField*)Password{
    if (!_Password) {
        _Password=[[UITextField alloc]init];
        _Password.placeholder=@"请输入您的交易密码";
        _Password.font=[UIFont systemFontOfSize:14.0];
        _Password.textColor=UIColorFromRGB(0x8e8e93);
        _Password.secureTextEntry=YES;
    }
    return _Password;
}
-(UILabel*)errorLabel{
    if (!_errorLabel) {
        _errorLabel=[[UILabel alloc]init];
       _errorLabel.font=[UIFont systemFontOfSize:12.0];
        _errorLabel.textColor=RedButtonColor;
            }
    return _errorLabel;
}

checkNet
@end
