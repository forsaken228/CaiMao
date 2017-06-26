//
//  CMBarView.m
//  CaiMao
//
//  Created by WangWei on 17/1/7.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import "CMBarView.h"

@implementation CMBarView

+(UIView*)barHeadViewWithImage:(NSString *)image{
    
    
    UIImage *imageName=[UIImage imageNamed:image];
    UIImageView *bgView=[[UIImageView alloc]init];
    bgView.frame=CGRectMake(0, 0, CMScreenW, f_i5real(imageName.size.height));
    bgView.contentMode=UIViewContentModeScaleAspectFill;
    bgView.clipsToBounds=YES;
    bgView.image=imageName;
    return bgView;
    
    
}

+(UIView*)barFootViewWithImage:(NSString *)image{
    UIImage *imageName=[UIImage imageNamed:image];
    UIImageView *bgView=[[UIImageView alloc]init];
    bgView.frame=CGRectMake(0, 0, CMScreenW, f_i5real(imageName.size.height));
    bgView.image=imageName;
    
    return bgView;
    
    
}
@end
