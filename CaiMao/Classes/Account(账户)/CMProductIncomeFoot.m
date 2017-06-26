//
//  CMProductIncomeFoot.m
//  CaiMao
//
//  Created by MAC on 16/10/28.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMProductIncomeFoot.h"

@implementation CMProductIncomeFoot

-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
       
        UILabel *total=[[UILabel alloc]init];
        total.text=@"合计:";
        total.font=[UIFont systemFontOfSize:13.0];
        total.textColor=UIColorFromRGB(0x333333);
        [self addSubview:total];
        [total mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@60);
            make.height.equalTo(@15);
            make.top.equalTo(self.mas_top).offset(8);
            make.left.equalTo(self.mas_left).offset(20);
            
        }];
        UILabel *YSBX=[[UILabel alloc]init];
        YSBX.text=@"本金";
        YSBX.font=[UIFont systemFontOfSize:13.0];
        YSBX.textColor=UIColorFromRGB(0x333333);
        YSBX.textAlignment=NSTextAlignmentLeft;
        [self addSubview:YSBX];
        [YSBX mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.left.equalTo(total);
            make.top.equalTo(total.mas_bottom).offset(2);
            
            
        }];
        
        UILabel *YSBJ=[[UILabel alloc]init];
        YSBJ.text=@"利息";
        YSBJ.font=[UIFont systemFontOfSize:13.0];
        YSBJ.textColor=UIColorFromRGB(0x333333);
        YSBJ.textAlignment=NSTextAlignmentCenter;
        [self addSubview:YSBJ];
        [YSBJ mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.width.height.equalTo(YSBX);
            make.centerX.equalTo(self);
        }];
        
        
        UILabel *YSLX=[[UILabel alloc]init];
        YSLX.text=@"金额";
        YSLX.font=[UIFont systemFontOfSize:13.0];
        YSLX.textColor=UIColorFromRGB(0x333333);
        YSLX.textAlignment=NSTextAlignmentRight;
        [self addSubview:YSLX];
        [YSLX mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.top.height.equalTo(YSBX);
            make.right.equalTo(self.mas_right).offset(-20);
            
        }];
        [self addSubview:self.BJin];
        [self addSubview:self.LXi];
        [self addSubview:self.TotalIncome];
        [self.BJin mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.left.equalTo(total);
            make.width.equalTo(@150);
            make.top.equalTo(YSBX.mas_bottom).offset(5);
        }];
        [self.LXi mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.width.top.equalTo(self.BJin);
           
            make.centerX.equalTo(self);
        }];
        [self.TotalIncome mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.width.top.equalTo(self.BJin);
            
            make.right.equalTo(YSLX);
        }];
//        UIView *bottomView=[UIView new];
//        bottomView.frame=CGRectMake(0, 70, CMScreenW, 100);
//        [self addSubview:bottomView];

        
        
    }
    return self;
}
-(UILabel*)BJin{
    if (!_BJin) {
        _BJin=[[UILabel alloc]init];
        _BJin.font=[UIFont systemFontOfSize:13.0];
        _BJin.textColor=RedButtonColor;
    }
    return _BJin;
}

-(UILabel*)LXi{
    if (!_LXi) {
        _LXi=[[UILabel alloc]init];
        _LXi.font=[UIFont systemFontOfSize:13.0];
        _LXi.textAlignment=NSTextAlignmentCenter;
        _LXi.textColor=RedButtonColor;
    }
    return _LXi;
}
-(UILabel*)TotalIncome{
    if (!_TotalIncome) {
        _TotalIncome=[[UILabel alloc]init];
        _TotalIncome.font=[UIFont systemFontOfSize:13.0];
        _TotalIncome.textAlignment=NSTextAlignmentRight;
        _TotalIncome.textColor=RedButtonColor;
    }
    return _TotalIncome;
}
@end
