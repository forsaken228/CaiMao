//
//  CMYuDingView.m
//  CaiMao
//
//  Created by MAC on 16/11/7.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMYuDingView.h"

@implementation CMYuDingView

-(instancetype)init{
    self=[super init];
    
    if (self) {
    
        UIImageView  *image=[[UIImageView alloc]init];
        image.image=[UIImage imageNamed:@"dropdown_01"];
        [self addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.equalTo(@50);
            make.top.equalTo(self.mas_top).offset(15);
            make.centerX.equalTo(self);
        }];
        UILabel  *label=[[UILabel alloc]init];
        label.text=@"暂无记录";
        label.font=[UIFont systemFontOfSize:14.0];
        label.textColor=UIColorFromRGB(0x333333);
        label.textAlignment=NSTextAlignmentCenter;
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.centerX.width.equalTo(self);
            make.top.equalTo(image.mas_bottom);
        }];
        self.GoActionBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.GoActionBtn setTitleColor:UIColorFromRGB(0xf69220) forState:UIControlStateNormal];
        self.GoActionBtn.layer.borderColor=UIColorFromRGB(0xf69220).CGColor;
        self.GoActionBtn.layer.borderWidth=0.5;
        [self.GoActionBtn setTitle:@"预定18节产品" forState:UIControlStateNormal];
        self.GoActionBtn.titleLabel.font=[UIFont systemFontOfSize:15.0];
        [self addSubview:self.GoActionBtn];
        [self.GoActionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@30);
            make.width.equalTo(@200);
            make.top.equalTo(label.mas_bottom).offset(10);
            make.centerX.equalTo(self);
        }];
        
        
    }
    
    return self;
    
}
@end
