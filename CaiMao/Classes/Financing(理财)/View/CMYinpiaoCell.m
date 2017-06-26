//
//  CMYinpiaoCell.m
//  CaiMao
//
//  Created by Fengpj on 15/11/23.
//  Copyright © 2015年 58cm. All rights reserved.
//

#import "CMYinpiaoCell.h"

@implementation CMYinpiaoCell



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor=[UIColor whiteColor];
       // self.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 148);
        
        UILabel *productTitle=[[UILabel alloc]init];
        productTitle.frame=CGRectMake(13, 12, 100, 21);
        productTitle.font=[UIFont systemFontOfSize:15.0];
        self.yinPiaoTitle=productTitle;
        [self addSubview:productTitle];
        
        UIImageView *safe=[[UIImageView alloc]init];
        safe.frame=CGRectMake(22, 152, 11, 13);
        safe.image=[UIImage imageNamed:@"ypt_yinhang_icon.png"];
        [self addSubview:safe];
        
        UILabel *bankName=[[UILabel alloc]init];
        bankName.frame=CGRectMake(37 , 148, 179, 21);
        self.yinYinhang=bankName;
        bankName.font=[UIFont systemFontOfSize:13.0];
        bankName.textAlignment=NSTextAlignmentLeft;
        bankName.textColor=[UIColor lightGrayColor];
        [self addSubview:bankName];
        
        UILabel *shouyi=[[UILabel alloc]init];
        shouyi.frame=CGRectMake(70 , 76, 47, 20);
        shouyi.text=@"年收益";
        shouyi.font=[UIFont systemFontOfSize:13.0];
        shouyi.textAlignment=NSTextAlignmentCenter;
        shouyi.textColor=[UIColor lightGrayColor];
        [self addSubview:shouyi];
        
        UILabel *shouYiZhi=[[UILabel alloc]init];
        shouYiZhi.frame=CGRectMake(1 , 45, 64, 58);
        self.yinZhengshu=shouYiZhi;
        shouYiZhi.font=[UIFont systemFontOfSize:45.0];
        shouYiZhi.textAlignment=NSTextAlignmentRight;
        shouYiZhi.textColor=CMColor(249, 44, 1);
        [self addSubview:shouYiZhi];
        
        UILabel *shouYiZhiXiao=[[UILabel alloc]init];
        shouYiZhiXiao.frame=CGRectMake(67 , 51, 63, 28);
        self.yinXiaoshu=shouYiZhiXiao;
        shouYiZhiXiao.font=[UIFont systemFontOfSize:22];
        shouYiZhiXiao.textAlignment=NSTextAlignmentLeft;
        shouYiZhiXiao.textColor=CMColor(249, 44, 1);
        [self addSubview:shouYiZhiXiao];
        
        UILabel *qiXian=[[UILabel alloc]init];
        qiXian.frame=CGRectMake(121 , 50, 75, 21);
        self.yinQiXian=qiXian;
        qiXian.font=[UIFont systemFontOfSize:13.0];
        qiXian.textAlignment=NSTextAlignmentCenter;
        qiXian.textColor=[UIColor lightGrayColor];
        [self addSubview:qiXian];
        
        UILabel *fenNum=[[UILabel alloc]init];
        fenNum.frame=CGRectMake(121 , 72, 80, 21);
        self.yinQitou=fenNum;
        fenNum.font=[UIFont systemFontOfSize:13.0];
        fenNum.textAlignment=NSTextAlignmentCenter;
        fenNum.textColor=[UIColor lightGrayColor];
        [self addSubview:fenNum];
        
        KDGoalBar *globe=[[KDGoalBar alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-85, 47, 54, 54)];
        globe.backgroundColor=[UIColor whiteColor];
        self.yinPercentView=globe;
        [self addSubview:globe];
        
        
        
        
        UIImageView *peopleImage=[[UIImageView alloc]init];
        peopleImage.frame=CGRectMake(222, 21, 12, 12);
        peopleImage.image=[UIImage imageNamed:@"product_canyuren.png"];
        [self addSubview:peopleImage];
        
        UILabel *joinPeople=[[UILabel alloc]init];
        joinPeople.frame=CGRectMake(237 , 16, 77, 21);
        joinPeople.font=[UIFont systemFontOfSize:13.0];
        joinPeople.textAlignment=NSTextAlignmentLeft;
        joinPeople.textColor=[UIColor lightGrayColor];
        self.yinCanyu=joinPeople;
        [self addSubview:joinPeople];
        
      
        
        
        
        
        
        
        UIButton *Join=[UIButton buttonWithType:UIButtonTypeCustom];
        //Join.frame=CGRectMake(12, 102, 300, 34);
        // [Join setTitle:@"参与" forState:UIControlStateNormal];
        Join.titleLabel.font=[UIFont systemFontOfSize:18];
        [Join setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.yinPaiBtn=Join;
        Join.backgroundColor=RedButtonColor;
        Join.layer.cornerRadius=5.0;
        Join.clipsToBounds=YES;
        [self addSubview:Join];
        
        [Join mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(-30);
            make.centerX.equalTo(self.mas_centerX);
            make.height.mas_equalTo(25);
            make.width.mas_equalTo(300);
            
        }];
        
        
        
        
        
        
    }
    return self;
}
@end
