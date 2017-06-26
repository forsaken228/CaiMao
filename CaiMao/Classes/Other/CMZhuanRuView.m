//
//  CMZhuanRuView.m
//  CaiMao
//
//  Created by MAC on 16/11/9.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMZhuanRuView.h"

@implementation CMZhuanRuView

-(instancetype)init{
    
    self=[super init];
    if (self) {
        
        UIView *TopBg=[[UIView alloc]init];
        TopBg.backgroundColor=[UIColor whiteColor];
        [self  addSubview:TopBg];
        [TopBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(66);
            make.right.left.top.equalTo(self);
        }];
        UILabel *jin=[[UILabel alloc]init];
        jin.textColor=UIColorFromRGB(0x4d4d4d);
        jin.textAlignment=NSTextAlignmentCenter;
        jin.font=[UIFont systemFontOfSize:20];
        jin.text=@"金额";
        [TopBg addSubview:jin];
        [jin  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(TopBg.mas_left).offset(20);
            make.centerY.equalTo(TopBg);
            make.height.equalTo(@20);
            make.width.equalTo(@50);
           
        }];
        
        [TopBg addSubview:self.ZhanRuAmountField];
        [self.ZhanRuAmountField  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(TopBg);
            make.height.equalTo(jin);
            make.width.equalTo(@150);
            make.left.equalTo(jin.mas_right);
        }];
        
       self.ZhuangRuFangshi=[[UILabel alloc]init];
        self.ZhuangRuFangshi.textColor=UIColorFromRGB(0x8e8d93);
        self.ZhuangRuFangshi.font=[UIFont systemFontOfSize:13];
        self.ZhuangRuFangshi.text=@"选择转入方式";
        [self addSubview:self.ZhuangRuFangshi];
        [self.ZhuangRuFangshi  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(20);
            make.top.equalTo(TopBg.mas_bottom).offset(10);
            make.height.equalTo(@14);
            make.width.equalTo(@100);
            
        }];
#pragma mark  账户余额
//        [self addSubview:self.YuErBg];
//        [self.YuErBg  mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(@48);
//            make.top.equalTo(self.ZhuangRuFangshi.mas_bottom).offset(10);
//            make.width.left.equalTo(self);
//        }];
//        
//        [self.YuErBg  addSubview:self.BalanceAmountBtn];
//        [self.BalanceAmountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(@20);
//            make.left.equalTo(self.YuErBg.mas_left).offset(20);
//            make.centerY.equalTo(self.YuErBg);
//            make.width.equalTo(@150);
//        }];
//        
//        [self.YuErBg  addSubview:self.ZhanRuAmountLabel];
//        [self.ZhanRuAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(@20);
//            make.right.equalTo(self.YuErBg.mas_right).offset(-10);
//            make.centerY.equalTo(self.YuErBg);
//            make.width.equalTo(@150);
//        }];
//        UILabel *line=[[UILabel alloc]init];
//        line.backgroundColor=separateLineColor;
//        [self.YuErBg addSubview:line];
//        [line  mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.width.left.equalTo(self.YuErBg);
//            make.height.equalTo(@0.5);
//        }];
//        
//        
//#pragma mark 银行卡
//        
//        [self addSubview:self.BankBgView];
//        [self.BankBgView  mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(@48);
//            make.top.equalTo(self.YuErBg.mas_bottom);
//            make.width.left.equalTo(self);
//        }];
//        [self.BankBgView addSubview:self.bankNameLabel];
//        [self.bankNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(@20);
//            make.left.equalTo(self.BankBgView.mas_left).offset(20);
//            make.centerY.equalTo(self.BankBgView);
//            make.width.equalTo(@100);
//        }];
//        [self.BankBgView  addSubview:self.XianEDetailBtn];
//        [self.XianEDetailBtn   mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(@16);
//            make.width.equalTo(@80);
//            make.centerY.equalTo(self.BankBgView);
//            make.left.equalTo(self.bankNameLabel.mas_right).offset(2);
//        }];
//        
//        [self.BankBgView  addSubview:self.BankZhanRuAmountLabel];
//        [self.BankZhanRuAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(@20);
//            make.right.equalTo(self.BankBgView.mas_right).offset(-10);
//            make.centerY.equalTo(self.BankBgView);
//            make.width.equalTo(@150);
//        }];
        
//        [self addSubview:self.ZhuangRuBtn];
//        [self.ZhuangRuBtn  mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(@30);
//            make.left.equalTo(self.mas_left).offset(15);
//            make.right.equalTo(self.mas_right).offset(-15);
//            make.top.equalTo(self.BankBgView.mas_bottom).offset(20);
//        }];
        
        
    }
    
    return self;
}
-(UITextField*)ZhanRuAmountField{
    if(!_ZhanRuAmountField){
        
        _ZhanRuAmountField=[[UITextField alloc]init];
        _ZhanRuAmountField.textColor=UIColorFromRGB(0xb3b3b3);
        _ZhanRuAmountField.textAlignment=NSTextAlignmentCenter;
        _ZhanRuAmountField.font=[UIFont systemFontOfSize:13.0];
        _ZhanRuAmountField.keyboardType=UIKeyboardTypeNumberPad;
        _ZhanRuAmountField.placeholder=@"建议转入1元以上金额";
    }
    
    return _ZhanRuAmountField;
    
}
//-(UIView*)YuErBg{
//    if (!_YuErBg) {
//        _YuErBg=[[UIView alloc]init];
//        _YuErBg.backgroundColor=[UIColor whiteColor];
//        
//    }
//    return _YuErBg;
//    
//}
//-(UIView*)BankBgView{
//    if (!_BankBgView) {
//        _BankBgView=[[UIView alloc]init];
//        _BankBgView.backgroundColor=[UIColor whiteColor];
//        
//    }
//    return _BankBgView;
//    
//}
//-(CMCustomYuEButton*)BalanceAmountBtn{
//    if (!_BalanceAmountBtn) {
//        _BalanceAmountBtn=[[CMCustomYuEButton alloc]init];
//        _BalanceAmountBtn.LeftimageView.image=[UIImage imageNamed:@"zhifu_xziocn.png"];
//
//    }
//    
//    return _BalanceAmountBtn;
//}
//
//-(UILabel*)ZhanRuAmountLabel{
//    
//    if (!_ZhanRuAmountLabel) {
//        _ZhanRuAmountLabel=[[UILabel alloc]init];
//        _ZhanRuAmountLabel.font=[UIFont systemFontOfSize:13.0];
//        _ZhanRuAmountLabel.textAlignment=NSTextAlignmentRight;
//        _ZhanRuAmountLabel.textColor=UIColorFromRGB(0x4d4d4d);
//    }
//    return _ZhanRuAmountLabel;
//}
//
//
//-(UILabel*)bankNameLabel{
//    
//    if (!_bankNameLabel) {
//        _bankNameLabel=[[UILabel alloc]init];
//        _bankNameLabel.font=[UIFont systemFontOfSize:13.0];
//        _bankNameLabel.textColor=UIColorFromRGB(0x4d4d4d);
//    }
//    return _bankNameLabel;
//}
//
//-(UIButton*)XianEDetailBtn{
//    if (!_XianEDetailBtn) {
//        _XianEDetailBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//        [_XianEDetailBtn  setImage:[UIImage imageNamed:@"detail_pressed"] forState:UIControlStateNormal];
//        
//        _XianEDetailBtn.imageEdgeInsets=UIEdgeInsetsMake(0, 0,0, 80-16);
//        [_XianEDetailBtn setTitle:@"限额说明" forState:UIControlStateNormal];
//        _XianEDetailBtn.titleLabel.font=[UIFont systemFontOfSize:12.0];
//        [_XianEDetailBtn setTitleColor:UIColorFromRGB(0x1b84ef) forState:UIControlStateNormal];
//        _XianEDetailBtn.titleEdgeInsets=UIEdgeInsetsMake(0,-15,0, 0);
//  
//    }
//    return _XianEDetailBtn;
//}
//
//-(UILabel*)BankZhanRuAmountLabel{
//    
//    if (!_BankZhanRuAmountLabel) {
//        _BankZhanRuAmountLabel=[[UILabel alloc]init];
//        _BankZhanRuAmountLabel.font=[UIFont systemFontOfSize:13.0];
//        _BankZhanRuAmountLabel.textColor=UIColorFromRGB(0x4d4d4d);
//        _BankZhanRuAmountLabel.textAlignment=NSTextAlignmentRight;
//    }
//    return _BankZhanRuAmountLabel;
//}
//
//-(UIButton*)ZhuangRuBtn{
//    if (!_ZhuangRuBtn) {
//        _ZhuangRuBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//        [_ZhuangRuBtn setTitle:@"转入" forState:UIControlStateNormal];
//        _ZhuangRuBtn.titleLabel.font=[UIFont systemFontOfSize:12.0];
//        [_ZhuangRuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [_ZhuangRuBtn setBackgroundColor:RedButtonColor];
//        _ZhuangRuBtn.layer.cornerRadius=5.0;
//        _ZhuangRuBtn.layer.masksToBounds=YES;
//    }
//    return _ZhuangRuBtn;
//}
@end
