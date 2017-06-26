//
//  CMBankListCell.m
//  CaiMao
//
//  Created by MAC on 16/6/16.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMBankListCell.h"

@implementation CMBankListCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
     
        [self addSubview:self.BankIcon];
        [self addSubview:self.bankName];
        [self addSubview:self.limit];
        [self.BankIcon  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(25);
            make.width.mas_equalTo(35);
            make.centerY.equalTo(self);
            make.left.equalTo(self.mas_left).offset(5);
        }];
        
        
        [self.bankName  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(15);
            make.width.mas_equalTo(200);
            make.bottom.equalTo(self.BankIcon.mas_centerY).offset(-2);
            make.left.equalTo(self.BankIcon.mas_right);
        }];
        [self.limit  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(15);
            make.width.mas_equalTo(CMScreenW-40);
            make.top.equalTo(self.BankIcon.mas_centerY).offset(2);
            make.left.equalTo(self.bankName);
        }];
        
    }
    return self;
}

-(UIImageView*)BankIcon{
    if (!_BankIcon) {
        _BankIcon=[[UIImageView alloc]init];
    }
    
    return _BankIcon;
}
-(UILabel*)bankName{
    if (!_bankName) {
        _bankName=[[UILabel alloc]init];
        _bankName.font=[UIFont systemFontOfSize:13.0];
    }
    
    return _bankName;
}
-(UILabel*)limit{
    if (!_limit) {
        _limit=[[UILabel alloc]init];
        _limit.font=[UIFont systemFontOfSize:10.0];
    }
    
    return _limit;
}

@end
