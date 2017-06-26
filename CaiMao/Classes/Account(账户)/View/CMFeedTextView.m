//
//  CMFeedTextView.m
//  CaiMao
//
//  Created by Fengpj on 16/1/15.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMFeedTextView.h"

@interface CMFeedTextView ()
{
    BOOL _shouldDrawPlaceholder;
}

@end

@implementation CMFeedTextView

#pragma mark - 重写父类方法
- (void)setText:(NSString *)text {
    [super setText:text];
    [self drawPlaceholder];
    return;
}

- (void)setPlaceholder:(NSString *)placeholder {
    if (![placeholder isEqual:_placeholder]) {
        _placeholder = placeholder;
        [self drawPlaceholder];
    }
    return;
}

#pragma mark - 父类方法
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self configureBase];
    }
    return self;
}

- (id)init{
    if (self = [super init]) {
        [self configureBase];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
   
    if (_shouldDrawPlaceholder) {
        [_placeholderTextColor set];
       
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        // 设置占位符样式
        [dict setObject:[UIFont systemFontOfSize:14.0f] forKey:NSFontAttributeName];
        [dict setObject:UIColorFromRGB(0xbbbbbd) forKey:NSForegroundColorAttributeName];
        [_placeholder drawAtPoint:CGPointMake(4.0f, 8.0f) withAttributes:dict];
    }
    return;
}

- (void)configureBase {
    [CMNSNotice addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:self];
    
    self.placeholderTextColor = UIColorFromRGB(0xbbbbbd);
    _shouldDrawPlaceholder = NO;
    return;
}

- (void)drawPlaceholder {
    BOOL prev = _shouldDrawPlaceholder;
    _shouldDrawPlaceholder = self.placeholder && self.placeholderTextColor && self.text.length == 0;
    
    if (prev != _shouldDrawPlaceholder) {
        [self setNeedsDisplay];
    }
    return;
}

- (void)textChanged:(NSNotification *)notification {
    [self drawPlaceholder];
    return;
}

- (void)dealloc {
    [CMNSNotice removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
    return;
}


@end
