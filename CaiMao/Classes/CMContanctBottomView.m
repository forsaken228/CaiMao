//
//  CMContanctBottomView.m
//  CaiMao
//
//  Created by MAC on 16/10/12.
//  Copyright © 2016年 58cm. All rights reserved.
//
#import "CMContanctBottomView.h"

@interface CMContanctBottomView ()
@property(nonatomic,strong)UIImageView *leftImage;
@property(nonatomic,strong)UILabel *rightLabel;

@end


@implementation CMContanctBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.rightLabel];
        [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.centerX.centerY.equalTo(self);
            make.width.equalTo(@140);
            
            
        }];
        [self addSubview:self.leftImage];
        [self.leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(f_i5real(14));
            make.width.mas_equalTo(f_i5real(17));
            make.right.equalTo(self.rightLabel.mas_left);
            make.centerY.equalTo(self.rightLabel);
        }];
        
    }
    return self;
}
-(UIImageView*)leftImage{
    if (!_leftImage) {
        _leftImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bottomImage"]];
        
        
    }
    return _leftImage;
}
-(UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel=[[UILabel alloc]init];
        _rightLabel.text=@"送所有好友80元红包";
        _rightLabel.textColor=[UIColor whiteColor];
        _rightLabel.font=[UIFont systemFontOfSize:14.0];
        _rightLabel.textAlignment=NSTextAlignmentCenter;
        
    }
    return _rightLabel;
}
@end
