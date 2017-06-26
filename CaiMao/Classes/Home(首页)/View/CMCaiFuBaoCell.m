//
//  CMCaiFuBaoCell.m
//  CaiMao
//
//  Created by MAC on 16/7/8.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMCaiFuBaoCell.h"

@implementation CMCaiFuBaoCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
//        self.backgroundColor=[UIColor whiteColor];
//        self.frame=CGRectMake(0, 0, CMScreenW, 100);
        
        UILabel *line=[[UILabel alloc]init];
       // line.frame=CGRectMake(CMScreenW/2.0, 10, 0.5,80);
        line.backgroundColor=separateLineColor;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@80);
            make.center.equalTo(self);
            make.width.equalTo(@0.5);
        }];
        UILabel *shouYiZhi=[[UILabel alloc]init];
        //shouYiZhi.frame=CGRectMake(41 , 17, 41, 58);
        shouYiZhi.text=@"8";
        //self.CaiFuZhengshu=shouYiZhi;
        shouYiZhi.font=[UIFont systemFontOfSize:50.0];
        shouYiZhi.textAlignment=NSTextAlignmentRight;
        shouYiZhi.textColor=RedButtonColor;
        [self addSubview:shouYiZhi];
        [shouYiZhi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX).offset(-(self.center.x/2.0+30));
            make.centerY.equalTo(self);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(50);
            
            
        }];
        UIButton *Join=[UIButton buttonWithType:UIButtonTypeSystem];
        //Join.frame=CGRectMake(178, 58, 128, 30);
        // [Join setTitle:@"参与" forState:UIControlStateNormal];
        Join.titleLabel.font=[UIFont systemFontOfSize:15.0];
        [Join setTitle:@"立即存入" forState:UIControlStateNormal];
        [Join setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.caiFuBaoBtn=Join;
        Join.backgroundColor=RedButtonColor;;
        Join.layer.cornerRadius=5.0;
        Join.clipsToBounds=YES;
        [self addSubview:Join];
        [Join mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(-10);
            make.left.equalTo(line.mas_right).offset(10);
            make.right.equalTo(self.mas_right).offset(-10);
            //make.width.mas_equalTo(128);
            make.height.mas_equalTo(buttonHeight);
            
            
        }];
        

        UILabel *cunRu=[[UILabel alloc]init];
       // cunRu.frame=CGRectMake(169 , 22, 38, 20);
        cunRu.text=@"存入";
        cunRu.font=[UIFont systemFontOfSize:14.0];
       // cunRu.textAlignment=NSTextAlignmentRight;
        cunRu.textColor=[UIColor lightGrayColor];
        [self addSubview:cunRu];
        [cunRu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(Join.mas_top).offset(-10);
            make.left.equalTo(Join);
            make.height.mas_equalTo(buttonHeight);
            make.width.mas_equalTo(35);
            
            
        }];
        UILabel *yuan=[[UILabel alloc]init];
        // yuan.frame=CGRectMake(277 , 22, 29, 20);
        yuan.font=[UIFont systemFontOfSize:14.0];
        yuan.text=@"元";
    
        yuan.textColor=[UIColor lightGrayColor];
        [self addSubview:yuan];
        [yuan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.top.equalTo(cunRu);
            make.width.mas_equalTo(25);
            make.right.equalTo(Join.mas_right);
        }];
        
        UITextField *text=[[UITextField alloc]init];
       // text.frame=CGRectMake(215, 18, 63, 30);
        text.font=[UIFont systemFontOfSize:14];
        text.placeholder=@"1元起";
        text.borderStyle=UITextBorderStyleRoundedRect;
        text.keyboardType=UIKeyboardTypeNumberPad;
        text.textAlignment=NSTextAlignmentCenter;
        self.input=text;
        [self addSubview:text];
        [text mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(Join.mas_top).offset(-10);
            
            make.height.mas_equalTo(30);
            make.left.equalTo(cunRu.mas_right);
            make.right.equalTo(yuan.mas_left);
            
        }];
        
       
        
        
        
      
        UILabel *shouYiZhiXiao=[[UILabel alloc]init];
        //shouYiZhiXiao.frame=CGRectMake(85 ,15, 67, 49);
        shouYiZhiXiao.text=@".80%";
        //self.yinXiaoshu=shouYiZhiXiao;
        shouYiZhiXiao.font=[UIFont systemFontOfSize:19.0];
        shouYiZhiXiao.textAlignment=NSTextAlignmentLeft;
        shouYiZhiXiao.textColor=RedButtonColor;
        [self addSubview:shouYiZhiXiao];
        [shouYiZhiXiao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(shouYiZhi.mas_centerY);
            make.left.equalTo(shouYiZhi.mas_right);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(20);
            
            
        }];
        
        UILabel *shouyi=[[UILabel alloc]init];
        //shouyi.frame=CGRectMake(85 , 50, 47, 20);
        shouyi.text=YuQiShouYi;
        shouyi.font=[UIFont systemFontOfSize:12.0];
        shouyi.textAlignment=NSTextAlignmentLeft;
        shouyi.textColor=[UIColor lightGrayColor];
        [self addSubview:shouyi];
        [shouyi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(shouYiZhi.mas_centerY).offset(2);
            make.left.equalTo(shouYiZhiXiao);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(15.0);
            
            
        }];
        
        
        
        UILabel *zuiGao=[[UILabel alloc]init];
        //zuiGao.frame=CGRectMake(13 , 39, 39, 20);
        zuiGao.font=[UIFont systemFontOfSize:16.0];
        zuiGao.text=@"最高";
        zuiGao.textAlignment=NSTextAlignmentRight;
        [self addSubview:zuiGao];
        
        [zuiGao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(shouYiZhi);
            make.right.equalTo(shouYiZhi.mas_left);
            make.width.mas_equalTo(39);
            make.height.mas_equalTo(20);
            
            
        }];
        
   
        
        
        
    }
    return self;
}
@end
