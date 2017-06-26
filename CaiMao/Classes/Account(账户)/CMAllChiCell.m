//
//  CMAllChiCell.m
//  CaiMao
//
//  Created by WangWei on 16/12/1.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMAllChiCell.h"

@implementation CMAllChiCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        [self.contentView addSubview:self.QiCi];
        [self.contentView addSubview:self.ShouYiDate];
        [self.contentView addSubview:self.YSBenXi];
        [self.contentView addSubview:self.YSBenJin];
        [self.contentView addSubview:self.YSLiXi];
        [self.contentView addSubview: self.SYBenJin];

        [self.QiCi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@50);
            make.height.equalTo(@20);
            make.top.equalTo(self.contentView.mas_top).offset(5);
            make.left.equalTo(self.contentView.mas_left).offset(20);
            
        }];
        [self.ShouYiDate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@150);
            make.left.height.equalTo(self.QiCi);
            make.top.equalTo(self.QiCi.mas_bottom);
            
            
        }];
        [self.YSBenXi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(self.ShouYiDate);
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.top.equalTo(self.QiCi);
            
        }];
        [self.YSBenJin mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.height.equalTo(self.YSBenXi);
            
            make.top.equalTo(self.ShouYiDate);
            
        }];
        [ self.YSLiXi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.top.height.equalTo(self.YSBenXi);
            
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            
        }];
        
        [self.SYBenJin mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.top.width.equalTo(self.YSBenJin);
            make.right.equalTo(self.YSLiXi);
            
        }];
        
        UILabel *Vline=[[UILabel alloc]init];
        Vline.backgroundColor=ViewBackColor;
        [self.contentView addSubview:Vline];
        [Vline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@10);
            make.bottom.width.left.equalTo(self);
        }];
        UIImage *image=[UIImage imageNamed:@"LoadMore"];
        [self.contentView addSubview:self.loadMoreImage];
        [self.loadMoreImage  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(image.size.height);
            make.width.mas_equalTo(image.size.width);
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(self.SYBenJin.mas_bottom).offset(5);
        }] ;
        
    }
    return self;
    
}

#pragma mark Lazy

-(UIImageView*)loadMoreImage{
    if (!_loadMoreImage) {
        _loadMoreImage=[[UIImageView  alloc]init];
        _loadMoreImage.image=[UIImage imageNamed:@"LoadMore"];
        _loadMoreImage.hidden=YES;
    }
    return _loadMoreImage;
}
-(UILabel*)QiCi{
    if (!_QiCi) {
        _QiCi=[[UILabel alloc]init];
        
        _QiCi.font=[UIFont systemFontOfSize:12.0];
        _QiCi.textColor=UIColorFromRGB(0x3a3836);
        _QiCi.textAlignment=NSTextAlignmentLeft;

    }
    return _QiCi;
}
-(UILabel*)ShouYiDate{
    if (!_ShouYiDate) {
        
        _ShouYiDate=[[UILabel alloc]init];
        
        _ShouYiDate.font=[UIFont systemFontOfSize:12.0];
        _ShouYiDate.textColor=UIColorFromRGB(0x999999);
        _ShouYiDate.textAlignment=NSTextAlignmentLeft;

    }
    return _ShouYiDate;
}
-(UILabel*)YSBenJin{
    if (!_YSBenJin) {
        
        _YSBenJin=[[UILabel alloc]init];
        
        
        _YSBenJin.font=[UIFont systemFontOfSize:12.0];
        _YSBenJin.textColor=UIColorFromRGB(0x999999);
        _YSBenJin.textAlignment=NSTextAlignmentCenter;
    }
    return _YSBenJin;
}
-(UILabel*)YSBenXi{
    if (!_YSBenXi) {
        
        _YSBenXi=[[UILabel alloc]init];

        _YSBenXi.font=[UIFont systemFontOfSize:12.0];
        _YSBenXi.textColor=UIColorFromRGB(0x3a3836);
        _YSBenXi.textAlignment=NSTextAlignmentCenter;
        
    }
    return _YSBenXi;
}
-(UILabel*)YSLiXi{
    if (!_YSLiXi) {
        
        _YSLiXi=[[UILabel alloc]init];

        _YSLiXi.font=[UIFont systemFontOfSize:12.0];
        _YSLiXi.textColor=UIColorFromRGB(0x3a3836);
        _YSLiXi.textAlignment=NSTextAlignmentRight;
        
    }
    return _YSLiXi;
}
-(UILabel*)SYBenJin{
    if (!_SYBenJin) {
        _SYBenJin=[[UILabel alloc]init];
        _SYBenJin.font=[UIFont systemFontOfSize:12.0];
        _SYBenJin.textColor=UIColorFromRGB(0x999999);
        _SYBenJin.textAlignment=NSTextAlignmentRight;
    }
    return _SYBenJin;
}
@end
