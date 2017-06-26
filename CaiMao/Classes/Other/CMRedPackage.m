//
//  CMRedPackage.m
//  CaiMao
//
//  Created by MAC on 16/9/10.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMRedPackage.h"

@implementation CMRedPackage

-(instancetype)init{
    self=[super init];
    if (self) {
        
        UIImage *image=[UIImage imageNamed:@"ttfx_hongbao"];
        
        UIImageView *redImageView=[[UIImageView alloc]init];
        redImageView.frame=CGRectMake(0, 0,CMScreenW-60, image.size.height+60);
        redImageView.image=image;

        [self addSubview:redImageView];
        UILabel *title=[[UILabel alloc]init];
        title.text=@"今日红包金额";
        title.textColor=[UIColor whiteColor];
        title.font=[UIFont boldSystemFontOfSize:22.0];
        title.textAlignment=NSTextAlignmentCenter;
        [redImageView addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@25);
            make.width.centerX.equalTo(redImageView);
            make.top.equalTo(redImageView.mas_top).offset(40);
        }];
        UIImage *YImage=[UIImage imageNamed:@"ttfx_yingbi"];
        UIImageView *jinBi=[[UIImageView alloc]init];
        jinBi.image=YImage;
        [redImageView addSubview:jinBi];
        [jinBi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(YImage.size.height);
            make.width.mas_equalTo(YImage.size.width);
            make.top.equalTo(title.mas_bottom).offset(70);
            make.centerX.equalTo(redImageView);
        }];
        
        UILabel *JinER=[[UILabel alloc]init];
        //JinER.text=@"￥ 1000元";
        self.redMoney=JinER;
        JinER.textColor=UIColorFromRGB(0xfee94e);
        JinER.font=[UIFont boldSystemFontOfSize:45.0];
        JinER.textAlignment=NSTextAlignmentCenter;
    
        [redImageView addSubview:JinER];
        [JinER mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@45);
            make.centerX.equalTo(redImageView);
            make.width.equalTo(@115);
            make.top.equalTo(jinBi.mas_bottom).offset(10);
        }];
        UILabel *yuan=[[UILabel alloc]init];
        yuan.text=@"￥";
        
        yuan.textColor=UIColorFromRGB(0xfee94e);
        yuan.font=[UIFont boldSystemFontOfSize:30.0];
        yuan.textAlignment=NSTextAlignmentRight;
        
        [redImageView addSubview:yuan];
        [yuan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@30);
            make.centerY.equalTo(JinER.mas_centerY);
            make.width.equalTo(@40);
            make.right.equalTo(JinER.mas_left);
        }];

        UILabel *yuan1=[[UILabel alloc]init];
        yuan1.text=@"元";
        
        yuan1.textColor=UIColorFromRGB(0xfee94e);
        yuan1.font=[UIFont boldSystemFontOfSize:30.0];
        yuan1.textAlignment=NSTextAlignmentLeft;
        
        [redImageView addSubview:yuan1];
        [yuan1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@30);
            make.centerY.equalTo(JinER.mas_centerY);
            make.width.equalTo(@40);
            make.left.equalTo(JinER.mas_right);
        }];
        UILabel *line=[[UILabel alloc]init];
        line.backgroundColor=UIColorFromRGB(0xfd8a75);
        [redImageView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
            make.left.equalTo(redImageView.mas_left).offset(8);
            make.right.equalTo(redImageView.mas_right).offset(-8);
            make.top.equalTo(JinER.mas_bottom).offset(15);
            
        }];
        
        UILabel *HongbaoDetail=[[UILabel alloc]init];
        HongbaoDetail.text=@"将红包分享到微信或者朋友圈,您的好友就可以抢红包;";
        HongbaoDetail.textColor=UIColorFromRGB(0xfdcc43);
        HongbaoDetail.font=[UIFont boldSystemFontOfSize:14.0];
        HongbaoDetail.numberOfLines=0;
        
        [redImageView addSubview:HongbaoDetail];
        [HongbaoDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@34);
            make.left.equalTo(redImageView.mas_left).offset(30);
            make.right.equalTo(redImageView.mas_right).offset(-15);
            make.top.equalTo(line.mas_bottom).offset(15);
        }];
        UILabel *circle=[[UILabel alloc]init];
        circle.backgroundColor=UIColorFromRGB(0xfdcc43);
        circle.layer.cornerRadius=2.5;
        circle.clipsToBounds=YES;
        [redImageView addSubview:circle];
        [circle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.equalTo(@5);
            make.right.equalTo(HongbaoDetail.mas_left).offset(-6);
            make.top.equalTo(HongbaoDetail.mas_top).offset(6);
        }];
        UILabel *HongbaoDetail1=[[UILabel alloc]init];
        HongbaoDetail1.text=@"每天财猫为您提供一个红包可以分享,朋友打开即可领取随机红包奖励。";
        HongbaoDetail1.textColor=UIColorFromRGB(0xfdcc43);
        HongbaoDetail1.font=[UIFont boldSystemFontOfSize:14.0];
        HongbaoDetail1.numberOfLines=0;
        [redImageView addSubview:HongbaoDetail1];
        [HongbaoDetail1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(HongbaoDetail);
            make.height.equalTo(@54);
            make.top.equalTo(HongbaoDetail.mas_bottom);
        }];
        

        
     
        UILabel *circle1=[[UILabel alloc]init];
        circle1.backgroundColor=UIColorFromRGB(0xfdcc43);
        circle1.layer.cornerRadius=2.5;
        circle1.clipsToBounds=YES;
        [redImageView addSubview:circle1];
//        [circle1 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.width.right.equalTo(circle);
//            
//            make.top.equalTo(HongbaoDetail1.mas_top).offset(7);
//        }];
        
        if (CMScreenH<=568) {
            [circle1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.width.right.equalTo(circle);
                
                make.top.equalTo(HongbaoDetail1.mas_top).offset(7);
            }];
        }else if(CMScreenH>568){
            
            [circle1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.width.right.equalTo(circle);
                
                make.top.equalTo(HongbaoDetail1.mas_top).offset(16);
            }];
            
        }
  
        
    }
    return self;
    
}

@end
