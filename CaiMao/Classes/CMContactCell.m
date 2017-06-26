//
//  CMContactCell.m
//  CaiMao
//
//  Created by MAC on 16/10/11.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMContactCell.h"

@implementation CMContactCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubview:self.headIcon];
        [self addSubview:self.phoneName];
        [self addSubview:self.PhoneNum];
        [self addSubview:self.InvatieBtn];
        [self.headIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(9);
            make.centerY.equalTo(self);
            make.height.width.equalTo(@32);
        }];
        [self.phoneName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headIcon.mas_right).offset(9);
            make.bottom.equalTo(self.mas_centerY).offset(-2);
            make.height.equalTo(@15);
            make.width.equalTo(@150);
        }];
        [self.PhoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.phoneName);
            make.top.equalTo(self.mas_centerY).offset(2);
            make.height.equalTo(@12);
            make.width.equalTo(@200);
        }];
        [self.InvatieBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-25);
            make.centerY.equalTo(self);
            make.height.mas_equalTo(51/2.0);
            make.width.mas_equalTo(81/2.0);
        }];
     
        
    }
  //分割线
    UILabel *Vline=[[UILabel alloc]init];
    Vline.backgroundColor=separateLineColor;
    [self addSubview:Vline];
    [Vline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.bottom.width.left.equalTo(self);
    }];
    return self;
}

//头像
-(UIButton *)headIcon{
    if (!_headIcon) {
        _headIcon=[UIButton buttonWithType:UIButtonTypeCustom];
        _headIcon.layer.cornerRadius=32/2.0;
        _headIcon.layer.masksToBounds=YES;
        _headIcon.titleLabel.font=[UIFont systemFontOfSize:20.0];
        [_headIcon setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _headIcon;
}

-(UILabel*)phoneName{
    if (!_phoneName) {
        _phoneName=[[UILabel alloc]init];
        _phoneName.font=[UIFont systemFontOfSize:14.0];
        _phoneName.textColor=UIColorFromRGB(0x333333);
        
    }
    return _phoneName;
}

-(UILabel*)PhoneNum{
    if (!_PhoneNum) {
        _PhoneNum=[[UILabel alloc]init];
        _PhoneNum.font=[UIFont systemFontOfSize:11.0];
        _PhoneNum.textColor=UIColorFromRGB(0x8e8d93);
        
    }
    return _PhoneNum;
}
-(UIButton*)InvatieBtn{
    if (!_InvatieBtn) {
        _InvatieBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_InvatieBtn setBackgroundColor:UIColorFromRGB(0x27ad28)];
        [_InvatieBtn setTitle:@"邀请" forState:UIControlStateNormal];
        [_InvatieBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _InvatieBtn.titleLabel.font=[UIFont systemFontOfSize:12.0];
        _InvatieBtn.clipsToBounds=YES;
        _InvatieBtn.layer.cornerRadius=4.0;
           [_InvatieBtn addTarget:self action:@selector(InvatieBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _InvatieBtn;
}
#pragma mark 邀请代理方法
-(void)InvatieBtnClick{
    if (self.Contanctdelegate) {
        if ([self.Contanctdelegate respondsToSelector:@selector(invationBtnClickWith:)]) {
            [self.Contanctdelegate invationBtnClickWith:self.indexPath];
        }
    }
    
    
}
@end
