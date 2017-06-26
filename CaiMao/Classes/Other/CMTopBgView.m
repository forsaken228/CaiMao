//
//  CMTopBgView.m
//  CaiMao
//
//  Created by MAC on 16/11/10.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMTopBgView.h"

@implementation CMTopBgView

-(instancetype)initWithImage:(NSString*)imageName{
    self=[super init];
    if (self) {
        UIImageView  *bg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, 30)];
        bg.image=[UIImage imageNamed:imageName];
        [self addSubview:bg];
        
        NSArray *TitleArr=@[@"转出金额",@"转出确认",@"成功转出"];
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
