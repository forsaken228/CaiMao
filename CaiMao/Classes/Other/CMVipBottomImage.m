//
//  CMVipBottomImage.m
//  CaiMao
//
//  Created by MAC on 16/11/8.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMVipBottomImage.h"

@implementation CMVipBottomImage

-(id)init{
    self=[super init];
    if (self) {
        [self addSubview:self.leftImage];
        [self addSubview:self.rightBottomLabel];
        [self addSubview:self.rightTopLabel];
        [self.leftImage  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.equalTo(@39);
            make.left.equalTo(self.mas_left).offset(25);
            make.centerY.equalTo(self);
        }];
        [self.rightTopLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.width.equalTo(@100);
            make.left.equalTo(self.leftImage.mas_right).offset(5);
            make.bottom.equalTo(self.leftImage.mas_centerY).offset(-2);
        }];
        [self.rightBottomLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.left.equalTo(self.rightTopLabel);
        
            make.top.equalTo(self.leftImage.mas_centerY).offset(2);
        }];
    }
    return self;
}
-(UIImageView*)leftImage{
    if (!_leftImage) {
        _leftImage=[[UIImageView alloc]init];
        
    }
    return _leftImage;
    
}
-(UILabel*)rightTopLabel{
    if (!_rightTopLabel) {
        _rightTopLabel=[[UILabel alloc]init];
        _rightTopLabel.textColor=RedButtonColor;
        _rightTopLabel.font=[UIFont systemFontOfSize:14];
    
    }
    return _rightTopLabel;
}

-(UILabel*)rightBottomLabel{
    if (!_rightBottomLabel) {
        _rightBottomLabel=[[UILabel alloc]init];
        _rightBottomLabel.textColor=UIColorFromRGB(0x8f8e93);
        _rightBottomLabel.font=[UIFont systemFontOfSize:12];
        
    }
    return _rightBottomLabel;
}
@end
