//
//  CMButtonTextView.m
//  CaiMao
//
//  Created by WangWei on 17/2/17.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import "CMButtonTextView.h"

@implementation CMButtonTextView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
      
        self.layer.borderColor=separateLineColor.CGColor;
        self.layer.borderWidth=0.7;
        self.layer.cornerRadius = 3.f;
        self.clipsToBounds = YES;
        
        [self addSubview:self.increaseBtn];
         [self addSubview:self.decreaseBtn];
        [self addSubview:self.textField];
        
        float width=    self.bounds.size.width;
        float height=    self.bounds.size.height;
        
        self.textField.frame = CGRectMake(height, 0, width - 2*height, height);
        self.increaseBtn.frame = CGRectMake(0, 0, height, height);
        self.decreaseBtn.frame = CGRectMake(width-height, 0, height, height);
        
    }
    
    
    return self;
}
-(UIButton*)increaseBtn{
    if (!_increaseBtn) {
        _increaseBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _increaseBtn.titleLabel.font=[UIFont systemFontOfSize:20];
        [_increaseBtn setBackgroundColor:[UIColor whiteColor]];
        [_increaseBtn setTitle:@"+" forState:UIControlStateNormal];
        [_increaseBtn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
       // _increaseBtn.layer.borderColor=separateLineColor.CGColor;
       // _increaseBtn.layer.borderWidth=0.7;
        [_increaseBtn setBackgroundColor:separateLineColor];
       
    }
    return _increaseBtn;
}

-(UIButton*)decreaseBtn{
    if (!_decreaseBtn) {
        _decreaseBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _decreaseBtn.titleLabel.font=[UIFont systemFontOfSize:20];
        [_decreaseBtn setBackgroundColor:[UIColor whiteColor]];
        [_decreaseBtn setTitle:@"-" forState:UIControlStateNormal];
        [_decreaseBtn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
        [_decreaseBtn setTitleEdgeInsets:UIEdgeInsetsMake(-5, 0, 0, 0)];
       // _decreaseBtn.layer.borderColor=separateLineColor.CGColor;
       // _decreaseBtn.layer.borderWidth=0.7;
         [_decreaseBtn setBackgroundColor:separateLineColor];
    }
    return _decreaseBtn;
}
-(UITextField*)textField{
    if (!_textField) {
        _textField=[[UITextField alloc]init];
        _textField.textAlignment=NSTextAlignmentCenter;
        _textField.textColor=UIColorFromRGB(0x333333);
        _textField.keyboardType=UIKeyboardTypeNumberPad;
        _textField.font=[UIFont systemFontOfSize:20];
//        _InPutField.layer.borderColor=separateLineColor.CGColor;
//        _InPutField.layer.borderWidth=0.8;
        
    }
    return _textField;
}

@end
