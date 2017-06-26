//
//  CMQianDaoView.m
//  CaiMao
//
//  Created by MAC on 16/11/8.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMQianDaoView.h"

@implementation CMQianDaoView

-(instancetype)init{
    self=[super init];
    if (self) {
        UIView  *topbg=[[UIView alloc]init];
        topbg.backgroundColor=RedButtonColor;
        topbg.frame=CGRectMake(0, 0, CMScreenW, f_i5real(350));
        [self addSubview:topbg];
        UIImage *image=[UIImage imageNamed:@"签到Button"];
        self.qiandaoImageView=[[UIImageView alloc]init];
        self.qiandaoImageView.image=image;
        self.qiandaoImageView.userInteractionEnabled=YES;
        [topbg addSubview:self.qiandaoImageView];
        [self.qiandaoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(f_i5real(image.size.height));
            make.width.mas_equalTo(f_i5real(image.size.width));
            make.top.equalTo(topbg);
            make.right.equalTo(topbg.mas_right).offset(-20);
        }];
        
        [self.qiandaoImageView addSubview:self.QianDaoLabel];
        [self.QianDaoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.qiandaoImageView.mas_left).offset(6);
            make.right.equalTo(self.qiandaoImageView.mas_right).offset(-5);
            make.bottom.equalTo(self.qiandaoImageView.mas_bottom).offset(-8);
            make.height.mas_equalTo(f_i5real(35));
            
        }];
        
        [self addSubview:self.NameLabel];
        [self addSubview:self.currentLevel];
        [self.NameLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.centerX.width.equalTo(self);
            make.top.equalTo(self.mas_top).offset(60);
            
        }];
        [self.currentLevel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.centerX.width.equalTo(self);
            make.top.equalTo(self.NameLabel.mas_bottom).offset(5);
            
        }];
        
        
        UIImage *image1=[UIImage imageNamed:@"backgroundImage"];
        // 尺寸需根据图片进行调整
        
        self.circleProgressView = [[CMCircleAnimationView alloc] initWithFrame: CGRectMake(0,105 ,f_i5real(image1.size.width),f_i5real(image1.size.height) )];
        self.circleProgressView.bgImage = [UIImage imageNamed:@"backgroundImage"];
        self.circleProgressView.percent = 0.f;

        [ topbg addSubview:self.circleProgressView];

        
        [topbg addSubview:self.chengzhangVaule];
        [topbg addSubview:self.ShengjiButton];
        
        UILabel *cheng=[[UILabel alloc]init];
        cheng.text=@"成长值(点)";
        cheng.font=[UIFont systemFontOfSize:14.0];
        cheng.textColor=[UIColor whiteColor];
        cheng.textAlignment=NSTextAlignmentCenter;
        [topbg addSubview:cheng];
        [cheng  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.width.centerX.equalTo(topbg);
            make.bottom.equalTo(self.circleProgressView.mas_bottom).offset(-5);
        }];
        
        [self.chengzhangVaule mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@55);
            make.centerX.equalTo(topbg);
            make.width.equalTo(topbg);
            make.bottom.equalTo(cheng.mas_top).offset(-10);
        }];
        [self.ShengjiButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@30);
            make.left.equalTo(topbg.mas_left).offset(20);
            make.right.equalTo(topbg.mas_right).offset(-20);
            make.top.equalTo(self.circleProgressView.mas_bottom).offset(20);
        }];
        UILabel  *circle=[[UILabel alloc]init];
        circle.backgroundColor=[UIColor whiteColor];
        circle.layer.cornerRadius=30;
        circle.layer.masksToBounds=YES;
        [topbg addSubview:circle];
        [circle  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.equalTo(@60);
            make.centerY.equalTo(topbg.mas_bottom).offset(15);
            make.centerX.equalTo(topbg);
        }];
        
        NSArray *titleArr=@[@"购买VIP产品",@"VIP特权福利"];
        NSArray *placeArr=@[@"送京东购物卡",@""];
        for (int i=0; i<titleArr.count; i++) {
            self.VipBottomView=[[CMVipBottomImage alloc]init];
            self.VipBottomView.frame=CGRectMake(i%2*(CMScreenW/2.0), f_i5real(350), CMScreenW/2.0, f_i5real(100));
            self.VipBottomView.leftImage.image=[UIImage imageNamed:titleArr[i]];
             self.VipBottomView.rightTopLabel.text=titleArr[i];
            self.VipBottomView.rightBottomLabel.text=placeArr[i];
            self.VipBottomView.tag=i+10;
            [self addSubview:self.VipBottomView];
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
            [self.VipBottomView addGestureRecognizer:tap];
        }
        
    }
    return self;
    
    
}
-(void)tapClick:(UIGestureRecognizer*)tap{
    if ([_delegate  respondsToSelector:@selector(bugVipProductOrCheackFuLiWithIndex:)]) {
        [_delegate bugVipProductOrCheackFuLiWithIndex:tap.view.tag];
    }
    
    
}
-(UILabel*)QianDaoLabel{
    if (!_QianDaoLabel) {
        _QianDaoLabel=[[UILabel alloc]init];
        _QianDaoLabel.font=[UIFont systemFontOfSize:10.0];
        _QianDaoLabel.numberOfLines=0;
        _QianDaoLabel.textColor=[UIColor whiteColor];
        _QianDaoLabel.textAlignment=NSTextAlignmentCenter;
        _QianDaoLabel.userInteractionEnabled=YES;
    }
    
    return _QianDaoLabel;
}

-(UILabel*)NameLabel{
    if (!_NameLabel) {
        _NameLabel=[[UILabel alloc]init];
        _NameLabel.font=[UIFont systemFontOfSize:14.0];
        _NameLabel.textColor=[UIColor whiteColor];
        _NameLabel.textAlignment=NSTextAlignmentCenter;
    }
    
    return _NameLabel;
}
-(UILabel*)chengzhangVaule{
    if (!_chengzhangVaule) {
        _chengzhangVaule=[[UILabel alloc]init];
        _chengzhangVaule.font=[UIFont systemFontOfSize:50.0];
        _chengzhangVaule.textColor=[UIColor whiteColor];
        _chengzhangVaule.textAlignment=NSTextAlignmentCenter;
    }
    
    return _chengzhangVaule;
}


-(UILabel*)currentLevel{
    if (!_currentLevel) {
        _currentLevel=[[UILabel alloc]init];
        _currentLevel.font=[UIFont systemFontOfSize:14.0];
        _currentLevel.textColor=[UIColor whiteColor];
        _currentLevel.textAlignment=NSTextAlignmentCenter;
    }
    
    return _currentLevel;
}

-(UIButton*)ShengjiButton{
    if (!_ShengjiButton) {
        _ShengjiButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _ShengjiButton.titleLabel.font=[UIFont systemFontOfSize:15];
        [_ShengjiButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _ShengjiButton.layer.masksToBounds=YES;
        _ShengjiButton.layer.cornerRadius=15;
        [_ShengjiButton setBackgroundColor:UIColorFromRGB(0xf9c229)];
    }
    return _ShengjiButton;
    
}
@end
