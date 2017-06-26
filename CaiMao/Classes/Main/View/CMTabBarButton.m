//
//  CMTabBarButton.m
//  CaiMao
//
//  Created by Fengpj on 14-12-13.
//  Copyright (c) 2014年 58cm. All rights reserved.
//

#import "CMTabBarButton.h"

@implementation CMTabBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.图片居中
        self.imageView.contentMode = UIViewContentModeCenter;
        
        // 2.文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:11.0];
        self.titleLabel.textColor = [UIColor blackColor];
        [self setTitleColor:UIColorFromRGB(0x8e8e93) forState:UIControlStateNormal];
        
        // 3.设置选中时的背景图片 / 文字颜色
//        [self setBackgroundImage:[UIImage imageNamed:@"tabbar_slider_os7"] forState:UIControlStateSelected];
        [self setTitleColor:RedButtonColor forState:UIControlStateSelected];
    }
    return self;
}


// 去掉父类在高亮时所做的操作
- (void)setHighlighted:(BOOL)highlighted {}

#pragma mark - 覆盖父类的2个方法
#pragma mark 设置按钮标题的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    UIImage *image =  [self imageForState:UIControlStateNormal];
    CGFloat titleY = image.size.height;
    CGFloat titleHeight = self.bounds.size.height - titleY;
    return CGRectMake(0, titleY, self.bounds.size.width,  titleHeight);
}

#pragma mark 设置按钮图片的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    UIImage *image = [self imageForState:UIControlStateNormal];
    return CGRectMake(0, 0, contentRect.size.width, image.size.height + 10);
}

- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    [self setTitle:item.title forState:UIControlStateNormal];
    [self setImage:item.image forState:UIControlStateNormal];
    [self setImage:item.selectedImage forState:UIControlStateSelected];
}

@end
