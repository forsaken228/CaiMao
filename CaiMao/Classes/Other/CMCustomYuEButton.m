//
//  CMCustomYuEButton.m
//  CaiMao
//
//  Created by MAC on 16/11/9.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMCustomYuEButton.h"

@implementation CMCustomYuEButton
-(id)init{
    self=[super init];
    if (self) {
        [self addSubview:self.LeftimageView];
        [self addSubview:self.rightLabel];
        [self.LeftimageView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.equalTo(@10);
            make.centerY.equalTo(self);
            make.left.equalTo(self);
        }];
        
        [self.rightLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.centerY.equalTo(self);
            make.left.equalTo(self.LeftimageView.mas_right).offset(5);
            make.width.equalTo(@200);
        }];
    }
    
    return self;
    
    
}
-(UIImageView*)LeftimageView{
    if (!_LeftimageView) {
        _LeftimageView=[[UIImageView alloc]init];
        _LeftimageView.userInteractionEnabled=YES;
    }
    return _LeftimageView;
}
-(UILabel*)rightLabel{
    if (!_rightLabel) {
        _rightLabel=[[UILabel  alloc]init];
        _rightLabel.font=[UIFont systemFontOfSize:13.0];
        _rightLabel.textColor=UIColorFromRGB(0x4d4d4d);
        _rightLabel.userInteractionEnabled=YES;
    }
    return _rightLabel;
}
@end
