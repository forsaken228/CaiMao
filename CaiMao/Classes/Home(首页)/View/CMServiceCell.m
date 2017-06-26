//
//  CMServiceCell.m
//  CaiMao
//
//  Created by Fengpj on 15/12/10.
//  Copyright © 2015年 58cm. All rights reserved.
//

#import "CMServiceCell.h"

@implementation CMServiceCell


-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        UIImage *image=[UIImage imageNamed:@"我的优惠券"];
        UIImageView *list=[[UIImageView alloc]init];
        self.serIcon=list;
        //list.frame=CGRectMake(41,9, 22,22);
        list.image=image;
        [self addSubview:list];
        [list mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.mas_top).offset(8);
            make.height.width.mas_equalTo(image.size.width);
            make.centerX.equalTo(self.mas_centerX);
        }];
        
        
        //title
        UILabel *tTitle=[[UILabel alloc]init];
       // tTitle.frame=CGRectMake(0, 36,self.contentView.frame.size.width, 21);
        tTitle.font=[UIFont systemFontOfSize:13];
        tTitle.textColor=[UIColor darkGrayColor];
        tTitle.textAlignment=NSTextAlignmentCenter;
        self.serTitle=tTitle;
        [self addSubview:tTitle];
        
        [tTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(list.mas_bottom).offset(6);
            make.height.mas_equalTo(21);
            make.left.width.equalTo(self);
        }];
        
        //关于财猫
        UILabel *tSubTitle=[[UILabel alloc]init];
        //tSubTitle.frame=CGRectMake(6, 55,91, 21);
        tSubTitle.font=[UIFont systemFontOfSize:13];
        tSubTitle.textAlignment=NSTextAlignmentCenter;
        tSubTitle.textColor=RedButtonColor;
        self.serSubTitle=tSubTitle;
        [self addSubview:tSubTitle];
        
        [tSubTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(tTitle.mas_bottom);
            make.height.mas_equalTo(21);
            make.left.width.equalTo(self);
        }];
        
        
        
        
        
//        UIView *verticalLine = [[UIView alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width-0.5, 0, 0.5, self.contentView.frame.size.height)];
//        verticalLine.backgroundColor = [UIColor lightGrayColor];
//        verticalLine.alpha = 0.35;
//        [self.contentView addSubview:verticalLine];
//        UIView *horizontalLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.contentView.frame.size.height - 0.5 , self.contentView.frame.size.width, 0.5)];
//        horizontalLine.backgroundColor = [UIColor lightGrayColor];
//        horizontalLine.alpha = 0.35;
//        [self.contentView addSubview:horizontalLine];
        
    }
    return self;
    
}
@end
