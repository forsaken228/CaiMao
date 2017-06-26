//
//  CMYuexiCell.m
//  CaiMao
//
//  Created by Fengpj on 15/11/23.
//  Copyright © 2015年 58cm. All rights reserved.
//

#import "CMYuexiCell.h"

@implementation CMYuexiCell



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //self.backgroundColor=[UIColor whiteColor];

        
        UIButton *Join=[UIButton buttonWithType:UIButtonTypeCustom];
        //Join.frame=CGRectMake(11, 112, 300, 30);
        [Join setTitle:@"参与" forState:UIControlStateNormal];
        Join.titleLabel.font=[UIFont systemFontOfSize:18];
        [Join setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.yuePaiBtn=Join;
        Join.backgroundColor=RedButtonColor;
        Join.layer.cornerRadius=5.0;
        Join.clipsToBounds=YES;
        [self addSubview:Join];
        
        [Join mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(buttonHeight);
            make.left.equalTo(self.mas_left).offset(15);
            make.right.equalTo(self.mas_right).offset(-15);
            make.bottom.equalTo(self.mas_bottom).offset(-15);
            
        }];
        
        
        
        UILabel *productTitle=[[UILabel alloc]init];
        //  productTitle.frame=CGRectMake(16, 16, 175, 21);
        productTitle.font=[UIFont systemFontOfSize:13.0];
        self.yueXiTitle=productTitle;
        [self addSubview:productTitle];
        
        [productTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(15);
            make.top.equalTo(self.mas_top).offset(15);
            make.height.mas_equalTo(15.0);
            make.width.mas_equalTo(200);
            
        }];
        
        UILabel *joinPeople=[[UILabel alloc]init];
        //joinPeople.frame=CGRectMake(240 , 16, 80, 21);
        joinPeople.font=[UIFont systemFontOfSize:13.0];
        joinPeople.textAlignment=NSTextAlignmentRight;
        joinPeople.textColor=[UIColor lightGrayColor];
        self.yueCanyu=joinPeople;
        [self addSubview:joinPeople];
        [joinPeople mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(productTitle);
            make.right.equalTo(self.mas_right).offset(-15);
            make.height.mas_equalTo(13.0);
            make.width.mas_equalTo(80);
            
        }];
        
        
        
        UIImageView *peopleImage=[[UIImageView alloc]init];
        // peopleImage.frame=CGRectMake(225, 20, 12, 12);
        peopleImage.image=[UIImage imageNamed:@"product_canyuren.png"];
        [self addSubview:peopleImage];
        
        [peopleImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(productTitle);
            make.right.equalTo(joinPeople.mas_left);
            make.height.width.mas_equalTo(12);
            
        }];
        
        KDGoalBar *globe=[[KDGoalBar alloc]initWithFrame:CGRectMake(CMScreenW-15-Join.bounds.size.width-54,self.bounds.size.height/2.0+15, 54, 54)];
        globe.backgroundColor=[UIColor whiteColor];
        self.yuePercentView=globe;
        [self addSubview:globe];
        
        
        UILabel *shouYiZhi=[[UILabel alloc]init];
        // shouYiZhi.frame=CGRectMake(2 , 45, 64, 58);
        self.yueZhengshu=shouYiZhi;
        shouYiZhi.font=[UIFont systemFontOfSize:45.0];
        shouYiZhi.textAlignment=NSTextAlignmentRight;
        shouYiZhi.textColor=RedButtonColor;
        [self addSubview:shouYiZhi];
        [shouYiZhi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@50);
            make.height.equalTo(@45);
            make.left.equalTo(Join);
            make.centerY.equalTo(self.mas_centerY).offset(-5);
        }];
       
    
        UILabel *shouYiZhiXiao=[[UILabel alloc]init];
        // shouYiZhiXiao.frame=CGRectMake(68 , 51, 57, 28);
        self.yueXiaoshu=shouYiZhiXiao;
        shouYiZhiXiao.font=[UIFont systemFontOfSize:18];
        shouYiZhiXiao.textAlignment=NSTextAlignmentLeft;
        shouYiZhiXiao.textColor=RedButtonColor;
        [self addSubview:shouYiZhiXiao];
        [shouYiZhiXiao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@60);
            make.height.equalTo(@22);
            make.bottom.equalTo(shouYiZhi.mas_centerY).offset(2);
            make.left.equalTo(shouYiZhi.mas_right);
        }];
        
        
        UILabel *shouyi=[[UILabel alloc]init];
        // shouyi.frame=CGRectMake(72 , 76, 47, 20);
        shouyi.text=YuQiShouYi;
        shouyi.font=[UIFont systemFontOfSize:12.0];
        shouyi.textAlignment=NSTextAlignmentLeft;
        shouyi.textColor=[UIColor lightGrayColor];
        [self addSubview:shouyi];
        [shouyi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@90);
            make.height.equalTo(@20);
            make.top.equalTo(shouYiZhi.mas_centerY);
            make.left.equalTo(shouYiZhiXiao);
        }];
        
        
        
        UILabel *qiXian=[[UILabel alloc]init];
        //qiXian.frame=CGRectMake(117 , 50, 80, 21);
        self.yueQixian=qiXian;
        qiXian.font=[UIFont systemFontOfSize:13.0];
        qiXian.textAlignment=NSTextAlignmentCenter;
        qiXian.textColor=[UIColor lightGrayColor];
        [self addSubview:qiXian];
        [qiXian mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(Join.mas_centerX).offset(25);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(80);
            make.top.equalTo(shouYiZhiXiao.mas_top);
        }];
        UILabel *fenNum=[[UILabel alloc]init];
        // fenNum.frame=CGRectMake(117 , 72, 80, 21);
        self.yueQitou=fenNum;
        fenNum.font=[UIFont systemFontOfSize:13.0];
        fenNum.textAlignment=NSTextAlignmentCenter;
        fenNum.textColor=[UIColor lightGrayColor];
        [self addSubview:fenNum];
        
        [fenNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX).offset(25);
            make.height.mas_equalTo(21);
            make.width.mas_equalTo(72);
            make.bottom.equalTo(shouyi.mas_bottom);
        }];
        
        
        
        
        
        
    }
    return self;
}

@end
