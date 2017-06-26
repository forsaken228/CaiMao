//
//  CMZhuanChuFootView.m
//  CaiMao
//
//  Created by MAC on 16/11/10.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMZhuanChuFootView.h"

@implementation CMZhuanChuFootView

-(instancetype)initWithButtonTitle:(NSString*)title{
    self=[super init];
    if (self) {
        self.backgroundColor=ViewBackColor;
        [self.ZhuangChuBtn setTitle:title forState:UIControlStateNormal];
        [self addSubview:self.ZhuangChuBtn];
        [self.ZhuangChuBtn  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(buttonHeight);
            make.left.equalTo(self.mas_left).offset(15);
            make.right.equalTo(self.mas_right).offset(-15);
            make.top.equalTo(self.mas_top).offset(20);
        }];
        
        
        [self addSubview:self.DetailLabel];
        [self.DetailLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@30);
            make.left.equalTo(self.mas_left).offset(15);
            make.right.equalTo(self.mas_right).offset(-15);
            make.top.equalTo(self.ZhuangChuBtn.mas_bottom).offset(10);
        }];
        
        
        
    }
    
    return self;
    
}

-(UIButton*)ZhuangChuBtn{
    if (!_ZhuangChuBtn) {
        _ZhuangChuBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _ZhuangChuBtn.titleLabel.font=[UIFont systemFontOfSize:12.0];
        [_ZhuangChuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_ZhuangChuBtn setBackgroundColor:RedButtonColor];
        _ZhuangChuBtn.layer.cornerRadius=5.0;
        _ZhuangChuBtn.layer.masksToBounds=YES;
    }
    return _ZhuangChuBtn;
}
-(UILabel*)DetailLabel{
    if (!_DetailLabel) {
        _DetailLabel=[[UILabel alloc]init];
        _DetailLabel.textAlignment=NSTextAlignmentCenter;
        _DetailLabel.font=[UIFont systemFontOfSize:10.0];
        _DetailLabel.text=@"转出金额不能低于100元(财富宝余额不足100元时,须一次性转出)";
        _DetailLabel.textColor=UIColorFromRGB(0x8e8d93);
    }
    return _DetailLabel;
    
}

@end
