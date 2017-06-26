//
//  CMMBin.m
//  CaiMao
//
//  Created by MAC on 16/10/27.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMMBin.h"

@implementation CMMBin

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        UIImage *image=[UIImage imageNamed:@"zh_wdmb_beijing"];
        self.backgroundColor=[UIColor whiteColor];
        UIImageView *bgImage=[[UIImageView alloc]init];
        bgImage.userInteractionEnabled=YES;
        bgImage.image=image;
        [self addSubview:bgImage];
        [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(f_i5real(image.size.height));
            make.width.top.left.equalTo(self);
            
        }];
       
        UILabel *JF=[[UILabel alloc]init];
        self.MyBin=JF;
        JF.textAlignment=NSTextAlignmentCenter;
        JF.font=[UIFont systemFontOfSize:40.0];
        JF.textColor=[UIColor whiteColor];
        [bgImage addSubview:JF];
        [JF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(f_i5real(50));
            make.width.equalTo(bgImage);
            make.bottom.equalTo(bgImage.mas_centerY);
            make.centerX.equalTo(bgImage.mas_centerX);
            
        }];
        
        
        CMDuiHuanButton *duihuan=[[CMDuiHuanButton alloc]initWithImageView:@"MBin" andButton:@"抢M币"];
        duihuan.frame=CGRectMake(0, f_i5real(image.size.height), CMScreenW/2.0,f_i5real(45));
        duihuan.tag=10;
        self.getMBin=duihuan;
        [self addSubview:duihuan];
        
        CMDuiHuanButton *duihuan1=[[CMDuiHuanButton alloc]initWithImageView:@"touzi" andButton:@"去投资"];
        duihuan1.frame=CGRectMake(CMScreenW/2.0, f_i5real(image.size.height), CMScreenW/2.0,f_i5real(45) );
        duihuan1.tag=11;
        self.GoTouZi=duihuan1;
        [self addSubview:duihuan1];
       
        
    }
    return self;
}


@end
