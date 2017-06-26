//
//  UIBarButtonItem+CM.h
//  CaiMao
//
//  Created by Fengpj on 14/12/20.
//  Copyright (c) 2014年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (CM)

+ (UIBarButtonItem *)itemWithImage:(NSString *)image higlightedImage:(NSString *)higlightedImage target:(id)target action:(SEL)action;

@end
