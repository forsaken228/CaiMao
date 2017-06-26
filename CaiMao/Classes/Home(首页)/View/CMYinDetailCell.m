//
//  CMYinDetailCell.m
//  CaiMao
//
//  Created by Fengpj on 15/12/23.
//  Copyright © 2015年 58cm. All rights reserved.
//

#import "CMYinDetailCell.h"

@implementation CMYinDetailCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor=[UIColor whiteColor];
        self.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 148);
        
        UILabel *productTitle=[[UILabel alloc]init];
        productTitle.frame=CGRectMake(13, 12, 100, 21);
        productTitle.font=[UIFont systemFontOfSize:15.0];
        self.yinPiaoTitle=productTitle;
        [self addSubview:productTitle];
        
       
     
        UILabel *bankName=[[UILabel alloc]init];
       // bankName.frame=CGRectMake(142 , 12, 170, 21);
        self.yinYinhang=bankName;
        bankName.font=[UIFont systemFontOfSize:13.0];
        bankName.textAlignment=NSTextAlignmentLeft;
        bankName.textColor=[UIColor lightGrayColor];
        [self addSubview:bankName];
        [bankName mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.mas_right);
            make.height.mas_equalTo(21);
            make.width.mas_equalTo(150);
            make.top.equalTo(self.mas_top).offset(12);
        }];
        UIImageView *safe=[[UIImageView alloc]init];
        //safe.frame=CGRectMake(127, 16, 11, 13);
        safe.image=[UIImage imageNamed:@"ypt_yinhang_icon.png"];
        [self addSubview:safe];
        [safe mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(bankName.mas_left);
            make.height.mas_equalTo(13);
            make.width.mas_equalTo(11);
            make.top.equalTo(bankName).offset(4);
        }];
     
        
        
        UILabel *shouyi=[[UILabel alloc]init];
        shouyi.frame=CGRectMake(64 , 69, 47, 20);
        shouyi.text=@"年收益";
        shouyi.font=[UIFont systemFontOfSize:13.0];
        shouyi.textAlignment=NSTextAlignmentCenter;
        shouyi.textColor=[UIColor lightGrayColor];
        [self addSubview:shouyi];
        
        UILabel *shouYiZhi=[[UILabel alloc]init];
        shouYiZhi.frame=CGRectMake(5 , 38, 54, 58);
        self.yinZhengshu=shouYiZhi;
        shouYiZhi.font=[UIFont systemFontOfSize:45.0];
        shouYiZhi.textAlignment=NSTextAlignmentRight;
        shouYiZhi.textColor=CMColor(249, 44, 1);
        [self addSubview:shouYiZhi];
        
        UILabel *shouYiZhiXiao=[[UILabel alloc]init];
        shouYiZhiXiao.frame=CGRectMake(61 , 44, 52, 28);
        self.yinXiaoshu=shouYiZhiXiao;
        shouYiZhiXiao.font=[UIFont systemFontOfSize:22];
        shouYiZhiXiao.textAlignment=NSTextAlignmentLeft;
        shouYiZhiXiao.textColor=CMColor(249, 44, 1);
        [self addSubview:shouYiZhiXiao];
        
        UILabel *qiXian=[[UILabel alloc]init];
        qiXian.frame=CGRectMake(113 , 43, 75, 21);
        self.yinQiXian=qiXian;
        qiXian.font=[UIFont systemFontOfSize:13.0];
        qiXian.textAlignment=NSTextAlignmentCenter;
        qiXian.textColor=[UIColor lightGrayColor];
        [self addSubview:qiXian];
        
        UILabel *fenNum=[[UILabel alloc]init];
        fenNum.frame=CGRectMake(117 , 68, 72, 21);
        self.yinQitou=fenNum;
        fenNum.font=[UIFont systemFontOfSize:13.0];
        fenNum.textAlignment=NSTextAlignmentCenter;
        fenNum.textColor=[UIColor lightGrayColor];
        [self addSubview:fenNum];

          KDGoalBar *globe=[[KDGoalBar alloc]initWithFrame:CGRectMake(183, 40, 54, 54)];
           globe.backgroundColor=[UIColor whiteColor];
            self.yinPercentView=globe;
           [self addSubview:globe];
        
        
                UIImageView *TimeImage=[[UIImageView alloc]init];
                TimeImage.frame=CGRectMake(240, 72, 12, 12);
                TimeImage.image=[UIImage imageNamed:@"product_time_icon.png"];
                [self addSubview:TimeImage];


        UIImageView *peopleImage=[[UIImageView alloc]init];
        peopleImage.frame=CGRectMake(240, 50, 12, 12);
        peopleImage.image=[UIImage imageNamed:@"product_canyuren.png"];
        [self addSubview:peopleImage];
        
        UILabel *joinPeople=[[UILabel alloc]init];
        joinPeople.frame=CGRectMake(255 , 45, 62, 21);
        joinPeople.font=[UIFont systemFontOfSize:13.0];
        joinPeople.textAlignment=NSTextAlignmentRight;
        joinPeople.textColor=[UIColor lightGrayColor];
        self.yinCanyu=joinPeople;
        [self addSubview:joinPeople];
        
                UILabel *time=[[UILabel alloc]init];
                time.frame=CGRectMake(255 , 67, 59, 21);
                time.font=[UIFont systemFontOfSize:13.0];
                time.textAlignment=NSTextAlignmentRight;
                time.textColor=[UIColor lightGrayColor];
                self.yinJiShi=time;
                [self addSubview:time];
        

        
        UIButton *Join=[UIButton buttonWithType:UIButtonTypeCustom];
        //Join.frame=CGRectMake(12, 102, 300, 34);
        // [Join setTitle:@"参与" forState:UIControlStateNormal];
        Join.titleLabel.font=[UIFont systemFontOfSize:18];
        [Join setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.yinPaiBtn=Join;
        Join.backgroundColor=RedButtonColor;;
        Join.layer.cornerRadius=5.0;
        Join.clipsToBounds=YES;
        [self addSubview:Join];
        [Join mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(5);
            make.centerX.equalTo(self.mas_centerX);
            make.height.mas_equalTo(buttonHeight);
            make.width.mas_equalTo(300);
        }];
//
        
        
   
        
        
    }
    return self;
}
@end
