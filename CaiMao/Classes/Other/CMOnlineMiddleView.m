//
//  CMOnlineMiddleView.m
//  CaiMao
//
//  Created by MAC on 16/8/1.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMOnlineMiddleView.h"

@implementation CMOnlineMiddleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        [self creatView];
        
    }
    return self;
}
-(id)init{
    self=[super init];
    if (self) {
         self.backgroundColor=[UIColor whiteColor]; 
        [self creatView];
        
    }
    return self;
}
-(void)creatView{
    UILabel *order=[[UILabel alloc]init];
    order.text=@"订单号";
    order.font=[UIFont systemFontOfSize:13.0];
    order.textColor=[UIColor grayColor];
    [self addSubview:order];
    [order mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.width.equalTo(@60);
        make.left.equalTo(self.mas_left).offset(8);
        make.top.equalTo(self.mas_top).offset(8);
    }];
    UILabel *line=[UILabel new];
     line.backgroundColor=separateLineColor;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.width.left.equalTo(self);
        make.top.equalTo(order.mas_bottom).offset(8);
    }];
    
    UILabel *pay=[[UILabel alloc]init];
    pay.text=@"应付金额";
    pay.font=[UIFont systemFontOfSize:13.0];
    pay.textColor=[UIColor grayColor];
    [self addSubview:pay];
    [pay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@80);
        make.left.height.equalTo(order);
        make.top.equalTo(line.mas_bottom).offset(8);
    }];
    UILabel *line2=[UILabel new];
    line2.backgroundColor=separateLineColor;
    [self addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.height.left.equalTo(line);
        make.top.equalTo(pay.mas_bottom).offset(8);
    }];
    UILabel *orderNum=[[UILabel alloc]init];
    self.orderNumber=orderNum;
    orderNum.font=[UIFont systemFontOfSize:13.0];
    orderNum.textAlignment=NSTextAlignmentRight;
    orderNum.textColor=[UIColor grayColor];
    [self addSubview:orderNum];
    [orderNum mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.equalTo(@100);
        make.right.equalTo(self.mas_right).offset(-8);
        make.top.height.equalTo(order);
    }];

    UILabel *payJin=[[UILabel alloc]init];
    self.payJinEr=payJin;
    payJin.font=[UIFont systemFontOfSize:13.0];
    payJin.textAlignment=NSTextAlignmentRight;
    payJin.textColor=[UIColor grayColor];
    [self addSubview:payJin];
    [payJin mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@100);
        make.right.equalTo(orderNum);
        make.top.height.equalTo(pay);
    }];
   
    UIButton *select=[UIButton buttonWithType:UIButtonTypeCustom];
    //[select setBackgroundColor:[UIColor grayColor]];
    //[select setBackgroundImage:[UIImage imageNamed:@"zhifu_xziocn.png"] forState:UIControlStateNormal];
//    select.layer.cornerRadius=7.5;
//    select.layer.masksToBounds=YES;
    [select setImage:[UIImage imageNamed:@"zhifu_xziocn"] forState:UIControlStateNormal];
    select.imageEdgeInsets=UIEdgeInsetsMake(0, 0,0, 200-15);
   // [select setTitle:@"使用M币抵扣" forState:UIControlStateNormal];
    select.titleLabel.font=[UIFont systemFontOfSize:13.0];
    [select setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    select.titleEdgeInsets=UIEdgeInsetsMake(0,-5,0, 0);
    select.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    self.selectBtn=select;
    [self addSubview:select];
    [select mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@15);
        make.width.mas_equalTo(@200);
        make.left.equalTo(pay);
        make.top.equalTo(line2).offset(10);
    }];
//    UILabel *yuEr=[[UILabel alloc]init];
//    self.accountYuEr=yuEr;
//    yuEr.font=[UIFont systemFontOfSize:13.0];
//    yuEr.textColor=[UIColor grayColor];
//    [self addSubview:yuEr];
//    [yuEr mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(@20);
//        make.width.equalTo(@150);
//        make.left.equalTo(select.mas_right);
//        make.bottom.equalTo(select).offset(2);
//
//    }];
    
    UILabel *accPay=[[UILabel alloc]init];
    self.accountPay=accPay;
    accPay.font=[UIFont systemFontOfSize:13.0];
    accPay.textAlignment=NSTextAlignmentRight;
    accPay.textColor=[UIColor grayColor];
    [self addSubview:accPay];
    [accPay mas_makeConstraints:^(MASConstraintMaker *make) {
    make.width.height.bottom.equalTo(select);
        make.right.equalTo(orderNum);
   
    }];
    
    UILabel *line3=[UILabel new];
    line3.backgroundColor=ViewBackColor;
    [self addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@8);
        make.width.left.equalTo(line);
        make.top.equalTo(accPay.mas_bottom).offset(8);
    }];
  
    
    UILabel *youHui=[[UILabel alloc]init];
    youHui.text=@"优惠:";
    youHui.font=[UIFont systemFontOfSize:13.0];
    youHui.textColor=[UIColor grayColor];
    [self addSubview:youHui];
    [youHui mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.left.equalTo(order);
        make.top.equalTo(line3.mas_bottom).offset(8);
    }];
    
    UIButton *Mselect=[UIButton buttonWithType:UIButtonTypeCustom];
    [Mselect setImage:[UIImage imageNamed:@"zhifu_xziocn.png"] forState:UIControlStateNormal];
    [Mselect setImage:[UIImage imageNamed:@"zhigu_xzicon-01"] forState:UIControlStateSelected];
    Mselect.imageEdgeInsets=UIEdgeInsetsMake(0, 0,0, 120-15);
    [Mselect setTitle:@"使用M币抵扣" forState:UIControlStateNormal];
    Mselect.titleLabel.font=[UIFont systemFontOfSize:13.0];
    [Mselect setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    Mselect.titleEdgeInsets=UIEdgeInsetsMake(0,-30,0, 0);

    self.MselectBtn=Mselect;
    [self addSubview:Mselect];
    [Mselect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@15);
        make.width.equalTo(@120);
        make.left.equalTo(youHui.mas_right);
        make.top.equalTo(line3.mas_bottom).offset(10);
    }];
   UIButton *Lselect=[UIButton buttonWithType:UIButtonTypeCustom];
    [Lselect setImage:[UIImage imageNamed:@"zhifu_xziocn.png"] forState:UIControlStateNormal];
    [Lselect setImage:[UIImage imageNamed:@"zhigu_xzicon-01"] forState:UIControlStateSelected];
    //Lselect.layer.cornerRadius=7.5;
   // Lselect.layer.masksToBounds=YES;
    Lselect.imageEdgeInsets=UIEdgeInsetsMake(0, 0,0, 120-15);
    [Lselect setTitle:@"使用理财本金劵" forState:UIControlStateNormal];
    Lselect.titleLabel.font=[UIFont systemFontOfSize:13.0];
    [Lselect setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    Lselect.titleEdgeInsets=UIEdgeInsetsMake(0,-15,0, 0);
    self.LselectBtn=Lselect;
    [self addSubview:Lselect];
    [Lselect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.top.equalTo(Mselect);
        make.width.equalTo(@120);
        make.left.equalTo(Mselect.mas_right).offset(5);
        
    }];
  
    
    UILabel *useMbi=[[UILabel alloc]init];
    self.useMbinLabel=useMbi;
   // useMbi.backgroundColor=[UIColor whiteColor];
    useMbi.hidden=YES;
    useMbi.font=[UIFont systemFontOfSize:13.0];
    useMbi.textColor=[UIColor grayColor];
    [self addSubview:useMbi];
    [useMbi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.right.equalTo(self);
        make.left.equalTo(self.mas_left).offset(10);
        make.top.equalTo(youHui.mas_bottom).offset(8);
    }];
    
    UILabel *useLiCai=[[UILabel alloc]init];
    self.useLiCaiLabel=useLiCai;
    //useLiCai.backgroundColor=[UIColor whiteColor];
    useLiCai.hidden=YES;
    useLiCai.font=[UIFont systemFontOfSize:13.0];
    useLiCai.textColor=RedButtonColor;
    [self addSubview:useLiCai];
    [useLiCai mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.right.equalTo(self);
        make.left.equalTo(self.mas_left).offset(10);
        make.top.equalTo(youHui.mas_bottom).offset(8);
    }];
    UILabel *TLiCaiJuan=[[UILabel alloc]init];
    self.LiCaiJuanLabel=TLiCaiJuan;
    //TLiCaiJuan.backgroundColor=[UIColor whiteColor];
    TLiCaiJuan.hidden=YES;
    TLiCaiJuan.font=[UIFont systemFontOfSize:13.0];
    TLiCaiJuan.textColor=[UIColor grayColor];
    [self addSubview:TLiCaiJuan];
    [TLiCaiJuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@15);
        make.right.equalTo(self);
        make.left.equalTo(self.mas_left).offset(10);
        make.top.equalTo(useLiCai.mas_bottom).offset(8);
    }];
    
}
@end
