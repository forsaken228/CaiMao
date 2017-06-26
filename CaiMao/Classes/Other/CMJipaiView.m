//
//  CMJipaiView.m
//  CaiMao
//
//  Created by MAC on 16/8/9.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMJipaiView.h"

@implementation CMJipaiView

-(id)init{
    self=[super init];
    if (self) {
        self.userInteractionEnabled=YES;
        self.backgroundColor=RedButtonColor;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
        [self addGestureRecognizer:tap];
        UILabel *jinPai=[[UILabel alloc]init];
        self.jinPai=jinPai;
        jinPai.text=@"竞拍";
        jinPai.font=[UIFont systemFontOfSize:16];
        jinPai.textColor=[UIColor whiteColor];
        jinPai.textAlignment=NSTextAlignmentCenter;
        [self addSubview:jinPai];
        [jinPai mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.height.equalTo(@16);
            make.left.right.equalTo(self);
            make.top.equalTo(self.mas_top).offset(4);
        }];
     
        UILabel *pay=[[UILabel alloc]init];
        self.PayJinEr=pay;
        pay.font=[UIFont systemFontOfSize:12];
        pay.textColor=[UIColor whiteColor];
        pay.textAlignment=NSTextAlignmentCenter;
        [self addSubview:pay];
        [pay mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.equalTo(@13);
            make.left.right.equalTo(self);
            make.top.equalTo(jinPai.mas_bottom).offset(5);
        }];
        
        
        
    }
    return self;
}
-(void)tapClick{
    
    if ([_delegate respondsToSelector:@selector(jiPaiBtnClick)]) {
        [_delegate jiPaiBtnClick];
    }
}
@end
