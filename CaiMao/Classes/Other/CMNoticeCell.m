//
//  CMNoticeCell.m
//  CaiMao
//
//  Created by MAC on 16/11/5.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMNoticeCell.h"

@implementation CMNoticeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubview:self.Title];
        [self addSubview:self.GaiYao];
        [self addSubview:self.Time];
        [self addSubview:self.CheackDeatiBtn];
      
        [self.Title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@16);
            make.right.equalTo(self.mas_right);
            make.left.equalTo(self.mas_left).offset(10);
            make.top.equalTo(self.mas_top).offset(8);
        }];
        
        UIView *line=[UIView new];
        line.backgroundColor=separateLineColor;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
            make.width.left.equalTo(self);
            make.top.equalTo(self.Title.mas_bottom).offset(8);
        }];
        
        UIView *SLine=[UIView new];
        SLine.backgroundColor=ViewBackColor;
        [self addSubview:SLine];
        [SLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@10);
            make.width.bottom.left.equalTo(self);
        }];
        [self.Time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.width.mas_equalTo(100);
            make.left.equalTo(self.Title);
            make.bottom.equalTo(SLine.mas_top).offset(-8);
        }];
        [self.CheackDeatiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.width.mas_equalTo(100);
            make.right.equalTo(self.mas_right).offset(-15);
            make.bottom.equalTo(SLine.mas_top).offset(-8);
        }];
        [self.GaiYao mas_makeConstraints:^(MASConstraintMaker *make) {

            make.right.equalTo(self.CheackDeatiBtn);
            make.left.equalTo(self.Title);
            make.top.equalTo(line.mas_bottom).offset(5);
            make.bottom.equalTo(self.Time.mas_top).offset(-5);
        }];
    }
    return self;
}


-(UILabel*)Title{
    if (!_Title) {
        _Title=[[UILabel alloc]init];
        _Title.textColor=UIColorFromRGB(0x333333);
        _Title.font=[UIFont systemFontOfSize:14];
        
    }
    
    return _Title;
}

-(UILabel*)GaiYao{
    if (!_GaiYao) {
        _GaiYao=[[UILabel alloc]init];
        _GaiYao.textColor=UIColorFromRGB(0x5a5657);
        _GaiYao.font=[UIFont systemFontOfSize:12];
        _GaiYao.numberOfLines=0;
    }
    
    return _GaiYao;
}
-(UILabel*)Time{
    if (!_Time) {
        _Time=[[UILabel alloc]init];
        _Time.textColor=UIColorFromRGB(0xbbbbbb);
        _Time.font=[UIFont systemFontOfSize:12];
       
    }
    
    return _Time;
}
-(UIButton*)CheackDeatiBtn{
    if (!_CheackDeatiBtn) {
        
        _CheackDeatiBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_CheackDeatiBtn setTitleColor:UIColorFromRGB(0x0e94ee) forState:UIControlStateNormal];
        [_CheackDeatiBtn setTitle:@"查看详情>>" forState:UIControlStateNormal];
        _CheackDeatiBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
        _CheackDeatiBtn.titleLabel.font=[UIFont systemFontOfSize:12.0];
        
    }
    return _CheackDeatiBtn;
}
@end
