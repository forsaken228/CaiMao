//
//  CMChangeDetailViewCell.m
//  CaiMao
//
//  Created by MAC on 16/10/24.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMChangeDetailViewCell.h"

@implementation CMChangeDetailViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.DetailTitle];
        [self.DetailTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.centerY.equalTo(self);
            make.left.equalTo(self.mas_left).offset(21);
            make.width.equalTo(@150);
        }];
        [self addSubview:self.detailField];
        [self.detailField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self.mas_right).offset(-20);
            make.height.equalTo(@23);
            make.width.equalTo(@200);
        }];
        [self addSubview:self.getCode];
        [self.getCode mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self.mas_right).offset(-20);
            make.height.equalTo(@23);
            make.width.equalTo(@80);
        }];
        
        
        UILabel *Vline=[[UILabel alloc]init];
        Vline.backgroundColor=separateLineColor;
        [self addSubview:Vline];
        [Vline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
            make.bottom.width.left.equalTo(self);
        }];
    }
    return self;
}

-(UILabel*)DetailTitle{
    if (!_DetailTitle) {
        _DetailTitle=[UILabel new];
        _DetailTitle.textColor=UIColorFromRGB(0x5a5655);
        _DetailTitle.font=[UIFont systemFontOfSize:14];
        
    }
    return _DetailTitle;
    
}
-(UITextField*)detailField{
    if (!_detailField) {
        _detailField=[[UITextField alloc]init];
        _detailField.textAlignment=NSTextAlignmentRight;
        _detailField.font=[UIFont systemFontOfSize:14.0];
    }
    return _detailField;
}
-(UIButton*)getCode{
    if (!_getCode) {
        _getCode=[UIButton buttonWithType:UIButtonTypeCustom];
        [_getCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getCode setBackgroundColor:RedButtonColor];
        
        _getCode.titleLabel.font=[UIFont systemFontOfSize:13.0];
        
    }
    return _getCode;
}
@end
