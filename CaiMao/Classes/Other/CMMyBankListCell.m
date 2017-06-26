//
//  CMMyBankListCell.m
//  CaiMao
//
//  Created by MAC on 16/10/24.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMMyBankListCell.h"

@implementation CMMyBankListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.bankIcon];
        [self.bankIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
            make.width.equalTo(@52);
            make.centerY.equalTo(self.mas_centerY).offset(-10);
            make.left.equalTo(self.mas_left).offset(8);
        }];
        
        [self addSubview:self.bankName];
        [self.bankName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.width.equalTo(@60);
            make.bottom.equalTo(self.bankIcon.mas_centerY).offset(-2);
            make.left.equalTo(self.bankIcon.mas_right);
        }];
        [self addSubview:self.RenZhengIcon];
        [self.RenZhengIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.width.equalTo(@30);
            make.bottom.equalTo(self.bankName);
            make.left.equalTo(self.bankName.mas_right);
        }];
        [self addSubview:self.bankNum];
        [self.bankNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.width.equalTo(@150);
            make.top.equalTo(self.bankIcon.mas_centerY).offset(4);
            make.left.equalTo(self.bankName);
        }];
        [self addSubview:self.TiXianCount];
        [self.TiXianCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.width.equalTo(@150);
            make.top.equalTo(self.bankName);
            make.right.equalTo(self.mas_right).offset(-10);
        }];
        [self addSubview:self.BDTime];
        [self.BDTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.width.equalTo(@150);
            make.top.equalTo(self.bankNum);
            make.right.equalTo(self.TiXianCount);
        }];
        UILabel *label=[UILabel new];
        label.backgroundColor=ViewBackColor;
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@10);
            make.width.mas_equalTo(CMScreenW);
            make.left.bottom.equalTo(self);
        }];
        
        
        
    }
    return self;
}
#pragma mark lazy
-(UIImageView*)bankIcon{
    if (!_bankIcon) {
        _bankIcon=[[UIImageView alloc]init];
        
    }
    return _bankIcon;
}
-(UILabel*)bankName{
    if (!_bankName) {
        _bankName=[[UILabel alloc]init];
        _bankName.font=[UIFont systemFontOfSize:14.0];
        _bankName.textColor=UIColorFromRGB(0x333333);
        
        
    }
    return _bankName;
    
}
-(UILabel*)bankNum{
    if (!_bankNum) {
        _bankNum=[[UILabel alloc]init];
        _bankNum.font=[UIFont systemFontOfSize:12.0];
        _bankNum.textColor=UIColorFromRGB(0x8e8e93);
        
        
    }
    return _bankNum;
    
}
-(UIImageView*)RenZhengIcon{
    if (!_RenZhengIcon) {
        _RenZhengIcon=[[UIImageView alloc]init];
        _RenZhengIcon.image=[UIImage imageNamed:@"tixian_renzheng_icon"];
        _RenZhengIcon.hidden=YES;
    }
    return _RenZhengIcon;
}
-(UILabel*)TiXianCount{
    if (!_TiXianCount) {
        _TiXianCount=[[UILabel alloc]init];
        _TiXianCount.font=[UIFont systemFontOfSize:14.0];
        _TiXianCount.textColor=UIColorFromRGB(0x333333);
        _TiXianCount.textAlignment=NSTextAlignmentRight;
    
    }
    return _TiXianCount;
    
}
-(UILabel*)BDTime{
    if (!_BDTime) {
        _BDTime=[[UILabel alloc]init];
        _BDTime.font=[UIFont systemFontOfSize:12.0];
        _BDTime.textColor=UIColorFromRGB(0x8e8e93);
        _BDTime.textAlignment=NSTextAlignmentRight;
        
    }
    return _BDTime;
    
}
@end
