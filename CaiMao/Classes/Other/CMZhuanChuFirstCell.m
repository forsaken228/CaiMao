//
//  CMZhuanChuFirstCell.m
//  CaiMao
//
//  Created by MAC on 16/11/10.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMZhuanChuFirstCell.h"

@implementation CMZhuanChuFirstCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
    
                UILabel *label=[[UILabel alloc]init];
                label.font=[UIFont systemFontOfSize:14.0];
                label.textColor=UIColorFromRGB(0x333333);
                label.text=@"转出金额";
                [self addSubview:label];
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.height.equalTo(@20);
                    make.left.equalTo(self.mas_left).offset(15);
                    make.centerY.equalTo(self);
                    make.width.equalTo(@100);
                    
                }];
        
        UILabel *right=[[UILabel alloc]init];
        right.font=[UIFont systemFontOfSize:14.0];
        right.textColor=UIColorFromRGB(0x333333);
        right.textAlignment=NSTextAlignmentRight;
        right.text=@"元";
        [self addSubview:right];
        [right mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.right.equalTo(self.mas_right).offset(-15);
            make.centerY.equalTo(self);
            make.width.equalTo(@20);
            
        }];
        [self addSubview:self.ZhuChuAmount];
        [self.ZhuChuAmount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.centerY.equalTo(right);
            make.width.equalTo(@150);
            make.right.equalTo(right.mas_left);
        }];
        
    }
    
    return self;
    
}
-(UITextField*)ZhuChuAmount{
    if (!_ZhuChuAmount) {
        _ZhuChuAmount=[[UITextField alloc]init];
        _ZhuChuAmount.textAlignment=NSTextAlignmentRight;
        _ZhuChuAmount.font=[UIFont systemFontOfSize:14.0];
        _ZhuChuAmount.placeholder=@"输入转出金额";
        _ZhuChuAmount.text=@"100";
        _ZhuChuAmount.keyboardType=UIKeyboardTypeNumberPad;
        _ZhuChuAmount.textColor=UIColorFromRGB(0x8e8d93);
    }
    return _ZhuChuAmount;
}

@end
