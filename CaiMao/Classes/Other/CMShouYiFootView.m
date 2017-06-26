//
//  CMShouYiFootView.m
//  CaiMao
//
//  Created by MAC on 16/8/9.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMShouYiFootView.h"

@implementation CMShouYiFootView

-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        
        UILabel *total=[[UILabel alloc]init];
        total.text=@"合计";
        total.font=[UIFont systemFontOfSize:14.0];
        total.textColor=UIColorFromRGB(0x000000);
        [self addSubview:total];
        [total mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@40);
            make.height.equalTo(@20);
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_left).offset(10);
            
        }];
        UILabel *YSBX=[[UILabel alloc]init];
        //YSBX.text=@"应收本息";
        self.fYSBX=YSBX;
        YSBX.font=[UIFont systemFontOfSize:12.0];
        YSBX.textColor=UIColorFromRGB(0xfb3f19);
        YSBX.textAlignment=NSTextAlignmentCenter;
        [self addSubview:YSBX];
        [YSBX mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.equalTo(total);
            make.centerX.equalTo(self.mas_centerX);
            make.width.equalTo(@100);
            
        }];
        
        UILabel *YSBJ=[[UILabel alloc]init];
        self.fSYBJ=YSBJ;
        YSBJ.font=[UIFont systemFontOfSize:12.0];
        YSBJ.textColor=UIColorFromRGB(0xfb3f19);
        YSBJ.textAlignment=NSTextAlignmentCenter;
        [self addSubview:YSBJ];
        [YSBJ mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.height.equalTo(YSBX);
            make.top.equalTo(YSBX.mas_bottom).offset(5);
            
        }];
        
        
        UILabel *YSLX=[[UILabel alloc]init];
        self.fYSLX=YSLX;
        YSLX.font=[UIFont systemFontOfSize:12.0];
        YSLX.textColor=UIColorFromRGB(0xfb3f19);
        YSLX.textAlignment=NSTextAlignmentRight;
        [self addSubview:YSLX];
        [YSLX mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.top.height.equalTo(YSBX);
            
            make.right.equalTo(self.mas_right).offset(-10);
            
        }];
//        UILabel *SYBJ=[[UILabel alloc]init];
//        SYBJ.text=@"剩余本金";
//        SYBJ.font=[UIFont systemFontOfSize:12.0];
//        SYBJ.textColor=[UIColor lightGrayColor];
//        SYBJ.textAlignment=NSTextAlignmentRight;
//        [self addSubview:SYBJ];
//        [SYBJ mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.top.width.equalTo(YSBJ);
//            make.right.equalTo(YSLX);
//            
//        }];
        

        UILabel *ShuoMing=[[UILabel alloc]init];
        ShuoMing.text=@"* 每期收款实际金额以最终到账为准,最终解释权归财猫网所有。";
        ShuoMing.numberOfLines=0;
        ShuoMing.font=[UIFont systemFontOfSize:10.0];
        //total.textColor=[UIColor lightGrayColor];
        [self addSubview:ShuoMing];
        [ShuoMing mas_makeConstraints:^(MASConstraintMaker *make) {
           // make.width.equalTo(@300);
            make.height.equalTo(@30);
            make.bottom.equalTo(self.mas_bottom);
            make.left.equalTo(self.mas_left).offset(10);
             make.right.equalTo(self.mas_right).offset(-10);
        }];
        
    }
    return self;
}
@end
