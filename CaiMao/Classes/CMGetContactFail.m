//
//  CMGetContactFail.m
//  CaiMao
//
//  Created by MAC on 16/10/11.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMGetContactFail.h"

@implementation CMGetContactFail

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        UIImage *image=[UIImage imageNamed:@"yqhy_txlshibai"];
        UIImageView *topImageView=[[UIImageView alloc]init];
        topImageView.image=image;
        [self addSubview:topImageView];
        [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(f_i5real(image.size.height));
            make.width.mas_equalTo(f_i5real(image.size.width));
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.mas_top).offset(75/2.0);
            
        }];
        
        UILabel *detail=[[UILabel alloc]init];
        detail.text=@"获取通讯录失败,原因可能为:";
        detail.font =[UIFont systemFontOfSize:12.0];
        detail.textColor=UIColorFromRGB(0xb1b0b6);
        [self addSubview:detail];
        [detail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topImageView.mas_bottom).offset(30);
            make.left.equalTo(self.mas_left).offset(20);
            make.height.equalTo(@15);
            make.width.equalTo(@200);
        }];
    
        UILabel *detailOne=[[UILabel alloc]init];
        detailOne.text=@"1.财猫没有权限访问您的通讯录。请先退出财猫,在系统设置或手机安全软件中,授权财猫访问通讯录。";
        CGSize rect=[ detailOne.text boundingRectWithSize:CGSizeMake(CMScreenW-40, 50) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]} context:nil].size;
        detailOne.numberOfLines=0;
        detailOne.font =[UIFont systemFontOfSize:12.0];
        detailOne.textColor=UIColorFromRGB(0x8f8e93);
        [self addSubview:detailOne];
        [detailOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-20);
            make.left.equalTo(detail);
            make.height.mas_equalTo(rect.height+5);
            make.top.equalTo(detail.mas_bottom).offset(20/2.0);
        }];
        UILabel *detailSecond=[[UILabel alloc]init];
        detailSecond.text=@"2.手机通讯录中没有联系人资料";
        detailSecond.font =[UIFont systemFontOfSize:12.0];
        detailSecond.textColor=UIColorFromRGB(0x8f8e93);
        [self addSubview:detailSecond];
        [detailSecond mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-20);
            make.left.equalTo(detailOne);
            make.height.mas_equalTo(15);
            make.top.equalTo(detailOne.mas_bottom);
        }];

    }
    return self;
}

@end
