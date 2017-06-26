//
//  CMHelpViewCell.m
//  CaiMao
//
//  Created by MAC on 16/11/2.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMHelpViewCell.h"

@implementation CMHelpViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor=ViewBackColor;
        [self addSubview:self.LeftView];
        [self.LeftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.equalTo(@5);
            make.left.equalTo(self.mas_left).offset(65);
            make.centerY.equalTo(self);
        }];
        
        [self addSubview:self.HeadTitle];
        [self.HeadTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.LeftView.mas_right).offset(7);
            make.height.mas_equalTo(self);
            make.width.mas_equalTo(102);
            make.centerY.equalTo(self);
        }];
        
        
      
        [self addSubview:self.RightImageView];
        [self.RightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-15);
            make.centerY.equalTo(self);
            make.height.mas_equalTo(11);
            make.width.mas_equalTo(7);
            
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

-(UILabel*)LeftView{
    if (!_LeftView) {
        _LeftView=[[UILabel alloc]init];
        _LeftView.backgroundColor=UIColorFromRGB(0x333333);
        _LeftView.layer.cornerRadius=2.5;
        _LeftView.clipsToBounds=YES;
    
    }
    return _LeftView;
    
}
-(UIImageView*)RightImageView{
    if (!_RightImageView) {
       _RightImageView=[[UIImageView alloc]init];
    
        _RightImageView.image=[UIImage imageNamed:@"listOpen.png"];
        
    }
    return _RightImageView;
}
-(UILabel*)HeadTitle{
    if (!_HeadTitle) {
        _HeadTitle=[[UILabel alloc]init];
        _HeadTitle.font=[UIFont systemFontOfSize:13.0];
        _HeadTitle.textColor=UIColorFromRGB(0x3333333);
        
    }
    return _HeadTitle;
}
@end
