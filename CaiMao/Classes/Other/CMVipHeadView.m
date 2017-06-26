//
//  CMVipHeadView.m
//  CaiMao
//
//  Created by MAC on 16/11/5.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMVipHeadView.h"

@implementation CMVipHeadView

-(instancetype)init{
    self=[super init];
    if (self) {
        UIImage *image=[UIImage imageNamed:@"VIPProduct"];
        self.backgroundColor=ViewBackColor;
        UIImageView  *TopImageView=[[UIImageView alloc]init];
        TopImageView.image=image;
        [self addSubview:TopImageView];
        [TopImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.width.equalTo(self);
            make.height.mas_equalTo(f_i5real(image.size.height));
        }];
        
        UIView *line=[[UIView alloc]init];
        line.backgroundColor=UIColorFromRGB(0xff7500);
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.width.equalTo(@2);
            make.left.equalTo(self.mas_left).offset(10);
            make.top.equalTo(TopImageView.mas_bottom).offset(10);
        }];
        
        UILabel *Title=[[UILabel alloc]init];
        Title.text=@"VIP专属理财产品";
        Title.textColor=UIColorFromRGB(0xbbbbbb);
        Title.font=[UIFont boldSystemFontOfSize:15];
        [self addSubview:Title];
        [Title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.top.equalTo(line);
            make.width.equalTo(@150);
            make.left.equalTo(line.mas_right).offset(5);
        }];
        
        
    }
    return self;
}


@end
