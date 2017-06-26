//
//  CMJuHaiLiCell.m
//  CaiMao
//
//  Created by Fengpj on 15/12/22.
//  Copyright © 2015年 58cm. All rights reserved.
//

#import "CMJuHaiLiCell.h"

@implementation CMJuHaiLiCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
//        self.backgroundColor=[UIColor whiteColor];
//        self.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 235);
//        
        UILabel *productTitle=[[UILabel alloc]init];
       // productTitle.frame=CGRectMake(20, 17, 200, 21);
        productTitle.font=[UIFont systemFontOfSize:15.0];
        self.juTitle=productTitle;
        [self addSubview:productTitle];
        [productTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(15);
            make.top.equalTo(self.mas_top).offset(17);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(200);
            
        }];
        
        

        
        
        UILabel *shouYiZhi=[[UILabel alloc]init];
       // shouYiZhi.frame=CGRectMake(5 , 46, 64, 58);
        self.juShouZheng=shouYiZhi;
        shouYiZhi.font=[UIFont systemFontOfSize:45.0];
        shouYiZhi.textAlignment=NSTextAlignmentRight;
        shouYiZhi.textColor=RedButtonColor;
        [self addSubview:shouYiZhi];
        [shouYiZhi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(15);
            make.top.equalTo(productTitle.mas_bottom).offset(10);
            make.height.equalTo(@46);
            make.width.equalTo(@50);
        }];
        
        UILabel *shouyi=[[UILabel alloc]init];
        //shouyi.frame=CGRectMake(72 , 77, 47, 20);
        shouyi.text=YuQiShouYi;
        shouyi.font=[UIFont systemFontOfSize:12.0];
        shouyi.textAlignment=NSTextAlignmentLeft;
        shouyi.textColor=[UIColor lightGrayColor];
        [self addSubview:shouyi];
        
        [shouyi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(shouYiZhi.mas_right);
            make.top.equalTo(shouYiZhi.mas_centerY).offset(2);
            make.height.equalTo(@13);
            make.width.equalTo(@90);
        }];
        
         UILabel *shouYiZhiXiao=[[UILabel alloc]init];
        // shouYiZhiXiao.frame=CGRectMake(71 , 52, 58, 28);
         self.juShouXiao=shouYiZhiXiao;
         shouYiZhiXiao.font=[UIFont systemFontOfSize:18];
         shouYiZhiXiao.textAlignment=NSTextAlignmentLeft;
         shouYiZhiXiao.textColor=RedButtonColor;
         [self addSubview:shouYiZhiXiao];
        [shouYiZhiXiao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(shouYiZhi.mas_right);
            make.bottom.equalTo(shouYiZhi.mas_centerY);
            make.height.equalTo(@18);
            make.width.equalTo(@45);
        }];
        
        
        
        UILabel *joinPeople=[[UILabel alloc]init];
       // joinPeople.frame=CGRectMake(220 , 47, 80, 21);
        joinPeople.font=[UIFont systemFontOfSize:13.0];
        joinPeople.textAlignment=NSTextAlignmentRight;
        joinPeople.textColor=[UIColor lightGrayColor];
        self.juPaiShu=joinPeople;
        [self addSubview:joinPeople];

        [joinPeople mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-15);
            make.top.equalTo(shouYiZhiXiao);
            make.height.equalTo(@15);
            make.width.equalTo(@80);
        }];
        UIImageView *peopleImage=[[UIImageView alloc]init];
        //peopleImage.frame=CGRectMake(225, 52, 12, 12);
        peopleImage.image=[UIImage imageNamed:@"product_canyuren.png"];
        [self addSubview:peopleImage];
        [peopleImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(joinPeople.mas_left);
            make.centerY.equalTo(joinPeople);
            make.height.width.equalTo(@12);
           ;
        }];
        
        UILabel *percent=[[UILabel alloc]init];
        //percent.frame=CGRectMake(117 , 77, 52, 20);
        percent.textColor=CMColor(95, 204, 124);
        percent.textAlignment=NSTextAlignmentCenter;
        percent.font=[UIFont systemFontOfSize:11.0];
         self.juQiShilv=percent;
        [self addSubview:percent];
        [percent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(shouYiZhiXiao.mas_right);
            make.centerY.equalTo(shouYiZhiXiao);
            make.height.equalTo(@13);
            make.width.equalTo(@52);
        }];
        
        
        
       
        
        UILabel *time=[[UILabel alloc]init];
       // time.frame=CGRectMake(240 , 72, 64, 24);
        time.font=[UIFont systemFontOfSize:13.0];
        time.textAlignment=NSTextAlignmentRight;
        time.textColor=[UIColor lightGrayColor];
        self.juJiShi=time;
        [self addSubview:time];
        [time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-15);
            make.bottom.equalTo(shouyi.mas_bottom);
            make.height.equalTo(@13);
            make.width.equalTo(@60);
        }];
        
        UIImageView *TimeImage=[[UIImageView alloc]init];
      //  TimeImage.frame=CGRectMake(225, 78, 11, 11);
        TimeImage.image=[UIImage imageNamed:@"product_time_icon.png"];
        [self addSubview:TimeImage];
        [TimeImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(time.mas_left);
            make.centerY.equalTo(time.mas_centerY);
            make.height.width.equalTo(@11);
           
        }];
        
        
        
        KDGoalBar *globe=[[KDGoalBar alloc]initWithFrame:CGRectMake(self.center.x, 44, 54, 54)];
        globe.backgroundColor=[UIColor whiteColor];
        self.juPercentView=globe;
        [self addSubview:globe];
        
        

        
        UIButton *Join=[UIButton buttonWithType:UIButtonTypeCustom];
        Join.frame=CGRectMake(12, 188, 300, 38);
       // [Join setTitle:@"参与" forState:UIControlStateNormal];
        Join.titleLabel.font=[UIFont systemFontOfSize:18];
        [Join setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.juPaiBtn=Join;
        Join.backgroundColor=RedButtonColor;;
        Join.layer.cornerRadius=5.0;
        Join.clipsToBounds=YES;
        [self addSubview:Join];
        [Join mas_makeConstraints:^(MASConstraintMaker *make) {
        
            make.bottom.equalTo(self.mas_bottom).offset(-10);
            make.height.mas_equalTo(buttonHeight);
         
            make.left.equalTo(self.mas_left).offset(15);
            make.right.equalTo(self.mas_right).offset(-15);
        }];
        UILabel *fenNum=[[UILabel alloc]init];
        //fenNum.frame=CGRectMake(238 , 162, 75, 21);
        self.juQitou=fenNum;
        fenNum.font=[UIFont systemFontOfSize:13.0];
        fenNum.textAlignment=NSTextAlignmentRight;
        fenNum.textColor=[UIColor lightGrayColor];
        [self addSubview:fenNum];
        [fenNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(Join.mas_top).offset(-5);
            make.right.equalTo(Join.mas_right);
            make.height.mas_equalTo(21);
            make.width.mas_equalTo(75);
        }];
        
        UILabel *haiLabel=[[UILabel alloc]init];
        //haiLabel.frame=CGRectMake(85 , 161, 160, 21);
        self.juHaiLable=haiLabel;
        self.juSubTitle=haiLabel;
        haiLabel.font=[UIFont systemFontOfSize:12.0];
        haiLabel.textAlignment=NSTextAlignmentCenter;
        haiLabel.textColor=[UIColor lightGrayColor];
        [self addSubview:haiLabel];

        [haiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
          
            make.centerX.equalTo(Join);
            make.height.bottom.equalTo(fenNum);
            make.width.mas_equalTo(155);
        }];
        
        
        
        UILabel *qiXian=[[UILabel alloc]init];
        //qiXian.frame=CGRectMake(20 , 162, 75, 21);
        self.juQixian=qiXian;
        qiXian.font=[UIFont systemFontOfSize:13.0];
        //qiXian.textAlignment=NSTextAlignmentCenter;
        qiXian.textColor=[UIColor lightGrayColor];
        [self addSubview:qiXian];
        [qiXian mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(Join.mas_left);
            make.height.bottom.equalTo(fenNum);
            make.width.mas_equalTo(75);
        }];
        
        float inteval=((CMScreenW-30)-55*4)/3;
        for (int i=0; i<4; i++) {
            CMJuHaiPercentView  *percentView=[[CMJuHaiPercentView alloc]init];
            percentView.frame=CGRectMake(i%4*(55+inteval)+15,98, 55, 55);
            [self addSubview:percentView];
            switch (i) {
                case 0:
                    self.juImage1=percentView;
                    self.juRen1=percentView.personer;
                    self.juShou1=percentView.perecent;
                    break;
                case 1:
                    self.juImage2=percentView;
                    self.juRen2=percentView.personer;
                    self.juShou2=percentView.perecent;
                    break;
                case 2:
                    self.juImage3=percentView;
                    self.juRen3=percentView.personer;
                    self.juShou3=percentView.perecent;
                    break;
                case 3:
                    self.juImage4=percentView;
                    self.juRen4=percentView.personer;
                    self.juShou4=percentView.perecent;
                    break;
                    
                default:
                    break;
            }
            
        
       }
                
    }
    return self;
}

@end
