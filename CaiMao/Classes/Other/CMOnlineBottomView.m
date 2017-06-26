//
//  CMOnlineBottomView.m
//  CaiMao
//
//  Created by MAC on 16/8/1.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMOnlineBottomView.h"

@implementation CMOnlineBottomView

-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self creatView];
        self.userInteractionEnabled=YES;
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

-(void)creatView{
    
    UILabel *line=[UILabel new];
    line.backgroundColor=ViewBackColor;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@8);
        make.width.left.equalTo(self);
        make.top.equalTo(self);
    }];
    UILabel *bankName=[UILabel new];
    self.BankName=bankName;
    bankName.textColor=[UIColor grayColor];
    bankName.font=[UIFont systemFontOfSize:13.0];

    [self addSubview:bankName];
    [bankName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(100);
        make.left.equalTo(self.mas_left).offset(8);
        make.top.equalTo(line.mas_bottom).offset(8);
        
    }];
    //详情图标
//    UIImageView *detail=[[UIImageView alloc]init];
//    //detail.frame=CGRectMake(233, 74, 16, 16);
//    detail.image=[UIImage imageNamed:@"detail_pressed"];
//    detail.layer.cornerRadius=7.5;
//    detail.clipsToBounds=YES;
//    [self addSubview:detail];
//    [detail mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.height.width.mas_equalTo(16);
//        make.left.equalTo(bankName.mas_right);
//        make.bottom.equalTo(bankName.mas_bottom).offset(-2);
//        
//    }];
    
    
   

    //限额说明
    UIButton *tLimitContent=[UIButton buttonWithType:UIButtonTypeCustom];
    // tLimitContent.frame=CGRectMake(248, 67, 64, 30);
    tLimitContent.titleLabel.font=[UIFont systemFontOfSize:13];
    [tLimitContent setImage:[UIImage imageNamed:@"detail_pressed"] forState:UIControlStateNormal];
    tLimitContent.imageEdgeInsets=UIEdgeInsetsMake(0, -3, 0, 15);
    //[tLimitContent setTitle:@"限额说明" forState:UIControlStateNormal];
    [tLimitContent setTitleColor:UIColorFromRGB(0x1b84ef) forState:UIControlStateNormal];
    tLimitContent.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    self.ZhiChiBank=tLimitContent;
    [self addSubview:tLimitContent];
    [tLimitContent mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.top.equalTo(bankName);
        make.left.equalTo(bankName.mas_right);
        make.width.mas_equalTo(100);
    }];
   
    
    UILabel *ZhiFu=[UILabel new];
    ZhiFu.userInteractionEnabled=YES;
    self.KaitongRenZheng=ZhiFu;
    ZhiFu.textColor=[UIColor grayColor];
    ZhiFu.font=[UIFont systemFontOfSize:13.0];
    [self addSubview:ZhiFu];
    [ZhiFu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.top.equalTo(bankName);
        make.width.mas_equalTo(100);
        make.right.equalTo(self.mas_right).offset(-8);
        
    }];
    
  
    
    
    UIButton *next=[UIButton buttonWithType:UIButtonTypeSystem];
    self.payBtnClick=next;
    [next setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [next setTitle:@"支付" forState:UIControlStateNormal];
    [next setBackgroundColor:RedButtonColor];
    next.layer.cornerRadius=5.0;
    next.clipsToBounds=YES;
    next.titleLabel.font=[UIFont systemFontOfSize:15.0];
    [self addSubview:next];
    [next mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(35);
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(ZhiFu.mas_bottom).offset(10);
        
    }];
    UILabel *error=[[UILabel alloc]init];
    self.errorLabel=error;
    error.hidden=YES;
    error.textColor=RedButtonColor;
    error.font=[UIFont systemFontOfSize:13.0];
    [self addSubview:error];
    [error mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.left.equalTo(bankName);
        make.width.equalTo(@250);
        
        make.top.equalTo(tLimitContent.mas_bottom).offset(8);
        
    }];
    
}
@end
