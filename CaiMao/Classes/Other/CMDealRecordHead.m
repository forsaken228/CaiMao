//
//  CMDealRecordHead.m
//  CaiMao
//
//  Created by MAC on 16/8/10.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMDealRecordHead.h"

@implementation CMDealRecordHead
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        NSArray *strArr=@[@"竞拍人",@"投资金额",@"份数",@"状态",@"交易时间"];
        for (int i=0; i<5; i++) {
            UILabel *title=nil;
            title=[[UILabel alloc]init];
            title.textAlignment=NSTextAlignmentCenter;
            title.font=[UIFont systemFontOfSize:14.0];
            title.textColor=UIColorFromRGB(0x3a3836);
            title.text=strArr[i];
            title.frame=CGRectMake((i%5)*(CMScreenW/5.0),0 , CMScreenW/5.0, 40);
            [self addSubview:title];
       
         }
        
        
    }
    return self;
}

@end
