//
//  CMDuiHuanButton.m
//  CaiMao
//
//  Created by MAC on 16/9/6.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMDuiHuanButton.h"

@implementation CMDuiHuanButton

-(instancetype)initWithImageView:(NSString*)ALeftImage andButton:(NSString*)aButton{
    self=[super init];
    if (self) {
     
        UILabel *moring=[[UILabel alloc]init];
        moring.font=[UIFont systemFontOfSize:15];
        moring.text=aButton;
        moring.textAlignment=NSTextAlignmentCenter;
        moring.textColor=CMColor(115, 116, 117);
        [self addSubview:moring];
        [moring mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@30);
            make.width.mas_equalTo(70);
            make.center.equalTo(self);
          }];
        
        UIImageView *image=[[UIImageView alloc]init];
        image.image=[UIImage imageNamed:ALeftImage];
        [self addSubview:image];
        [image mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.width.mas_equalTo(f_i5real(24));
            make.right.equalTo(moring.mas_left);
            make.centerY.equalTo(moring);
        }];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]init];
        self.MyIntegralBtn=tap;
        [self addGestureRecognizer:tap];
        
    }
    return self;
}

@end
