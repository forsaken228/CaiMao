//
//  CMRecordBgView.m
//  CaiMao
//
//  Created by MAC on 16/9/1.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMRecordBgView.h"

@implementation CMRecordBgView

-(instancetype)init{
    self=[super init];
    if (self) {
       
        
    }
    return self;
}
-(void)creatHeadImage:(NSString*)ahedImage andTitle:(NSString*)aTitle{
    
    UIImage *tImage=[UIImage imageNamed:ahedImage];
    imageView=[[UIImageView alloc]init];
    imageView.image=tImage;
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(tImage.size.height);
        make.width.mas_equalTo(tImage.size.width);
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(20);
    }];
    
    label1=[[UILabel alloc]init];
    label1.text=aTitle;
    label1.textAlignment=NSTextAlignmentCenter;
    label1.font=[UIFont boldSystemFontOfSize:14.0];
    label1.textColor=UIColorFromRGB(0xb3b3b3);
    [self addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.left.equalTo(self);
        make.height.equalTo(@20);
        make.top.equalTo(imageView.mas_bottom).offset(8);
    }];
    
}
-(void)cleanNsstring{
    
    imageView.image=nil;
     label1.text=nil;
}

@end
