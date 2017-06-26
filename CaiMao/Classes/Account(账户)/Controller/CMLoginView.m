//
//  CMLoginView.m
//  CaiMao
//
//  Created by WangWei on 17/2/16.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import "CMLoginView.h"

@implementation CMLoginView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        
        UIImage *image=[UIImage imageNamed:@"denglu_logo.png"];
        UIImageView *headImage=[[UIImageView alloc]initWithImage:image];
        [self addSubview:headImage];
        [headImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(20);
            make.centerX.equalTo(self.mas_centerX);
            make.height.mas_equalTo(image.size.height);
            make.width.mas_equalTo(image.size.width);
            
        }];
        
        
        UIView *line=[[UIView alloc]init];
        //line.frame=CGRectMake(30, 215, 260, 1);
        line.backgroundColor=separateLineColor;
        [self addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headImage.mas_bottom).offset(60);
            make.height.mas_equalTo(0.5);
            make.left.equalTo(self.mas_left).offset(10);
            make.right.equalTo(self.mas_right).offset(-10);
        }];
        
        
        [self addSubview:self.phoneLeftIcon];
        [self.phoneLeftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(line);
            make.bottom.equalTo(line.mas_bottom).offset(-10);
            make.height.width.mas_equalTo(27);
            
            
        }];
        
       
        [self addSubview:self.phoneTextField];
        
        [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.phoneLeftIcon.mas_right).offset(5);
            make.bottom.equalTo(line.mas_bottom);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(140);
            
            
        }];

        [self addSubview:self.pwdLeftIcon];
        [self.pwdLeftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line.mas_bottom).offset(20);
            make.height.width.left.equalTo(self.phoneLeftIcon);
            
            
        }];
        
        [self addSubview:self.pwdTextField];
        
        [self.pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.height.width.equalTo(self.phoneTextField);
            make.top.equalTo(line.mas_bottom).offset(15);
            
        }];
        
        
        UIView *line2=[[UIView alloc]init];
        //line2.frame=CGRectMake(30, 263, 260, 1);
        line2.backgroundColor=separateLineColor;
        [self addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.height.width.equalTo(line);
            make.top.equalTo(self.pwdLeftIcon.mas_bottom).offset(7);
            
        }];
        
        [self addSubview:self.loginBtn];
        [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line2.mas_bottom).offset(20);
            make.left.right.equalTo(line);
            make.height.equalTo(@40);
            
            
        }];
      
        [self addSubview:self.forgetPsw];
        [self.forgetPsw mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.loginBtn.mas_bottom).offset(10);
            make.right.equalTo(self.loginBtn);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(90);
            
            
        }];
        [self addSubview:self.phoneClearBtn];
        
        [self.phoneClearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(line.mas_bottom).offset(-10);
            make.height.width.mas_equalTo(20);
            make.right.equalTo(line.mas_right).offset(-5);
            
        }];
        
        [self addSubview:self.pwdClearBtn];
        [self.pwdClearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(line2.mas_bottom).offset(-10);
            
            make.right.width.height.equalTo(self.phoneClearBtn);
            
        }];

    }
    return self;
}
#pragma mark Lazy
-(UIImageView*)phoneLeftIcon{
    if (!_phoneLeftIcon) {
        _phoneLeftIcon=[[UIImageView alloc]init];
       
        _phoneLeftIcon.image=[UIImage imageNamed:@"denglu_shouji.png"];
    }
    return _phoneLeftIcon;
}
-(CMTextField*)phoneTextField{
    if (!_phoneTextField) {
        _phoneTextField=[[CMTextField alloc]init];
        _phoneTextField.placeholder=@"手机号";
        _phoneTextField.keyboardType=UIKeyboardTypeNumberPad;

        
    }
    return _phoneTextField;
    
}
-(UIImageView*)pwdLeftIcon{
    if (!_pwdLeftIcon) {
        _pwdLeftIcon=[[UIImageView alloc]init];
        
        _pwdLeftIcon.image=[UIImage imageNamed:@"denglu_mima.png"];
    }
    return _pwdLeftIcon;
}
-(CMTextField*)pwdTextField{
    if (!_pwdTextField) {
        _pwdTextField=[[CMTextField alloc]init];
        _pwdTextField.placeholder=@"密码";
        _pwdTextField.secureTextEntry=YES;
       
        
    }
    return _pwdTextField;
    
}
-(UIButton*)loginBtn{
    if (!_loginBtn) {
        _loginBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        
        _loginBtn.layer.cornerRadius=5.0;
        _loginBtn.clipsToBounds=YES;
        
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn setBackgroundColor:RedButtonColor];
        _loginBtn.titleLabel.font=[UIFont systemFontOfSize:19.0];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    }
    return _loginBtn;
    
}
-(UIButton*)forgetPsw{
    
    if (!_forgetPsw) {
        _forgetPsw=[UIButton buttonWithType:UIButtonTypeSystem];
        [_forgetPsw setTitle:@"忘记密码?" forState:UIControlStateNormal];
        [_forgetPsw setTitleColor:RedButtonColor forState:UIControlStateNormal];
        _forgetPsw.titleLabel.font=[UIFont systemFontOfSize:15.0];
    }
    return _forgetPsw;
}

-(UIButton*)phoneClearBtn{
    
    if (!_phoneClearBtn) {
       
        _phoneClearBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        
        
        _phoneClearBtn.hidden=YES;
        [_phoneClearBtn setBackgroundImage:[UIImage imageNamed:@"denglu_guanbi.png"] forState:UIControlStateNormal];
  
        
    }
    return _phoneClearBtn;
}
-(UIButton*)pwdClearBtn{
    
    if (!_pwdClearBtn) {
        
        _pwdClearBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        
        
        _pwdClearBtn.hidden=YES;
        [_pwdClearBtn setBackgroundImage:[UIImage imageNamed:@"denglu_guanbi.png"] forState:UIControlStateNormal];
        
        
    }
    return _pwdClearBtn;
}

@end
