//
//  CMCFBZhuangFootView.m
//  CaiMao
//
//  Created by MAC on 16/11/9.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMCFBZhuangFootView.h"

@implementation CMCFBZhuangFootView
-(instancetype)init{
    self=[super init];
    if (self) {
        self.backgroundColor=ViewBackColor;
                [self addSubview:self.ZhuangRuBtn];
                [self.ZhuangRuBtn  mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(buttonHeight);
                    make.left.equalTo(self.mas_left).offset(15);
                    make.right.equalTo(self.mas_right).offset(-15);
                    make.top.equalTo(self.mas_top).offset(20);
                }];
        
    }
    
    return self;
    
}

-(UIButton*)ZhuangRuBtn{
    if (!_ZhuangRuBtn) {
        _ZhuangRuBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_ZhuangRuBtn setTitle:@"转入" forState:UIControlStateNormal];
        _ZhuangRuBtn.titleLabel.font=[UIFont systemFontOfSize:12.0];
        [_ZhuangRuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_ZhuangRuBtn setBackgroundColor:RedButtonColor];
        _ZhuangRuBtn.layer.cornerRadius=5.0;
        _ZhuangRuBtn.layer.masksToBounds=YES;
    }
    return _ZhuangRuBtn;
}
@end
