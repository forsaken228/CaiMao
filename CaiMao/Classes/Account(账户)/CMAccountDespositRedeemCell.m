//
//  CMAccountDespositRedeemCell.m
//  CaiMao
//
//  Created by WangWei on 17/3/24.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import "CMAccountDespositRedeemCell.h"

@implementation CMAccountDespositRedeemCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.redeemTimeLabel];
        [self addSubview:self.annualProfitLabel];
        [self addSubview:self.JxDateLabel];
        [self addSubview:self.productBZ];
        [self addSubview:self.productSY];
        [self addSubview:self.PLBZ];
        [self addSubview:self.PSHY];

        [self.redeemTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.top.equalTo(self.mas_top);
            make.height.equalTo(@25);
            make.width.equalTo(@150);
        }];
        
        [self.annualProfitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.bottom.equalTo(self.mas_bottom);
            make.height.equalTo(@25);
            make.width.equalTo(@110);
        }];
        [self.JxDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.annualProfitLabel.mas_right);
            make.bottom.equalTo(self.mas_bottom);
            make.height.equalTo(@25);
            make.width.equalTo(@100);
        }];
        
        
        [self.productBZ mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-10);
            make.top.height.equalTo(self.redeemTimeLabel);
            make.width.mas_equalTo(100);
        }];
        [self.productSY mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.height.equalTo(self.productBZ);
            make.bottom.equalTo(self.mas_bottom);
            make.width.mas_equalTo(100);
        }];
        
        [self.PLBZ mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.productBZ.mas_left);
            make.centerY.equalTo(self.productBZ);
            make.height.equalTo(@20);
            make.width.equalTo(@30);
        }];
        [self.PSHY mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.equalTo(self.PLBZ);
            make.centerY.equalTo(self.productSY);
            make.right.equalTo(self.productSY.mas_left);
        }];
        
   
        
        
        
        
    }
    return self;
    
}

-(UILabel*)redeemTimeLabel{
    if (!_redeemTimeLabel) {
        _redeemTimeLabel=[[UILabel alloc]init];
        _redeemTimeLabel.font=[UIFont systemFontOfSize:13.0];
        _redeemTimeLabel.textColor=UIColorFromRGB(0x5a5657);
    }
    return _redeemTimeLabel;
}
-(UILabel*)annualProfitLabel{
    if (!_annualProfitLabel) {
        _annualProfitLabel=[[UILabel alloc]init];
        _annualProfitLabel.font=[UIFont systemFontOfSize:13.0];
        _annualProfitLabel.textColor=RedButtonColor;
    }
    return _annualProfitLabel;
}
-(UILabel*)JxDateLabel{
    if (!_JxDateLabel) {
        _JxDateLabel=[[UILabel alloc]init];
        _JxDateLabel.font=[UIFont systemFontOfSize:13.0];
        _JxDateLabel.textColor=RedButtonColor;
    }
    return _JxDateLabel;
}
-(UILabel*)productBZ{
    if (!_productBZ) {
        _productBZ=[[UILabel alloc]init];
        _productBZ.font=[UIFont systemFontOfSize:13.0];
        _productBZ.textColor=RedButtonColor;
        _productBZ.textAlignment=NSTextAlignmentRight;
    }
    return _productBZ;
}
-(UILabel*)productSY{
    if (!_productSY) {
        _productSY=[[UILabel alloc]init];
        _productSY.font=[UIFont systemFontOfSize:13.0];
        _productSY.textColor=RedButtonColor;
        _productSY.textAlignment=NSTextAlignmentRight;
    }
    return _productSY;
}

-(UILabel*)PLBZ{
    if (!_PLBZ) {
        _PLBZ=[[UILabel alloc]init];
        _PLBZ.font=[UIFont systemFontOfSize:11.0];
        _PLBZ.text=@"本金";
        _PLBZ.layer.borderColor=UIColorFromRGB(0x33ca79).CGColor;
        _PLBZ.layer.borderWidth=0.8;
        _PLBZ.layer.cornerRadius=0.5;
        _PLBZ.layer.masksToBounds=YES;
        _PLBZ.textColor=UIColorFromRGB(0x33ca79);
        _PLBZ.textAlignment=NSTextAlignmentCenter;
        
    }
    return _PLBZ;
}
-(UILabel*)PSHY{
    if (!_PSHY) {
        _PSHY=[[UILabel alloc]init];
        _PSHY.font=[UIFont systemFontOfSize:11.0];
        _PSHY.text=@"收益";
        _PSHY.layer.borderColor=UIColorFromRGB(0xfaaf3c).CGColor;
        _PSHY.layer.borderWidth=0.8;
        _PSHY.layer.cornerRadius=0.5;
        _PSHY.layer.masksToBounds=YES;
        _PSHY.textColor=UIColorFromRGB(0xfaaf3c);
        _PSHY.textAlignment=NSTextAlignmentCenter;
        
    }
    return _PSHY;
}
@end
