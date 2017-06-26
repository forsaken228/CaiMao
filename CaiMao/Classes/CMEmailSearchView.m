//
//  CMEmailSearchView.m
//  CaiMao
//
//  Created by WangWei on 16/12/26.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMEmailSearchView.h"

@implementation CMEmailSearchView


-(id)init{
    self=[super init];
    if (self) {
       
        [self addSubview:self.EmailImageView];
        [self addSubview:self.JoinView];
        [self.JoinView addSubview:self.speakView];
        [self.JoinView addSubview:self.JoinPeopleLabel];
        UIImage *QImageView=[UIImage imageNamed:@"QQEmailImage"];
          UIImage *speakImage=[UIImage imageNamed:@"cPesrone"];

        [self.EmailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(f_i5real(QImageView.size.height));
            make.width.top.left.equalTo(self);
        }];
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(QQEmailLoginClick)];
        [self.EmailImageView addGestureRecognizer:tap];
        
        [self.JoinView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.width.left.equalTo(self);
            make.top.equalTo(self.EmailImageView.mas_bottom);
        }];
        [self.speakView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(speakImage.size.height);
            make.width.mas_equalTo(speakImage.size.width);
            make.centerY.equalTo(self.JoinView);
            make.left.equalTo(self.JoinView.mas_left).offset(20);
        }];
        
        [self.JoinPeopleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.top.equalTo(self.JoinView);
            
            make.left.equalTo(self.speakView.mas_right).offset(5);
            make.right.equalTo(self.JoinView.mas_right).offset(10);
        }];
        
        
        
        
        
        
        
    }
    return self;
    
    
}


-(UIImageView*)EmailImageView{
    if (!_EmailImageView) {
        _EmailImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"QQEmailImage"]];
        _EmailImageView.userInteractionEnabled=YES;
    }
    
    return _EmailImageView;
}


-(UIView*)JoinView{
    if (!_JoinView) {
        _JoinView=[[UIView alloc]init];
        //_JoinView.hidden=NO;
        _JoinView.backgroundColor=UIColorFromRGB(0xfdf9dc);
    }
    return _JoinView;
}
-(UIImageView*)speakView{
    if (!_speakView) {
        _speakView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cPesrone"]];
    }
    
    return _speakView;
}
-(UILabel*)JoinPeopleLabel{
    if (!_JoinPeopleLabel) {
        _JoinPeopleLabel=[[UILabel alloc]init];
        _JoinPeopleLabel.font=[UIFont systemFontOfSize:12];
        _JoinPeopleLabel.textColor=UIColorFromRGB(0xf69220);
        _JoinPeopleLabel.text=@"正在查询您的好友...";
    }
    return _JoinPeopleLabel;
}
-(void)QQEmailLoginClick{
    if (self.QQEmailLogin) {
        self.QQEmailLogin();
    }
    
}
@end
