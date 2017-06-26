//
//  CMHelpHeadView.m
//  CaiMao
//
//  Created by MAC on 16/10/21.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMHelpHeadView.h"

@implementation CMHelpHeadView


-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor=[UIColor whiteColor];
        UIImage *image=[UIImage imageNamed:@"新手入门"];
        [self addSubview:self.LeftImageView];
        [self.LeftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.width.mas_equalTo(f_i5real(image.size.width));
            make.height.mas_equalTo(f_i5real(image.size.height));
            make.centerY.equalTo(self);
        }];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.LeftImageView.mas_right).offset(10);
            make.height.equalTo(self);
            make.width.mas_equalTo(102);
            make.top.equalTo(self.mas_top);
        }];
        
        
               [self addSubview:self.rightImageView];
        [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-15);
            make.top.equalTo(self.mas_top).offset(16);
            make.height.mas_equalTo(11);
            make.width.mas_equalTo(7);
            
        }];
        
        UILabel *line=[[UILabel alloc]init];
        line.backgroundColor=separateLineColor;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.width.equalTo(self);
            make.height.equalTo(@0.5);
        }];

    }
    
    return self;
    
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc]init];
        _titleLabel.font=[UIFont systemFontOfSize:15];
        _titleLabel.textColor=UIColorFromRGB(0x333333);
    }
    return _titleLabel;
    
    
}
-(UIImageView*)LeftImageView{
    if (!_LeftImageView) {
        _LeftImageView=[[UIImageView alloc]init];
           }
    return _LeftImageView;
}
-(UIImageView*)rightImageView{
    if (!_rightImageView) {
        _rightImageView=[[UIImageView alloc]init];
        _rightImageView.image=[UIImage imageNamed:@"listOpen"];
    }
    return _rightImageView;
}
@end
