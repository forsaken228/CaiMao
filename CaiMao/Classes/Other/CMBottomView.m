//
//  CMBottomView.m
//  CaiMao
//
//  Created by MAC on 16/7/30.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMBottomView.h"

@implementation CMBottomView


-(id)init{
    self=[super init];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        self.userInteractionEnabled=YES;
        [self creatView];
        
    }
    return self;
}
-(void)creatView{
   int height=((CMScreenH-150)/2.0+20)/6.0;
    UILabel *yuer=[[UILabel alloc]init];
    self.YuEr=yuer;
    yuer.font=[UIFont systemFontOfSize:14.0];
    yuer.textColor=UIColorFromRGB(0x676767);
    yuer.textAlignment=NSTextAlignmentCenter;
    [self addSubview:yuer];
    [yuer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
        make.centerX.equalTo(self.mas_centerX).offset(-10);
        make.width.mas_equalTo(150);
        make.top.equalTo(self.mas_top);
        
    }];
    
    UILabel *lineView=[UILabel new];
    lineView.backgroundColor=ViewBackColor;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(yuer.mas_bottom);
        make.height.mas_equalTo(10);
        make.width.left.equalTo(self);
    }];
    
    UIButton *loginBtn=[UIButton buttonWithType:UIButtonTypeSystem];
   
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.titleLabel.font=[UIFont systemFontOfSize:14.0];
    loginBtn.backgroundColor=RedButtonColor;
    self.loginOrRechargebtn=loginBtn;
    loginBtn.layer.cornerRadius=5.0;
    loginBtn.clipsToBounds=YES;
   // [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.centerY.equalTo(yuer);
        make.left.equalTo(yuer.mas_right);
        make.width.mas_equalTo(40);
        
    }];
    

    
    UITextField *phoneText=[[UITextField alloc]init];
    phoneText.borderStyle=UITextBorderStyleNone;
    phoneText.placeholder=@"请输入您的手机号";
    phoneText.font=[UIFont systemFontOfSize:14.0];
    phoneText.keyboardType=UIKeyboardTypeNumberPad;
    
    phoneText.textAlignment=NSTextAlignmentCenter;
    self.shouJiNum=phoneText;

    [self addSubview:phoneText];
    
    [phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
        make.width.mas_equalTo(120);
        make.centerX.equalTo(self.mas_centerX).offset(20);
        make.top.equalTo(lineView.mas_bottom);
        
    }];
    
        UILabel *phone=[[UILabel alloc]init];
        phone.text=@"手机:";
    phone.textColor=CMColor(157, 157, 157);
    phone.textAlignment=NSTextAlignmentRight;
        phone.font=[UIFont systemFontOfSize:14.0];
    [self addSubview:phone];
    [phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.top.mas_equalTo(phoneText);
        make.width.mas_equalTo(40);
        make.right.equalTo(phoneText.mas_left);
     
    }];
    UIView *lineView1=[UIView new];
    lineView1.backgroundColor=separateLineColor;
    [self addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(phone.mas_bottom);
        make.height.mas_equalTo(0.5);
        make.width.left.equalTo(self);
        
        
    }];

    
    UILabel *agree=[[UILabel alloc]init];
    agree.text=@"同意";
    agree.textAlignment=NSTextAlignmentRight;
    agree.textColor=[UIColor lightGrayColor];
    agree.font=[UIFont systemFontOfSize:13.0];
    [self addSubview:agree];
    [agree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
        make.top.equalTo(lineView1.mas_bottom);
        make.width.mas_equalTo(30);
        make.left.equalTo(phone.mas_left);
        
    }];
        UIButton  *selectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.selectButton=selectBtn;
        selectBtn.layer.cornerRadius=2.0;
        selectBtn.layer.masksToBounds=YES;
        //[selectBtn setBackgroundColor:[UIColor blueColor]];
        [selectBtn setBackgroundImage:[UIImage imageNamed:@"btnSelected.png"] forState:UIControlStateNormal];
        [self addSubview:selectBtn];
        [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.mas_equalTo(15);
            make.centerY.equalTo(agree);
            make.right.equalTo(agree.mas_left);
        }];
    UIButton *zijin=[UIButton buttonWithType:UIButtonTypeSystem];
    self.zijinBtn=zijin;
    zijin.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [zijin setTitleColor:RedButtonColor forState:UIControlStateNormal];
    [zijin setTitle:@"资金交易合同" forState:UIControlStateNormal];
    zijin.titleLabel.font=[UIFont systemFontOfSize:13.0];
    [self addSubview:zijin];
    [zijin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.top.equalTo(agree);
        make.left.equalTo(agree.mas_right);
        make.width.equalTo(@80);
    }];
    
    UILabel *and=[[UILabel alloc]init];
    and.text=@"和";
    and.textAlignment=NSTextAlignmentLeft;
    and.textColor=[UIColor lightGrayColor];
    and.font=[UIFont systemFontOfSize:13.0];
    [self addSubview:and];
    [and mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.top.mas_equalTo(agree);
        make.width.mas_equalTo(15);
        make.left.equalTo(zijin.mas_right);
        
    }];
    UIButton *safe=[UIButton buttonWithType:UIButtonTypeSystem];
    self.securityBtn=safe;
    safe.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [safe setTitleColor:RedButtonColor forState:UIControlStateNormal];
    [safe setTitle:@"安全保证合同" forState:UIControlStateNormal];
    safe.titleLabel.font=[UIFont systemFontOfSize:13.0];
    [self addSubview:safe];
    [safe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.top.width.equalTo(zijin);
        make.left.equalTo(and.mas_right);
        
    }];
    
    
//    UIView *botline=[[UIView alloc]init];
//    botline.backgroundColor=CMColor(230, 230, 230 );
//    [self addSubview:botline];
//    [botline mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(selectBtn.mas_bottom).offset(8);
//        make.height.width.left.equalTo(lineView);
//        
//        
//    }];
//    UILabel *error=[[UILabel alloc]init];
//    self.errorLabel=error;
//    error.text=@"提示";
//    error.font=[UIFont boldSystemFontOfSize:13.0];
//    error.textColor=[UIColor redColor];
//    error.textAlignment=NSTextAlignmentLeft;
//    [self addSubview:error];
//    [error mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(15);
//        make.left.equalTo(self.mas_left).offset(20);
//        make.width.mas_equalTo(200);
//        make.top.equalTo(selectBtn.mas_bottom).offset(8);
//        
//    }];
//    
    
    
    UIButton *next=[UIButton buttonWithType:UIButtonTypeSystem];
    self.nextBtn=next;
    [next setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [next setTitle:@"下一步" forState:UIControlStateNormal];
    [next setBackgroundColor:RedButtonColor];
    next.layer.cornerRadius=5.0;
    next.clipsToBounds=YES;
    next.titleLabel.font=[UIFont systemFontOfSize:15.0];
    [self addSubview:next];
    [next mas_makeConstraints:^(MASConstraintMaker *make) {
     
        make.height.mas_equalTo(height);
        //make.width.mas_equalTo(200);
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.equalTo(safe.mas_bottom);
        
    }];
   
}
@end
