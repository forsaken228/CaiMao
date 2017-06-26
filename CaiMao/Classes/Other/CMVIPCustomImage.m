//
//  CMVIPCustomImage.m
//  CaiMao
//
//  Created by MAC on 16/11/7.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMVIPCustomImage.h"

@implementation CMVIPCustomImage

-(instancetype)init{
    self=[super init];
    if (self) {
        [self addSubview:self.TopImage];
        [self addSubview:self.MidLabel];
        [self addSubview:self.bottomLabel];
        [self.TopImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(21);
            make.width.mas_equalTo(18);
            make.top.equalTo(self.mas_top).offset(7.5);
            make.centerX.equalTo(self);
        }];
        [self.MidLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(13);
            make.top.equalTo(self.TopImage.mas_bottom).offset(9);
            make.width.centerX.equalTo(self);
        }];
        [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
            make.top.equalTo(self.MidLabel.mas_bottom).offset(7);
            make.width.centerX.equalTo(self);
        }];
        
        
    }
    return self;
}
-(UIImageView*)TopImage{
    if (!_TopImage) {
        _TopImage=[[UIImageView alloc]init];
        
    }
    
    return _TopImage;
}

-(UILabel*)MidLabel{
    if (!_MidLabel) {
        _MidLabel=[[UILabel alloc]init];
        _MidLabel.textAlignment=NSTextAlignmentCenter;
        _MidLabel.textColor=[UIColor whiteColor];
        _MidLabel.font=[UIFont systemFontOfSize:10.0];
    }
    return _MidLabel;
}

-(UILabel*)bottomLabel{
    if (!_bottomLabel) {
        _bottomLabel=[[UILabel alloc]init];
        _bottomLabel.textAlignment=NSTextAlignmentCenter;
        _bottomLabel.textColor=[UIColor whiteColor];
        _bottomLabel.numberOfLines=0;
        _bottomLabel.font=[UIFont systemFontOfSize:10.0];
        _bottomLabel.contentMode=UIViewContentModeTop;
    }
    return _bottomLabel;
}
@end
