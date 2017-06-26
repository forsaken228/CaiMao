//
//  CMZhuanChuConfirmHeadView.m
//  CaiMao
//
//  Created by MAC on 16/11/11.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMZhuanChuConfirmHeadView.h"

@implementation CMZhuanChuConfirmHeadView

-(instancetype)init{
    self=[super init];
    
    if (self) {
        
        CMTopBgView *top=[[CMTopBgView alloc]initWithImage:@"转出确认"];
        top.frame=CGRectMake(0, 10, CMScreenW, 30);
        [self addSubview:top];
        
        UIView *bgView=[[UIView alloc]init];
        bgView.backgroundColor=[UIColor whiteColor];
        [self addSubview:bgView];
        [bgView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@82);
            make.width.left.equalTo(self);
            make.top.equalTo(top.mas_bottom).offset(10);
        }];
  
        UILabel  *one=[[UILabel alloc]init];
        one.text=@"转出金额";
        one.textColor=UIColorFromRGB(0x4d4d4d);
        one.font=[UIFont systemFontOfSize:13];
        [bgView addSubview:one];
        [one  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
            make.width.equalTo(@100);
            make.left.equalTo(self.mas_left).offset(15);
            make.top.equalTo(bgView);
        }];
        UILabel *line=[[UILabel alloc]init];
        line.backgroundColor=separateLineColor;
        [bgView addSubview:line];
        
        [line  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
           
            make.left.width.equalTo(self);
            make.top.equalTo(one.mas_bottom);
        }];
        UILabel  *Two=[[UILabel alloc]init];
        Two.text=@"总收益";
        Two.textColor=UIColorFromRGB(0x4d4d4d);
        Two.font=[UIFont systemFontOfSize:13];
        [bgView addSubview:Two];
        [Two  mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.width.height.equalTo(one);
            
            make.top.equalTo(line.mas_bottom);
        }];
        [self addSubview:self.ZhuanJinEr];
        [self addSubview:self.ShouYi];
        [self.ZhuanJinEr  mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.height.equalTo(one);
            make.width.equalTo(@150);
            make.right.equalTo(self.mas_right).offset(-15);
            
        }];
        
        [self.ShouYi  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.equalTo(Two);
            make.width.equalTo(@150);
            make.right.equalTo(self.mas_right).offset(-15);
            
        }];
        
    
    }
    
    return self;
   
}
-(UILabel *)ZhuanJinEr{
    if (!_ZhuanJinEr) {
        _ZhuanJinEr=[[UILabel alloc]init];
        _ZhuanJinEr.textColor=RedButtonColor;
        _ZhuanJinEr.font=[UIFont systemFontOfSize:13.0];
        _ZhuanJinEr.textAlignment=NSTextAlignmentRight;
        
    }
    return _ZhuanJinEr;
    
}

-(UILabel *)ShouYi{
    if (!_ShouYi) {
        _ShouYi=[[UILabel alloc]init];
        _ShouYi.textColor=RedButtonColor;
        _ShouYi.font=[UIFont systemFontOfSize:13.0];
        _ShouYi.textAlignment=NSTextAlignmentRight;
        
    }
    return _ShouYi;
    
}
@end
