//
//  CMMiaoShaCell.m
//  CaiMao
//
//  Created by Fengpj on 15/12/23.
//  Copyright © 2015年 58cm. All rights reserved.
//

#import "CMMiaoShaCell.h"

@implementation CMMiaoShaCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor=[UIColor whiteColor];
    
        
        UIButton *Join=[UIButton buttonWithType:UIButtonTypeCustom];

        Join.titleLabel.font=[UIFont systemFontOfSize:18];
        [Join setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.miaoJoin=Join;
        Join.backgroundColor=RedButtonColor;
        Join.layer.cornerRadius=5.0;
        Join.clipsToBounds=YES;
        [self addSubview:Join];
        
        [Join mas_makeConstraints:^(MASConstraintMaker *make) {
            //make.centerX.equalTo(self.mas_centerX);
            make.height.mas_equalTo(buttonHeight);
            make.left.equalTo(self.mas_left).offset(15);
            make.right.equalTo(self.mas_right).offset(-15);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
        }];
        
        UILabel *productTitle=[[UILabel alloc]init];
        //productTitle.frame=CGRectMake(16, 12, 121, 21);
        productTitle.font=[UIFont systemFontOfSize:15.0];
        self.miaoTitle=productTitle;
        [self addSubview:productTitle];
        [productTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top .equalTo(self.mas_top).offset(12);
            make.left.equalTo(Join.mas_left);
            make.height.equalTo(@21);
            make.width.mas_equalTo(121);
            
        }];
        
        
       
        
        UILabel *joinPeople=[[UILabel alloc]init];
        //joinPeople.frame=CGRectMake(155 , 12, 71, 21);
        joinPeople.font=[UIFont systemFontOfSize:13.0];
        //joinPeople.textAlignment=NSTextAlignmentCenter;
        joinPeople.textColor=[UIColor lightGrayColor];
        self.miaoPaiShu=joinPeople;
        [self addSubview:joinPeople];
        [joinPeople mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(productTitle);
            make.centerX.equalTo(Join.mas_centerX);
            make.height.equalTo(@21);
            make.width.mas_equalTo(80);
        }];
        
        UIImageView *peopleImage=[[UIImageView alloc]init];
        //peopleImage.frame=CGRectMake(145, 16, 12, 12);
        peopleImage.image=[UIImage imageNamed:@"product_canyuren.png"];
        [self addSubview:peopleImage];
        [peopleImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(productTitle);
            make.right.equalTo(joinPeople.mas_left);
            make.width.height.mas_equalTo(12);
        }];
        
        
        
        
        
        
    
        UILabel *time=[[UILabel alloc]init];
       // time.frame=CGRectMake(240 , 11, 59, 21);
        time.font=[UIFont systemFontOfSize:13.0];
       // time.textAlignment=NSTextAlignmentRight;
        time.textColor=[UIColor lightGrayColor];
        self.miaoTime=time;
        [self addSubview:time];
        [time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.equalTo(joinPeople);
            make.right.equalTo(Join.mas_right);
            make.width.mas_equalTo(58);
        }];
        
        UIImageView *TimeImage=[[UIImageView alloc]init];
        //TimeImage.frame=CGRectMake(230, 16, 12, 12);
        TimeImage.image=[UIImage imageNamed:@"product_time_icon.png"];
        [self addSubview:TimeImage];
        
        [TimeImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.width.height.equalTo(peopleImage);
            make.right.equalTo(time.mas_left);
            
        }];

        
        UILabel *shouYiZhi=[[UILabel alloc]init];
        self.miaoShouZheng=shouYiZhi;
        shouYiZhi.font=[UIFont systemFontOfSize:45.0];
        //shouYiZhi.textAlignment=NSTextAlignmentRight;
        shouYiZhi.textColor=CMColor(249, 44, 1);
        [self addSubview:shouYiZhi];
        [shouYiZhi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@50);
            make.height.equalTo(@45);
            make.left.equalTo(Join);
            make.centerY.equalTo(self);
        }];
        
        UILabel *shouYiZhiXiao=[[UILabel alloc]init];
        //shouYiZhiXiao.frame=CGRectMake(64 , 46, 62, 28);
        self.miaoShouXiao=shouYiZhiXiao;
        shouYiZhiXiao.font=[UIFont systemFontOfSize:18];
        shouYiZhiXiao.textAlignment=NSTextAlignmentLeft;
        shouYiZhiXiao.textColor=CMColor(249, 44, 1);
        [self addSubview:shouYiZhiXiao];
        [shouYiZhiXiao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@45);
            make.height.equalTo(@22);
            make.bottom.equalTo(shouYiZhi.mas_centerY);
            make.left.equalTo(shouYiZhi.mas_right);
        }];
        
        
        UILabel *percent=[[UILabel alloc]init];
        percent.textColor=[UIColor lightGrayColor];
        percent.textAlignment=NSTextAlignmentCenter;
        percent.font=[UIFont systemFontOfSize:12.0];
        self.miaoQiSX=percent;
        
        [self addSubview:percent];
        [percent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(shouYiZhiXiao.mas_right);
            make.centerY.equalTo(shouYiZhiXiao);
            make.height.equalTo(@13);
            make.width.equalTo(@52);
        }];
        
        
        
        KDGoalBar *globe=[[KDGoalBar alloc]initWithFrame:CGRectMake(CMScreenW-15-Join.bounds.size.width-54,self.bounds.size.height/2.0+27, 54, 54)];
        globe.backgroundColor=[UIColor whiteColor];
        self.miaoPercentView=globe;
        [self addSubview:globe];
        UILabel *shouyi=[[UILabel alloc]init];
       // shouyi.frame=CGRectMake(67 , 72, 47, 20);
        shouyi.text=YuQiShouYi;
        shouyi.font=[UIFont systemFontOfSize:12.0];
       // shouyi.textAlignment=NSTextAlignmentCenter;
        shouyi.textColor=[UIColor lightGrayColor];
        [self addSubview:shouyi];
        [shouyi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@90);
            make.height.equalTo(@20);
            make.top.equalTo(shouYiZhi.mas_centerY);
            make.left.equalTo(shouYiZhiXiao);
        }];
        
        
        UILabel *fenNum=[[UILabel alloc]init];
        //fenNum.frame=CGRectMake(145 , 71, 72, 21);
        self.miaoQiTou=fenNum;
        fenNum.font=[UIFont systemFontOfSize:13.0];
        fenNum.textAlignment=NSTextAlignmentCenter;
        fenNum.textColor=[UIColor lightGrayColor];
        [self addSubview:fenNum];
        [fenNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX).offset(35);
            make.height.mas_equalTo(21);
            make.width.mas_equalTo(72);
            make.bottom.equalTo(shouyi.mas_bottom);
        }];
        
        UILabel *qiXian=[[UILabel alloc]init];
        //qiXian.frame=CGRectMake(145 , 46, 80, 21);
        self.miaoQiXian=qiXian;
        qiXian.font=[UIFont systemFontOfSize:13.0];
        qiXian.textAlignment=NSTextAlignmentCenter;
        qiXian.textColor=[UIColor lightGrayColor];
        [self addSubview:qiXian];
        [qiXian mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(Join.mas_centerX).offset(35);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(80);
            make.top.equalTo(shouYiZhiXiao.mas_top);
        }];
        
        
    }
    return self;
}
@end
