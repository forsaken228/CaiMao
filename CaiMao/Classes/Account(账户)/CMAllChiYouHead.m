//
//  CMAllChiYouHead.m
//  CaiMao
//
//  Created by WangWei on 16/12/1.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMAllChiYouHead.h"

@implementation CMAllChiYouHead
-(instancetype)init{
    self=[super init];
    if(self)  {
        self.backgroundColor=[UIColor whiteColor];
        UILabel *QiCi=[[UILabel alloc]init];
        QiCi.text=@"期次";
        QiCi.font=[UIFont systemFontOfSize:12.0];
        QiCi.textColor=UIColorFromRGB(0x333333);
        QiCi.textAlignment=NSTextAlignmentLeft;
        [self addSubview:QiCi];
        [QiCi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@50);
            make.height.equalTo(@13);
            make.top.equalTo(self.mas_top).offset(8);
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
