//
//  CMMainProductCell.m
//  CaiMao
//
//  Created by WangWei on 2017/6/5.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import "CMMainProductCell.h"

@implementation CMMainProductCell


-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.topTitle];
        [self.topTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.centerY.equalTo(self.mas_centerY).offset(-10);
            make.centerX.equalTo(self.mas_centerX).offset(-25);
            make.width.equalTo(@100);
            
        }];
        
        
        [self addSubview:self.detailTitle];
        [self.detailTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.top.equalTo(self.topTitle.mas_bottom).offset(6);
            make.centerX.equalTo(self.topTitle);
            make.width.equalTo(@140);
            
        }];
        
        
        [self  addSubview:self.headIcon];
        [self.headIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.equalTo(@52);
            make.right.equalTo(self.mas_right).offset(-5);
            make.centerY.equalTo(self);
            
        }];
        
        
        [self addSubview:self.verticalView];
        [self.verticalView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(10);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
            make.right.equalTo(self);
            make.width.equalTo(@0.5);
        }];
        [self addSubview:self.levelView];
        [self.levelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5);
            make.bottom.width.left.equalTo(self);
            
        }];
        
        
    }
    return self;
}

-(UILabel*)topTitle{
    if (!_topTitle) {
        _topTitle=[[UILabel alloc]init];
        
        _topTitle.textAlignment=NSTextAlignmentCenter;
        _topTitle.font=[UIFont systemFontOfSize:14.0];
        _topTitle.textColor=UIColorFromRGB(0x3a3836);
    }
    return _topTitle;
}

-(UILabel*)detailTitle{
    
    if (!_detailTitle) {
        _detailTitle=[[UILabel alloc]init];
        _detailTitle.textAlignment=NSTextAlignmentCenter;
        _detailTitle.font=[UIFont systemFontOfSize:12.0];
        _detailTitle.textColor=UIColorFromRGB(0x7c7c7c);
        
    }
    return _detailTitle;
    
}
-(UIImageView*)headIcon{
    if (!_headIcon) {
        _headIcon=[[UIImageView alloc]init];
    }
    return _headIcon;
}
-(UIView*)levelView{
    if (!_levelView) {
        _levelView=[[UIView alloc]init];
        _levelView.backgroundColor=separateLineColor;
    }
    return _levelView;
}
-(UIView*)verticalView{
    if (!_verticalView) {
        _verticalView=[[UIView alloc]init];
        _verticalView.backgroundColor=separateLineColor;
    }
    return _verticalView;
}

@end
