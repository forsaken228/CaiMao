//
//  CMBottomXuanFu.m
//  CaiMao
//
//  Created by MAC on 16/9/1.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMBottomXuanFu.h"

@implementation CMBottomXuanFu

-(void)creatbuttonImage:(NSString*)ahedImage andTitle:(NSString*)aTitle{
    UILabel *zhuan=[[UILabel alloc]init];
    zhuan.text=aTitle;
    zhuan.textColor=[UIColor whiteColor];
    zhuan.font=[UIFont systemFontOfSize:18.0];
    [self addSubview:zhuan];
    [zhuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_centerX);
        make.height.equalTo(@20);
        make.width.equalTo(@80);
    }];
    
UIImage *tImage=[UIImage imageNamed:ahedImage];
   UIImageView *imageView=[[UIImageView alloc]init];
    imageView.image=tImage;
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(tImage.size.height);
        make.width.mas_equalTo(tImage.size.width);
        make.right.equalTo(zhuan.mas_left).offset(-5);
        make.top.equalTo(zhuan);
    }];
 
}

@end
