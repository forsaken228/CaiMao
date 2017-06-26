//
//  CMAllChiheadFootView.m
//  CaiMao
//
//  Created by WangWei on 16/12/1.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMAllChiheadFootView.h"

@implementation CMAllChiheadFootView


-(id)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor=[UIColor whiteColor];
        [self addSubview:self.productTitle];
        [self.productTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@200);
            make.height.top.equalTo(self);
            make.left.equalTo(self.mas_left).offset(20);
            
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
