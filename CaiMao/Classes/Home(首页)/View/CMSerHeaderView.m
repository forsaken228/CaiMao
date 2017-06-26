//
//  CMSerHeaderView.m
//  CaiMao
//
//  Created by Fengpj on 16/1/11.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMSerHeaderView.h"

@implementation CMSerHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1.0];
        [self addSubview:_titleLab];
        
    }
    return self;
}

@end
