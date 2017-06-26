//
//  CMTextField.m
//  CaiMao
//
//  Created by Fengpj on 16/1/9.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMTextField.h"

@implementation CMTextField

- (id)init
{
    self = [super init];
    if (self) {
        // 内容垂直居中
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.clearButtonMode = UITextFieldViewModeNever;
        
        // 设置左边的view永远显示
        self.leftViewMode = UITextFieldViewModeAlways;
         
        // 设置字体
        self.font = [UIFont systemFontOfSize:14.0f];
        
        
    }
    return self;
}

@end
