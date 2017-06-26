//
//  CMChangzhangHeadView.m
//  CaiMao
//
//  Created by MAC on 16/11/9.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMChangzhangHeadView.h"

@implementation CMChangzhangHeadView

-(instancetype)init{
    self=[super init];
    if (self) {
        UIImage  *image=[UIImage imageNamed:@"VIPbanner"];
        UIImageView  *imageView=[[UIImageView alloc]init];
        imageView.image=image;
        [self  addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(f_i5real(image.size.height));
            make.top.centerX.width.equalTo(self);
        }];
        UIImage  *image2=[UIImage imageNamed:@"VIPTeQuan"];
        UIView  *bgView=[[UIView alloc]init];
        bgView.backgroundColor=[UIColor whiteColor];
        [self addSubview: bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(f_i5real(image2.size.height)+110);
            make.centerX.width.equalTo(self);
            make.top.equalTo(imageView.mas_bottom).offset(10);
        }];
        UILabel  *First=[[UILabel alloc]init];
         First.text=@"什么是成长值?";
        First.font=[UIFont boldSystemFontOfSize:13.5];
        First.textColor=UIColorFromRGB(0x585657);
        [bgView addSubview:First];
        [First mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.width.equalTo(@95);
            make.top.equalTo(bgView.mas_top).offset(15);
            make.left.equalTo(bgView.mas_left).offset(15);
        }];
        UILabel  *second=[[UILabel alloc]init];
        second.text=@"成长值越高,VIP等级越高,享受特权越高!";
        second.font=[UIFont systemFontOfSize:11.0];
        second.textColor=UIColorFromRGB(0x898989);
        [bgView addSubview:second];
        [second mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@12);
            make.width.equalTo(@200);
            make.bottom.equalTo(First);
            make.left.equalTo(First.mas_right);
        }];
        
        NSArray  *titleArr=@[@"成长值",@"投资",@"签到",@"邀请好友"];
        NSArray  *imagesArr=@[@"成长值",@"投资",@"签到",@"VIP邀请好友"];
         NSArray  *colorArr=@[UIColorFromRGB(0xffbb4f),UIColorFromRGB(0xfc3e1a),UIColorFromRGB(0xe06a2c),UIColorFromRGB(0x04a7e0)];
        float interal=(CMScreenW-4*38)/5.0;
        float interalOne=(CMScreenW-4*50)/5.0;
        for (int i=0; i<titleArr.count; i++) {
         

            UIImageView  *Fimage=[[UIImageView alloc]init];
            Fimage.frame=CGRectMake(i%4*(38+interal)+interal, 50, 38, 38);
            Fimage.image=[UIImage imageNamed:imagesArr[i]];
            [bgView addSubview:Fimage];
            
            UILabel  *third=[[UILabel alloc]init];
            third.text=titleArr[i];
            third.font=[UIFont systemFontOfSize:12.0];
            third.textColor=colorArr[i];
            third.textAlignment=NSTextAlignmentCenter;
          //  third.center=CGPointMake(Fimage.center.x, 120);
            third.frame=CGRectMake(i%4*(50+interalOne)+interalOne, 90, 50, 13);
            [bgView addSubview:third];
         
            if(i==0){
                UILabel  *thirdOne=[[UILabel alloc]init];
                thirdOne.text=@"=";
                thirdOne.font=[UIFont systemFontOfSize:15.0];
                thirdOne.textColor=UIColorFromRGB(0x898989);
                thirdOne.textAlignment=NSTextAlignmentCenter;
                [bgView addSubview:thirdOne];
                 [thirdOne  mas_makeConstraints:^(MASConstraintMaker *make) {
                     make.height.equalTo(@20);
                     make.width.equalTo(@20);
                     make.centerY.equalTo(Fimage);
                     make.left.equalTo(Fimage.mas_right).offset(10);
                 }];

                
                
            }
            
            if(i==1){
                UILabel  *thirdOne=[[UILabel alloc]init];
                thirdOne.text=@"+";
                thirdOne.font=[UIFont systemFontOfSize:15.0];
                thirdOne.textColor=UIColorFromRGB(0x898989);
                thirdOne.textAlignment=NSTextAlignmentCenter;
                [bgView addSubview:thirdOne];
                [thirdOne  mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.height.equalTo(@20);
                    make.width.equalTo(@20);
                    make.centerY.equalTo(Fimage);
                    make.left.equalTo(Fimage.mas_right).offset(10);
                }];
                
                
                
            }
            if(i==2){
                UILabel  *thirdOne=[[UILabel alloc]init];
                thirdOne.text=@"+";
                thirdOne.font=[UIFont systemFontOfSize:15.0];
                thirdOne.textColor=UIColorFromRGB(0x898989);
                thirdOne.textAlignment=NSTextAlignmentCenter;
                [bgView addSubview:thirdOne];
                [thirdOne  mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.height.equalTo(@20);
                    make.width.equalTo(@20);
                    make.centerY.equalTo(Fimage);
                    make.left.equalTo(Fimage.mas_right).offset(10);
                }];
                
                
                
            }
       
        }
        
        UIImage  *image1=[UIImage imageNamed:@"VIPTeQuan"];
        UIImageView  *BimageView=[[UIImageView alloc]init];
        BimageView.image=image1;
        [bgView  addSubview:BimageView];
        [BimageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(f_i5real(image1.size.height));
            make.centerX.width.equalTo(self);
            make.bottom.equalTo(bgView.mas_bottom).offset(10);
        }];
    
        
        
    }
    return self;
    
}

@end
