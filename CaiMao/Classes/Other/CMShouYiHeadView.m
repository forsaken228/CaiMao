//
//  CMShouYiHeadView.m
//  CaiMao
//
//  Created by MAC on 16/8/9.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMShouYiHeadView.h"

@implementation CMShouYiHeadView


-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        UILabel *jiXi=[[UILabel alloc]init];
        self.JiXiDate=jiXi;
        jiXi.font=[UIFont systemFontOfSize:12.0];
        jiXi.textColor=UIColorFromRGB(0x999999);
        [self addSubview:jiXi];
        [jiXi mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.height.equalTo(@20);
            make.top.equalTo(self.mas_top).offset(10);
            make.left.equalTo(self.mas_left).offset(10);
            make.width.equalTo(@250);
        }];
        UILabel *unit=[[UILabel alloc]init];
        unit.text=@"单位(元)";
        unit.font=[UIFont systemFontOfSize:12.0];
        unit.textColor=UIColorFromRGB(0x999999);
        unit.textAlignment=NSTextAlignmentRight;
        [self addSubview:unit];
        [unit mas_makeConstraints:^(MASConstraintMaker *make) {
             make.width.equalTo(@50);
            make.height.top.equalTo(jiXi);
            make.right.equalTo(self.mas_right).offset(-10);
            
        }];
        UILabel *line=[[UILabel alloc]init];
        line.backgroundColor=separateLineColor;
        [self addSubview:line];
        [line mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
            make.top.equalTo(jiXi.mas_bottom).offset(5);
            make.left.width.equalTo(self);
        }];;
        
        UILabel *QiCi=[[UILabel alloc]init];
        QiCi.text=@"期次";
        QiCi.font=[UIFont systemFontOfSize:12.0];
        QiCi.textColor=UIColorFromRGB(0x3a3836);
        QiCi.textAlignment=NSTextAlignmentLeft;
        [self addSubview:QiCi];
        [QiCi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@50);
            make.height.equalTo(jiXi);
            make.top.equalTo(jiXi.mas_bottom).offset(10);
            make.left.equalTo(self.mas_left).offset(10);
            
        }];
        UILabel *SYFP=[[UILabel alloc]init];
        SYFP.text=@"收益分配日";
        SYFP.font=[UIFont systemFontOfSize:12.0];
        SYFP.textColor=UIColorFromRGB(0x999999);
        SYFP.textAlignment=NSTextAlignmentLeft;
        [self addSubview:SYFP];
        [SYFP mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@150);
            make.left.height.equalTo(QiCi);
            make.top.equalTo(QiCi.mas_bottom);
            
            
        }];
        
        UILabel *YSBX=[[UILabel alloc]init];
        YSBX.text=@"应收本息";
        YSBX.font=[UIFont systemFontOfSize:12.0];
        YSBX.textColor=UIColorFromRGB(0x3a3836);
        YSBX.textAlignment=NSTextAlignmentCenter;
        [self addSubview:YSBX];
        [YSBX mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(SYFP);
            make.centerX.equalTo(self.mas_centerX);
             make.top.equalTo(QiCi);
            
        }];
        
        UILabel *YSBJ=[[UILabel alloc]init];
        YSBJ.text=@"应收本金";
        YSBJ.font=[UIFont systemFontOfSize:12.0];
        YSBJ.textColor=UIColorFromRGB(0x999999);
        YSBJ.textAlignment=NSTextAlignmentCenter;
        [self addSubview:YSBJ];
        [YSBJ mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.height.equalTo(YSBX);
           
            make.top.equalTo(SYFP);
            
        }];
        
        
        UILabel *YSLX=[[UILabel alloc]init];
        YSLX.text=@"应收利息";
        YSLX.font=[UIFont systemFontOfSize:12.0];
        YSLX.textColor=UIColorFromRGB(0x3a3836);
        YSLX.textAlignment=NSTextAlignmentRight;
        [self addSubview:YSLX];
        [YSLX mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.top.width.equalTo(YSBX);
         
            make.right.equalTo(self.mas_right).offset(-10);
            
        }];
        UILabel *SYBJ=[[UILabel alloc]init];
        SYBJ.text=@"剩余本金";
        SYBJ.font=[UIFont systemFontOfSize:12.0];
        SYBJ.textColor=UIColorFromRGB(0x999999);
        SYBJ.textAlignment=NSTextAlignmentRight;
        [self addSubview:SYBJ];
        [SYBJ mas_makeConstraints:^(MASConstraintMaker *make) {
             make.width.top.width.equalTo(YSBJ);
            make.right.equalTo(YSLX);
            
        }];
   
        UILabel *Vline=[[UILabel alloc]init];
        Vline.backgroundColor=ViewBackColor;
        [self addSubview:Vline];
        [Vline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@10);
            make.bottom.width.left.equalTo(self);
        }];
        
    }
    return self;
}
@end
