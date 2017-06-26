//
//  CMProductDetailHeadCell.m
//  CaiMao
//
//  Created by WangWei on 17/3/23.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import "CMProductDetailHeadCell.h"

@implementation CMProductDetailHeadCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.top.equalTo(self);
            make.width.equalTo(@100);
            make.left.equalTo(self.mas_left).offset(20);
        }];
        
        [self addSubview:self.detailLabel];
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.top.equalTo(self);
            make.width.equalTo(@150);
            make.left.equalTo(self.titleLabel.mas_right).offset(30);
        }];
        
     
        self.riskImageView.image=[UIImage imageNamed:@"rishIcon"];
        [self addSubview:self.riskImageView];
        
        [self.riskImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self.riskImageView.image.size.height);
            make.width.mas_equalTo(self.riskImageView.image.size.width);
            make.centerY.equalTo(self);
            make.left.equalTo(self.detailLabel.mas_right).offset(2);
            
        }];
        
        UILabel *hL=[[UILabel alloc]init];
        hL.backgroundColor=separateLineColor;
        [self addSubview:hL];
        [hL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5);
            make.bottom.width.equalTo(self);
            
        }];
        
    }
    return self;
}


-(UILabel*)titleLabel{
    if (!_titleLabel) {
     
       _titleLabel=[[UILabel alloc]init];
        _titleLabel.font=[UIFont systemFontOfSize:15.0];
        _titleLabel.textColor=[UIColor lightGrayColor];
   
        
    }
    
    return _titleLabel;
}
-(UILabel*)detailLabel{
    if (!_detailLabel) {
        
        _detailLabel=[[UILabel alloc]init];
        _detailLabel.font=[UIFont systemFontOfSize:15.0];

    }
    
    return _detailLabel;
}
-(UIImageView*)riskImageView{
    if (!_riskImageView) {
        
        _riskImageView=[[UIImageView alloc]init];
        _riskImageView.hidden=YES;

    }
    
    return _riskImageView;
}
@end
