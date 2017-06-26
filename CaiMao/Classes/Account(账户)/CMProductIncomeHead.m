//
//  CMProductIncomeHead.m
//  CaiMao
//
//  Created by MAC on 16/10/28.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMProductIncomeHead.h"

@implementation CMProductIncomeHead

-(instancetype)init{
    self=[super init];
    if(self)  {
        self.backgroundColor=[UIColor whiteColor];
        [self addSubview:self.productName];
        [self addSubview:self.productOrderNum];
        [self addSubview:self.productOrderID];
        [self.productName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.width.centerX.equalTo(self);
            make.top.equalTo(self.mas_top).offset(15);
        }];
        [self.productOrderNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.width.equalTo(@150);
            make.top.equalTo(self.productName.mas_bottom).offset(10);
            make.left.equalTo(self.mas_left).offset(20);
        }];
        [self.productOrderID mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.top.width.equalTo(self.productOrderNum);

            make.right.equalTo(self.mas_right).offset(-20);
        }];
        
        UILabel *detail=[[UILabel alloc]init];
       // detail.text=@"说明:收益日在工作日,当天发放收益到您的财猫账户;收益日在周日或者法定节假日,下一个工作日发放收益。";
        self.productExplain=detail;
        detail.numberOfLines=0;
        detail.font=[UIFont systemFontOfSize:12];
        detail.textColor=UIColorFromRGB(0xbbbbbb);
        [self addSubview:detail];
        [detail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
            make.right.equalTo(self.mas_right).offset(-20);
            make.top.equalTo(self.productOrderNum.mas_bottom).offset(10);
            make.left.equalTo(self.mas_left).offset(20);
        }];
        
        UILabel *line=[[UILabel alloc]init];
        line.backgroundColor=ViewBackColor;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@10);
            make.left.width.equalTo(self);
            make.top.equalTo(detail.mas_bottom).offset(10);
            
        }];
        
        UILabel *QiCi=[[UILabel alloc]init];
        QiCi.text=@"期次";
        QiCi.font=[UIFont systemFontOfSize:12.0];
        QiCi.textColor=UIColorFromRGB(0x333333);
        QiCi.textAlignment=NSTextAlignmentLeft;
        [self addSubview:QiCi];
        [QiCi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@50);
            make.height.equalTo(@13);
            make.top.equalTo(line.mas_bottom).offset(10);
            make.left.equalTo(self.mas_left).offset(20);
            
        }];
        UILabel *SYFP=[[UILabel alloc]init];
        SYFP.text=@"收益分配日";
        SYFP.font=[UIFont systemFontOfSize:12.0];
        SYFP.textColor=UIColorFromRGB(0xbbbbbb);
        SYFP.textAlignment=NSTextAlignmentLeft;
        [self addSubview:SYFP];
        [SYFP mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@150);
            make.left.height.equalTo(QiCi);
            make.top.equalTo(QiCi.mas_bottom).offset(5);
            
            
        }];
        
        UILabel *YSBX=[[UILabel alloc]init];
        YSBX.text=@"利息";
        YSBX.font=[UIFont systemFontOfSize:12.0];
        YSBX.textColor=UIColorFromRGB(0x333333);
        YSBX.textAlignment=NSTextAlignmentCenter;
        [self addSubview:YSBX];
        [YSBX mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(SYFP);
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(QiCi);
            
        }];
        
        UILabel *YSBJ=[[UILabel alloc]init];
        YSBJ.text=@"本金";
        YSBJ.font=[UIFont systemFontOfSize:12.0];
        YSBJ.textColor=UIColorFromRGB(0xbbbbbb);
        YSBJ.textAlignment=NSTextAlignmentCenter;
        [self addSubview:YSBJ];
        [YSBJ mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.height.equalTo(YSBX);
            
            make.top.equalTo(SYFP);
            
        }];
        
        
        UILabel *YSLX=[[UILabel alloc]init];
        YSLX.text=@"金额";
        YSLX.font=[UIFont systemFontOfSize:12.0];
        YSLX.textColor=UIColorFromRGB(0x333333);
        YSLX.textAlignment=NSTextAlignmentRight;
        [self addSubview:YSLX];
        [YSLX mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.top.width.equalTo(YSBX);
            
            make.right.equalTo(self.mas_right).offset(-20);
            
        }];
        UILabel *SYBJ=[[UILabel alloc]init];
        SYBJ.text=@"状态";
        SYBJ.font=[UIFont systemFontOfSize:12.0];
        SYBJ.textColor=UIColorFromRGB(0xbbbbbb);
        SYBJ.textAlignment=NSTextAlignmentRight;
        [self addSubview:SYBJ];
        [SYBJ mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.top.width.equalTo(YSBJ);
            make.right.equalTo(YSLX);
            
        }];
        

        
        
    }
    return self;
}
-(UILabel*)productName{
    if (!_productName) {
        _productName=[[UILabel alloc]init];
        _productName.textAlignment=NSTextAlignmentCenter;
        _productName.font=[UIFont systemFontOfSize:15];
        _productName.textColor=UIColorFromRGB(0x595758);
        
    }
    return _productName;
}
-(UILabel*)productOrderNum{
    if (!_productOrderNum) {
        _productOrderNum=[[UILabel alloc]init];
        _productOrderNum.font=[UIFont systemFontOfSize:14];
        _productOrderNum.textColor=UIColorFromRGB(0x8f8e93);
        
    }
    return _productOrderNum;
}
-(UILabel*)productOrderID{
    if (!_productOrderID) {
        _productOrderID=[[UILabel alloc]init];
        _productOrderID.textAlignment=NSTextAlignmentRight;
        _productOrderID.font=[UIFont systemFontOfSize:14];
        _productOrderID.textColor=UIColorFromRGB(0x8f8e93);
        
    }
    return _productOrderID;
}
@end
