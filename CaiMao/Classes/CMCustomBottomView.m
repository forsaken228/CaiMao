//
//  CMCustomBottomView.m
//  CaiMao
//
//  Created by MAC on 16/10/26.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMCustomBottomView.h"

@implementation CMCustomBottomView

-(instancetype)init{
    self=[super init];
    if (self) {

        [self addSubview:self.topImageView];
        [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self.mas_centerY).offset(-8);
            make.height.mas_equalTo(f_i5real(20));
             make.width.mas_equalTo(f_i5real(24));
        }];
        [self addSubview:self.midLaebel];
        [self.midLaebel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.left.equalTo(self);
            make.top.equalTo(self.mas_centerY);
            make.height.equalTo(@15);
            
        }];
        
        [self addSubview:self.bottomLabel];
        [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.left.equalTo(self);
            make.top.equalTo(self.midLaebel.mas_bottom).offset(2);
            make.height.equalTo(@11);
            
        }];
        [self addSubview:self.bottomLabel1];
        [self.bottomLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.left.equalTo(self);
            make.top.equalTo(self.bottomLabel.mas_bottom);
            make.height.equalTo(@11);
            
        }];
        
               [self addSubview:self.VerLine];
        [self.VerLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(10);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
            make.right.equalTo(self.mas_right).offset(-1);
            make.width.equalTo(@0.5);
        }];
        
    
    }
    return self;
}
-(UIImageView*)topImageView{
    if (!_topImageView) {
        _topImageView=[[UIImageView alloc]init];
    }
    return _topImageView;
}
-(UILabel*)midLaebel{
    if (!_midLaebel) {
        _midLaebel=[[UILabel alloc]init];
        _midLaebel.textAlignment=NSTextAlignmentCenter;
        _midLaebel.font=[UIFont systemFontOfSize:12.0];
        _midLaebel.textColor=UIColorFromRGB(0x333333);
    }
    return _midLaebel;
}
-(UILabel*)bottomLabel{
    if (!_bottomLabel) {
        _bottomLabel=[[UILabel alloc]init];
        _bottomLabel.textAlignment=NSTextAlignmentCenter;
        _bottomLabel.font=[UIFont systemFontOfSize:10.0];
        _bottomLabel.textColor=UIColorFromRGB(0x8e8e93);
    }
    return _bottomLabel;
}
-(UILabel*)bottomLabel1{
    if (!_bottomLabel1) {
        _bottomLabel1=[[UILabel alloc]init];
        _bottomLabel1.textAlignment=NSTextAlignmentCenter;
        _bottomLabel1.font=[UIFont systemFontOfSize:10.0];
        _bottomLabel1.textColor=UIColorFromRGB(0x8e8e93);
    }
    return _bottomLabel1;
}

-(UIView*)VerLine{
    if (!_VerLine) {
        _VerLine=[[UIView alloc]init];
        _VerLine.backgroundColor=separateLineColor;

    }
    return _VerLine;
}
@end
