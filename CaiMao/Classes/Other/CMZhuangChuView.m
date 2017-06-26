//
//  CMZhuangChuView.m
//  CaiMao
//
//  Created by MAC on 16/11/10.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMZhuangChuView.h"

@implementation CMZhuangChuView

-(id)init{
    self=[super init];
    if (self) {
        CMTopBgView *top=[[CMTopBgView alloc]initWithImage:@"转出"];
        top.frame=CGRectMake(0, 10, CMScreenW, 30);
        [self addSubview:top];
        [self addSubview:self.CaiFuBaoYu];
        [self addSubview:self.TodayZhunaChu];
        [self.CaiFuBaoYu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.width.equalTo(@150);
            make.left.equalTo(self.mas_left).offset(15);
            make.top.equalTo(top.mas_bottom).offset(10);
        }];
        [self.TodayZhunaChu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.width.equalTo(@150);
            make.right.equalTo(self.mas_right).offset(-15);
            make.top.equalTo(top.mas_bottom).offset(10);
        }];
    }
    return self;
    
}
-(UILabel*)CaiFuBaoYu{
    if (!_CaiFuBaoYu) {
        _CaiFuBaoYu=[[UILabel alloc]init];
        _CaiFuBaoYu.textColor=UIColorFromRGB(0x8e8d93);
        _CaiFuBaoYu.font=[UIFont systemFontOfSize:14.0];
        
    }
    return _CaiFuBaoYu;
}
-(UILabel*)TodayZhunaChu{
    if (!_TodayZhunaChu) {
        _TodayZhunaChu=[[UILabel alloc]init];
        _TodayZhunaChu.textColor=UIColorFromRGB(0x8e8d93);
        _TodayZhunaChu.font=[UIFont systemFontOfSize:14.0];
        _TodayZhunaChu.textAlignment=NSTextAlignmentRight;
        
    }
    return _TodayZhunaChu;
}
@end
