//
//  CMCFBZhuangRuTwoCell.m
//  CaiMao
//
//  Created by MAC on 16/11/9.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMCFBZhuangRuTwoCell.h"

@implementation CMCFBZhuangRuTwoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self addSubview:self.bankNameLabel];
        [self.bankNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.left.equalTo(self.mas_left).offset(20);
            make.centerY.equalTo(self);
            make.width.mas_equalTo(120);
        }];
        [self  addSubview:self.XianEDetailBtn];
        [self.XianEDetailBtn   mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@16);
            make.width.equalTo(@80);
            make.centerY.equalTo(self);
            make.left.equalTo(self.bankNameLabel.mas_right).offset(2);
        }];
        
        [self  addSubview:self.BankZhanRuAmountLabel];
        [self.BankZhanRuAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.right.equalTo(self.mas_right).offset(-10);
            make.centerY.equalTo(self);
            make.width.equalTo(@150);
        }];
        
       
    }
    
    return self;
    
}

-(UILabel*)bankNameLabel{
    
    if (!_bankNameLabel) {
        _bankNameLabel=[[UILabel alloc]init];
        _bankNameLabel.font=[UIFont systemFontOfSize:13.0];
        _bankNameLabel.textColor=UIColorFromRGB(0x4d4d4d);
        _bankNameLabel.text=@"银行卡支付";
    }
    return _bankNameLabel;
}

-(UIButton*)XianEDetailBtn{
    if (!_XianEDetailBtn) {
        _XianEDetailBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_XianEDetailBtn  setImage:[UIImage imageNamed:@"detail_pressed"] forState:UIControlStateNormal];
        
        _XianEDetailBtn.imageEdgeInsets=UIEdgeInsetsMake(0, 0,0, 80-16);
        [_XianEDetailBtn setTitle:@"限额说明" forState:UIControlStateNormal];
        _XianEDetailBtn.titleLabel.font=[UIFont systemFontOfSize:12.0];
        [_XianEDetailBtn setTitleColor:UIColorFromRGB(0x1b84ef) forState:UIControlStateNormal];
        _XianEDetailBtn.titleEdgeInsets=UIEdgeInsetsMake(0,-15,0, 0);
        
    }
    return _XianEDetailBtn;
}

-(UILabel*)BankZhanRuAmountLabel{
    
    if (!_BankZhanRuAmountLabel) {
        _BankZhanRuAmountLabel=[[UILabel alloc]init];
        _BankZhanRuAmountLabel.font=[UIFont systemFontOfSize:13.0];
        _BankZhanRuAmountLabel.textColor=UIColorFromRGB(0x4d4d4d);
        _BankZhanRuAmountLabel.textAlignment=NSTextAlignmentRight;
        _BankZhanRuAmountLabel.userInteractionEnabled=YES;
    }
    return _BankZhanRuAmountLabel;
}
@end
