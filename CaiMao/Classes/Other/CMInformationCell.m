//
//  CMInformationCell.m
//  CaiMao
//
//  Created by MAC on 16/10/26.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMInformationCell.h"

@implementation CMInformationCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.DetailTitle];
        [self.DetailTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.centerY.equalTo(self);
            make.left.equalTo(self.mas_left).offset(20);
            make.width.equalTo(@150);
        }];
        [self addSubview:self.detailField];
        [self.detailField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self.mas_right).offset(-20);
            make.height.equalTo(@23);
            make.width.equalTo(@200);
        }];
        [self addSubview:self.WomanBtn];
        [self.WomanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self.mas_right).offset(-20);
            make.height.equalTo(@15);
            make.width.equalTo(@40);
        }];
        [self addSubview:self.manBtn];
        [self.manBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self.WomanBtn.mas_left).offset(-5);
            make.height.width.equalTo(self.WomanBtn);
            
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
        _DetailTitle.textColor=UIColorFromRGB(0x333333);
        _DetailTitle.font=[UIFont systemFontOfSize:14];
        
    }
    return _DetailTitle;
    
}
-(UITextField*)detailField{
    if (!_detailField) {
        _detailField=[[UITextField alloc]init];
        _detailField.textAlignment=NSTextAlignmentRight;
        _detailField.font=[UIFont systemFontOfSize:14.0];
        _detailField.textColor=UIColorFromRGB(0x5a5655);
        
    }
    return _detailField;
}
-(UIButton*)manBtn{
    if (!_manBtn) {
        _manBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_manBtn setImage:[UIImage imageNamed:@"zhifu_xziocn.png"] forState:UIControlStateNormal];
        [_manBtn setImageEdgeInsets:UIEdgeInsetsMake(2,2,2, 27)];
        [_manBtn setTitle:@"男" forState:UIControlStateNormal];
        [_manBtn setTitleColor:UIColorFromRGB(0x5a5655) forState:UIControlStateNormal];
        _manBtn.titleEdgeInsets=UIEdgeInsetsMake(0,-15,0, 0);
        
        _manBtn.titleLabel.font=[UIFont systemFontOfSize:12.0];
        [_manBtn addTarget:self action:@selector(changeSex:) forControlEvents:UIControlEventTouchUpInside];
        _manBtn.tag=100;
    }
    return _manBtn;
}
-(UIButton*)WomanBtn{
    if (!_WomanBtn) {
        _WomanBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_WomanBtn setImage:[UIImage imageNamed:@"zhifu_xziocn.png"] forState:UIControlStateNormal];
        [_WomanBtn setImageEdgeInsets:UIEdgeInsetsMake(2,2,2, 27)];
        [_WomanBtn setTitle:@"女" forState:UIControlStateNormal];
        [_WomanBtn setTitleColor:UIColorFromRGB(0x5a5655) forState:UIControlStateNormal];
        _WomanBtn.titleEdgeInsets=UIEdgeInsetsMake(0,-15,0, 0);
        _WomanBtn.titleLabel.font=[UIFont systemFontOfSize:12.0];
        [_WomanBtn addTarget:self action:@selector(changeSex:) forControlEvents:UIControlEventTouchUpInside];
        _WomanBtn.tag=101;
    }
    return _WomanBtn;
}

-(void)changeSex:(UIButton*)btn{
    
    if ([self.delegate respondsToSelector:@selector(clickChangeWithButtonTag:andIndex:)]) {
        [self.delegate clickChangeWithButtonTag:btn.tag andIndex:self.IndexPath];
    }
    
}

@end
