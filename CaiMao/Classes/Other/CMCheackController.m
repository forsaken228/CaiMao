//
//  CMCheackController.m
//  CaiMao
//
//  Created by MAC on 16/10/25.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMCheackController.h"

@interface CMCheackController ()

@end

@implementation CMCheackController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=ViewBackColor;
    [self.view addSubview:self.statuesLabel];
    [self.statuesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.width.equalTo(@120);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(50);
    }];
    [self.view addSubview:self.statuesImage];
    [self.statuesImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(29);
        make.centerY.equalTo(self.statuesLabel);
        make.right.equalTo(self.statuesLabel.mas_left).offset(-3);
    }];
    [self.view addSubview:self.DetailLabel];
    [self.DetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.equalTo(@50);
        make.top.equalTo(self.statuesImage.mas_bottom).offset(10);
    }];
    [self.view addSubview:self.PhoneLabel];
    [self.PhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@15);
        make.top.equalTo(self.DetailLabel.mas_bottom).offset(20);
    }];
    [self.view addSubview:self.clickBtn];
    [self.clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
       make.height.mas_equalTo(buttonHeight);
        make.top.equalTo(self.PhoneLabel.mas_bottom).offset(10);
    }];
    
   // self.DetailLabel.text=@"我们将尽快审核,1-2个工作日内将为您处理,之后您可以认证新的银行卡";
    if (self.type==CheackTypeUpLoadSuccesse) {
        self.title=@"提交成功";
        self.statuesLabel.text=@"提交成功!";
        self.DetailLabel.text=@"我们将尽快审核,1-2个工作日内将为您处理,之后您可以认证新的银行卡";
         _statuesImage.image=[UIImage imageNamed:@"zfcg_chengong_icon"];
          [_clickBtn setTitle:@"确定" forState:UIControlStateNormal];
    }else if(self.type==CheackTypeISCheack){
        self.title=@"正在审核";
        self.statuesLabel.text=@"正在审核中...";
        self.DetailLabel.text=@"你提交的更换认证卡申请,正在审核中,请耐心等待";
        [_clickBtn setTitle:@"返回" forState:UIControlStateNormal];
        _statuesImage.image=[UIImage imageNamed:@"isCheack"];
        
    }else{
        self.title=@"审核未通过";
        self.statuesLabel.text=@"审核未通过!";
       self.DetailLabel.text=[NSString stringWithFormat:@"原因:%@",self.message];
        _statuesImage.image=[UIImage imageNamed:@"SHFail"];
        [_clickBtn setTitle:@"重新申请" forState:UIControlStateNormal];
        
    }
   
    
    
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSMutableArray  *arr=[[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    for (UIViewController *vc in arr) {
        if ([vc isKindOfClass:[self class]]) {
            
            [arr removeObject:vc];
            break;
        }
        
    }
    self.navigationController.viewControllers=arr;

}
-(UIImageView*)statuesImage{
    if (!_statuesImage) {
        _statuesImage=[[UIImageView alloc]init];
       
    }
    return _statuesImage;
}
-(UILabel*)statuesLabel{
    if (!_statuesLabel) {
        _statuesLabel=[[UILabel alloc]init];
        _statuesLabel.font=[UIFont systemFontOfSize:20];
        _statuesLabel.textColor=UIColorFromRGB(0x333333);
    }
    
    return _statuesLabel;
}
-(UILabel*)DetailLabel{
    if (!_DetailLabel) {
        _DetailLabel=[[UILabel alloc]init];
        _DetailLabel.numberOfLines=0;
        _DetailLabel.font=[UIFont systemFontOfSize:14.0];
        _DetailLabel.textColor=UIColorFromRGB(0x8e8e93);
        _DetailLabel.textAlignment=NSTextAlignmentCenter;
    }
    
    return _DetailLabel;
}
-(UILabel*)PhoneLabel{
    if (!_PhoneLabel) {
        _PhoneLabel=[[UILabel alloc]init];
        _PhoneLabel.font=[UIFont systemFontOfSize:12.0];
        _PhoneLabel.textColor=UIColorFromRGB(0x8e8e93);
        _PhoneLabel.text=@"如有疑问,请致电400-999-3972";
        _PhoneLabel.textAlignment=NSTextAlignmentCenter;
    }
    
    return _PhoneLabel;
}
-(UIButton*)clickBtn{
    if  (!_clickBtn) {
        _clickBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _clickBtn.titleLabel.font=[UIFont systemFontOfSize:14.0];
        _clickBtn.layer.cornerRadius=4.0;
        _clickBtn.clipsToBounds=YES;
        [_clickBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_clickBtn setBackgroundColor:RedButtonColor];
        [_clickBtn addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clickBtn;

    
}

-(void)nextClick{
    if (self.type!=CheackTypeCheackFailure) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        CMYZSFController *vc=[[CMYZSFController alloc]init];
        vc.bankListArr=self.bankListArry;
        CMPush(vc);
        
    }
    
}
@end
