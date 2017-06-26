//
//  CMZhuanChuSuccessFootView.m
//  CaiMao
//
//  Created by MAC on 16/11/11.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMZhuanChuSuccessFootView.h"

@implementation CMZhuanChuSuccessFootView

-(instancetype)init{
    self=[super init];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        UIImageView *RightImage=[[UIImageView alloc]init];
        RightImage.image=[UIImage imageNamed:@"zfcg_chengong_icon"];
        RightImage.clipsToBounds=YES;
        RightImage.layer.cornerRadius=24/2.0;
        [self addSubview:RightImage];
        [RightImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.equalTo(@24);
            
            make.top.equalTo(self.mas_top).offset(15);
            make.centerX.equalTo(self);
        }];

        UILabel  *success=[[UILabel alloc]init];
        success.text=@"转出成功!";
        success.font=[UIFont systemFontOfSize:16];
        success.textColor=UIColorFromRGB(0x4d4d4d);
        success.textAlignment=NSTextAlignmentCenter;
        [self addSubview:success];
        [success mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@17);
            make.width.equalTo(@150);
            make.centerX.equalTo(RightImage);
            make.top.equalTo(RightImage.mas_bottom).offset(8);
        }];
        [self addSubview:self.detailLabel];
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@17);
make.right.equalTo(self.mas_right).offset(-10);
            make.left.equalTo(self.mas_left).offset(10);
            make.top.equalTo(success.mas_bottom).offset(10);
        }];
        NSArray *titleArr=@[@"财富账户",@"特惠活动",@"我要投资"];
        for (int i=0; i<titleArr.count; i++) {
        
            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            button.frame=CGRectMake(i%titleArr.count*(CMScreenW/3.0), 100, CMScreenW/3.0, 20);
            button.titleLabel.font=[UIFont systemFontOfSize:14.0];
            [button setTitle:titleArr[i] forState:UIControlStateNormal];
            [button setTitleColor:UIColorFromRGB(0x1b84ed) forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            button.tag=i+10;
            [self addSubview:button];
            
            
        }
        
        
        
        
        
        
        
    }
    return self;
}
-(UILabel*)detailLabel{
    if (!_detailLabel) {
        _detailLabel=[[UILabel alloc]init];
        _detailLabel.font=[UIFont systemFontOfSize:11];
        _detailLabel.textColor=UIColorFromRGB(0x4d4d4d);
        _detailLabel.textAlignment=NSTextAlignmentCenter;
    }
    
    return _detailLabel;
}

-(void)buttonAction:(UIButton*)btn{
    
    if ([_delegate respondsToSelector:@selector(changeViewActionWithTag:)]) {
        [_delegate  changeViewActionWithTag:btn.tag];
    }
    
}
@end
