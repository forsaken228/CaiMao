//
//  CMChiYouTitleView.m
//  CaiMao
//
//  Created by WangWei on 16/12/2.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMChiYouTitleView.h"

@implementation CMChiYouTitleView
-(id)init{
    
    self=[super init];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        [self addSubview:self.productTitle];
        [self.productTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@200);
            make.height.left.top.equalTo(self);
            
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

-(UILabel*)productTitle{
    if (!_productTitle) {
        _productTitle=[[UILabel alloc]init];
        _productTitle.textColor=UIColorFromRGB(0x333333);
        _productTitle.font=[UIFont boldSystemFontOfSize:13.0];
    }
    return _productTitle;
}

@end
