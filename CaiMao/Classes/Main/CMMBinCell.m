//
//  CMMBinCell.m
//  CaiMao
//
//  Created by MAC on 16/10/27.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMMBinCell.h"

@implementation CMMBinCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.MBNum];
        [self.MBNum  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@100);
            make.height.centerY.equalTo(self);
            make.right.equalTo(self.mas_right).offset(-15);
            
        }];
        [self addSubview:self.FromSource];
        [self.FromSource  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@150);
            make.height.equalTo(@15);
            make.left.equalTo(self.mas_left).offset(15);
            make.bottom.equalTo(self.mas_centerY).offset(-2);
            
        }];
        
        [self addSubview:self.JoinDate];
        [self.JoinDate  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.left.equalTo(self.FromSource);
            make.top.equalTo(self.mas_centerY).offset(2);
            
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


-(UILabel*)FromSource{
    if (!_FromSource) {
        _FromSource=[[UILabel alloc]init];
        _FromSource.textColor=UIColorFromRGB(0x333333);
        _FromSource.font=[UIFont systemFontOfSize:13.0];
    }
    return _FromSource;
}
-(UILabel*)JoinDate{
    if (!_JoinDate) {
        _JoinDate=[[UILabel alloc]init];
        _JoinDate.textColor=UIColorFromRGB(0xb3b3b3);
        _JoinDate.font=[UIFont systemFontOfSize:13.0];
    }
    return _JoinDate;
}
-(UILabel*)MBNum{
    if (!_MBNum) {
        _MBNum=[[UILabel alloc]init];
        _MBNum.textColor=RedButtonColor;
        _MBNum.font=[UIFont systemFontOfSize:16.0];
        _MBNum.textAlignment=NSTextAlignmentRight;
    }
    return _MBNum;
}
@end
