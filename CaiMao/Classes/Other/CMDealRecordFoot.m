//
//  CMDealRecordFoot.m
//  CaiMao
//
//  Created by MAC on 16/8/10.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMDealRecordFoot.h"

@implementation CMDealRecordFoot

-(id)init{
    self=[super init];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        UILabel *total=[UILabel new];
        total.text=@"合计";
         total.textColor=UIColorFromRGB(0x3a3836);
        total.font=[UIFont systemFontOfSize:15.0];
        [self addSubview:total];
        [total mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(8);
            make.height.equalTo(@20);
            make.left.equalTo(self.mas_left).offset(15);
            make.width.equalTo(@35);
        }];
        
        
        UILabel *jinEr=[UILabel new];
        self.TotalJinEr=jinEr;
        jinEr.font=[UIFont systemFontOfSize:15.0];
        jinEr.textColor=UIColorFromRGB(0xfb3f19);
        //jinEr.textAlignment=NSTextAlignmentCenter;
        [self addSubview:jinEr];
        [jinEr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.top.equalTo(total);
            make.left.equalTo(self.mas_left).offset(80);
            make.width.equalTo(@100);
        }];
        UILabel *FenS=[UILabel new];
        self.TotalTJFS=FenS;
        FenS.font=[UIFont systemFontOfSize:15.0];
        FenS.textColor=UIColorFromRGB(0xfb3f19);
        //jinEr.textAlignment=NSTextAlignmentCenter;
        [self addSubview:FenS];
        [FenS mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.top.equalTo(total);
            make.left.equalTo(jinEr.mas_right);
            make.width.equalTo(@100);
        }];
        
        
        UILabel *Zui=[UILabel new];
        Zui.text=@"*以上为部分最新交易信息";
        Zui.font=[UIFont systemFontOfSize:14.0];
       Zui.textColor=UIColorFromRGB(0xb4b4b4);
        //jinEr.textAlignment=NSTextAlignmentCenter;
        [self addSubview:Zui];
        [Zui mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(total);
            make.left.equalTo(self.mas_left).offset(10);
            make.width.equalTo(@300);
            make.top.equalTo(total.mas_bottom).offset(10);
        }];
        
    }
    return self;
}

@end
