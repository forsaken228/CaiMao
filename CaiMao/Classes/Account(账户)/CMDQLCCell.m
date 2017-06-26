//
//  CMDQLCCell.m
//  CaiMao
//
//  Created by MAC on 16/10/27.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMDQLCCell.h"

@implementation CMDQLCCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.productTitle];
        [self addSubview:self.productId];
        [self addSubview:self.productTime];
        [self addSubview:self.productBZ];
        [self addSubview:self.productSY];
        [self addSubview:self.PLBZ];
        [self addSubview:self.PSHY];
        [self addSubview:self.productState];
        [self.productTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.top.equalTo(self.mas_top).offset(20);
            make.height.equalTo(@14);
            make.width.equalTo(@100);
        }];
       
        [self.productId mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.productTitle.mas_right).offset(2);
            make.top.height.equalTo(self.productTitle);
            make.width.equalTo(@120);
            
        }];
        [self.productBZ mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-10);
            make.top.height.equalTo(self.productTitle);
            make.width.mas_equalTo(100);
        }];
        [self.productSY mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.height.equalTo(self.productBZ);
            make.top.equalTo(self.productBZ.mas_bottom).offset(10);
          make.width.mas_equalTo(100);
        }];
        [self.productState mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-10);
            make.top.equalTo(self.productBZ.mas_bottom).offset(10);
            make.height.equalTo(@14);
            make.width.equalTo(@200);
        }];
        [self.PLBZ mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.productBZ.mas_left);
            make.height.top.equalTo(self.productBZ);
            make.width.equalTo(@30);
        }];
        [self.PSHY mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.equalTo(self.PLBZ);
            make.top.equalTo(self.productSY);
              make.right.equalTo(self.productSY.mas_left);
        }];
        
        [self.productTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.top.equalTo(self.productTitle.mas_bottom).offset(10);
            make.height.equalTo(@14);
            make.width.equalTo(@200);
        }];
        
    }
    return self;
    
}

-(UILabel*)productTitle{
    if (!_productTitle) {
        _productTitle=[[UILabel alloc]init];
        _productTitle.font=[UIFont systemFontOfSize:13.0];
        _productTitle.textColor=UIColorFromRGB(0x5a5657);
    }
    return _productTitle;
}
-(UILabel*)productId{
    if (!_productId) {
        _productId=[[UILabel alloc]init];
        _productId.font=[UIFont systemFontOfSize:13.0];
        _productId.textColor=UIColorFromRGB(0x8e8d93);
    }
    return _productId;
}
-(UILabel*)productTime{
    if (!_productTime) {
        _productTime=[[UILabel alloc]init];
        _productTime.font=[UIFont systemFontOfSize:13.0];
        _productTime.textColor=UIColorFromRGB(0xbbbbbb);
    }
    return _productTime;
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
-(UIButton*)productState{
    if (!_productState) {
        _productState=[UIButton buttonWithType:UIButtonTypeSystem];
        _productState.titleLabel.font=[UIFont systemFontOfSize:13.0];
        [_productState setTitleColor:UIColorFromRGB(0x0e94ee) forState:UIControlStateNormal];
        _productState.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
       
    }
    return _productState;
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
