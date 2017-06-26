//
//  CMLoginUsePassWordAlert.m
//  CaiMao
//
//  Created by MAC on 16/8/25.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMLoginUsePassWordAlert.h"

@implementation CMLoginUsePassWordAlert

-(id)initLoginUsePassWordAlert{
    self=[super init];
    if (self) {
        self.frame=[UIScreen mainScreen].bounds;
        //模糊视图
        UIView  *bgView=[[UIView alloc]initWithFrame:self.frame];
        bgView.userInteractionEnabled=YES;
        bgView.backgroundColor=[UIColor blackColor];
        bgView.alpha=0.52f;
        [self addSubview:bgView];
        
           UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissView)];
                tap.delegate=self;
                [bgView addGestureRecognizer:tap];
        //弹框背景
        UIView *contentView=[[UIView alloc]init];
        
        
        contentView.backgroundColor=[UIColor whiteColor];
        contentView.userInteractionEnabled=YES;
        contentView.layer.cornerRadius=5.0;
        contentView.clipsToBounds=YES;
        [self addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(bgView);
            make.height.mas_equalTo(170);
            make.width.mas_equalTo(260);
        }];
        
        
        UILabel *tittle=[[UILabel alloc]init];
        self.mainTitle=tittle;
        //tittle.text=@"账户登录";
        tittle.font=[UIFont systemFontOfSize:14];
        //tittle.textColor=UIColorFromRGB(0x666666);
        tittle.textAlignment=NSTextAlignmentCenter;
        [contentView addSubview:tittle];
        [tittle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.centerX.equalTo(contentView.mas_centerX);
            make.top.equalTo(contentView.mas_top).offset(10);
            
        }];
        
        UIView *lineView=[UIView new];
        lineView.backgroundColor=separateLineColor;
        // lineView.backgroundColor=[UIColor blueColor];
        
        [contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
            make.width.left.right.equalTo(contentView);
            make.bottom.equalTo(tittle.mas_bottom).offset(10);
            
        }];
        NSString *name=[CMUserDefaults objectForKey:@"name"];
       NSString *newName=[name stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        UILabel *user=[[UILabel alloc]init];
        user.text=[NSString stringWithFormat:@"请输入%@用户的登录密码",newName];
        user.textColor=UIColorFromRGB(0x888888);
        [NSString  DoubleStringChangeColer:user andFromStr:@"入" ToStr:@"用" withColor:RedButtonColor];
        user.font=[UIFont systemFontOfSize:12];
        
        user.textAlignment=NSTextAlignmentCenter;
        [contentView addSubview:user];
        [user mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.width.equalTo(@200);
            make.centerX.equalTo(contentView.mas_centerX);
            make.top.equalTo(lineView.mas_bottom).offset(10);
            
        }];
        
        UITextField *password=[[UITextField alloc]init];
        self.passWordField=password;
        password.secureTextEntry=YES;
        password.font=[UIFont systemFontOfSize:13.0];
    
       // password.borderStyle=UITextBorderStyleLine;
        password.placeholder=@"请输入账户登录密码";
        
        password.layer.borderColor=[[UIColor orangeColor]CGColor];
        password.layer.borderWidth= 0.5f;
        
        [contentView addSubview:password];
        [contentView addSubview:password];
        [password mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@30);
            make.width.equalTo(@200);
            make.centerX.equalTo(contentView.mas_centerX);
            make.top.equalTo(user.mas_bottom).offset(10);
            
        }];

        UIButton *SureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [SureBtn setTitle:@"确定" forState:UIControlStateNormal];
        
        //[SureBtn setTitleColor:[UIColor ] forState:UIControlStateNormal];
        // button.frame = CGRectMake(100, 550, kScreenW, 14);
        SureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [SureBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        
        [contentView addSubview:SureBtn];
        [SureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(16);
            make.width.equalTo(contentView);
            make.top.equalTo(password.mas_bottom).offset(15);
            make.centerX.equalTo(contentView.mas_centerX);
        }];
        
        [SureBtn addTarget:self action:@selector(didClickBtn) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *error=[[UILabel alloc]init];
        self.errorlabel=error;
        error.font=[UIFont systemFontOfSize:12];
        error.textColor=RedButtonColor;
        
        [contentView addSubview:error];
        [error mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.width.equalTo(@200);
            make.left.equalTo(password.mas_left);
            make.top.equalTo(SureBtn.mas_bottom).offset(10);
            
        }];
        
    }
    return self;
}
-(void)didClickBtn{
    if ([_delegate respondsToSelector:@selector(exitView:)]) {
        [_delegate exitView:self.passWordField.text];
    }
    
}
-(void)dismissView{

    [self dimissLoginAlert];

}
-(void)ShowLoginAlert
{
    UIWindow *window=[[[UIApplication sharedApplication]delegate]window];
    // //展示alertView,将alertView展示在window
    [window addSubview:self];
    
}
-(void)dimissLoginAlert{
    for (UIView *vc in self.subviews) {
        [vc removeFromSuperview];
    }
    [self removeFromSuperview];
}

@end
