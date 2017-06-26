//
//  CMZhuanTopView.m
//  CaiMao
//
//  Created by WangWei on 16/12/28.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMZhuanTopView.h"

@implementation CMZhuanTopView

-(instancetype)initWithImage:(NSString*)imageName{
    self=[super init];
    if (self) {
        UIImageView  *bg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, 30)];
        bg.image=[UIImage imageNamed:imageName];
        [self addSubview:bg];
        
        NSArray *TitleArr=@[@"确认合同",@"在线支付",@"支付成功"];
        for (int i=0; i<TitleArr.count; i++) {
            
            UILabel *label=[[UILabel alloc]init];
            label.frame=CGRectMake(i%TitleArr.count*(CMScreenW/3.0), 0, CMScreenW/3.0, 30);
            label.textAlignment=NSTextAlignmentCenter;
            label.font=[UIFont systemFontOfSize:14.0];
            label.textColor=[UIColor whiteColor];
            label.text=TitleArr[i];
            [bg addSubview:label];
            
        }
        
        
    }
    return self;
    
}


@end
